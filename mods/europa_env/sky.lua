-- change sky params

minetest.register_on_joinplayer(function(player)
	sky_def = {
		clouds = false,
		sky_color = {
			day_sky = "#000011",
			day_horizion = "000002",
			dawn_sky = "#000009",
			dawn_horizion = "000010",
			night_sky = "#000002",
			night_horizion = "#000005",
			indoors = "#111111",
			--fog_sun_tint = "",
			--fog_moon_tint = "", -- (Jupiter)
			fog_tint_type = "default",
		},
	}
	player:set_sky(sky_def)

	jupiter_def = {
		visible = true,
	}
	player:set_moon(jupiter_def)

	stars_def = {
		visible = true,
		count = 5000,
		day_opacity = 1.0,
		star_color = "#ffffee",
		scale = 1
	}
	player:set_stars(stars_def)
end)