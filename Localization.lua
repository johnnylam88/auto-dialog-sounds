--[[--------------------------------------------------------------------
    Copyright (C) 2018 Johnny C. Lam.
    See the file LICENSE.txt for copying permission.
--]]--------------------------------------------------------------------

local _, addon = ...

local setmetatable = setmetatable
-- GLOBALS: LibStub

local MooZone = LibStub("MooZone-1.0")

if not addon.L then
	addon.L = { }
end
local L = setmetatable(addon.L, { __index = function(t, k) t[k] = k; return k end })

L["Arena"] = MooZone:GetLocalizedZone("arena")
L["Battlegrounds"] = MooZone:GetLocalizedZone("battleground")
L["Dungeon"] = MooZone:GetLocalizedZone("dungeon")
L["Dungeon Finder"] = MooZone:GetLocalizedZone("lfg_dungeon")
L["Raid"] = MooZone:GetLocalizedZone("raid")
L["Raid Finder"] = MooZone:GetLocalizedZone("lfg_raid")
L["Scenarios"] = MooZone:GetLocalizedZone("scenario")
L["World"] = MooZone:GetLocalizedZone("world")