require("aquellia/aque_config.lua")
local config = _G["aque_config"] or {}
if not config.mod_enabled_loot then return end


require("lua/utils/table_utils.lua")
require("aquellia/utils/aque_debug_utils.lua")
require("aquellia/utils/aque_component_utils.lua")

--local loot = GetLootComponent("units/ground/arachnoid_boss")

--LogAllFieldData(loot, "explosion_min_power")
--LogAllFieldData(loot, "explosion_max_power")
--LogAllFieldData(loot, "loot_container_override")
--LogAllFieldData(loot, "bp")
--LogAllFieldData(loot, "is_gatherable")