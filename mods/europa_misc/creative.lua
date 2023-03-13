-- europa_misc_creative/init.lua

-- Load support for MT game translation.
local S = minetest.get_translator("europa_misc_creative")

europa_misc_creative = {}
europa_misc_creative.get_translator = S

local function update_europa_misc_inv(name)
	minetest.after(0, function()
		local player = minetest.get_player_by_name(name)
		if player then
			if europa_misc_inv.get_page(player):sub(1, 9) == "europa_misc_creative:" then
				europa_misc_inv.set_page(player, europa_misc_inv.get_homepage_name(player))
			else
				europa_misc_inv.set_player_inventory_formspec(player)
			end
		end
	end)
end

minetest.register_privilege("europa_misc_creative", {
	description = S("Allow player to use creative inventory"),
	give_to_singleplayer = false,
	give_to_admin = false,
	on_grant = update_europa_misc_inv,
	on_revoke = update_europa_misc_inv,
})

minetest.register_privilege("creative", {
	description = S("Allow player to use creative inventory"),
	give_to_singleplayer = false,
	give_to_admin = false,
	on_grant = update_europa_misc_inv,
	on_revoke = update_europa_misc_inv,
})

-- Override the engine's europa_misc_creative mode function
local old_is_europa_misc_creative_enabled = minetest.is_creative_enabled

function minetest.is_europa_misc_creative_enabled(name)
	if name == "" then
		return old_is_europa_misc_creative_enabled(name)
	end
	return minetest.check_player_privs(name, {europa_misc_creative = true}) or
			minetest.check_player_privs(name, {creative = true}) or
		old_is_europa_misc_creative_enabled(name)
end

-- For backwards compatibility:
function europa_misc_creative.is_enabled_for(name)
	return minetest.is_europa_misc_creative_enabled(name)
end

--
-- inventory
--

-- europa_misc_creative/inventory.lua

-- support for MT game translation.
local S = europa_misc_creative.get_translator

local player_inventory = {}
local inventory_cache = {}

local function init_europa_misc_creative_cache(items)
	inventory_cache[items] = {}
	local i_cache = inventory_cache[items]

	for name, def in pairs(items) do
		if def.groups.not_in_creative_inventory ~= 1 and
				def.description and def.description ~= "" then
			i_cache[name] = def
		end
	end
	table.sort(i_cache)
	return i_cache
end

function europa_misc_creative.init_europa_misc_creative_inventory(player)
	local player_name = player:get_player_name()
	player_inventory[player_name] = {
		size = 0,
		filter = "",
		start_i = 0,
		old_filter = nil, -- use only for caching in update_europa_misc_creative_inventory
		old_content = nil
	}

	minetest.create_detached_inventory("europa_misc_creative_" .. player_name, {
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player2)
			local name = player2 and player2:get_player_name() or ""
			if not minetest.is_europa_misc_creative_enabled(name) or
					to_list == "main" then
				return 0
			end
			return count
		end,
		allow_put = function(inv, listname, index, stack, player2)
			return 0
		end,
		allow_take = function(inv, listname, index, stack, player2)
			local name = player2 and player2:get_player_name() or ""
			if not minetest.is_europa_misc_creative_enabled(name) then
				return 0
			end
			return -1
		end,
		on_move = function(inv, from_list, from_index, to_list, to_index, count, player2)
		end,
		on_take = function(inv, listname, index, stack, player2)
			if stack and stack:get_count() > 0 then
				minetest.log("action", player_name .. " takes " .. stack:get_name().. " from europa_misc_creative inventory")
			end
		end,
	}, player_name)

	return player_inventory[player_name]
end

local NO_MATCH = 999
local function match(s, filter)
	if filter == "" then
		return 0
	end
	if s:lower():find(filter, 1, true) then
		return #s - #filter
	end
	return NO_MATCH
end

local function description(def, lang_code)
	local s = def.description
	if lang_code then
		s = minetest.get_translated_string(lang_code, s)
	end
	return s:gsub("\n.*", "") -- First line only
end

