function zoid_off(monster)
	local zoidbase_melee = monster:get_melee()
	monster:set_cut_bonus( zoidbase_melee + 7 )
	monster:set_bash_bonus( zoidbase_melee + 10 )
	local zoidbase_defensebashbonus = monster:get_armor_bash_bonus()
	local zoidbase_defensecutbonus = monster:get_armor_cut_bonus()
	local zoidbase_agilitydodgebonus = monster:get_dodge_bonus()
	local zoidbase_agilityspeedbonus = monster:get_speed_bonus()
	if zoidbase_defensebashbonus > 0 and
	zoidbase_defensecutbonus > 0 or
	zoidbase_agilitydodgebonus > 0 and 
	zoidbase_agilityspeedbonusand > 0 then
		monster:set_armor_cut_bonus( 0 )
		monster:set_armor_bash_bonus( 0 )
		monster:set_dodge_bonus( 0 )
		monster:set_speed_bonus( 0 )
		end
	end

-- Remove other stance bonuses, place with core ones.

function zoid_def(monster)
	local zoidbase_defense = monster:get_hp_max()
	monster:set_armor_cut_bonus( zoidbase_defense / 2 )
	monster:set_armor_bash_bonus( zoidbase_defense / 3 )
	local zoidbase_agilitydodgebonus = monster:get_dodge_bonus()
	local zoidbase_agilityspeedbonus = monster:get_speed_bonus()
	local zoidbase_meleecutbonus = monster:get_cut_bonus()
	local zoidbase_meleebashbonus = monster:get_bash_bonus()
	if zoidbase_meleecutbonus > 0 and
	zoidbase_meleebashbonus > 0 or
	zoidbase_agilitydodgebonus > 0 and 
	zoidbase_agilityspeedbonus > 0 then
		monster:set_cut_bonus( 0 )
		monster:set_bash_bonus( 0 )
		monster:set_dodge_bonus( 0 )
		monster:set_speed_bonus( 0 )
		end
	end

function zoid_agi(monster)
	local zoidbase_agility = monster:get_speed_base()
	monster:set_dodge_bonus( zoidbase_agility / 10 )
	monster:set_speed_bonus( zoidbase_agility * 2 )
	local zoidbase_meleecutbonus = monster:get_cut_bonus()
	local zoidbase_meleebashbonus = monster:get_bash_bonus()
	local zoidbase_defensebashbonus = monster:get_armor_bash_bonus()
	local zoidbase_defensecutbonus = monster:get_armor_cut_bonus()
	if zoidbase_defensebashbonus > 0 and
	zoidbase_defensecutbonus > 0 or
	zoidbase_meleecutbonus > 0 and
	zoidbase_meleebashbonus > 0 then
		monster:set_cut_bonus( 0 )
		monster:set_bash_bonus( 0 )
		monster:set_armor_cut_bonus( 0 )
		monster:set_armor_bash_bonus( 0 )
		end
	end

-- Monster Attacks

function ground_smash(monster)
	local mon = monster
	if creature_distance_from_player(mon) < 4
	and monster:sees(player) == true then
		if math.random(10) > 3 then
			player:add_effect(efftype_id("downed"), TURNS(2))
			player:add_effect(efftype_id("stunned"), TURNS(2))
			game.add_msg("<color_red>The "..monster:get_name().." brought down tremor!</color>")
		else
			player:add_effect(efftype_id("stunned"), TURNS(5))
			player:add_effect(efftype_id("downed"), TURNS(5))
			game.add_msg("<color_red>The "..monster:get_name().." brought down an immensive tremor!</color>")
			map:destroy(monster:pos())
		end
	else
		return false
	end
end

function titan_bashingcharge(monster)
	local mon = game.get_critter_at(monster:pos())
	local titancharge = efftype_id("titan_bashcharge")
	local titancharge_duration = TURNS(15)
	if monster:sees(player) == true 
	and creature_distance_from_player(mon) > 15	then
		game.add_msg("<color_red>A titan is ferociously charging towards you!</color>")
		monster:add_effect(titancharge, titancharge_duration)
		monster:add_effect(efftype_id("blind"), TURNS(12))
		monster:move_to(player:pos())
	else
		return false
	end
