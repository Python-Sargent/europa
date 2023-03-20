-- europa_nodes/init.lua

--[[

-- natural

europa_nodes:ice
europa_nodes:ice_warm
europa_nodes:ice_hard
europa_nodes:silicate
europa_nodes:magnesium_sulfate
europa_nodes:core_iron
europa_nodes:core_nickel
europa_nodes:core_iron_nickel

-- liquids

europa_nodes:water_source
europa_nodes:water_flowing

-- other

europa_nodes:electric_lamp
europa_nodes:glowstick

]]--

local S = minetest.get_translator("europa_nodes")

--
-- Nodes
--

minetest.register_node("europa_nodes:ice", {
	description = "Ice",
	tiles = {"europa_nodes_ice.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {cracky = 3, melty = 3, slippery = 2}
})

minetest.register_node("europa_nodes:ice_warm", {
	description = "Warm Ice",
	tiles = {"europa_nodes_warm_ice.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {cracky = 3, melty = 3, slippery = 1}
})

minetest.register_node("europa_nodes:ice_hard", {
	description = "Hard Ice",
	tiles = {"europa_nodes_hard_ice.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {cracky = 3, melty = 3, slippery = 3}
})

minetest.register_node("europa_nodes:silicate", {
	description = "Silicate",
	tiles = {"europa_nodes_silicate.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {cracky = 3, melty = 2}
})

minetest.register_node("europa_nodes:magnesium_sulfate", {
	description = "Magnesium Sulfate",
	tiles = {"europa_nodes_magnesium_sulfate.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {cracky = 3, melty = 2}
})

minetest.register_node("europa_nodes:core_iron", {
	description = "Iron Core",
	tiles = {"europa_nodes_core_iron.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {cracky = 2, melty = 1}
})

minetest.register_node("europa_nodes:core_nickel", {
	description = "Nickel Core",
	tiles = {"europa_nodes_core_nickel.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {cracky = 2, melty = 1}
})

minetest.register_node("europa_nodes:core_iron_nickel", {
	description = "Iron and Nickel Core",
	tiles = {"europa_nodes_core_iron_nickel.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {cracky = 1, melty = 1}
})

-- meteorites

minetest.register_node("europa_nodes:meteor_platinum", {
	description = "Platinum Meteor Rock",
	tiles = {"europa_nodes_meteor_platinum.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {cracky = 1, melty = 1}
})

minetest.register_node("europa_nodes:meteor_chromium", {
	description = "Chromium Meteor Rock",
	tiles = {"europa_nodes_meteor_chromium.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {cracky = 1, melty = 1}
})

minetest.register_node("europa_nodes:meteor_titanium", { -- FIXME is this really in meteors?
	description = "Titanium Meteor Rock",
	tiles = {"europa_nodes_meteor_titanium.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {cracky = 1, melty = 1}
})

minetest.register_node("europa_nodes:meteor_ice", {
	description = "Meteor Rock",
	tiles = {"europa_nodes_meteor_ice.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {cracky = 1, melty = 1}
})

--
-- Liquids
--

minetest.register_node("europa_nodes:water_source", {
	description = S("Water"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "europa_nodes_water_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.0,
			},
		},
		{
			name = "europa_nodes_water_source_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.0,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "europa_nodes:water_flowing",
	liquid_alternative_source = "europa_nodes:water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 150, r = 180, g = 200, b = 255},
	groups = {water = 3, liquid = 3, cools_lava = 1},
	sounds = europa_sounds.node_sound_water_defaults(),
})

minetest.register_node("europa_nodes:water_flowing", {
	description = S("Flowing Water"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"europa_nodes_water.png"},
	special_tiles = {
		{
			name = "europa_nodes_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.25,
			},
		},
		{
			name = "europa_nodes_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.25,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "europa_nodes:water_flowing",
	liquid_alternative_source = "europa_nodes:water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 150, r = 180, g = 200, b = 255},
	groups = {water = 3, liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1},
	sounds = europa_sounds.node_sound_water_defaults(),
})

--
-- Lighting
--

local default_charge = 600 -- if 600 should be 10 minutes of battery (1 second power draw)

minetest.register_node("europa_nodes:electric_lamp", {
	description = "Electric Lamp \n 600/600",
	tiles = {
		"europa_nodes_electric_lamp_top.png",
		"europa_nodes_electric_lamp_top.png",
		"europa_nodes_electric_lamp.png",
	},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.35, 0.25}
	},
	paramtype = "light",
	groups = {cracky = 3, melty = 3, handy = 3, chargeable_node = 1},
	preserve_metadata = function(pos, oldnode, oldmeta, drops)
		local meta = drops[1]:get_meta()
		local om_charge = oldmeta.charge or default_charge
		meta:set_int("charge", om_charge)
		meta:set_string("description", "Electric Lamp\n"..tostring(om_charge).."/600")
	end,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		local itemstack_meta = itemstack:get_meta()
		local previous_charge = itemstack_meta:contains("charge") and itemstack_meta:get_int("charge")
		meta:set_int("charge", previous_charge or default_charge)
		local timer = minetest.get_node_timer(pos)
		timer:start(1) -- if 1, 1 second power draw (1 = 1 second delay)
	end,
	on_rightclick = function(pos)
		minetest.swap_node(pos, {name="europa_nodes:electric_lamp_on"})
	end,
})

minetest.register_node("europa_nodes:electric_lamp_on", {
	description = "Electric Lamp \n 600/600",
	tiles = {
		"europa_nodes_electric_lamp_top.png",
		"europa_nodes_electric_lamp_top.png",
		"europa_nodes_electric_lamp_on.png",
	},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.35, 0.25}
	},
	paramtype = "light",
	light_source = 14,
	drop = "europa_nodes:electric_lamp",
	groups = {cracky = 3, melty = 3, handy = 3, not_in_creative_inventory = 1, chargeable_node = 1},
	preserve_metadata = function(pos, oldnode, oldmeta, drops)
		local meta = drops[1]:get_meta()
		local om_charge = oldmeta.charge
		meta:set_int("charge", om_charge)
		meta:set_string("description", "Electric Lamp\n"..tostring(om_charge).."/600")
	end,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		local itemstack_meta = itemstack:get_meta()
		local previous_charge = itemstack_meta:contains("charge") and itemstack_meta:get_int("charge")
		meta:set_int("charge", previous_charge or default_charge)
		local timer = minetest.get_node_timer(pos)
		timer:start(1) -- if 1, 1 second power draw (1 = 1 second delay)
	end,
	on_timer = function(pos)
		local meta = minetest.get_meta(pos)
		local charge = meta:get_int("charge")
		if charge > 0 then
			meta:set_int("charge", charge - 1) -- if 1, 1 power draw per second
		else
			minetest.set_node(pos, {name="europa_nodes:electric_lamp_depleted"})
			minetest.log("info", "europa_nodes: electric lamp depleted at "..minetest.pos_to_string(pos))
		end
		return true
	end,
	on_rightclick = function(pos)
		minetest.swap_node(pos, {name="europa_nodes:electric_lamp"})
	end,
})

minetest.register_node("europa_nodes:electric_lamp_depleted", {
	description = "Depleted Electric Lamp",
	tiles = {
		"europa_nodes_electric_lamp_top.png",
		"europa_nodes_electric_lamp_top.png",
		"europa_nodes_electric_lamp_dep.png",
	},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.35, 0.25}
	},
	paramtype = "light",
	light_source = 14,
	groups = {cracky = 3, melty = 3, handy = 3, chargeable_node = 1}
})

minetest.register_node("europa_nodes:glowstick", {
	description = "Glowstick",
	tiles = {"europa_nodes_glowstick.png"},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.125, -0.5, -0.125, 0.125, 0.35, 0.125}
	},
	paramtype = "light",
	light_source = 8,
	groups = {cracky = 3, melty = 3, handy = 3}
})


