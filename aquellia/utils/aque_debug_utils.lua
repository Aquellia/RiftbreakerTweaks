require("lua/utils/table_utils.lua")
require("aquellia/utils/aque_error_utils.lua")

function IsSafeContainerType(typeName)
    if typeName == "Vector_GuiAnimationGroupDef2" then return false end
    if typeName == "FlatMap_StringGuiBind" then return false end
    if typeName == "UnorderedMap_TableHandleVector_TableKVP" then return false end
    if typeName == "UnorderedMap_LuaHandlerKeyLuaEventCallback" then return false end
    return true
end

--- Prints all of the items in a container to the logs
function LogContainerItems(object, name, tabs)
    tabs = tabs or ""
    name = name or ""
    local type = GetTypeName(object)
    LogService:Log(tabs .. "## Item List for container: " .. name .. " (" .. type .. ")")
    if not object then Error("container is nil", object) return end
    --if not IsSafeContainerType(type) then return end
    if not object.IsContainer then Error("IsContainer is not a property of type", object) return end
    if not object:IsContainer() then Error("provided object is not a container", object) return end
    local container = object:ToContainer()
    local count = container:GetItemCount()
    LogService:Log(tabs .. "  " .. tostring(count) .. " items:")
    for i=0, count - 1 do
        local item = container:GetItem(i) -- 0 index
        if item == nil then break end
        if not item then Error("Unexpected nil in container", item) break end
        LogService:Log(tabs .. "    [" .. tostring(i) .. "] " .. item:GetTypeName())
        LogExorFields(item, tabs .. "        ") -- Print any fields the item has
    end
end

--- Prints any fields on an exor object
function LogExorFields(object, tabs, safe)
    tabs = tabs or "" -- default tab string
    if not object then Error("object is nil", object) return end
    if not object.GetFieldNames then Error("GetFieldNames is missing on provided object", object) return end
    for fieldName in Iter( object:GetFieldNames() ) do repeat
        if safe then LogService:Log(tabs .. "Field name: " .. fieldName) end
        if fieldName == "animations" then break end
        if fieldName == "item_scripts" then break end
        if fieldName == "world" then break end
        if fieldName == "aim_volume" then break end
        local field = object:GetField(fieldName)
        if not field then Error("field not found: " .. fieldName, field) return end
        LogService:Log(tabs .. fieldName .. ": " .. field:GetTypeName())
        if field.IsContainer and field:IsContainer() then LogContainerItems(field, tabs) end
        if field.GetFieldNames then LogExorFields(field, tabs .. "    ", true) end
    until true end
end

--- Prints any components on an exor object
function LogExorComponents(object)
    if not object then Error(name .. " object not found", thread + 1) return end
    if not object.GetComponentNames then Error("GetComponentName is not a property", object) return end
    for componentName in Iter( object:GetComponentNames() ) do
        LogService:Log("  *" .. componentName)
        local component = object:GetComponent(componentName)
        LogExorFields(component, "    ")
    end
end

--- Prints the components of blueprint to the logs
function LogBlueprintComponents(name)
    if not name then Error("name is nil", name) return end
    LogService:Log(name)
    local blueprint = ResourceManager:GetBlueprint(name)
    if not blueprint then Error(name .. " blueprint not found", blueprint) return end
    if blueprint.GetFieldNames then LogExorFields(name, "", true) end
    LogExorComponents(blueprint)
end

function LogTable(table, name)
    if name then LogService:Log("Log of table: " .. name) end
    if not Assert( type(table) == "table", "ERROR: calling LogTable on non table type: `" .. type(table) .. "`" ) then
        return nil
    end

    for key, value in pairs(table) do
        if type(key) == "number" then key = "[" .. tostring(key) .. "]" end
        LogService:Log("k: " .. key .. ", type: " .. type(value))
    end
end

function LogMetaTable(userdata, name)
    if name then LogService:Log("Metatable of: " .. name) end
    local metatable = getmetatable(userdata)
    if metatable then LogTable(metatable) end
end

function LogDebugInfo(func)
    local info = debug.getinfo(func)
    LogService:Log("Source: " .. info.source) -- Where the function was defined
    LogService:Log("Line: " .. info.linedefined) -- Line of the source where the function was defined
    LogService:Log("What: " .. info.what) -- Lua, C, main
    if info.name then LogService:Log("Name: " .. info.name) end
    LogService:Log("Name What: " .. info.namewhat)
    LogService:Log("Nups: " .. tostring(info.nups))