end

function titan_bashingcharge_impact(monster)
	local mon = game.get_critter_at(monster:pos())
	if monster:sees(player) == true
	and monster:has_effect(efftype_id("titan_bashcharge")) == true
	and creature_distance_from_player(mon) <= 2	then
		game.add_msg("<color_red>The devastating onslaught of the titan cripples your senses!</color>")
		player:add_effect(efftype_id("stunned"), TURNS(3))
		player:add_effect(efftype_id("downed"), TURNS(3))
	else
		return false;
	end
end

function blacktitan_bashingcharge(monster)
	local mon = game.get_critter_at(monster:pos())
	local blacktitancharge = efftype_id("blacktitan_bashcharge")
	local blacktitancharge_duration = TURNS(15)
	if monster:sees(player) == true 
	and creature_distance_from_player(mon) > 15	then
		game.add_msg("<color_red>A black titan is ferociously charging towards you!</color>")
		monster:add_effect(blacktitancharge, blacktitancharge_duration)
		monster:add_effect(efftype_id("blind"), TURNS(12))
		monster:move_to(player:pos())
	else
		return false
	end
end

function blacktitan_bashingcharge_impact(monster)
	local mon = game.get_critter_at(monster:pos())
	if monster:sees(player) == true
	and monster:has_effect(efftype_id("blacktitan_bashcharge")) == true
	and creature_distance_from_player(mon) <= 2	then
		game.add_msg("<color_red>The devastating onslaught of the black titan cripples your senses!</color>")
		player:add_effect(efftype_id("stunned"), TURNS(5))
		player:add_effect(efftype_id("downed"), TURNS(5))
	else
		return false
	end
end

function spawn_inforcer(monster)
	local mon = monster
	local locs = {}
	if monster:sees(player) == true then
	for delta_x = -1, 1 do
		for delta_y = -1, 1 do
			local point = monster:pos()
			point.x = point.x + delta_x
			point.y = point.y + delta_y
			if g:is_empty(point) then
				table.insert(locs, point )
			end
		end
	end

	if #locs == 0 then
		return false
	end

	local loc = pick_from_list(locs)
	local monster = game.create_monster(mtype_id("mon_bot_secroinforcer"), loc)
	game.add_msg("<color_purple>A reinforcer bot flies into vicinity!</color>")
	
	end
end

function secrodrag_eheal(monster)
	local secrodrag_hpage = monster:hp_percentage()
	if secrodrag_hpage < 50 then
		monster:set_moves(-500)
		local draghpmax = monster:get_hp_max() 
		local draghp = monster:get_hp()
		local dragaddhp = draghp + draghpmax / 5
		monster:set_hp( draghp + dragaddhp )
		game.add_msg("<color_purple>The secronom dragon momentarily pauses as it undergo maintenance.</color>")
	end
end

function zoid_stances(monster)
	local mon = monster
	if monster:can_act() == true then
		if player:sees(monster) then
		game.add_msg("<color_purple>The zoid blinks...</color>")
		end
		local stance = math.random(4)
		if stance == 1 then
			zoid_off(monster)
			if player:sees(monster) == true
			and creature_distance_from_player(mon) < 5 then
			game.add_msg("<color_red>And forms weaponry in its arms!</color>")
			end
		elseif stance == 2 then
			zoid_def(monster)
			if player:sees(monster) == true
			and creature_distance_from_player(mon) < 5 then
			game.add_msg("<color_red>And its body calcifies, forming a thick hide!</color>")
			end
		elseif stance == 3 then 
			zoid_agi(monster)
			if player:sees(monster) == true
			and creature_distance_from_player(mon) < 5 then
			game.add_msg("<color_red>And its body became slim as it moves cautiously!</color>")
			end
		elseif stance == 4 then
			monster:add_effect(efftype_id("stunned"), TURNS(3))
			monster:add_effect(efftype_id("downed"), TURNS(3))
			if player:sees(monster) == true
			and creature_distance_from_player(mon) < 5 then
			game.add_msg("<color_green>But it suddenly spasms to the floor!</color>")
			end
			end
		end
	end

