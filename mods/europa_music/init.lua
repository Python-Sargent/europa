-- music down loaded free from Pixabay, thanks to pixabay for the music in this mod.

europa_music = {}

europa_music.nostop = {
	track = "europa_music_track",
	track_delay = 600 --default 60 (10 min)
}

europa_music.play_track_nostop = function()
	local handle = minetest.sound_play(europa_music.nostop.track, {gain = 0.7})
	minetest.after(europa_music.nostop.track_delay, europa_music.play_track_nostop) -- recursively play the track every N seconds
end

europa_music.load_start_delay = 300 --default 300 (5 min)

minetest.register_on_mods_loaded(function()
	minetest.after(europa_music.load_start_delay, europa_music.play_track_nostop)
end)