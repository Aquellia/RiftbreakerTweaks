require("aquellia/aque_config.lua")
local config = _G["aque_config"] or {}
if not config.mod_enabled_mech_upgrades then return end

--- Alter several mech upgrade values
require("aquellia/utils/aque_debug_utils.lua")
require("aquellia/utils/components/aque_EntityModDesc.lua")

-- LogBlueprintComponents("items/upgrades/energy_sensors_advanced_item")

--LogUpgradeModValue("armor_plating", "standard", "health")
--SetUpgradeModValue("armor_plating", "standard", "health", "50.000")
--LogUpgradeModValue("armor_plating", "standard", "health")



--[[
function RarityTest(name, rarity)
    local blueprint = GetUpgradeBlueprint(name, rarity)
    local component = blueprint:GetComponent("EntityModDesc")
    local value = component:GetField("rarity"):GetValue()
    LogService:Log(name .. " - ".. rarity .. ": " .. value)
end

RarityTest("energy_sensors", "standard")
RarityTest("energy_sensors", "advanced")
RarityTest("energy_sensors", "superior")
RarityTest("energy_sensors", "extreme")

do
    local blueprint = GetUpgradeBlueprint("fireproof_armor", "advanced")
    local component = blueprint:GetComponent("EntityModDesc")
    local container = component:GetField("mod_flags"):ToContainer()
    local count = container:GetItemCount()
    for i=0,count do
        local item = container:GetItem(i)
        if not item then break end
        local key = item:GetField("key"):GetValue()
        local value = item:GetField("value"):GetValue()
        LogService:Log(tostring(key) .. " | " .. tostring(value))
    end
end

function LogField(object, field)
    local value = object[field]
    if value then value = type(value) end
    LogService:Log(field .. ": " .. SafeToString(value) )
end
--]]