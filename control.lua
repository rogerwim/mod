local handleBoiler = require("scripts.limited_boilers")
local handleSolar = require("scripts.limited_solar")
local function handleBuildByPlayer(e)
	handleBoiler.handleBuildByPlayer(e)
	handleSolar.handleBuildByRobot(e)
end
local function handleBuildByRobot(e)
	handleBoiler.handleBuildByRobot(e)
	handleSolar.handleBuildByRobot(e)
end
local function handleDestroy(e)
	handleBoiler.handleDestroy(e)
	handleSolar.handleDestroy(e)
end
local function setter()
	handleBoiler.setter()
	handleSolar.setter()
end
script.on_event(defines.events.on_robot_built_entity, handleBuildByRobot)
script.on_event(defines.events.on_built_entity, handleBuildByPlayer)
script.on_event(defines.events.on_entity_destroyed,handleDestroy)
script.on_init(setter)