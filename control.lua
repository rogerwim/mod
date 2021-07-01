local handleBoiler = require("scripts.limited_boilers")
local handleSolar = require("scripts.limited_solar")
local function handleBuildByPlayer(e)
	if handleBoiler.handleBuildByPlayer(e) == 0 then
		handleSolar.handleBuildByPlayer(e)
	end
end
local function handleBuildByRobot(e)
	if handleBoiler.handleBuildByRobot(e) == 0 then
		handleSolar.handleBuildByRobot(e)
	end
end
local function handleDestroy(e)
	handleBoiler.handleDestroy(e)
	handleSolar.handleDestroy(e)
end
local function setter()
	handleBoiler.setter()
	handleSolar.setter()
end
local function reset(e)
	game.print(e.command)
	if e.command == 'reset' then
		game.print('resetting counts')
		global['boiler_count'] = 0
		global['boiler_ids'] = {}
		global['solar_count'] = 0
		global['solar_ids'] = {}
	end
end
script.on_event(defines.events.on_robot_built_entity, handleBuildByRobot)
script.on_event(defines.events.on_built_entity, handleBuildByPlayer)
script.on_event(defines.events.on_entity_destroyed,handleDestroy)
script.on_event(defines.events.on_console_command,reset)
script.on_init(setter)