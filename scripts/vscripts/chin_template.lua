--[[
Dota PvP game mode
]]

print( "chin_template loaded." )

--constants go here
-- TIMERS_THINK = 0.01 

-- Begin: Not really sure about all this stuff, think it's just syntax stuff to do classes? 
if ChinTemplate == nil then
  print ( '[ChinTemplate] creating ChinTemplate' )
  ChinTemplate = {} --  Creates an array to let us beable to index itemFunctions when creating new functions
  ChinTemplate.__index = ChinTemplate
end

function ChinTemplate:new() -- Creates the new class
	print ( '[ChinTemplate] ChinTemplate:new' )
	o = o or {}
	setmetatable( o, ChinTemplate )
	return o
end

function ChinTemplate:start() -- Runs whenever the itemFunctions.lua is ran
	print('[ChinTemplate] ChinTemplate started!')
end

--End: Syntax stuff for classes?