require("aquellia/utils/reflection.lua")
require("aquellia/utils/components/aque_ResourceStorageComponent.lua")
require("lua/utils/table_utils.lua")
require("lua/utils/string_utils.lua")

local gamemode_based_building = require("lua/buildings/building.lua");

class 'gamemode_based_building' (gamemode_based_building)

function gamemode_based_building:__init()
    building.__init(self)
end

-- Changes the blueprint values according to the database values
function gamemode_based_building:UpdateBlueprint(mode)
    local database = EntityService:GetBlueprintDatabase( self.entity ) or self.data
    -- ResourceConverterDesc

    -- ResourceStorageDesc
    local resourceStorageComponent = reflection_helper(EntityService:GetComponent(self.entity, "ResourceStorageComponent"))
    local global_base_max = database:GetFloat(mode .. "_global_base_max")
    if global_base_max ~= nil then
        local storage = FindStorageFor(resourceStorageComponent, "global", "base")
        if not storage then return end -- Error Missing Storage Entry
        storage.max = global_base_max
    end
    local energy_max = database:GetFloat(mode .. "_energy_max")
    if energy_max ~= nil then
        local storage = FindStorageFor(resourceStorageComponent, "energy")
        if not storage then return end -- Error Missing Storage Entry
        storage.max = energy_max
    end
end

function gamemode_based_building:OnBuild()
    if campaign_mode then
        self:UpdateBlueprint("campaign")
    else
        self:UpdateBlueprint("survival")
    end
end

return gamemode_based_building