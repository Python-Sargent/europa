-- compressed europa_misc_inv
-- Load support for MT game translation.
local S = minetest.get_translator("europa_misc_inv")

--
-- API
--

europa_misc_inv = {
	pages = {},
	pages_unordered = {},
	contexts = {},
	enabled = true
}

function europa_misc_inv.register_page(name, def)
	assert(name, "Invalid europa_misc_inv page. Requires a name")
	assert(def, "Invalid europa_misc_inv page. Requires a def[inition] table")
	assert(def.get, "Invalid europa_misc_inv page. Def requires a get function.")
	assert(not europa_misc_inv.pages[name], "Attempt to register already registered europa_misc_inv page " .. dump(name))

	europa_misc_inv.pages[name] = def
	def.name = name
	table.insert(europa_misc_inv.pages_unordered, def)
end

function europa_misc_inv.override_page(name, def)
	assert(name, "Invalid europa_misc_inv page override. Requires a name")
	assert(def, "Invalid europa_misc_inv page override. Requires a def[inition] table")
	local page = europa_misc_inv.pages[name]
	assert(page, "Attempt to override europa_misc_inv page " .. dump(name) .. " which does not exist.")
	for key, value in pairs(def) do
		page[key] = value
	end
end

function europa_misc_inv.get_nav_fs(player, context, nav, current_idx)
	-- Only show tabs if there is more than one page
	if #nav > 1 then
		return "tabheader[0,0;europa_misc_inv_nav_tabs;" .. table.concat(nav, ",") ..
				";" .. current_idx .. ";true;false]"
	else
		return ""
	end
end

local theme_inv = [[
		image[0,5.2;1,1;gui_hb_bg.png]
		image[1,5.2;1,1;gui_hb_bg.png]
		image[2,5.2;1,1;gui_hb_bg.png]
		image[3,5.2;1,1;gui_hb_bg.png]
		image[4,5.2;1,1;gui_hb_bg.png]
		image[5,5.2;1,1;gui_hb_bg.png]
		image[6,5.2;1,1;gui_hb_bg.png]
		image[7,5.2;1,1;gui_hb_bg.png]
		list[current_player;main;0,5.2;8,1;]
		list[current_player;main;0,6.35;8,3;8]
	]]

function europa_misc_inv.make_formspec(player, context, content, show_inv, size)
	local tmp = {
		size or "size[8,9.1]",
		europa_misc_inv.get_nav_fs(player, context, context.nav_titles, context.nav_idx),
		show_inv and theme_inv or "",
		content
	}
	return table.concat(tmp, "")
end

function europa_misc_inv.get_homepage_name(player)
	return "europa_misc_inv:crafting"
end

function europa_misc_inv.get_formspec(player, context)
	-- Generate navigation tabs
	local nav = {}
	local nav_ids = {}
	local current_idx = 1
	for i, pdef in pairs(europa_misc_inv.pages_unordered) do
		if not pdef.is_in_nav or pdef:is_in_nav(player, context) then
			nav[#nav + 1] = pdef.title
			nav_ids[#nav_ids + 1] = pdef.name
			if pdef.name == context.page then
				current_idx = #nav_ids
			end
		end
	end
	context.nav = nav_ids
	context.nav_titles = nav
	context.nav_idx = current_idx

	-- Generate formspec
	local page = europa_misc_inv.pages[context.page] or europa_misc_inv.pages["404"]
	if page then
		return page:get(player, context)
	else
		local old_page = context.page
		local home_page = europa_misc_inv.get_homepage_name(player)

		if old_page == home_page then
			minetest.log("error", "[europa_misc_inv] Couldn't find " .. dump(old_page) ..
					", which is also the old page")

			return ""
		end

		context.page = home_page
		assert(europa_misc_inv.pages[context.page], "[europa_misc_inv] Invalid homepage")
		minetest.log("warning", "[europa_misc_inv] Couldn't find " .. dump(old_page) ..
				" so switching to homepage")

		return europa_misc_inv.get_formspec(player, context)
	end
end

function europa_misc_inv.get_or_create_context(player)
	local name = player:get_player_name()
	local context = europa_misc_inv.contexts[name]
	if not context then
		context = {
			page = europa_misc_inv.get_homepage_name(player)
		}
		europa_misc_inv.contexts[name] = context
	end
	return context
end

function europa_misc_inv.set_context(player, context)
	europa_misc_inv.contexts[player:get_player_name()] = context
end

function europa_misc_inv.set_player_inventory_formspec(player, context)
	local fs = europa_misc_inv.get_formspec(player,
			context or europa_misc_inv.get_or_create_context(player))
	player:set_inventory_formspec(fs)
end

function europa_misc_inv.set_page(player, pagename)
	local context = europa_misc_inv.get_or_create_context(player)
	local oldpage = europa_misc_inv.pages[context.page]
	if oldpage and oldpage.on_leave then
		oldpage:on_leave(player, context)
	end
	context.page = pagename
	local page = europa_misc_inv.pages[pagename]
	if page.on_enter then
		page:on_enter(player, context)
	end
	europa_misc_inv.set_player_inventory_formspec(player, context)
end

function europa_misc_inv.get_page(player)
	local context = europa_misc_inv.contexts[player:get_player_name()]
	return context and context.page or europa_misc_inv.get_homepage_name(player)
end

minetest.register_on_joinplayer(function(player)
	if europa_misc_inv.enabled then
		europa_misc_inv.set_player_inventory_formspec(player)
	end
end)

minetest.register_on_leaveplayer(function(player)
	europa_misc_inv.contexts[player:get_player_name()] = nil
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "" or not europa_misc_inv.enabled then
		return false
	end

	-- Get Context
	local name = player:get_player_name()
	local context = europa_misc_inv.contexts[name]
	if not context then
		europa_misc_inv.set_player_inventory_formspec(player)
		return false
	end

	-- Was a tab selected?
	if fields.europa_misc_inv_nav_tabs and context.nav then
		local tid = tonumber(fields.europa_misc_inv_nav_tabs)
		if tid and tid > 0 then
			local id = context.nav[tid]
			local page = europa_misc_inv.pages[id]
			if id and page then
				europa_misc_inv.set_page(player, id)
			end
		end
	else
		-- Pass event to page
		local page = europa_misc_inv.pages[context.page]
		if page and page.on_player_receive_fields then
			return page:on_player_receive_fields(player, context, fields)
		end
	end
end)



--
-- register crafting page
--

europa_misc_inv.register_page("europa_misc_inv:crafting", {
	title = S("Crafting"),
	get = function(self, player, context)
		return europa_misc_inv.make_formspec(player, context, [[
				list[current_player;craft;1.75,0.5;3,3;]
				list[current_player;craftpreview;5.75,1.5;1,1;]
				image[4.75,1.5;1,1;europa_misc_inv_crafting_arrow.png]
				listring[current_player;main]
				listring[current_player;craft]
			]], true)
	end
})

