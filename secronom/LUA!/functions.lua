function creature_distance_from_player(target)

	local mpoint = target:pos() 
	local ppoint = player:pos()
	local distance_to_player = math.sqrt( ((mpoint.x - ppoint.x)^2) + ((mpoint.y - ppoint.y)^2) )
	return distance_to_player
	
end

function monsters_around()

	local center = player:pos()
	for off = 1, 60 do
		for x = -off, off do
			for y = -off, off do
			local z = 0 
				if math.abs(x) == off or math.abs(y) == off then
					local point = tripoint(center.x + x, center.y + y, center.z + z)
					local monster = g:critter_at(point)
						if monster then
							return monster
						end
				end
			end
		end
	end
	
end

function pick_from_list(list)
	local rand = math.random(1, #list)
	return list[rand]
end