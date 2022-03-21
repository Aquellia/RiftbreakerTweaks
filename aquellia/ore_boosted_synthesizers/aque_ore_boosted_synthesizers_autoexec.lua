require("aquellia/aque_config.lua")
local config = _G["aque_config"] or {}
if not config.mod_enabled_ore_boosted_synthesizers then return end

require("aquellia/utils/aque_debug_utils.lua")
require("aquellia/utils/aque_component_utils.lua")
require("aquellia/utils/components/aque_ResourceConverterDesc.lua")

LogResourceInformation("buildings/resources/ore_boosted_carbonium_synthesizer", "EntityBlueprint")

local blueprint = ResourceManager:GetBlueprint("buildings/resources/ore_boosted_carbonium_synthesizer")
local resourceConverterComponent = blueprint:GetComponent("ResourceConverterComponent")
local resourceConverterDesc = blueprint:GetComponent("ResourceConverterDesc")
local buildingDesc = blueprint:GetComponent("BuildingDesc")

LogFieldList(resourceConverterComponent, "ResourceConverterComponent")
LogFieldList(resourceConverterDesc, "ResourceConverterDesc")
LogFieldList(buildingDesc, "BuildingDesc")

local in_field = resourceConverterDesc:GetField("in")
LogContainerItems(in_field, "in")
local out_field = resourceConverterDesc:GetField("out")
LogContainerItems(out_field, "out")

LogVectorGameplayResource(in_field, "in")
LogVectorGameplayResource(out_field, "out")

local vein_field = resourceConverterComponent:GetField("vein")
LogContainerItems(vein_field, "vein")