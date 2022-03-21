--- Logs an error message followed by a stacktrace
function StackTraceError(message)
    message = message or "No Error Message Provided"
    for i=0, 10 do
        local info = debug.getinfo(i + 2,"Sl")
        if not info then break end
        message = message .. "\n    line " .. info.currentline .. ": " .. info.short_src
    end
    LogService:Log(message)
end

function Error(message, object)
    local type = object and (object.GetTypeName and object:GetTypeName() or typeof(object)) or "nil"
    StackTraceError(message.. "\n        Type: " .. type)
end

--- Logs an error alongside a parameter's details
function ParamError(param, name, message)
    name = name or "Unnamed Param"
    message = message or ""
    local paramLines = "\nMismatched Parameter: " .. name .. "\nType: " .. type(param) .. "\nValue: " .. tostring(param)
    StackTraceError(message .. paramLines)
end

function MissingMemberError(objectName, memberName, message)
    if not type(objectName) == "string" then ParamError(objectName, "objectName", "string expected") return end
    if not type(memberName) == "string" then ParamError(memberName, "memberName", "string expected") return end
    message = message and ("\n" .. message) or ""
    StackTraceError(objectName .. " does not contain member: " .. memberName .. message)
end