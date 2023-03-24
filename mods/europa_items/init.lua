-- craftitems (food, crafting materials, fuel, tools, etc.)

local S = minetest.get_translator("europa_items")

minetest.override_item("", {
	wield_scale = {x=1,y=1,z=2.5},
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[2]=3.00, [3]=0.70}, uses=0, maxlevel=1},
			snappy = {times={[3]=0.40}, uses=0, maxlevel=1},
			handy = {times={[3]=0.70, [2]=0.30, [3]=0.10}, uses=0, maxlevel=3},
			oddly_breakable_by_hand = {times={[1]=3.50,[2]=2.00,[3]=0.70}, uses=0}
		},
		damage_groups = {fleshy=1},
	}
})

--
-- Food
--

minetest.register_craftitem("europa_items:energy_bar", {
	description = S("Energy Bar"),
	inventory_image = "europa_items_energy_bar.png",
	groups = {edible = 1},
	on_use = minetest.item_eat(6),
})

minetest.register_craftitem("europa_items:energy_drink", {
	description = S("Energy Drink"),
	inventory_image = "europa_items_energy_drink.png",
	groups = {edible = 1},
	on_use = minetest.item_eat(6),
})

minetest.register_craftitem("europa_items:day_meal", {
	description = S("24 Hour Meal Pack"),
	inventory_image = "europa_items_day_meal.png",
	groups = {edible = 1},
	on_use = minetest.item_eat(20),
})

minetest.register_craftitem("europa_items:space_rations", {
	description = S("Space Rations"),
	inventory_image = "europa_items_space_rations.png",
	groups = {edible = 1},
	on_use = minetest.item_eat(8),
})

minetest.register_craftitem("europa_items:space_rations_expired", {
	description = S("Space Rations (expired)"),
	inventory_image = "europa_items_space_rations_expired.png",
	groups = {edible = 1},
	on_use = minetest.item_eat(4),
})

--
-- Craftitems
--

minetest.register_craftitem("europa_items:tool_housing", {
	description = S("Tool Housing"),
	inventory_image = "europa_items_tool_housing.png"
})

minetest.register_craftitem("europa_items:battery", {
	description = S("New Small Battery"),
	inventory_image = "europa_items_battery_small.png",
	groups = {battery=1, chargeable=1}
})

minetest.register_craftitem("europa_items:battery_charged", {
	description = S("Small Charged Battery"),
	inventory_image = "europa_items_battery_small_charged.png",
	groups = {battery=1}
})

minetest.register_craftitem("europa_items:battery_dead", {
	description = S("Small Dead Battery"),
	inventory_image = "europa_items_battery_small_dead.png",
	groups = {battery=1, chargeable=1}
})

minetest.register_craftitem("europa_items:silicate_crystal", {
	description = S("Silicate Crystal"),
	inventory_image = "europa_items_silicate_crystal.png",
	groups = {crystal=1}
})

minetest.register_craftitem("europa_items:hardened_silicate_crystal", {
	description = S("Hardened Silicate Crystal"),
	inventory_image = "europa_items_silicate_crystal_hardened.png",
	groups = {crystal=1}
})

minetest.register_craftitem("europa_items:nickel_ingot", {
	description = S("Nickel Ingot"),
	inventory_image = "europa_items_nickel_ingot.png",
	groups = {core_metal = 1, metal=1}
})

minetest.register_craftitem("europa_items:iron_ingot", {
	description = S("Iron Ingot"),
	inventory_image = "europa_items_iron_ingot.png",
	groups = {core_metal = 1, metal=1}
})

minetest.register_craftitem("europa_items:steel_ingot", {
	description = S("Steel Ingot"),
	inventory_image = "europa_items_steel_ingot.png",
	groups = {metal_alloy = 1, metal=1}
})

minetest.register_craftitem("europa_items:nickel_steel_ingot", {
	description = S("Nickel Steel Ingot"),
	inventory_image = "europa_items_nickel_steel_ingot.png",
	groups = {metal_alloy = 1, metal=1}
})

