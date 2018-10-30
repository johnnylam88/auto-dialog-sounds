--[[--------------------------------------------------------------------
    Copyright (C) 2018 Johnny C. Lam.
    See the file LICENSE.txt for copying permission.
--]]--------------------------------------------------------------------

local ADDON_NAME, addon = ...
local L = addon.L

-- GLOBALS: GetAddOnMetadata

local defaultDB = {
	global = {
		debug = false,
		debuglevel = 1,
		debugFrame = "ChatFrame1",
	},
	profile = {
		zone = {
			arena = true,
			battleground = true,
			dungeon = true,
			raid = true,
			scenario = true,
			lfg_dungeon = true,
			lfg_raid = true,
			world = false,
		}
	},
}

local options = {
	name = GetAddOnMetadata(ADDON_NAME, "Title"),
	type = "group",
	args = {
		settings = {
			name = L["Settings"],
			desc = L["Setup how dialog sounds are automatically enabled and disabled."],
			type = "group",
			order = 10,
			args = {
				desc = {
					name = L["Automatically enable dialog sounds based on the instance/zone the character is in."],
					type = "description",
					order = 1,
				},
				zones = {
					name = L["Zones"],
					type = "group",
					order = 10,
					inline = true,
					get = function(info)
						return addon.db.profile.zone[info[#info]]
					end,
					set = function(info, value)
						addon.db.profile.zone[info[#info]] = value
					end,
					args = {
						world = {
							name = L["World"],
							desc = L["Enable dialog sounds while in the open world."],
							type = "toggle",
							order = 10,
						},
						arena = {
							name = L["Arena"],
							desc = L["Enable dialog sounds while in an arena."],
							type = "toggle",
							order = 15,
						},
						battleground = {
							name = L["Battlegrounds"],
							desc = L["Enable dialog sounds while in a battleground."],
							type = "toggle",
							order = 20,
						},
						dungeon = {
							name = L["Dungeon"],
							desc = L["Enable dialog sounds while in a manually-created dungeon group."],
							type = "toggle",
							order = 40,
						},
						raid = {
							name = L["Raid"],
							desc = L["Enable dialog sounds while in a manually-created raid group."],
							type = "toggle",
							order = 50,
						},
						scenario = {
							name = L["Scenarios"],
							desc = L["Enable dialog sounds while in scenario."],
							type = "toggle",
							order = 50,
						},
						lfg_dungeon = {
							name = L["Dungeon Finder"],
							desc = L["Enable dialog sounds while in a Dungeon Finder group."],
							type = "toggle",
							order = 60,
						},
						lfg_raid = {
							name = L["Raid Finder"],
							desc = L["Enable dialog sounds while in a Raid Finder group."],
							type = "toggle",
							order = 70,
						},
					},
				},
			},
		},
		debugging = {
			name = L["Debugging"],
			desc = L["Debugging menu."],
			type = "group",
			order = 40,
			get = function(info)
				return addon.db.global[info[#info]]
			end,
			set = function(info, value)
				addon.db.global[info[#info]] = value
			end,
			args = {
				desc = {
					name = L["Regular users should leave debugging turned off except when troubleshooting a problem for a bug report."],
					type = "description",
					order = 1,
				},
				debug = {
					name = L["Debug"],
					desc = L["Toggle debugging output."],
					type = "toggle",
					order = 10,
				},
				debuglevel = {
					name = L["Debug level"],
					desc = L["The level of debugging information to output."],
					type = "range",
					order = 15,
					min = 1,
					max = 3,
					step = 1,
				},
				debugFrame = {
					name = L["Output frame"],
					desc = L["Send debugging output to this frame."],
					type = "select",
					order = 20,
					values = {
						ChatFrame1  = "ChatFrame1",
						ChatFrame2  = "ChatFrame2",
						ChatFrame3  = "ChatFrame3",
						ChatFrame4  = "ChatFrame4",
						ChatFrame5  = "ChatFrame5",
						ChatFrame6  = "ChatFrame6",
						ChatFrame7  = "ChatFrame7",
						ChatFrame8  = "ChatFrame8",
						ChatFrame8  = "ChatFrame9",
						ChatFrame10 = "ChatFrame10",
					}
				},
			},
		},
	},
}

function addon:GetDefaultDB()
	return defaultDB
end

function addon:GetOptions()
	return options
end