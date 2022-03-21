function SafeToString(object)
    if object == nil then return "nil" end
    if type(object) == "String" or "string" then return object end
    if type(object) == "number" then return tostring(object) end
    return "Failed to convert to string object of type" .. type(object)
end