end

--- Returns the Exor Type name if it has one or the Lua Type name otherwise
function GetTypeName(object)
    local luaType = type(object)
    if luaType == "function" then return luaType end
    if luaType == "userdata" or luaType == "table" then
        if object.GetTypeName then
            local exorType = object:GetTypeName()
            if exorType then return exorType
            end
        end
    end
    return luaType
end

--- Prints field data to the logs if it exists
function LogIfFieldExists(object, fieldName, tabs)
    if not object then return end
    --tabs = tabs or ""
    local value = object[fieldName]
    if not value then return end -- Field is nil
    if value then LogService:Log(tabs .. fieldName .. ": " .. GetTypeName(value)) end
end

characters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM-_"

function LogIfFieldExistsAddCharacter(object, fieldName, tabs, max, index)
    for i=1, string.len(characters) - 1 do
        local name = fieldName .. string.sub(characters, i, i)
        LogService:Log(name)
        LogIfFieldExists(object, name, tabs)
    end
    if index < max then
        LogService:Log("Checked Fields of length: " .. tostring(string.len(fieldName) + 1))
        for i=1, string.len(characters) - 1 do
            local name = fieldName .. string.sub(characters, i, i)
            --LogService:Log(name)
            LogIfFieldExistsAddCharacter(object, name, tabs, max, index + 1)
        end
    end
end

--- Attempts to print any existing properties of an exor object
function LogPossibleProperties(object, name, tabs)
    tabs = tabs or ""
    name = name or ""
    local type = object and (object.GetTypeName and object:GetTypeName() or type(object)) or "nil"
    LogService:Log(tabs .. "## Possible Properties for: " .. type .. " (" .. name .. ")")
    tabs = tabs .. "  "

    --LogIfFieldExistsAddCharacter(object, "", tabs, 5, 1)

    --- Array Accessors
    LogIfFieldExists(object, "0", tabs)
    LogIfFieldExists(object, "1", tabs)

    --- Array Functions
    LogIfFieldExists(object, "_count", tabs)
    LogIfFieldExists(object, "count", tabs)
    LogIfFieldExists(object, "Count", tabs)
    LogIfFieldExists(object, "_getCount", tabs)
    LogIfFieldExists(object, "getCount", tabs)
    LogIfFieldExists(object, "GetCount", tabs)
    LogIfFieldExists(object, "_getItemCount", tabs)
    LogIfFieldExists(object, "getItemCount", tabs)
    LogIfFieldExists(object, "GetItemCount", tabs)
    LogIfFieldExists(object, "_size", tabs)
    LogIfFieldExists(object, "size", tabs)
    LogIfFieldExists(object, "Size", tabs)

    --- Pair Accessors
    LogIfFieldExists(object, "key", tabs)
    LogIfFieldExists(object, "value", tabs)

    --- Container Properties
    LogIfFieldExists(object, "_items", tabs)
    LogIfFieldExists(object, "items", tabs)
    LogIfFieldExists(object, "Items", tabs)

    --- Generic Properties
    LogIfFieldExists(object, "_name", tabs)
    LogIfFieldExists(object, "name", tabs)
    LogIfFieldExists(object, "Name", tabs)
    LogIfFieldExists(object, "_getName", tabs)
    LogIfFieldExists(object, "getName", tabs)
    LogIfFieldExists(object, "GetName", tabs)
    LogIfFieldExists(object, "_parent", tabs)
    LogIfFieldExists(object, "parent", tabs)
    LogIfFieldExists(object, "Parent", tabs)
    LogIfFieldExists(object, "_getParent", tabs)
    LogIfFieldExists(object, "getParent", tabs)
    LogIfFieldExists(object, "GetParent", tabs)

    --- Value Properties
    LogIfFieldExists(object, "_amount", tabs)
    LogIfFieldExists(object, "amount", tabs)
    LogIfFieldExists(object, "Amount", tabs)

    --- Entity Properties
    LogIfFieldExists(object, "GetField", tabs)
    LogIfFieldExists(object, "GetFieldNames", tabs)
    LogIfFieldExists(object, "CreateField", tabs)
    LogIfFieldExists(object, "AddField", tabs)
    LogIfFieldExists(object, "RemoveField", tabs)

    --- Blueprint Properties
    LogIfFieldExists(object, "GetComponentNames", tabs)
    LogIfFieldExists(object, "GetComponent", tabs)
    LogIfFieldExists(object, "CreateComponent", tabs)
    LogIfFieldExists(object, "AddComponent", tabs)
    LogIfFieldExists(object, "RemoveComponent", tabs)
    LogIfFieldExists(object, "DeleteComponent", tabs)

    --- Field Properties
    LogIfFieldExists(object, "GetValue", tabs)
    LogIfFieldExists(object, "SetValue", tabs)
    LogIfFieldExists(object, "GetItem", tabs)
    LogIfFieldExists(object, "CreateItem", tabs)
    LogIfFieldExists(object, "AddItem", tabs)
    LogIfFieldExists(object, "Add", tabs)
    LogIfFieldExists(object, "GetTypeName", tabs)
    LogIfFieldExists(object, "ToContainer", tabs)
    LogIfFieldExists(object, "IsContainer", tabs)
    LogIfFieldExists(object, "GetRealBase", tabs)
    LogIfFieldExists(object, "SetInt", tabs)
    LogIfFieldExists(object, "GetInt", tabs)
    LogIfFieldExists(object, "SetString", tabs)
    LogIfFieldExists(object, "GetString", tabs)
    LogIfFieldExists(object, "SetBool", tabs)
    LogIfFieldExists(object, "GetBool", tabs)

    --- ResourceManager
    LogIfFieldExists(object, "GetBlueprint", tabs)
    LogIfFieldExists(object, "ResourceExists", tabs)
    LogIfFieldExists(object, "GetResource", tabs)
    LogIfFieldExists(object, "self", tabs)

    --- Events
    LogIfFieldExists(object, "RegisterHandler", tabs)
    LogIfFieldExists(object, "UnregisterHandler", tabs)


    LogIfFieldExists(object, "HasBlueprint", tabs)
    LogIfFieldExists(object, "Load", tabs)
    LogIfFieldExists(object, "Unload", tabs)
    LogIfFieldExists(object, "GetFriendlyText", tabs)
    --]]
