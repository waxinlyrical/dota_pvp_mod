--[[
Dota PvP game mode
]]

print( "chin_hero_abilities loaded." )

--globals go here
prot_monk_rof_buff_storedHealthTable = {}

-- TODO: Not really sure about all this stuff, think it's just syntax stuff to do classes? 
if ChinHeroAbilities == nil then
  print ( '[ChinHeroAbilities] creating ChinHeroAbilities' )
  ChinHeroAbilities = {} --  Creates an array to let us beable to index itemFunctions when creating new functions
  ChinHeroAbilities.__index = ChinHeroAbilities
end

function ChinHeroAbilities:new() -- Creates the new class
	print ( '[ChinHeroAbilities] ChinHeroAbilities:new' )
	o = o or {}
	setmetatable( o, ChinHeroAbilities )
	return o
end

function ChinHeroAbilities:start() -- Runs whenever the itemFunctions.lua is ran
	print('[ChinHeroAbilities] ChinHeroAbilities started!')
end

--TODO: End Syntax stuff for classes?

function prot_monk_rof_buff_OnCreated( keys )
	printt( '[ChinHeroAbilities] prot_monk_rof_buff_OnCreated Called' )
	local unit = keys.target
	--unit:SetHealth( 1 )
	prot_monk_rof_buff_storedHealthTable[ unit ] = unit:GetHealth()
	printt( 'putting unit: ' .. unit:GetName()  .. " into table with health of: " .. unit:GetHealth() )
end

function prot_monk_rof_buff_OnDestroy( keys )
	printt( '[ChinHeroAbilities] prot_monk_rof_buff_OnDestroy Called' )

	local unit = keys.target
	if ( prot_monk_rof_buff_storedHealthTable[ unit ] ~= nil ) then
		prot_monk_rof_buff_storedHealthTable[ unit ] = nil
		printt( 'Removing unit: ' .. unit:GetName() .. " from prot_monk_rof_buff_storedHealthTable" )
	end
end

function prot_monk_rof_buff_OnDamage( keys )
	printt( '[ChinHeroAbilities] prot_monk_rof_buff_OnDamage Called' )
	local unit = keys.unit

	local storedHealth = prot_monk_rof_buff_storedHealthTable[ unit ]

	if( storedHealth == nil  ) then
		printt( 'Unit: ' .. unit:GetName() .. ' was not stored in prot_monk_rof_buff_storedHealthTable. WTH?' )
		return
	end

	printt( 'unit\'s stored health: ' .. storedHealth )

	-- TODO: By the time we get into this function, the damage has already been done. Is there somewhere else we can place this functionality to intercept the damage before it's been done? 	
	local currentHealth = unit:GetHealth() 
	printt( 'unit\'s current health: ' .. currentHealth )

	local damageDone = storedHealth -  currentHealth
	
	--TODO: Really don't like this since it means you have to make sure the values for the level are kept in sync between npc_abilities_custom.txt and this file. Is there another way? 
	local dmgAbsorbedPerLevel = { 100, 200, 300, 400 } 			
	local dmgAbsorbed = dmgAbsorbedPerLevel[ keys.ability:GetLevel() ] 	
	printt( 'Damage to be absorbed: ' .. dmgAbsorbed )

	if ( damageDone <= dmgAbsorbed ) then
		unit:SetHealth( storedHealth + damageDone )
	else
		unit:SetHealth( currentHealth + ( 2 * dmgAbsorbed ) )
	end

	printt( 'unit\'s health after absorption: ' .. unit:GetHealth() )

	RemoveModifierOnUnit( 'prot_monk_rof_buff', unit )	
end


--TODO: Util functions. Move into separate file later
function printt( ... )
	 print( Time() .. " " .. ... )
end -- function

function RemoveModifierOnUnit( modifierName, unit )
	if ( unit:HasModifier( modifierName ) ) then
		printt( 'Removing modifier :' .. modifierName .. 'from unit: ' .. unit:GetName() )
		unit:RemoveModifierByName( modifierName )
	end
end