function vex_horrify(monster)
	if monster:sees(player) == true and
	player:sees(monster) == true then
		local debuff = math.random(10)
		local dbuff = math.random(15,20)
		if debuff == 4 then
			player:add_effect(efftype_id("stunned"), TURNS(dbuff/4))
			player:add_effect(efftype_id("blind"), TURNS(dbuff/4))
			player:add_effect(efftype_id("downed"), TURNS(dbuff/4))
			game.add_msg("<color_red>You succumb to the sinister eyes of the vex!</color>")
		elseif debuff < 3 then
			player:add_effect(efftype_id("blind"), TURNS(dbuff/5))
			game.add_msg("<color_red>At a glance to the eyes of vex, your sight fades into black!</color>")
		elseif debuff > 5 then
			return false
		end
	end
end

function startspawn_jinx(monster)
	if monster:sees(player) == true then
	local spawncount = math.random(3,10)
	monster:add_effect(efftype_id("jinx_spawning"), TURNS(spawncount))
	game.add_msg("<color_red>Shadows are emerging from the smog!</color>")
	end
end


function spawn_jinx(monster)
	local mon = monster
	local locs = {}
	if monster:has_effect(efftype_id("jinx_spawning")) == true then
	for delta_x = -1, 1 do
		for delta_y = -1, 1 do
			local point = monster:pos()
			point.x = point.x + delta_x
			point.y = point.y + delta_y
			if g:is_empty(point) then
				table.insert(locs, point )
			end
		end
	end
	
	if #locs == 0 then
		return false
	end

	local loc = pick_from_list(locs)
	local monster = game.create_monster(mtype_id("mon_zombie_jinx_ed"), loc)
	
	end
end

function concentrate_jinx(monster)
	local dmgbase = player:get_effect_int(efftype_id("jinx_mark"))
	local dmgtarget = player:get_random_body_part()
	local dmg = dmgbase * 1.6
	if DEBUG == true then
		game.add_msg("Damage to "..dmgtarget..": "..dmg)
	end
	if player:has_effect(efftype_id("jinx_mark")) == true
	and dmgbase > 10 then
		player:remove_effect(efftype_id("jinx_mark"))
		player:apply_damage(player, dmgtarget, dmg)
		game.add_msg("<color_red>The jinx afflicts you with a surge of distress, as your marks vanishes...</color>")
		if dmgbase > 20 then
			player:add_effect(efftype_id("stunned"), TURNS(4))
			player:add_effect(efftype_id("blind"), TURNS(4))
			game.add_msg("<color_red>And your mind were sent into a trance!</color>")
		end
	end
end

-- We need 10 marks for this attack, ranging up to 30 marks. DAMAGE IS TRUE, even if you've got a bad-ass power armor, you still get damaged.
-- NOTE: Players with "FRAGILE" trait won't survive more than 20 marks, only if it targets the torso or head.

function jinx_mark(monster)
	local mon = monster
	if creature_distance_from_player(mon) < 2 and
	monster:sees(player) == true then
		player:add_effect(efftype_id("jinx_mark"), TURNS(50))
		monster:die(monster)
		game.add_msg("<color_red>The shadow penetrates through you and creates a marking!</color>")
	elseif creature_distance_from_player(mon) > 3 then
		monster:wander_to(player:pos(), 100)
	end
end

