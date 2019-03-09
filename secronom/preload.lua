-- I AM BUSY WITH LUA. Yes, that's the reason of my inactivity at the forums. But still, I lack knowledge about it, so expect that my works has limitations... HELP!

require("data/mods/secronom/LUA/functions")
require("data/mods/secronom/LUA/-Essentials/secro_attacks")

local MOD = {}

mods["secronom"] = MOD

-- Mod

MOD.on_minute_passed = function()
	
	-- Constant debuffs entering the flesh cavern. Lesser or no damage applied to player whether they got environmental resistance on a randomly targeted body part.
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
				game.add_msg("<color_red>You felt consumed...</color>")
			elseif msg == 32 then
				game.add_msg("<color_red>The burden on your feet intensifies...</color>")
			end
		end
	end
end