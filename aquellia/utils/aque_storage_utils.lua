require("aquellia/utils/aque_enumerables.lua")
require("aquellia/utils/aque_string_utils.lua")
require("aquellia/utils/aque_component_utils.lua")

function GetStorageGroupValue(name)
    if name == "global" then return "0" end
    if name == "local" then return "1" end
    if name == "energy" then return "9" end
end

--- Logs the Vector_Storage entries
function LogBuildingStorages(building)
    LogService:Log("   *" .. building)
    local blueprint = ResourceManager:GetBlueprint(building)
    local resourceStorageComponent = blueprint:GetComponent("ResourceStorageComponent")
    if resourceStorageComponent == nil then
        LogService:Log("No ResourceStorageComponent")
    end
    local storages = resourceStorageComponent:GetField("Storages")
    local container = storages:ToContainer()
    local count = container:GetItemCount()
    for i=0, count do
        local item = container:GetItem(i)
        if item ~= nil then
            local group = item:GetField("group"):GetValue()
            local group_name = GetResourceGroupName(group)
            local subgroup = item:GetField("subgroup"):GetValue()
            local distribution_radius = item:GetField("distribution_radius"):GetValue()
            local max = item:GetField("max"):GetValue()
            local resource = item:GetField("resource"):GetValue()

            LogService:Log("      - " .. group .. ": " .. group_name)
            LogService:Log("        subgroup: " .. subgroup)
            LogService:Log("        resource: " .. SafeToString(resource))
            LogService:Log("        distribution_radius: " .. SafeToString(distribution_radius))
            LogService:Log("        max: " .. SafeToString(max))
        end
    end
end

function GetStoragesContainer(building)
    local blueprint = ResourceManager:GetBlueprint(building)
    local resourceStorageComponent = blueprint:GetComponent("ResourceStorageComponent")
    if resourceStorageComponent == nil then
        LogService:Log("Add Component Test")
        EntityService:CreateComponent(blueprint, "ResourceStorageComponent")
        local component = blueprint:GetComponent("ResourceStorageComponent")
        LogExorFields(component)
        return
    end
    return resourceStorageComponent:GetField("Storages"):ToContainer()
end

--- Finds and returns the matching Storage object if there is one
function FindStorage(storages, group, subgroup)
    group = GetStorageGroupValue(group)
    local count = storages:GetItemCount()
    for i=0, count do
        local storage = storages:GetItem(i)
        if storage ~= nil then
            if (storage:GetField("group"):GetValue() == group) then
                if subgroup == nil or storage:GetField("subgroup"):GetValue() then
                    return storage
                end
            end
        end
    end
    return nil
end

---
function GetStorageByBuilding(building, group, subgroup)
    local storages = GetStoragesContainer(building)
    return FindStorage(storages, group, subgroup)
end


--- Sets the max property of a storage object
function SetStorageMax(building, group, subgroup, value)
    local storages = GetStoragesContainer(building)
    local storage = FindStorage(storages, group, subgroup)
    if (storage ~= nil) then
        storage:GetField("max"):SetValue(tostring(value))
        return
    end
    LogService:Log("No Storage found for: " .. group .. subgroup)
end

--- Sets the distribution_radius property of a storage object
function SetStorageDistributionRadius(building, group, subgroup, value)
    local storages = GetStoragesContainer(building)
    local storage = FindStorage(storages, group, subgroup)
    if (storage ~= nil) then
        storage:GetField("distribution_radius"):SetValue(tostring(value))
        return
    end
    LogService:Log("No Storage found for: " .. group .. subgroup)
end