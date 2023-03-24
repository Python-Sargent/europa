-- europa_nodes/refiner.lua

-- support for MT game translation.
local S = minetest.get_translator("europa_nodes")

-- List of sound handles for active refiner
local refiner_fire_sounds = {}

--
-- Formspecs
--

function europa_nodes.get_refiner_active_formspec(power_percent, item_percent)
	return "size[8,8.5]"..
		"list[context;src;2.75,0.5;1,1;]"..
		"list[context;power;2.75,2.5;1,1;]"..
		"image[2.75,1.5;1,1;europa_nodes_refiner_fire_bg.png^[lowpart:"..
		(power_percent)..":europa_nodes_refiner_fire_fg.png]"..
		"image[3.75,1.5;1,1;gui_refiner_arrow_bg.png^[lowpart:"..
		(item_percent)..":gui_refiner_arrow_fg.png^[transformR270]"..
		"list[context;dst;4.75,0.96;2,2;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[context;dst]"..
		"listring[current_player;main]"..
		"listring[context;src]"..
		"listring[current_player;main]"..
		"listring[context;power]"..
		"listring[current_player;main]"
end

function europa_nodes.get_refiner_inactive_formspec()
	return "size[8,8.5]"..
		"list[context;src;2.75,0.5;1,1;]"..
		"list[context;power;2.75,2.5;1,1;]"..
		"image[2.75,1.5;1,1;europa_nodes_refiner_fire_bg.png]"..
		"image[3.75,1.5;1,1;gui_refiner_arrow_bg.png^[transformR270]"..
		"list[context;dst;4.75,0.96;2,2;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[context;dst]"..
		"listring[current_player;main]"..
		"listring[context;src]"..
		"listring[current_player;main]"..
		"listring[context;power]"..
		"listring[current_player;main]"
end

--
-- Node callback functions that are the same for active and inactive refiner
--

