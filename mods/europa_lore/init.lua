-- europa_lore/init.lua

europa_lore = {}

--
-- node based lore (crashed things: satellites, rovers, etc.)
--

europa_lore.ruins = {
	scanner = {},
	rover = {},
	lander = {},
	other = {}
}

europa_lore.add_ruin_rover = function(name)
	europa_lore.ruins.rover[name] = name
end

europa_lore.add_ruin_scanner = function(name)
	europa_lore.ruins.scanner[name] = name
end

europa_lore.add_ruin_lander = function(name)
	europa_lore.ruins.lander[name] = name
end

europa_lore.add_ruin_other = function(name)
	europa_lore.ruins.other[name] = name
end

europa_lore.register_rover = function(number)
	minetest.register_node("europa_lore:ruins_rover_"..tostring(number), {
		description = "Ruined Rover",
		tiles = "europa_lore_ruined_rover_"..tostring(number)..".png",
		drawtype = "mesh",
		mesh = "ruined_rover_"..tostring(number)..".obj",
		paramtype = "light",
		paramtype2 = "facedir",
		drop = {
			max_items = 4,
			items = {
				{items = {"europa_items:steel_ingot"}, rarity = 8},
				{items = {"europa_items:iron_ingot"}, rarity = 4},
				{items = {"europa_items:nickel_ingot"}, rarity = 2},
			}
		},
		groups = {cracky=1, not_in_creative_inventory=1, melty=1},
		sounds = europa_sounds.node_sound_metal_defaults(),
	})
	
	europa_lore.add_ruin_rover("europa_lore:ruins_rover_"..tostring(number))

	minetest.register_decoration({
		name = "europa_lore:ruins_rover_"..tostring(number),
		deco_type = "simple",
		place_on = {"europa_nodes:ice_hard"},
		sidelen = 16,
		noise_params = {
			offset = -0.012,
			scale = 0.008 / (number + 1), 
			spread = {x = 100, y = 100, z = 100},
			seed = 230,
			octaves = 3,
			persist = 0.6
		},
		y_max = 31000,
		y_min = -32,
		decoration = "europa_lore:ruins_rover_"..tostring(number),
	})
end

europa_lore.register_scanner = function(number)
	minetest.register_node("europa_lore:ruins_scanner_"..tostring(number), {
		description = "Crashed Orbital Scanner",
		tiles = {
			"europa_lore_ruined_scanner_"..tostring(number).."_panel.png",
			"europa_lore_ruined_scanner_"..tostring(number).."_body.png",
			"europa_lore_ruined_scanner_"..tostring(number).."_relay.png",
		},
		drawtype = "mesh",
		mesh = "ruined_scanner_"..tostring(number)..".obj",
		paramtype = "light",
		paramtype2 = "facedir",
		drop = {
			max_items = 4,
			items = {
				{items = {"europa_items:steel_ingot"}, rarity = 2},
				{items = {"europa_items:iron_ingot"}, rarity = 8},
				{items = {"europa_items:nickel_ingot"}, rarity = 4},
			}
		},
		groups = {cracky=1, not_in_creative_inventory=1, melty=1},
		sounds = europa_sounds.node_sound_metal_defaults(),
	})
	
	europa_lore.add_ruin_rover("europa_lore:ruins_scanner_"..tostring(number))

	minetest.register_decoration({
		name = "europa_lore:ruins_scanner_"..tostring(number),
		deco_type = "simple",
		place_on = {"europa_nodes:ice_hard"},
		sidelen = 16,
		noise_params = {
			offset = -0.012,
			scale = 0.008 / (number + 1),
			spread = {x = 100, y = 100, z = 100},
			seed = 230,
			octaves = 3,
			persist = 0.6
		},
		y_max = 31000,
		y_min = -32,
		decoration = "europa_lore:ruins_scanner_"..tostring(number),
	})
end

europa_lore.register_lander = function(number)
	minetest.register_node("europa_lore:ruins_lander_"..tostring(number), {
		description = "Crashed Lander",
		tiles = {
			"europa_lore_ruined_lander_"..tostring(number).."_computer.png",
			"europa_lore_ruined_lander_"..tostring(number).."_body.png",
			"europa_lore_ruined_lander_"..tostring(number).."_accent.png",
		},
		drawtype = "mesh",
		mesh = "ruined_lander_"..tostring(number)..".obj",
		paramtype = "light",
		paramtype2 = "facedir",
		drop = {
			max_items = 4,
			items = {
				{items = {"europa_items:steel_ingot"}, rarity = 4},
				{items = {"europa_items:iron_ingot"}, rarity = 8},
				{items = {"europa_items:nickel_ingot"}, rarity = 2},
			}
		},
		groups = {cracky=1, not_in_creative_inventory=1, melty=1},
		sounds = europa_sounds.node_sound_metal_defaults(),
	})
	
	europa_lore.add_ruin_rover("europa_lore:ruins_lander_"..tostring(number))

	minetest.register_decoration({
		name = "europa_lore:ruins_lander_"..tostring(number),
		deco_type = "simple",
		place_on = {"europa_nodes:ice_hard"},
		sidelen = 16,
		noise_params = {
			offset = -0.012,
			scale = 0.008 / (number + 1),
			spread = {x = 100, y = 100, z = 100},
			seed = 230,
			octaves = 3,
			persist = 0.6
		},
		y_max = 31000,
		y_min = -32,
		decoration = "europa_lore:ruins_lander_"..tostring(number),
	})
