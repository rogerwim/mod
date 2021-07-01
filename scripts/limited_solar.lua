local function setter()
	global['solar_count'] = 0
	global['solar_ids'] = {}
end
local function handleBuildByPlayer (e)
  if e.created_entity.name == "solar-panel" then
    global['solar_count'] = global['solar_count'] + 1
	if global['solar_count'] > 5 then
		game.print("too many of a limited item have been built, removeing last built and giving to builder")
		e.created_entity.last_user.insert({name = e.created_entity.name, count=1})
		e.created_entity.mine({ignore_minable = true})
		global['solar_count'] = global['solar_count'] - 1
	else
		global['solar_ids'][global['solar_count']] = script.register_on_entity_destroyed(e.created_entity)
	end
  end
end
local function handleBuildByRobot (e)
  if e.created_entity.name == "solar-panel" then
    global['solar_count'] = global['solar_count'] + 1
	if global['solar_count'] > 5 then
		local posx = (e.created_entity.bounding_box['left_top']['x']+e.created_entity.bounding_box['right_bottom']['x'])/2
		local posy = (e.created_entity.bounding_box['left_top']['y']+e.created_entity.bounding_box['right_bottom']['y'])/2
		local itemstack = {name = e.created_entity.name, count=1}
		local surface = e.created_entity.surface
		game.print("too many of a limited item have been built, removeing last built placeing at [gps=" .. posx .. "," .. posy .. "]")
		e.created_entity.mine({ignore_minable = true})
		surface.spill_item_stack({posx,posy},itemstack)
		global['solar_count'] = global['solar_count'] - 1
	else
		global['solar_ids'][global['solar_count']] = script.register_on_entity_destroyed(e.created_entity)
	end
  end
end
local function handleDestroy (e)
	for key,value in ipairs(global['solar_ids']) do
		if e.registration_number == value then
			global['solar_count'] = global['solar_count'] - 1
		end
	end	
end
local exports = {
	["handleBuildByRobot"] = handleBuildByRobot,
	["handleBuildByPlayer"] = handleBuildByPlayer,
	["handleDestroy"] = handleDestroy,
	["setter"] = setter
}

return exports