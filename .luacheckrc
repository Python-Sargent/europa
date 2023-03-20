unused_args = false
allow_defined_top = true

read_globals = {
	"DIR_DELIM",
	"minetest",
	"dump",
	"vector",
	"VoxelManip", "VoxelArea",
	"PseudoRandom", "PcgRandom",
	"ItemStack",
	"Settings",
	"unpack",
	-- Silence errors about custom table methods.
	table = { fields = { "copy", "indexof" } },
	-- Silence warnings about accessing undefined fields of global 'math'
	math = { fields = { "sign" } }
}

-- Overwrites minetest.handle_node_drops
files["mods/europa_misc/creative.lua"].globals = { "minetest" }

-- Overwrites minetest.calculate_knockback
files["mods/europa_misc/player_api.lua"].globals = { "minetest" }
