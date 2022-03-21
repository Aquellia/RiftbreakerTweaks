require("lua/utils/table_utils.lua")
require("aquellia/utils/aque_error_utils.lua")
require("aquellia/utils/aque_debug_utils.lua")

function SafeMemberCall(object, member, default)
    if type(object) == "userdata" or type(object) == "table" then
        if member and object[member] then
            local response = object[member](object)
            if response == nil then
                LogService:Log("Call resulted in nil")
                return default
            else
                --LogService:Log(tostring(response))
                return response
            end
        else
            MissingMemberError("blueprint", member)
        end
    else
        ParamError(object, "object", "userdata or table expected")
    end
    return default
end

--- Calls GetComponentNames with checks to prevent crashes
function SafeGetComponentNames(blueprint)
    return SafeMemberCall(blueprint, "GetComponentNames", {})
end

---
function SafeGetFieldNames(object)
    return SafeMemberCall(object, "GetFieldNames", {})
end

--- Gets the loot component of a blueprint if it exists
function GetComponent(blueprintName, componentName)
    local blueprint = ResourceManager:GetBlueprint(blueprintName)
    if not blueprint then Error("blueprint not found: " .. blueprintName) return end
    for name in Iter( blueprint:GetComponentNames() ) do
        if name == componentName then return blueprint:GetComponent(name) end
    end
end

--- Logs the list of components
function LogComponentList(blueprint, tabs)
    if type(blueprint) == "string" then
        blueprint = ResourceManager:GetBlueprint(blueprint) or Error("Blueprint not found: " .. blueprint)
    end
    for componentName in Iter( SafeGetComponentNames(blueprint) ) do
        LogService:Log((tabs or "") .. "  *" .. componentName)
    end
end

function LogFieldList(object, name, tabs, noTitle)
    tabs = tabs or ""
    name = name or ""
    if not noTitle then
        LogService:Log(tabs .. "## Field List for: " .. name .. " (" .. GetTypeName(object) .. ")")
    end
    for name in Iter( SafeGetFieldNames(object) ) do repeat
        if name == "animations" or name == "item_scripts" or name == "world" or name == "aim_volume" then
            LogService:Log(tabs .. "  " .. name)
            break
        end
        local field = object:GetField(name)
        if not field then Error("field not found: " .. name, field) return end
        local isContainer = (field.IsContainer and field:IsContainer() and " (container)") or ""
        LogService:Log(tabs .. "  " .. name .. ": " .. GetTypeName(field) .. isContainer)
        if field.GetFieldNames then LogFieldList(field, name, tabs .. "    ", true) end
    until true end
end

function GetLootComponent(blueprintName)
    return GetComponent(blueprintName, "LootComponent")
end

function GetResourceStorageComponent(blueprintName)
    return GetComponent(blueprintName, "ResourceStorageComponent")
end