minetest.register_craftitem("europa_items:platinum_ingot", {
	description = S("Platinum Ingot"),
	inventory_image = "europa_items_platinum_ingot.png",
	groups = {special_metal = 1, metal=1}
})

minetest.register_craftitem("europa_items:titanium_ingot", {
	description = S("Titanium Ingot"),
	inventory_image = "europa_items_titanium_ingot.png",
	groups = {special_metal = 1, metal=1}
})

minetest.register_craftitem("europa_items:stainless_ingot", {
	description = S("Stainless Steel Ingot"),
	inventory_image = "europa_items_stainless_ingot.png",
	groups = {metal_alloy = 1, metal=1}
})

minetest.register_craftitem("europa_items:chromium_ingot", {
	description = S("Chromium Ingot"),
	inventory_image = "europa_items_chromium_ingot.png",
	groups = {special_metal = 1, metal=1}
})

--
-- Tools
--

minetest.register_tool("europa_items:drill_silicate", {
	description = S("Silicate Drill"),
	inventory_image = "europa_items_drill_silicate.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[2]=4.90, [2]=2.50, [3]=1.40}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "europa_sounds_tool_breaks"},
	groups = {drill = 1, chargeable = 1}
})

minetest.register_tool("europa_items:drill_nickel", {
	description = S("Nickel Drill"),
	inventory_image = "europa_items_drill_nickel.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[2]=1.50, [3]=0.80}, uses=15, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "europa_sounds_tool_breaks"},
	groups = {drill = 1, chargeable = 1}
})

minetest.register_tool("europa_items:drill_iron", {
	description = S("Iron Drill"),
	inventory_image = "europa_items_drill_iron.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "europa_sounds_tool_breaks"},
	groups = {drill = 1, chargeable = 1}
})

minetest.register_tool("europa_items:drill_nickel_steel", {
	description = S("Nickel Steel Drill"),
	inventory_image = "europa_items_drill_nickel_steel.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[1]=4.30, [2]=1.70, [3]=0.80}, uses=25, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "europa_sounds_tool_breaks"},
	groups = {drill = 1, chargeable = 1}
})

minetest.register_tool("europa_items:drill_steel", {
	description = S("Steel Drill"),
	inventory_image = "europa_items_drill_steel.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=30, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "europa_sounds_tool_breaks"},
	groups = {drill = 1, chargeable = 1}
})

minetest.register_tool("europa_items:drill_stainless", {
	description = S("Stainless Steel Drill"),
	inventory_image = "europa_items_drill_stainless.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[1]=3.90, [2]=1.50, [3]=0.80}, uses=30, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "europa_sounds_tool_breaks"},
	groups = {drill = 1, chargeable = 1}
})

minetest.register_tool("europa_items:drill_platinum", {
	description = S("Platinum Drill"),
	inventory_image = "europa_items_drill_platinum.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[1]=3.00, [2]=1.30, [3]=0.70}, uses=35, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "europa_sounds_tool_breaks"},
	groups = {drill = 1, chargeable = 1}
})

minetest.register_tool("europa_items:drill_titanium", {
	description = S("Titanium Drill"),
	inventory_image = "europa_items_drill_titanium.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[1]=2.80, [2]=1.20, [3]=0.70}, uses=35, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "europa_sounds_tool_breaks"},
	groups = {drill = 1, chargeable = 1}
})

--
-- Crafts
--
--[[
minetest.register_craft({
	output = "",
	recipe = {
		{"", "", ""},
		{"", "", ""},
		{"", "", ""},
	}
})
]]--

-- drills

minetest.register_craft({
	output = "europa_items:drill_silicate",
	recipe = {
		{"europa_items:silicate_crystal_hardened"},
		{"europa_items:tool_housing"},
	}
})