function europa_misc_creative.update_europa_misc_creative_inventory(player_name, tab_content)
	local inv = player_inventory[player_name] or
			europa_misc_creative.init_europa_misc_creative_inventory(minetest.get_player_by_name(player_name))
	local player_inv = minetest.get_inventory({type = "detached", name = "europa_misc_creative_" .. player_name})

	if inv.filter == inv.old_filter and tab_content == inv.old_content then
		return
	end
	inv.old_filter = inv.filter
	inv.old_content = tab_content

	local items = inventory_cache[tab_content] or init_europa_misc_creative_cache(tab_content)

	local lang
	local player_info = minetest.get_player_information(player_name)
	if player_info and player_info.lang_code ~= "" then
		lang = player_info.lang_code
	end

	local europa_misc_creative_list = {}
	local order = {}
	for name, def in pairs(items) do
		local m = match(description(def), inv.filter)
		if m > 0 then
			m = math.min(m, match(description(def, lang), inv.filter))
		end
		if m > 0 then
			m = math.min(m, match(name, inv.filter))
		end

		if m < NO_MATCH then
			europa_misc_creative_list[#europa_misc_creative_list+1] = name
			-- Sort by match value first so closer matches appear earlier
			order[name] = string.format("%02d", m) .. name
		end
	end

	table.sort(europa_misc_creative_list, function(a, b) return order[a] < order[b] end)

	player_inv:set_size("main", #europa_misc_creative_list)
	player_inv:set_list("main", europa_misc_creative_list)
	inv.size = #europa_misc_creative_list
end

-- Create the trash field
local trash = minetest.create_detached_inventory("trash", {
	-- Allow the stack to be placed and remove it in on_put()
	-- This allows the europa_misc_creative inventory to restore the stack
	allow_put = function(inv, listname, index, stack, player)
		return stack:get_count()
	end,
	on_put = function(inv, listname)
		inv:set_list(listname, {})
	end,
})
trash:set_size("main", 1)

europa_misc_creative.formspec_add = ""

function europa_misc_creative.register_tab(name, title, items)
	europa_misc_inv.register_page("europa_misc_creative:" .. name, {
		title = title,
		is_in_nav = function(self, player, context)
			return minetest.is_europa_misc_creative_enabled(player:get_player_name())
		end,
		get = function(self, player, context)
			local player_name = player:get_player_name()
			europa_misc_creative.update_europa_misc_creative_inventory(player_name, items)
			local inv = player_inventory[player_name]
			local pagenum = math.floor(inv.start_i / (4*8) + 1)
			local pagemax = math.ceil(inv.size / (4*8))
			local esc = minetest.formspec_escape
			return europa_misc_inv.make_formspec(player, context,
				"label[5.8,4.15;" .. minetest.colorize("#FFFF00", tostring(pagenum)) .. " / " .. tostring(pagemax) .. "]" ..
				[[
					image[4.08,4.2;0.8,0.8;europa_misc_creative_trash_icon.png]
					listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]
					list[detached:trash;main;4.02,4.1;1,1;]
					listring[]
					image_button[5,4.05;0.8,0.8;europa_misc_creative_prev_icon.png;europa_misc_creative_prev;]
					image_button[7.2,4.05;0.8,0.8;europa_misc_creative_next_icon.png;europa_misc_creative_next;]
					image_button[2.63,4.05;0.8,0.8;europa_misc_creative_search_icon.png;europa_misc_creative_search;]
					image_button[3.25,4.05;0.8,0.8;europa_misc_creative_clear_icon.png;europa_misc_creative_clear;]
				]] ..
				"tooltip[europa_misc_creative_search;" .. esc(S("Search")) .. "]" ..
				"tooltip[europa_misc_creative_clear;" .. esc(S("Reset")) .. "]" ..
				"tooltip[europa_misc_creative_prev;" .. esc(S("Previous page")) .. "]" ..
				"tooltip[europa_misc_creative_next;" .. esc(S("Next page")) .. "]" ..
				"listring[current_player;main]" ..
				"field_close_on_enter[europa_misc_creative_filter;false]" ..
				"field[0.3,4.2;2.8,1.2;europa_misc_creative_filter;;" .. esc(inv.filter) .. "]" ..
				"listring[detached:europa_misc_creative_" .. player_name .. ";main]" ..
				"list[detached:europa_misc_creative_" .. player_name .. ";main;0,0;8,4;" .. tostring(inv.start_i) .. "]" ..
				europa_misc_creative.formspec_add, true)
		end,
		on_enter = function(self, player, context)
			local player_name = player:get_player_name()
			local inv = player_inventory[player_name]
			if inv then
				inv.start_i = 0
			end
		end,
		on_player_receive_fields = function(self, player, context, fields)
			local player_name = player:get_player_name()
			local inv = player_inventory[player_name]
			assert(inv)

			if fields.europa_misc_creative_clear then
				inv.start_i = 0
				inv.filter = ""
				europa_misc_inv.set_player_inventory_formspec(player, context)
			elseif fields.europa_misc_creative_search or
					fields.key_enter_field == "europa_misc_creative_filter" then
				inv.start_i = 0
				inv.filter = fields.europa_misc_creative_filter:lower()
				europa_misc_inv.set_player_inventory_formspec(player, context)
			elseif not fields.quit then
				local start_i = inv.start_i or 0

				if fields.europa_misc_creative_prev then
					start_i = start_i - 4*8
					if start_i < 0 then
						start_i = inv.size - (inv.size % (4*8))
						if inv.size == start_i then
							start_i = math.max(0, inv.size - (4*8))
						end
					end
				elseif fields.europa_misc_creative_next then
					start_i = start_i + 4*8
					if start_i >= inv.size then
						start_i = 0
					end
				end

				inv.start_i = start_i
				europa_misc_inv.set_player_inventory_formspec(player, context)
			end
		end
	})
end

-- Sort registered items
local registered_nodes = {}
local registered_tools = {}
local registered_craftitems = {}

minetest.register_on_mods_loaded(function()
	for name, def in pairs(minetest.registered_items) do
		local group = def.groups or {}

		local nogroup = not (group.node or group.tool or group.craftitem)
		if group.node or (nogroup and minetest.registered_nodes[name]) then
			registered_nodes[name] = def
		elseif group.tool or (nogroup and minetest.registered_tools[name]) then
			registered_tools[name] = def
		elseif group.craftitem or (nogroup and minetest.registered_craftitems[name]) then
			registered_craftitems[name] = def
		end
	end
end)

europa_misc_creative.register_tab("all", S("All"), minetest.registered_items)
europa_misc_creative.register_tab("nodes", S("Nodes"), registered_nodes)
europa_misc_creative.register_tab("tools", S("Tools"), registered_tools)
europa_misc_creative.register_tab("craftitems", S("Items"), registered_craftitems)

local old_homepage_name = europa_misc_inv.get_homepage_name
function europa_misc_inv.get_homepage_name(player)
	if minetest.is_europa_misc_creative_enabled(player:get_player_name()) then
		return "europa_misc_creative:all"
	else
		return old_homepage_name(player)
	end
end


--
-- inventory end
--

if minetest.is_europa_misc_creative_enabled("") then
	-- Dig time is modified according to difference (leveldiff) between tool
	-- 'maxlevel' and node 'level'. Digtime is divided by the larger of
	-- leveldiff and 1.
	-- To speed up digging in europa_misc_creative, hand 'maxlevel' and 'digtime' have been
	-- increased such that nodes of differing levels have an insignificant
	-- effect on digtime.
	local digtime = 42
	local caps = {times = {digtime, digtime, digtime}, uses = 0, maxlevel = 256}

	-- Override the hand tool
	minetest.override_item("", {
		range = 10,
		tool_capabilities = {
			full_punch_interval = 0.5,
			max_drop_level = 3,
			groupcaps = {
				crumbly = caps,
				cracky  = caps,
				snappy  = caps,
				choppy  = caps,
				oddly_breakable_by_hand = caps,
				-- dig_immediate group doesn't use value 1. Value 3 is instant dig
				dig_immediate =
					{times = {[2] = digtime, [3] = 0}, uses = 0, maxlevel = 256},
			},
			damage_groups = {fleshy = 10},
		}
	})
end

-- Unlimited node placement
minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack)
	if placer and placer:is_player() then
		return minetest.is_europa_misc_creative_enabled(placer:get_player_name())
	end
end)

-- Don't pick up if the item is already in the inventory
local old_handle_node_drops = minetest.handle_node_drops
function minetest.handle_node_drops(pos, drops, digger)
	if not digger or not digger:is_player() or
		not minetest.is_europa_misc_creative_enabled(digger:get_player_name()) then
		return old_handle_node_drops(pos, drops, digger)
	end
	local inv = digger:get_inventory()
	if inv then
		for _, item in ipairs(drops) do
			if not inv:contains_item("main", item, true) then
				inv:add_item("main", item)
			end
		end
	end
end