end

europa_lore.register_other = function(number)
	minetest.register_node("europa_lore:ruins_other_"..tostring(number), {
		description = "Ruined Object",
		tiles = "europa_lore_ruined_other_"..tostring(number)..".png",
		drawtype = "mesh",
		mesh = "ruined_other_"..tostring(number)..".obj",
		paramtype = "light",
		paramtype2 = "facedir",
		drop = {
			max_items = 4,
			items = {
				{items = {"europa_items:steel_ingot"}, rarity = 4},
				{items = {"europa_items:iron_ingot"}, rarity = 4},
				{items = {"europa_items:nickel_ingot"}, rarity = 4},
			}
		},
		groups = {cracky=1, not_in_creative_inventory=1, melty=1},
		sounds = europa_sounds.node_sound_metal_defaults(),
	})
	
	europa_lore.add_ruin_rover("europa_lore:ruins_other_"..tostring(number))

	minetest.register_decoration({
		name = "europa_lore:ruins_other_"..tostring(number),
		deco_type = "simple",
		place_on = {"europa_nodes:ice_hard"},
		sidelen = 16,
		noise_params = {
			offset = -0.012,
			scale = 0.008 / (number + 1),
			spread = {x = 100, y = 100, z = 100},
			seed = 230,
			octaves = 3,
			persist = 0.6
		},
		y_max = 31000,
		y_min = -32,
		decoration = "europa_lore:ruins_other_"..tostring(number),
	})
end

-- register ruins

rovers = 0 -- 0 means none, 1 means one

for i=0,rovers,1 do
	europa_lore.register_rover(i)
end

scanners = 0

for i=0,scanners,1 do
	europa_lore.register_scanner(i)
end

landers = 0

for i=0,landers,1 do
	europa_lore.register_lander(i)
end

others = 0

for i=0,others,1 do
	europa_lore.register_other(i)
end

--
-- text nased lore (role-playing, history, info, etc.)
--

europa_lore.bios = {
	["speilaz"] = {name = "Speilaz Ratrofthe", description = "Loves problem solving and exploring the world."},
	["keilragne"] = {name = "Keilragne Konmalhone", description = "Strong and rigid, loves to run and walk."},
	["hialgroe"] = {name = "Hialgroe Kiaodmaphe", description = "Weak but fast, knowledgeable and bookly."},
	["diafkaile"] = {name = "Diafkaile Japasdokle", description = "Dexterous and cordinated, inventive."},
	["shielgnad"] = {name = "Sheilgnad Daokdwalke", description = "Effecient and aerobic, strong laugh."},
	["japkelate"] = {name = "Japkelate Honedaerkel", description = "Gentle and strong, good learner."},
	["meitgraphe"] = {name = "Meitgraphe Nordancide", description = "Strong and Brutal, unbrakable."},
	["germaonad"] = {name = "Germaonad Hoadfanque", description = "Fun and Helpful, intersteller settler."},
	["berdanoide"] = {name = "Berdanoide Ohdabadosh", description = "Rich and sphisticated, technology expert."},
	["jaordebein"] = {name = "Jaordebien Fogneshiel", description = "Simple and natural, lightly stingy."},
}

europa_lore.info = { --this is actually all true, part of it is from wikipedia, and part from what I remember about these two celestial bodies
	europa = "The sixth largest of the approxomately 200 moons of jupiter, Europa is slightly smaller than earth's moon."..
			"The crust is entrirely made of ice and silicate, underneath is a layer of water and warm ice."..
			"Europa's core is made of iron and nickel, with a small amount of magnesium which is also on the surface in small quantities in the form of magnesium sulphate",

	jupiter = "The fith planet in the system of Sol; this planet has the largest number of moons in the entire system of Sol."..
			"This planet is home to some of the most destructive dust storms in the galaxy as we know it."..
			"The atmoshpere is composed of many different substances, including argon; which is a dangerous chemical"..
			"usually in gas or vapor form that is heavier than oxygen, hydrogen, and nitrogen", -- and helium of course :)
}




