--
-- Sounds
--

europa_sounds = {}

function europa_sounds.node_sound_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "", gain = 1.0}
	table.dug = table.dug or
			{name = "europa_nodes_dug_node", gain = 0.25}
	table.place = table.place or
			{name = "europa_nodes_place_node_hard", gain = 1.0}
	return table
end

function europa_sounds.node_sound_stone_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "europa_nodes_hard_footstep", gain = 0.2}
	table.dug = table.dug or
			{name = "europa_nodes_hard_footstep", gain = 1.0}
	europa_sounds.node_sound_defaults(table)
	return table
end

function europa_sounds.node_sound_soil_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "europa_nodes_dirt_footstep", gain = 0.25}
	table.dig = table.dig or
			{name = "europa_nodes_dig_crumbly", gain = 0.4}
	table.dug = table.dug or
			{name = "europa_nodes_dirt_footstep", gain = 1.0}
	table.place = table.place or
			{name = "europa_nodes_place_node", gain = 1.0}
	europa_sounds.node_sound_defaults(table)
	return table
end

function europa_sounds.node_sound_sand_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "europa_nodes_sand_footstep", gain = 0.05}
	table.dug = table.dug or
			{name = "europa_nodes_sand_footstep", gain = 0.15}
	table.place = table.place or
			{name = "europa_nodes_place_node", gain = 1.0}
	europa_sounds.node_sound_defaults(table)
	return table
end

function europa_sounds.node_sound_gravel_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "europa_nodes_gravel_footstep", gain = 0.25}
	table.dig = table.dig or
			{name = "europa_nodes_gravel_dig", gain = 0.35}
	table.dug = table.dug or
			{name = "europa_nodes_gravel_dug", gain = 1.0}
	table.place = table.place or
			{name = "europa_nodes_place_node", gain = 1.0}
	europa_sounds.node_sound_defaults(table)
	return table
end

function europa_sounds.node_sound_hollow_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "europa_nodes_wood_footstep", gain = 0.15}
	table.dig = table.dig or
			{name = "europa_nodes_dig_choppy", gain = 0.4}
	table.dug = table.dug or
			{name = "europa_nodes_wood_footstep", gain = 1.0}
	europa_sounds.node_sound_defaults(table)
	return table
end

function europa_sounds.node_sound_glass_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "europa_nodes_glass_footstep", gain = 0.3}
	table.dig = table.dig or
			{name = "europa_nodes_glass_footstep", gain = 0.5}
	table.dug = table.dug or
			{name = "europa_nodes_break_glass", gain = 1.0}
	europa_sounds.node_sound_defaults(table)
	return table
end

function europa_sounds.node_sound_ice_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "europa_nodes_ice_footstep", gain = 0.15}
	table.dig = table.dig or
			{name = "europa_nodes_ice_dig", gain = 0.5}
	table.dug = table.dug or
			{name = "europa_nodes_ice_dug", gain = 0.5}
	europa_sounds.node_sound_defaults(table)
	return table
end

function europa_sounds.node_sound_metal_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "europa_nodes_metal_footstep", gain = 0.2}
	table.dig = table.dig or
			{name = "europa_nodes_dig_metal", gain = 0.5}
	table.dug = table.dug or
			{name = "europa_nodes_dug_metal", gain = 0.5}
	table.place = table.place or
			{name = "europa_nodes_place_node_metal", gain = 0.5}
	europa_sounds.node_sound_defaults(table)
	return table
end

function europa_sounds.node_sound_liquid_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "europa_nodes_water_footstep", gain = 0.2}
	europa_sounds.node_sound_defaults(table)
	return table
end

function europa_sounds.node_sound_crunchy_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "europa_nodes_snow_footstep", gain = 0.2}
	table.dig = table.dig or
			{name = "europa_nodes_snow_footstep", gain = 0.3}
	table.dug = table.dug or
			{name = "europa_nodes_snow_footstep", gain = 0.3}
	table.place = table.place or
			{name = "europa_nodes_place_node", gain = 1.0}
	europa_sounds.node_sound_defaults(table)
	return table
end