minetest.register_craft({
	output = "europa_items:drill_nickel",
	recipe = {
		{"europa_items:nickel_ingot"},
		{"europa_items:tool_housing"},
	}
})

minetest.register_craft({
	output = "europa_items:drill_iron",
	recipe = {
		{"europa_items:iron_ingot"},
		{"europa_items:tool_housing"},
	}
})

minetest.register_craft({
	output = "europa_items:drill_nickel_steel",
	recipe = {
		{"europa_items:nickel_steel_ingot"},
		{"europa_items:tool_housing"},
	}
})

minetest.register_craft({
	output = "europa_items:drill_steel",
	recipe = {
		{"europa_items:steel_ingot"},
		{"europa_items:tool_housing"},
	}
})

minetest.register_craft({
	output = "europa_items:drill_platinum",
	recipe = {
		{"europa_items:platinum_ingot"},
		{"europa_items:tool_housing"},
	}
})

minetest.register_craft({
	output = "europa_items:drill_titanium",
	recipe = {
		{"europa_items:titanium_ingot"},
		{"europa_items:tool_housing"},
	}
})

minetest.register_craft({
	output = "europa_items:drill_stainless",
	recipe = {
		{"europa_items:stainless_ingot"},
		{"europa_items:tool_housing"},
	}
})

minetest.register_craft({
	output = "europa_items:drill_stainless",
	recipe = {
		{"europa_items:stainless_ingot"},
		{"europa_items:tool_housing"},
	}
})

-- tool stuff

minetest.register_craft({
	output = "europa_items:tool_housing",
	recipe = {
		{"", "group:metal_alloy", ""},
		{"group:metal_alloy", "europa_items:battery_charged", "group:metal_alloy"},
		{"", "group:metal_alloy", ""},
	}
})

minetest.register_craft({
	output = "europa_items:battery",
	recipe = {
		{"group:core_metal", "group:metal_alloy"},
		{"group:core_metal", "group:special_metal"},
	}
})

minetest.register_craft({
	output = "europa_items:battery_large",
	recipe = {
		{"group:core_metal", "group:metal_alloy", "group:special_metal"},
		{"group:core_metal", "group:metal_alloy", "group:special_metal"},
		{"group:core_metal", "group:metal_alloy", "group:special_metal"},
	}
})

-- refineable (cooking)

minetest.register_craft({
	type = "cooking",
	output = "europa_items:silicate_crystal_hardened",
	recipe = "europa_items:silicate_crystal"
})

minetest.register_craft({
	type = "cooking",
	output = "europa_items:nickel_ingot",
	recipe = "europa_nodes:core_nickel"
})

minetest.register_craft({
	type = "cooking",
	output = "europa_items:iron_ingot",
	recipe = "europa_nodes:core_iron"
})

minetest.register_craft({
	type = "cooking",
	output = "europa_items:nickel_steel_ingot",
	recipe = "europa_nodes:core_iron_nickel"
})

minetest.register_craft({
	type = "cooking",
	output = "europa_items:steel_ingot",
	recipe = "europa_itmes:iron_ingot"
})

minetest.register_craft({
	type = "cooking",
	output = "europa_items:platinum_ingot",
	recipe = "europa_nodes:meteor_platinum"
})

minetest.register_craft({
	type = "cooking",
	output = "europa_items:titanium_ingot",
	recipe = "europa_nodes:meteor_titanium"
})

minetest.register_craft({
	type = "cooking",
	output = "europa_items:chromium_ingot",
	recipe = "europa_nodes:meteor_chromium"
})

minetest.register_craft({
	type = "shapeless",
	output = "europa_items:stainless_ingot",
	recipe = {"europa_items:chromium_ingot", "europa_items:iron_ingot", "europa_items:nickel_ingot"}
})

minetest.register_craft({
	type = "fuel",
	recipe = "europa_items:battery_charged",
	burntime = 60,
	replacements = {{"europa_items:battery_charged", "europa_items:battery_dead"}},
})


