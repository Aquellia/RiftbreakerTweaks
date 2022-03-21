require("lua/utils/table_utils.lua")
require("aquellia/utils/aque_error_utils.lua")
require("aquellia/utils/aque_component_utils.lua")

function FindStorageFor(component, group, subgroup)
    local storages = component.storages
    for i=0, storages.size do
        local storage = storages[i]
        if not storage then return end -- Not Found
        if storage.group == group then
            if subgroup == nil or storage.subgroup == subgroup then return storage end
        end
    end
end

function FindStorage(blueprintName, group, subgroup)
    local component = GetResourceStorageComponent(blueprintName)
    if not component then Error("No Resource Storage Component found on: " .. blueprintName) return end
    local storages = component:GetField("Storages"):ToContainer()

    for i=0, storages:GetItemCount() do
        local storage = storages:GetItem(i)
        if not storage then Error("Storage is nil") return end
        local group_field = storage:GetField("group")
        if group_field:GetValue() == group then
            local subgroup_field = storage:GetField("subgroup")
            if subgroup_field:GetValue() == subgroup then
                return storage -- Match
            end
        end
    end
end

function LogStorages(blueprintName, tabs)
    tabs = tabs or ""
    LogService:Log(tabs .. "   =" .. blueprintName)
    local component = GetResourceStorageComponent(blueprintName)
    if not component then Error("No Resource Storage Component found on: " .. blueprintName) return end
    local storages = component:GetField("Storages"):ToContainer()

    for i=0, storages:GetItemCount() - 1 do
        local storage = storages:GetItem(i)
        for fieldName in Iter( storage:GetFieldNames() ) do
            LogAllFieldData(storage, fieldName, tabs .. "    ")
        end
    end
end