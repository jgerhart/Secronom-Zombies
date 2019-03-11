require("data/mods/secronom/LUA/functions")
require("data/mods/secronom/LUA/-Essentials/secro_attacks")

local MOD = {}

mods["secronom"] = MOD

-- Mod

MOD.on_turn_passed = function()
	
	-- Prevent in-game performance drop by adding more conditions before launch. You will experience a sudden lag in this process, so don't panic.
	if player:has_effect(efftype_id("flesh_breakdown")) == true and -- Check player if they killed the heart
	map:tername(player:pos()) == "fleshy floor" then -- and if the player is stepping on a flesh floor
	for delta_x = -100, 100 do
		for delta_y = -100, 100 do -- Whole overmap special gets changed by this. Player must step on a flesh floor, not downward holes.
			local point = player:pos()
			point.x = point.x + delta_x
			point.y = point.y + delta_y
			if map:tername(point) == "fleshy wall" then 
				map:ter_set(point, ter_str_id("t_rock")) -- Flesh area becomes a normal cavern
				end
			end
		end
	end
	
	if player:has_effect(efftype_id("flesh_breakdown")) == true and 
	map:tername(player:pos()) == "fleshy floor" then
	for delta_x = -100, 100 do
		for delta_y = -100, 100 do
			local point = player:pos()
			point.x = point.x + delta_x
			point.y = point.y + delta_y
			if map:tername(point) == "fleshy floor" then
				map:ter_set(point, ter_str_id("t_rock_floor"))
				end
			end
		end
	end
	
	if g:is_in_sunlight(player:pos()) == true then
		player:remove_effect(efftype_id("flesh_breakdown"))
	end
	
end

MOD.on_minute_passed = function()
	
	if map:tername(player:pos()) == "fleshy floor" then
		local bodypart = player:get_random_body_part()
		local bodypartdmgmod = math.random(3)
		local bodypartres = player:get_env_resist(bodypart)
		if bodypartres == 0 then
			bodypartres = bodypartres + 1
			end -- Zero means instant limb break, so we prevent that to happen.
		local bodypartdmg = 0.04 / bodypartdmgmod + 2.25 / bodypartres
		player:add_effect(efftype_id("flesh_succumb"), TURNS(10))
		if player:has_effect(efftype_id("flesh_succumb")) == true and
		bodypartres <= 2 then -- 3 and higher value results to no damage
			local msg = math.random(32)
			player:apply_damage(player, bodypart, bodypartdmg) -- Source of damage? Can't say null cuz codes
			if msg == 31 then
				game.add_msg("<color_red>You felt consumed...</color>") -- Give player a notice to get out if above conditions were met.
			elseif msg == 32 then
				game.add_msg("<color_red>The burden on your feet intensifies...</color>")
			end
		end
	end -- An unprepared player may not survive 1 or 2 z-levels

end