end

--- Logs
function LogAllFieldData(object, name, tabs)
    tabs = tabs or ""
    if not name then Error("No field name provided") return end
    if not object then Error("object is nil") return end
    if object.GetFieldNames then
        local fieldNames = object:GetFieldNames()
        for fieldName in Iter(object:GetFieldNames()) do
            if fieldName == name then
                LogService:Log(tabs .. "Field Name: " .. name)
                local field = object:GetField(name)
                if not field then Error("field is nil: " .. name, object) end
                local type = field:GetTypeName()
                LogService:Log(tabs .. "    Type: " .. type)
                local value = field:GetValue()
                if value == nil then
                    LogService:Log(tabs .. "    Value: nil")
                else
                    LogService:Log(tabs .. "    Value: " .. tostring(value))
                end
            end
        end
    end
end

function LogResourceInformation(name, type)
    type = type or "EntityBlueprint"
    LogService:Log(name .. " | " .. type)
    LogService:Log(" As blueprint:")
    local blueprint = ResourceManager:GetBlueprint(name)
    if blueprint then
        LogPossibleProperties(blueprint, name, "    ")
        LogComponentList(blueprint, "    ")
        --[[
        LogFieldList(blueprint, name, "    ")
        local isContainer = SafeMemberCall(blueprint, "IsContainer", false)
        if isContainer then
            LogService:Log("  # Is A Container")
            local container = blueprint:ToContainer()
            LogContainerItems(container, "    ")
        end
        --]]
    end
    LogService:Log(" As Resource:")
    local exists = ResourceManager:ResourceExists(type, name)
    if exists then
        LogService:Log("    Exists")
        local resource = ResourceManager:GetResource(type, name)
        if resource then
            LogService:Log(GetTypeName(resource))
            LogPossibleProperties(resource, name, "    ")
            --LogComponentList(resource, "    ")
            LogFieldList(resource, name, "    ")
            local isContainer = SafeMemberCall(resource, "IsContainer", false)
            if isContainer then
                LogService:Log("  # Is A Container")
                local container = resource:ToContainer()
                LogContainerItems(container, name, "    ")
            end
        end
    else
        LogService:Log("  # Not Found")
    end
end