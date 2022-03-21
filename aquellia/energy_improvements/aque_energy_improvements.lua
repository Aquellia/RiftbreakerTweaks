require("aquellia/utils/aque_debug_utils.lua")

function setEnergyDistribution(buildingName, radius)
    local blueprint = ResourceManager:GetBlueprint(buildingName)
    local resourceStorageComponent = blueprint:GetComponent("ResourceStorageComponent")
    local storages = resourceStorageComponent:GetField("Storages")
    local container = storages:ToContainer()
    local count = container:GetItemCount()
    -- Find energy storage
    for i=0, count do
        local item = container:GetItem(i)
        if item ~= nil then
            local resource = item:GetField("resource")

            --[[
            if resource == "energy" then
                item:GetField("distribution_radius"):SetValue("2")
                return
            end
            --]]
        end
    end
end
