--[[
Dota PvP game mode
]]

print( "chin_util loaded." )

--constants go here
-- TIMERS_THINK = 0.01 

-- Begin: Not really sure about all this stuff, think it's just syntax stuff to do classes? 
if ChinUtil == nil then
  print ( '[ChinUtil] creating ChinUtil' )
  ChinUtil = {} --  Creates an array to let us beable to index itemFunctions when creating new functions
  ChinUtil.__index = ChinUtil
end

function ChinUtil:new() -- Creates the new class
	print ( '[ChinUtil] ChinUtil:new' )
	o = o or {}
	setmetatable( o, ChinUtil )
	return o
end

--End: Syntax stuff for classes?

--function printt( ... )
--	 print( Time() .. " " .. ... )
--end -- function
--
--function RemoveModifierOnUnit( modifierName, unit )
--	if ( unit:HasModifier( modifierName ) ) then
--		printt( 'Removing modifier :' .. modifierName .. 'from unit: ' .. unit:GetName() )
--		unit:RemoveModifierByName( modifierName )
--	end
--end
