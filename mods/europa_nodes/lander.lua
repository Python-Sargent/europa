europa_nodes.lander = {}

local S = minetest.get_translator("europa_nodes")

--
function europa_nodes.lander.get_lander_formspec(pos, charge, fuel)
	local spos = pos.x .. "," .. pos.y .. "," .. pos.z
	local meta = minetest.get_meta(pos)
	local charge = meta:get_int("charge")
	local fuel = meta:get_int("fuel")
	local formspec =
		"size[8,9]" ..
		"label[2,2;charge: " .. tostring(charge) .. "/100]" ..
		"list[nodemeta:" .. spos .. ";charge_inv;2,3;1,1;]" ..
		"label[5,2;Fuel: " .. tostring(fuel) .. "/100]" ..
		"list[nodemeta:" .. spos .. ";fuel_inv;5,3;1,1;]" ..
		"list[nodemeta:" .. spos .. ";main;0,0.3;8,4;]" ..
		"list[current_player;main;0,4.85;8,1;]" ..
		"list[current_player;main;0,6.08;8,3;8]" ..
		"listring[nodemeta:" .. spos .. ";main]" ..
		"listring[current_player;main]"
	return formspec
end

europa_nodes.lander.landers = {}

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "europa_nodes:lander" then
		return
	end
	if not player or not fields.quit then
		return
	end
	local pn = player:get_player_name()

	if not europa_nodes.lander.landers[pn] then
		return
	end

	return true
end)
--

europa_nodes.charge_replacments = {
	[""] = "empty item",
	["europa_items:battery"] = "europa_items:battery_charged",
	["europa_items:battery_dead"] = "europa_items:battery_charged",
	["europa_nodes:battery_dead"] = "europa_nodes:battery_charged",
	["europa_items:drill_silicate"] = "europa_items:drill_silicate",
	["europa_items:drill_nickel"] = "europa_items:drill_nickel",
	["europa_items:drill_iron"] = "europa_items:drill_iron",
	["europa_items:drill_nickel_steel"] = "europa_items:drill_nickel_steel",
	["europa_items:drill_steel"] = "europa_items:drill_steel",
	["europa_items:drill_stainless"] = "europa_items:drill_stainless",
	["europa_items:drill_platinum"] = "europa_items:drill_platinum",
	["europa_items:drill_titanium"] = "europa_items:drill_titanium",
}

europa_nodes.lander.on_timer = function(pos)
	local meta = minetest.get_meta(pos)
	local charge = meta:get_int("charge") -- charge means the amount of power stored, charge_inv means the charging inventory that charges things
	if charge < 100 then
		meta:set_int("charge", charge + 1) -- increase charge
	end
	local inv = meta:get_inventory()
	if charge > 0 then
		local charge_stack = inv:get_stack("charge_inv", 0) -- FIXME this is nothing, why?
		minetest.chat_send_all(tostring(europa_nodes.charge_replacments[charge_stack:get_name()]))
		minetest.chat_send_all(tostring(charge_stack:get_name()))
		minetest.chat_send_all(tostring(charge_stack))
		minetest.chat_send_all(type(charge_stack))
		minetest.chat_send_all(type(charge_stack:get_name()))
		inv:set_stack("charge_inv", 0, ItemStack(tostring(europa_nodes.charge_replacments[charge_stack:get_name()]))) -- FIXME why is this not working?
		meta:set_int("charge", charge - 20) -- decrease charge
	end
	return true
end

minetest.register_node("europa_nodes:lander", {
	description = "Big Lander\nHEY! This is not supposed to be an inventory item!",
	tiles = {
		"europa_nodes_lander_body.png",
		"europa_nodes_lander_thruster.png",
		"europa_nodes_lander_windows.png",
		"europa_nodes_lander_accent.png",
	},
	paramtype = "light",
	drawtype = "mesh",
	light_source = 10,
	mesh = "lander_big.obj",
	groups = {not_in_creative_inventory=1, charge_source=1},
	sounds = europa_sounds.node_sound_metal_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.75, -0.75, -0.75, 0.75, 4.5, 0.75},
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.75, -0.75, -0.75, 0.75, 4.5, 0.75},
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_int("charge", 50) -- europa_nodes charge amount (starts half charged to make it easy) [default: 100]
		meta:set_int("fuel", 0) -- europa_nodes fuel amount (used all the fuel getting here) [default: 100]
		local timer = minetest.get_node_timer(pos)
		timer:start(60)
		meta:set_string("infotext", S("Lander"))
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*1)
		inv:set_size("charge_inv", 1*1)
		inv:set_size("fuel_inv", 1*1)
	end,
	
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", S("Lander (owned by @1)", meta:get_string("owner")))
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		europa_nodes.lander.on_timer(pos)
		if listname == "charge_inv" or listname == "fuel_inv" then
			local groupnum = minetest.get_item_group(stack:get_name(), "chargeable") -- the chargeable item group (only uncharged items)
			if groupnum > 0 then
				return stack:get_count()
			else
				return groupnum
			end
		end
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		return stack:get_count()
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		local charge = meta:get_int("charge")
		local fuel = meta:get_int("fuel")
		minetest.after(0.2, minetest.show_formspec, clicker:get_player_name(), "europa_nodes:lander", europa_nodes.lander.get_lander_formspec(pos, charge, fuel))
		europa_nodes.lander.landers[clicker:get_player_name()] = { pos = pos}
	end,
	on_blast = function() end,
	on_timer = europa_nodes.lander.on_timer
})