local function can_dig(pos, player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	return inv:is_empty("power") and inv:is_empty("dst") and inv:is_empty("src")
end

local function allow_metadata_inventory_put(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if listname == "power" then
		if minetest.get_craft_result({method="fuel", width=1, items={stack}}).time ~= 0 then
			if inv:is_empty("src") then
				meta:set_string("infotext", S("refiner is empty"))
			end
			return stack:get_count()
		else
			return 0
		end
	elseif listname == "src" then
		return stack:get_count()
	elseif listname == "dst" then
		return 0
	end
end

local function allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stack = inv:get_stack(from_list, from_index)
	return allow_metadata_inventory_put(pos, to_list, to_index, stack, player)
end

local function allow_metadata_inventory_take(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	return stack:get_count()
end

local function stop_refiner_sound(pos, fadeout_step)
	local hash = minetest.hash_node_position(pos)
	local sound_ids = refiner_fire_sounds[hash]
	if sound_ids then
		for _, sound_id in ipairs(sound_ids) do
			minetest.sound_fade(sound_id, -1, 0)
		end
		refiner_fire_sounds[hash] = nil
	end
end

local function swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

local function refiner_node_timer(pos, elapsed)
	--
	-- Initialize metadata
	--
	local meta = minetest.get_meta(pos)
	local power_time = meta:get_float("power_time") or 0
	local src_time = meta:get_float("src_time") or 0
	local power_totaltime = meta:get_float("power_totaltime") or 0

	local inv = meta:get_inventory()
	local srclist, powerlist
	local dst_full = false

	local timer_elapsed = meta:get_int("timer_elapsed") or 0
	meta:set_int("timer_elapsed", timer_elapsed + 1)

	local cookable, cooked
	local power

	local update = true
	while elapsed > 0 and update do
		update = false

		srclist = inv:get_list("src")
		powerlist = inv:get_list("power")

		--
		-- Cooking
		--

		-- Check if we have cookable content
		local aftercooked
		cooked, aftercooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		cookable = cooked.time ~= 0

		local el = math.min(elapsed, power_totaltime - power_time)
		if cookable then -- power lasts long enough, adjust el to cooking duration
			el = math.min(el, cooked.time - src_time)
		end

		-- Check if we have enough power to burn
		if power_time < power_totaltime then
			-- The refiner is currently active and has enough power
			power_time = power_time + el
			-- If there is a cookable item then check if it is ready yet
			if cookable then
				src_time = src_time + el
				if src_time >= cooked.time then
					-- Place result in dst list if possible
					if inv:room_for_item("dst", cooked.item) then
						inv:add_item("dst", cooked.item)
						inv:set_stack("src", 1, aftercooked.items[1])
						src_time = src_time - cooked.time
						update = true
					else
						dst_full = true
					end
					-- Play cooling sound
					minetest.sound_play("europa_nodes_cool_lava",
						{pos = pos, max_hear_distance = 16, gain = 0.07}, true)
				else
					-- Item could not be cooked: probably missing power
					update = true
				end
			end
		else
			-- refiner ran out of power
			if cookable then
				-- We need to get new power
				local afterpower
				power, afterpower = minetest.get_craft_result({method = "fuel", width = 1, items = powerlist})

				if power.time == 0 then
					-- No valid power in power list
					power_totaltime = 0
					src_time = 0
				else
					-- prevent blocking of power inventory (for automatization mods)
					local is_power = minetest.get_craft_result({method = "fuel", width = 1, items = {afterpower.items[1]:to_string()}})
					if is_power.time == 0 then
						table.insert(power.replacements, afterpower.items[1])
						inv:set_stack("power", 1, "")
					else
						-- Take power from power list
						inv:set_stack("power", 1, afterpower.items[1])
					end
					-- Put replacements in dst list or drop them on the refiner.
					local replacements = power.replacements
					if replacements[1] then
						local leftover = inv:add_item("dst", replacements[1])
						if not leftover:is_empty() then
							local above = vector.new(pos.x, pos.y + 1, pos.z)
							local drop_pos = minetest.find_node_near(above, 1, {"air"}) or above
							minetest.item_drop(replacements[1], nil, drop_pos)
						end
					end
					update = true
					power_totaltime = power.time + (power_totaltime - power_time)
				end
			else
				-- We don't need to get new power since there is no cookable item
				power_totaltime = 0
				src_time = 0
			end
			power_time = 0
		end

		elapsed = elapsed - el
	end

	if power and power_totaltime > power.time then
		power_totaltime = power.time
	end
	if srclist and srclist[1]:is_empty() then
		src_time = 0
	end

	--
	-- Update formspec, infotext and node
	--
	local formspec
	local item_state
	local item_percent = 0
	if cookable then
		item_percent = math.floor(src_time / cooked.time * 100)
		if dst_full then
			item_state = S("100% (output full)")
		else
			item_state = S("@1%", item_percent)
		end
	else
		if srclist and not srclist[1]:is_empty() then
			item_state = S("Not cookable")
		else
			item_state = S("Empty")
		end
	end

	local power_state = S("Empty")
	local active = false
	local result = false

	if power_totaltime ~= 0 then
		active = true
		local power_percent = 100 - math.floor(power_time / power_totaltime * 100)
		power_state = S("@1%", power_percent)
		formspec = europa_nodes.get_refiner_active_formspec(power_percent, item_percent)
		swap_node(pos, "europa_nodes:refiner_active")
		-- make sure timer restarts automatically
		result = true

		-- Play sound every 5 seconds while the refiner is active
		if timer_elapsed == 0 or (timer_elapsed + 1) % 5 == 0 then
			local sound_id = minetest.sound_play("europa_nodes_refiner_active",
				{pos = pos, max_hear_distance = 16, gain = 0.25})
			local hash = minetest.hash_node_position(pos)
			refiner_fire_sounds[hash] = refiner_fire_sounds[hash] or {}
			table.insert(refiner_fire_sounds[hash], sound_id)
			-- Only remember the 3 last sound handles
			if #refiner_fire_sounds[hash] > 3 then
				table.remove(refiner_fire_sounds[hash], 1)
			end
			-- Remove the sound ID automatically from table after 11 seconds
			minetest.after(11, function()
				if not refiner_fire_sounds[hash] then
					return
				end
				for f=#refiner_fire_sounds[hash], 1, -1 do
					if refiner_fire_sounds[hash][f] == sound_id then
						table.remove(refiner_fire_sounds[hash], f)
					end
				end
				if #refiner_fire_sounds[hash] == 0 then
					refiner_fire_sounds[hash] = nil
				end
			end)
		end
	else
		if powerlist and not powerlist[1]:is_empty() then
			power_state = S("@1%", 0)
		end
		formspec = europa_nodes.get_refiner_inactive_formspec()
		swap_node(pos, "europa_nodes:refiner")
		-- stop timer on the inactive refiner
		minetest.get_node_timer(pos):stop()
		meta:set_int("timer_elapsed", 0)

		stop_refiner_sound(pos)
	end


	local infotext
	if active then
		infotext = S("refiner active")
	else
		infotext = S("refiner inactive")
	end
	infotext = infotext .. "\n" .. S("(Item: @1; power: @2)", item_state, power_state)

	--
	-- Set meta values
	--
	meta:set_float("power_totaltime", power_totaltime)
	meta:set_float("power_time", power_time)
	meta:set_float("src_time", src_time)
	meta:set_string("formspec", formspec)
	meta:set_string("infotext", infotext)

	return result
end

--
-- Node definitions
--

minetest.register_node("europa_nodes:refiner", {
	description = S("Refiner"),
	tiles = {
		"europa_nodes_refiner_funnel.png",
		"europa_nodes_refiner_body.png",
		"europa_nodes_refiner_inside.png",
	},
	drawtype = "mesh",
	mesh = "refiner.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=3, melty=3, not_in_creative_inventory=1},

	can_dig = can_dig,

	on_timer = refiner_node_timer,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('src', 1)
		inv:set_size('power', 1)
		inv:set_size('dst', 4)
		refiner_node_timer(pos, 0)
	end,

	on_metadata_inventory_move = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_put = function(pos)
		-- start timer function, it will sort out whether refiner can burn or not.
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_take = function(pos)
		-- check whether the refiner is empty or not.
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_blast = function(pos)
		local drops = {}
		europa_nodes.get_inventory_drops(pos, "src", drops)
		europa_nodes.get_inventory_drops(pos, "power", drops)
		europa_nodes.get_inventory_drops(pos, "dst", drops)
		drops[#drops+1] = "europa_nodes:refiner"
		minetest.remove_node(pos)
		return drops
	end,

	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
})

minetest.register_node("europa_nodes:refiner_active", {
	description = S("Refiner"),
	tiles = {
		"europa_nodes_refiner_funnel.png",
		"europa_nodes_refiner_body.png",
		"europa_nodes_refiner_inside.png",
	},
	drawtype = "mesh",
	mesh = "refiner.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 8,
	drop = "europa_nodes:refiner",
	groups = {cracky=3, melty=3, not_in_creative_inventory=1},
	on_timer = refiner_node_timer,
	on_destruct = function(pos)
		stop_refiner_sound(pos)
	end,

	can_dig = can_dig,

	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
})

minetest.register_craft({
	output = "europa_nodes:refiner",
	recipe = {
		{"group:metal_alloy", "group:core_metal", "group:metal_alloy"},
		{"group:metal_alloy", "", "group:metal_alloy"},
		{"group:metal_alloy", "group:special_metal", "group:metal_alloy"},
	}
})
