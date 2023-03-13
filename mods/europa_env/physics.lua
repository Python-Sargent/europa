-- set player gravity for to europa's mean-grav

minetest.register_on_joinplayer(function(player)
	player:set_physics_override({
        gravity = 0.117, -- set gravity to 11.7% of its original value
                       -- (0.117 * 9.81 ~ 1.15)
    })
end)