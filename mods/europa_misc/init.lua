-- europa_misc/init.lua

local modpath = minetest.get_modpath("europa_misc")

local S = minetest.get_translator("europa_misc")

dofile(modpath.."/weather.lua")
dofile(modpath.."/sfinv.lua")
dofile(modpath.."/player_api.lua")
dofile(modpath.."/spawn.lua")
dofile(modpath.."/creative.lua")

minetest.log("[ACTION] Europa Basemod: Europa Misc, Loaded.")