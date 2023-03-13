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

minetest.register_craftitem("europa_items:silicate_crystal", {
	description = S("Silicate Crystal"),
	inventory_image = "europa_items_silicate_crystal.png"
})

minetest.register_craftitem("europa_items:hardened_silicate_crystal", {
	description = S("Hardened Silicate Crystal"),
	inventory_image = "europa_items_silicate_crystal_hardened.png"
})

minetest.register_craftitem("europa_items:nickel_ingot", {
	description = S("Nickel Ingot"),
	inventory_image = "europa_items_nickel_ingot.png"
})

minetest.register_craftitem("europa_items:iron_ingot", {
	description = S("Iron Ingot"),
	inventory_image = "europa_items_iron_ingot.png"
})

minetest.register_craftitem("europa_items:steel_ingot", {
	description = S("Steel Ingot"),
	inventory_image = "europa_items_steel_ingot.png"
})

minetest.register_craftitem("europa_items:nickel_steel_ingot", {
	description = S("Nickel Steel Ingot"),
	inventory_image = "europa_items_nickel_steel_ingot.png"
})

minetest.register_tool("europa_items:drill_silicate", {
	description = S("Silicate Drill"),
	inventory_image = "europa_items_tool_drill_silicate.png",
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
	inventory_image = "europa_items_tool_drill_nickel.png",
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
	inventory_image = "europa_items_tool_drill_iron.png",
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

minetest.register_tool("europa_items:drill_steel", {
	description = S("Steel Drill"),
	inventory_image = "europa_items_tool_drill_steel.png",
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

minetest.register_tool("europa_items:drill_nickel_steel", {
	description = S("Nickel Steel Drill"),
	inventory_image = "europa_items_tool_drill_nickel_steel.png",
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

