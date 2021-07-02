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
local function placeholder()

end
local function reset(e)
	if e.player_index then
		if e.command == 'count' then
			game.get_player(e.player_index).print("boilers used: " .. global["boiler_count"] .. "/" .. 50)
			game.get_player(e.player_index).print("solar panels used: " .. global["solar_count"] .. "/" .. 1500)
		end
		if e.command == 'reset' then
			game.print(game.get_player(e.player_index).name .. " is attempting to reset the limted solar/boiler plugin") 
		end
		if game.get_player(e.player_index).admin == false and e.command == 'reset' then
			game.get_player(e.player_index).print("error, you must be an admin")
			game.print(game.get_player(e.player_index).name .. " did not have the permission to do that")
		end
		if e.command == 'reset' and game.get_player(e.player_index).admin then
			game.print('resetting counts')
			global['boiler_count'] = 0
			global['boiler_ids'] = {}
			global['solar_count'] = 0
			global['solar_ids'] = {}
		end
	end
end
script.on_event(defines.events.on_robot_built_entity, handleBuildByRobot)
script.on_event(defines.events.on_built_entity, handleBuildByPlayer)
script.on_event(defines.events.on_entity_destroyed,handleDestroy)
script.on_init(setter)
commands.add_command("count","print how close you are to the limit",reset)
commands.add_command("reset","reset the boiler/solar limit",reset)