function zombie_shed(monster)
	local mon = monster
	local shedhold = monster:hp_percentage()
	local beforeshedhp = monster:get_hp()
	local beforeshedhpmax = monster:get_hp_max()
	local aftershedhp = beforeshedhpmax - beforeshedhp
	if shedhold < 40 then
		local shedwhat = math.random(2)
		monster:set_hp( aftershedhp + beforeshedhp )
		if shedwhat == 1 then
			monster:poly(mtype_id("mon_zombie_ichorus"))
			game.add_msg("<color_red>The head of the zombie bursts a dreadful tentacle, flinging acid everywhere!</color>")
			local source = monster:pos()
			for re = 0, 1 do
			for x = -re, re do
				for y = -re, re do
					local z = 0 
					if math.abs(x) == re or math.abs(y) == re then
						local srcpoint = tripoint(source.x + x, source.y + y, source.z + z) 
						local dur = math.random(5, 15)
						local acid = math.random(3)
						map:add_field(srcpoint, "fd_acid", acid, TURNS(dur))
						end
					end
				end
			end
			
		elseif shedwhat == 2 then
			monster:poly(mtype_id("mon_zombie_psyrus"))
			game.add_msg("<color_red>The whole body of the zombie explodes into gore, revealing its true, revolting figure!</color>")
			if creature_distance_from_player(mon) <= 2 then
			player:add_effect(efftype_id("stunned"), TURNS(2))
			player:add_effect(efftype_id("downed"), TURNS(3))
			game.add_msg("<color_red>The remains are flung towards you, and knocks you in its impact!</color>")
			
			end
		end
	end
end

function electric_spark_lrange(monster)
	local mon = monster
	local locs = {}
	if monster:can_act() == true then
	for delta_x = -10, 25 do
		for delta_y = -10, 25 do
			local point = monster:pos()
			point.x = point.x + delta_x
			point.y = point.y + delta_y
			if monster:sees(point) then
				table.insert(locs, point )
			end
		end
	end
	
	if #locs == 0 then
		return false
	end

	local loc = pick_from_list(locs)
	local electrical = math.random(2,3)
	local electricality = math.random(5,10)
	local monster = map:add_field(loc, "fd_electricity", electrical, TURNS(electricality))
	
	end
end

function electric_spark_srange(monster)
	local mon = monster
	local locs = {}
	if monster:can_act() == true then
	for delta_x = -0, 10 do
		for delta_y = -0, 10 do
			local point = monster:pos()
			point.x = point.x + delta_x
			point.y = point.y + delta_y
			if monster:sees(point) then
				table.insert(locs, point )
			end
		end
	end
	
	if #locs == 0 then
		return false
	end

	local loc = pick_from_list(locs)
	local electrical = math.random(2,3)
	local electricality = math.random(5,10)
	local monster = map:add_field(loc, "fd_electricity", electrical, TURNS(electricality))
	
	end
end

function electric_spark_allrange(monster)
	local mon = monster
	local locs = {}
	if monster:can_act() == true then
	for delta_x = -0, 25 do
		for delta_y = -0, 25 do
			local point = monster:pos()
			point.x = point.x + delta_x
			point.y = point.y + delta_y
			if monster:sees(point) then
				table.insert(locs, point )
			end
		end
	end
	
	if #locs == 0 then
		return false
	end

	local loc = pick_from_list(locs)
	local electrical = math.random(2,3)
	local electricality = math.random(5,10)
	local monster = map:add_field(loc, "fd_electricity", electrical, TURNS(electricality))
	
	end
end

-- NOTE: If you hold something with very low light source, the electricity will strike near you at nighttime.

game.register_monattack("SMASH_GROUND", ground_smash )
game.register_monattack("TITAN_CHARGE", titan_bashingcharge )
game.register_monattack("TITAN_IMPACT", titan_bashingcharge_impact )
game.register_monattack("BLACKTITAN_CHARGE", blacktitan_bashingcharge )
game.register_monattack("BLACKTITAN_IMPACT", blacktitan_bashingcharge_impact )
game.register_monattack("INFORCER_SPAWN", spawn_inforcer )
game.register_monattack("EHEAL_SECRODRAG", secrodrag_eheal )
game.register_monattack("STANCES_ZOID", zoid_stances )
game.register_monattack("HORRIFY_VEX", vex_horrify )
game.register_monattack("JINX_SPAWNSTART", startspawn_jinx )
game.register_monattack("JINX_SPAWN", spawn_jinx )
game.register_monattack("JINX_CONCENTRATE", concentrate_jinx )
game.register_monattack("MARK_JINX", jinx_mark )
game.register_monattack("SHED_ZOMBIE", zombie_shed )
game.register_monattack("ESPARK_L", electric_spark_lrange )
game.register_monattack("ESPARK_S", electric_spark_srange )
game.register_monattack("ESPARK_A", electric_spark_allrange )