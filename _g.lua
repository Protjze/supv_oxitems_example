Config = {}

local ox_items <const> = exports.supv_oxitems

if not ox_items then error("Erreur, vous avez supv_oxitems qui est chargé avant cette ressource", 3) return end

local config <const> = ox_items:GetConfig()

Config.handcuff = config.handcuff ~= nil and {} or nil