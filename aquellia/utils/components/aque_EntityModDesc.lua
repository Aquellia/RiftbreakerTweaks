require("lua/utils/table_utils.lua")


--- Gets the blueprint of the given upgrade with the given rarity value
function GetUpgradeBlueprint(name, rarity)
    return ResourceManager:GetBlueprint("items/upgrades/" .. name .. "_" .. rarity .. "_item" )
end

EntityModTypeFlag = {
    ["health"] = "0",
    ["health_regen"] = "1",
    ["forcefield"] = "3",
    ["forcefield_regen"] = "4",
    ["forcefield_regen_cooldown"] = "5",
    ["radar_range"] = "6",
    ["item_cooldowns"] = "12",
    ["resistance_physical"] = "21",
    ["resistance_fire"] = "22",
    ["resistance_energy"] = "23",
    ["resistance_acid"] = "24",
    ["resistance_cryo"] = "25",
    ["resistance_area"] = "26",
}

--- Finds the EntityMod instance
--- @param name string Name of the upgrade to find
--- @param rarity string Rarity to find "standard" | "advanced" | "superior" | "extreme"
--- @param type string ModType to find
function FindEntityMod(name, rarity, type)
    local blueprint = GetUpgradeBlueprint(name, rarity)
    local component = blueprint:GetComponent("EntityModDesc")
    local field = component:GetField("entity_mods")
    local container = field:ToContainer()
    for i=0, container:GetItemCount() -1 do
        local item = container:GetItem(i) -- 0 index
        local key_field = item:GetField("key"):GetValue()
        --LogService:Log(tostring(key_field) .. ": " .. EntityModTypeFlag[type])
        if key_field == EntityModTypeFlag[type] then
            LogService:Log("Found")
            return item:GetField("value")
        end
    end
end

---
function LogUpgradeModValue(name, rarity, type)
    local EntityMod = FindEntityMod(name, rarity, type)
    if not EntityMod then LogService:Log("EntityMod not found for: " .. name .. ", " .. rarity .. ", " .. type) return end
    local mod_value = EntityMod:GetField("mod_value"):GetValue()
    LogService:Log(tostring(mod_value))
end

function SetUpgradeModValue(name, rarity, type, value)
    local EntityMod = FindEntityMod(name, rarity, type)
    local mod_value = EntityMod:GetField("mod_value")
    mod_value:SetValue(value)
end

function SetUpgradeModFuncType(name, rarity, type, value)
    local EntityMod = FindEntityMod(name, rarity, type)
    local mod_value = EntityMod:GetField("mod_func")
    mod_value:SetValue(value)
end
