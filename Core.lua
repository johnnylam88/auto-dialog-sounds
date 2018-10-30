--[[--------------------------------------------------------------------
    Copyright (C) 2018 Johnny C. Lam.
    See the file LICENSE.txt for copying permission.
--]]--------------------------------------------------------------------

local ADDON_NAME, addon = ...
local L = addon.L

---------------------------------------------------------------------
-- Global functions and constants.

local format = string.format
local ipairs = ipairs
local pairs = pairs
local setmetatable = setmetatable
local strfind = string.find
local strjoin = strjoin
local strlen = string.len
local tonumber = tonumber
local tostringall = tostringall
local type = type
-- GLOBALS: _G
-- GLOBALS: GetCVar
-- GLOBALS: SetCVar
-- GLOBALS: GetAddOnMetadata
-- GLOBALS: LibStub

local addonName = GetAddOnMetadata(ADDON_NAME, "Title")
_G[ADDON_NAME] = LibStub("AceAddon-3.0"):NewAddon(addon, addonName or ADDON_NAME, "AceConsole-3.0", "AceEvent-3.0")

local MooZone = LibStub("MooZone-1.0")

---------------------------------------------------------------------

-- Debugging code from Grid by Phanx.
-- https://github.com/phanx-wow/Grid

function addon:Debug(level, str, ...)
	if not self.db.global.debug then return end
	if not level then return end
	if not str or strlen(str) == 0 then return end

	if level <= self.db.global.debuglevel then
		if (...) then
			if type(str) == "string" and (strfind(str, "%%%.%d") or strfind(str, "%%[dfqsx%d]")) then
				str = format(str, ...)
			else
				str = strjoin(" ", str, tostringall(...))
			end
		end
	end

	local name = self.moduleName or self.name or ADDON_NAME
	local frame = _G[addon.db.global.debugFrame]
	self:Print(frame, str)
end

---------------------------------------------------------------------
-- Initialization.

-- Reference to the frame registered into the Interface Options panel.
local settingsFrame

function addon:OnInitialize()
	local defaultDB = self:GetDefaultDB()
	local options = self:GetOptions()

	self.db = LibStub("AceDB-3.0"):New("AutoDialogSoundsDB", defaultDB, true)
	options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)

	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(self.name, options)
	settingsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(self.name)
end

function addon:OnEnable()
	self:Debug(3, "OnEnable")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "Update")
	MooZone.RegisterCallback(self, "MooZone_ZoneChanged", "Update")
end

function addon:OnDisable()
	self:Debug(3, "OnDisable")
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	MooZone.UnregisterCallback(self, "MooZone_ZoneChanged")
end

function addon:Update(event)
	self:Debug(3, "Update", event)

	local value = GetCVar("Sound_EnableDialog")
	if value then
		value = tonumber(value)
	end
	local zone = MooZone:GetZone()
	local newValue = self.db.profile.zone[zone] and 1 or 0
	if value ~= newValue then
		SetCVar("Sound_EnableDialog", newValue)
		self:Print(newValue == 1 and L["Dialog sounds enabled."] or L["Dialog sounds disabled."])
	end
end