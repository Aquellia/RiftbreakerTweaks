require("aquellia/aque_config.lua")
local config = _G["aque_config"] or {}
if not config.mod_enabled_test then return end

require("lua/utils/table_utils.lua")
require("aquellia/utils/aque_debug_utils.lua")
require("aquellia/utils/aque_storage_utils.lua")
require("aquellia/utils/aque_component_utils.lua")

--LogPossibleProperties(ResourceManager, "ResourceManager")

--local database = EntityService:GetBlueprintDatabase("player/character")
--LogPossibleProperties(database)
--LogMetaTable(database, "database")
--LogService:Log(tostring(database))
--LogPossibleProperties(script, "script")

--LogResourceInformation("player/character", "EntityBlueprint")
--LogResourceInformation("buildings/decorations/base_lamp", "EntityBlueprint")
--LogResourceInformation("player/player", "EntityBlueprint")

--LogService:Log("")
--local component = ResourceManager:GetBlueprint("buildings/decorations/base_lamp"):GetComponent("LuaComponent")
--component:GetField("script"):SetValue()
--LogPossibleProperties(component, "LuaComponent", "    ")
--LogFieldList(component, "LuaComponent")
--local script = component:GetField("script")
--LogPossibleProperties(script:GetValue())

--local is_initialized = component:GetField("is_initialized"):GetValue()
--LogService:Log("    is_initialized: " .. tostring(is_initialized))

--local snapshot = component:GetField("snapshot")
--LogPossibleProperties(snapshot, "snapshot")
--LogFieldList(snapshot, "snapshot")

--local tables = snapshot:GetField("tables")
--LogContainerItems(tables, "tables")

--local storage = snapshot:GetField("storage")
--LogContainerItems(storage, "storage")

--local object = component:GetField("object")
--LogPossibleProperties(object, "object")
--LogFieldList(object, "object")
--local context = object:GetField("context")
--LogPossibleProperties(context, "context")
--LogFieldList(context, "context")
--local script_name = context:GetField("script_name"):SetValue("IdString", "lua/units/ground/mech_replace_test.lua")
--LogPossibleProperties(script_name, "script_name")
--LogService:Log("script_name: " .. tostring(script_name:GetValue()))

--local test = ResourceManager:ResourceExists()

--LogService:Log("ResourceExists Test: ", tostring(test))

--local blueprint_check = ResourceManager:ResourceExists("EntityBlueprint","buildings/energy/energy_connector")
--LogService:Log("ResourceExists Test: " .. tostring(blueprint_check))

--local self_test = ResourceManager.self
--LogService:Log("Self Test: " .. tostring(self_test))

--LogBlueprintComponents("logic/dynamic_flow_field")

--local resource = ResourceManager:GetResource("CampaignDef", "campaigns/story/story.campaign")
--LogService:Log("Logic File: " .. GetTypeName(resource))
--LogService:Log("campaigns/story/story.campaign")
--LogPossibleProperties(resource, "story.campaign")
--LogFieldList(resource, "    ")

--[[
bool SetValue(TypeInstance&, string)

(filename not available):0 - luabind::detail::function<void UnitService::(unsigned int,string,int),type_list,type_list<> >::entry_point

Optional<TypeInstance>(luabind::object, string,custom [class Exor::UtfString<char>] const&)

Optional<BlueprintAccesor>(luabind::object,string)
--- Test object properties
local blueprint = ResourceManager:GetBlueprint("items/upgrades/energy_sensors_advanced_item")
LogPossibleProperties(blueprint, "upgrade blueprint")
local component = blueprint:GetComponent("EntityModDesc")
LogPossibleProperties(component, "EntityModDesc Component")
local entity_mods_field = component:GetField("entity_mods")
LogPossibleProperties(entity_mods_field, "entity_mods_field")
local entity_mods_container = entity_mods_field:ToContainer()
LogPossibleProperties(entity_mods_container, "entity_mods_container")
for i=0, entity_mods_container:GetItemCount() - 1 do
    local item = entity_mods_container:GetItem(i) -- 0 index
    LogPossibleProperties(item, tostring(i), "    ")
end

--]]

--LogDebugInfo(ResourceManager.GetBlueprint)

--LogMetaTable(EntityService, "Entity Service")
--LogMetaTable(ResourceManager:GetBlueprint("buildings/resources/liquid_material_storage"), "Blueprint")

--- Test Available Services
--[[
LogService:Log("AcidRainService " .. tostring(AcidRainService ~= nil))
LogService:Log("AnimationService " .. tostring(AnimationService ~= nil))
LogService:Log("CameraService " .. tostring(CameraService ~= nil))
LogService:Log("CampaignService " .. tostring(CampaignService ~= nil))
LogService:Log("ConsoleService " .. tostring(ConsoleService ~= nil))
LogService:Log("DifficultyService " .. tostring(DifficultyService ~= nil))
LogService:Log("EarthquakeService " .. tostring(EarthquakeService ~= nil))
LogService:Log("EffectService " .. tostring(EffectService ~= nil))
LogService:Log("EntityService " .. tostring(EntityService ~= nil))
LogService:Log("EnvironmentService " .. tostring(EnvironmentService ~= nil))
LogService:Log("FindService " .. tostring(FindService ~= nil))
LogService:Log("GameStreamingService " .. tostring(GameStreamingService ~= nil))
LogService:Log("GuiService " .. tostring(GuiService ~= nil))
LogService:Log("HealthService " .. tostring(HealthService ~= nil))
LogService:Log("ItemService " .. tostring(ItemService ~= nil))
LogService:Log("LampService " .. tostring(LampService ~= nil))
LogService:Log("LogService " .. tostring(LogService ~= nil))
LogService:Log("MeteorService " .. tostring(MeteorService ~= nil))
LogService:Log("MissionService " .. tostring(MissionService ~= nil))
LogService:Log("MoveService " .. tostring(MoveService ~= nil))
LogService:Log("ObjectiveService " .. tostring(ObjectiveService ~= nil))
LogService:Log("PlayerService " .. tostring(PlayerService ~= nil))
LogService:Log("ResourceService " .. tostring(ResourceService ~= nil))
LogService:Log("RiftbreakerGameStreamingService " .. tostring(RiftbreakerGameStreamingService ~= nil))
LogService:Log("SoundService " .. tostring(SoundService ~= nil))
LogService:Log("TornadoService " .. tostring(TornadoService ~= nil))
LogService:Log("UnitService " .. tostring(UnitService ~= nil))
LogService:Log("UnitSpawnerService " .. tostring(UnitSpawnerService ~= nil))
LogService:Log("WeaponService " .. tostring(WeaponService ~= nil))
--]]

--LogBuildingStorages("buildings/resources/liquid_material_storage")
--LogBuildingStorages("buildings/energy/energy_connector")
--LogBuildingStorages("buildings/resources/ammunition_storage")
--LogBuildingStorages("buildings/resources/solid_material_storage")

--LogService:Log("Set energy distribution radius test")

--LogComponents("buildings/resources/pipe_straight")
--LogBuildingStorages("buildings/resources/pipe_straight")
--SetStorageDistributionRadius("buildings/resources/pipe_straight", "energy", nil, 5)
--LogBuildingStorages("buildings/resources/pipe_straight")
