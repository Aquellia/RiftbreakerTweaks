


function LogGameplayResource(gameplayResource, tabs)
    tabs = tabs or ""
    LogService:Log(tabs .. "radius: " .. tostring(gameplayResource:GetField("radius"):GetValue()))
    LogService:Log(tabs .. "group: " .. tostring(gameplayResource:GetField("group"):GetValue()))
    LogService:Log(tabs .. "missing_modifier: " .. tostring(gameplayResource:GetField("missing_modifier"):GetValue()))
    LogService:Log(tabs .. "resource: " .. tostring(gameplayResource:GetField("resource"):GetValue()))
    LogService:Log(tabs .. "family: " .. tostring(gameplayResource:GetField("family"):GetValue()))
    LogService:Log(tabs .. "optional: " .. tostring(gameplayResource:GetField("optional"):GetValue()))
    LogService:Log(tabs .. "value: " .. tostring(gameplayResource:GetField("value"):GetValue()))
    LogService:Log(tabs .. "specific_group: " .. tostring(gameplayResource:GetField("specific_group"):GetValue()))
    LogService:Log(tabs .. "attachment: " .. tostring(gameplayResource:GetField("radius"):GetValue()))
    local attachment = gameplayResource:GetField("attachment"):ToContainer()
    for i=0, attachment:GetItemCount() - 1 do
        LogService:Log(tabs .. "    " .. tostring(attachment:GetItem(i):GetValue()))
    end
end

function LogVectorGameplayResource(vector, name, tabs)
    tabs = tabs or ""
    LogService:Log(tabs .. "Vector GameplayResource: " .. name)
    if vector.IsContainer and vector:IsContainer() then
        vector = vector:ToContainer()
    end
    if vector.GetItemCount then
        local count = vector:GetItemCount()
        for i=0, count -1 do
            LogGameplayResource(vector:GetItem(i), tabs .. "    ")
        end
    end
end