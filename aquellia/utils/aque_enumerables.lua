--- Resource Groups
function GetResourceGroupName(value)
    if value == "0" then return "global" end
    if value == "1" then return "local" end
    if value == "9" then return "energy" end
    return "unknown"
end