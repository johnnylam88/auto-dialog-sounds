--[[--------------------------------------------------------------------
    Copyright (C) 2018 Johnny C. Lam.
    See the file LICENSE.txt for copying permission.
--]]--------------------------------------------------------------------

local _, addon = ...

if not addon.L then
	addon.L = { }
end
local L = setmetatable(addon.L, { __index = function(t, k) t[k] = k; return k end })

-- Seed localization table with localizations already available in global constants.
L["Arena"] = _G.ARENA
L["Battlegrounds"] = _G.BATTLEFIELDS
L["Raid"] = _G.RAID
L["World"] = _G.CHANNEL_CATEGORY_WORLD