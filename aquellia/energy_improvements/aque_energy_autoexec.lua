require("aquellia/aque_config.lua")
local config = _G["aque_config"] or {}
if not config.mod_enabled_energy_improvements then return end


require("aquellia/utils/aque_debug_utils.lua")
require("aquellia/utils/aque_component_utils.lua")
--require("aquellia/utils/aque_storage_utils.lua")
require("aquellia/utils/components/aque_ResourceStorageComponent.lua")

--local resource_storage = GetResourceStorageComponent("buildings/energy/energy_connector")
--local storages = resource_storage:GetField("Storages")
--local container = storages:ToContainer()
--LogPossibleProperties(resource_storage, "ResourceStorageComponent")
--LogPossibleProperties(storages, "storages field")
--LogPossibleProperties(container, "container")
--LogPossibleProperties(ResourceManager, "Resource Manager")
--LogMetaTable(ResourceManager, "ResourceManager")
--LogTable(ResourceManager, "ResourceManager")

--LogStorages("buildings/energy/energy_connector")

--LogBuildingStorages("buildings/resources/liquid_material_storage")
--LogBuildingStorages("buildings/energy/energy_connector")
--LogBuildingStorages("buildings/resources/ammunition_storage")
--LogBuildingStorages("buildings/resources/solid_material_storage")

--LogService:Log("Set energy distribution radius test")

--LogComponents("buildings/resources/pipe_straight")
--LogBuildingStorages("buildings/resources/pipe_straight")
--SetStorageDistributionRadius("buildings/resources/pipe_straight", "energy", nil, 5)
--LogBuildingStorages("buildings/resources/pipe_straight")

--[[
bool <unknown>(luabind::object,custom [class Exor::UtfString<char>] const&,custom [class Exor::UtfString<char>] const&)
void Log(LogService&,unsigned int,custom [class Exor::UtfString<char>] const&)
void Log(LogService&,custom [class Exor::UtfString<char>] const&)
--]]