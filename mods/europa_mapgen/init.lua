-- registering the nodes for all mapgens

minetest.register_alias("mapgen_stone", "europa_nodes:core_iron_nickel")
minetest.register_alias("mapgen_water_source", "europa_nodes:water_source")
minetest.register_alias("mapgen_river_water_source", "europa_nodes:water_source")

minetest.clear_registered_biomes()
minetest.clear_registered_ores()
minetest.clear_registered_decorations()

minetest.register_ore({
	ore_type        = "stratum",
	ore             = "europa_nodes:silicate",
	wherein         = {"air", "europa_nodes:ice_hard"},
	clust_scarcity  = 4 * 4 * 4,
	y_max           = 8,
	y_min           = 0,
	noise_params    = {
		offset = 28,
		scale = 16,
		spread = {x = 128, y = 128, z = 128},
		seed = 90122,
		octaves = 1,
	},
	stratum_thickness = 8,
})

minetest.register_ore({
	ore_type        = "stratum",
	ore             = "europa_nodes:magnesium_sulfate",
	wherein         = {"europa_nodes:ice_hard"},
	clust_scarcity  = 5 * 5 * 5,
	y_max           = 64,
	y_min           = -8,
	noise_params    = {
		offset = 28,
		scale = 16,
		spread = {x = 128, y = 128, z = 128},
		seed = 90122,
		octaves = 1,
	},
	stratum_thickness = 32,
})

minetest.register_ore({
	ore_type        = "stratum",
	ore             = "europa_nodes:ice_hard",
	wherein         = {"europa_nodes:water_source"},
	clust_scarcity  = 1,
	y_max           = 64,
	y_min           = -32,
	noise_params    = {
		offset = 28,
		scale = 16,
		spread = {x = 128, y = 128, z = 128},
		seed = 90122,
		octaves = 1,
	},
	stratum_thickness = 32,
})

minetest.register_ore({
	ore_type        = "stratum",
	ore             = "europa_nodes:ice",
	wherein         = {"europa_nodes:water_source"},
	clust_scarcity  = 2 * 2 * 2,
	y_max           = -32,
	y_min           = -128,
	noise_params    = {
		offset = 28,
		scale = 16,
		spread = {x = 128, y = 128, z = 128},
		seed = 90122,
		octaves = 1,
	},
	stratum_thickness = 32,
})

minetest.register_ore({
	ore_type        = "blob",
	ore             = "europa_nodes:core_iron",
	wherein         = {"europa_nodes:core_iron_nickel"},
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 5,
	y_max           = -364,
	y_min           = -31000,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = -316,
		octaves = 1,
		persist = 0.0
	},
})

minetest.register_ore({
	ore_type        = "blob",
	ore             = "europa_nodes:core_nickel",
	wherein         = {"europa_nodes:core_iron_nickel"},
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 5,
	y_max           = -256,
	y_min           = -31000,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = -316,
		octaves = 1,
		persist = 0.0
	},
})

-- biomes

minetest.register_biome({
	name = "polar",
	node_top = "europa_nodes:ice_hard",
	depth_top = 40,
	node_filler = "europa_nodes:ice",
	depth_filler = 16,
	node_stone = "europa_nodes:water_source",
	node_water_top = "europa_nodes:ice_warm",
	depth_water_top = 24,
	node_river_water = "europa_nodes:water_source",
	node_riverbed = "europa_nodes:ice_warm",
	depth_riverbed = 8,
	y_max = 31000,
	y_min = -128,
	heat_point = -100,
	humidity_point = 80,
})

minetest.register_biome({
	name = "equator",
	node_top = "europa_nodes:ice_hard",
	depth_top = 32,
	node_filler = "europa_nodes:ice",
	depth_filler = 16,
	node_stone = "europa_nodes:water_source",
	node_water_top = "europa_nodes:ice_warm",
	depth_water_top = 16,
	node_river_water = "europa_nodes:water_source",
	node_riverbed = "europa_nodes:ice_warm",
	depth_riverbed = 4,
	y_max = 31000,
	y_min = -128,
	heat_point = -80,
	humidity_point = 90,
})

minetest.register_biome({
	name = "cryogeyser",
	node_top = "europa_nodes:ice_hard",
	depth_top = 64,
	node_filler = "europa_nodes:ice",
	depth_filler = 32,
	node_stone = "europa_nodes:water_source",
	node_riverbed = "europa_nodes:ice_warm",
	depth_riverbed = 16,
	y_max = 31000,
	y_min = -128,
	heat_point = -60,
	humidity_point = 100,
})

--
-- decorations
--

-- Penitentes

minetest.register_decoration({
	name = "europa_mapgen:penitentes",
	deco_type = "simple",
	place_on = {"europa_nodes:ice_hard", "europa_nodes:ice"},
	sidelen = 16,
	noise_params = {
		offset = -0.3,
		scale = 0.7,
		spread = {x = 100, y = 100, z = 100},
		seed = 354,
		octaves = 3,
		persist = 0.7
	},
	y_max = 32,
	y_min = -8,
	biomes = {"equator"},
	decoration = "europa_nodes:ice_hard",
	height = 8,
	height_max = 16,
})
