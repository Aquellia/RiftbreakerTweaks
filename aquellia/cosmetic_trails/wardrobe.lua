require("lua/utils/string_utils.lua")
require("lua/utils/table_utils.lua")

local building = require("lua/buildings/building.lua")
class 'wardrobe' ( building )

local DEFAULT_TRAIL_BLUEPRINT = "items/loot/trails/no_trail_item";

function wardrobe:__init()
    building.__init(self,self)
end

function wardrobe:OnInit()
    building.OnInit(self)

    self.default_item = INVALID_ID

    self:RegisterHandler( self.entity, "ItemEquippedEvent", "OnItemEquippedEvent" )
    self:RegisterHandler( self.entity, "LuaGlobalEvent", "OnLuaGlobalEvent" )
end

function IsEquippedTrailItemBlueprintValid( entity, new_blueprint )
    if new_blueprint ~= DEFAULT_TRAIL_BLUEPRINT and EntityService:GetBlueprintName( entity ) == DEFAULT_TRAIL_BLUEPRINT then
        return false
    end

    return true
end

function wardrobe:OnLoad()
    building.OnLoad(self)

    if self.default_item ~= INVALID_ID then
        local default_blueprint = self:GetDefaultTrailItem()
        if not IsEquippedTrailItemBlueprintValid( self.default_item, default_blueprint )  then
            self.default_item = ItemService:AddItemToInventory( self.entity, default_blueprint )
        end

        if self.item and self.item ~= INVALID_ID then
            if not IsEquippedTrailItemBlueprintValid( self.item, default_blueprint ) then
                ItemService:EquipItemInSlot( self.entity, self.default_item, "MOD_1" )
            end
        end
    end
end

function wardrobe:GetDefaultTrailItem()
    return self.data:GetStringOrDefault("trail_item", DEFAULT_TRAIL_BLUEPRINT)
end

function wardrobe:OnBuildingEnd()
    if self.default_item == INVALID_ID then
        self.default_item = ItemService:AddItemToInventory( self.entity, self:GetDefaultTrailItem())
    end

    if not ItemService:IsSameSubTypeEquipped( self.entity, self.default_item ) then
        ItemService:EquipItemInSlot( self.entity, self.default_item, "MOD_1" )
    end

    building.OnBuildingEnd(self)
end

function wardrobe:OnActivate()
    if not ItemService:IsSameSubTypeEquipped( self.entity, self.default_item ) then
        ItemService:EquipItemInSlot( self.entity, self.default_item, "MOD_1" )
    end

    building.OnActivate(self)
end

function wardrobe:PopulateSpecialActionInfo()
    local trail_blueprint = self.data:GetStringOrDefault("trail_blueprint", "")
    if trail_blueprint == "" then
        trail_blueprint = self.data:GetStringOrDefault("plant_prefab", "");
    end

    if trail_blueprint == "" then
        return
    end

    self.data:SetString("stat_categories", "gui/hud/build_menu/info.plants" )
    self.data:SetString("gui/hud/build_menu/info.plants.icon", "")
    self.data:SetString("gui/hud/build_menu/info.plants.rows", "plant" )
    self.data:SetString("gui/hud/build_menu/info.plants.rows.plant.name", trail_blueprint)

    if ( self.item ~= INVALID_ID ) then
        local material = ItemService:GetItemIcon( self.item )

        self.data:SetString("gui/hud/build_menu/info.plants.rows.plant.icon", material )
        self.data:SetString("gui/hud/build_menu/info.plants.rows.plant.value",  "" )

        self.data:SetString("action_icon", material )
    end
end

function wardrobe:OnLuaGlobalEvent( evt )
    if evt:GetEvent() == "CultivationEnded" then
        self.cultivate_target = nil;
    elseif evt:GetEvent() == "CultivateSapling" then
        local trail_item = evt:GetDatabase():GetString("trail_item");

        self.data:SetString("trail_item", trail_item)
        self.default_item = ItemService:AddItemToInventory( self.entity, trail_item)
        ItemService:EquipItemInSlot( self.entity, self.default_item, "MOD_1" )
    else
        local tokens = Split(evt:GetEvent(), "@");
        if #tokens == 2 then
            if tokens[1] == "CultivatePlant" then
                local entity = FindService:FindEntityByName(tokens[2] )
                if entity ~= INVALID_ID then
                    self.cultivate_target = tokens[2]
                end
            end
        end
    end
end

function wardrobe:OnItemEquippedEvent( evt )
    self.item = evt:GetItem()
    if ( EntityService:IsAlive(self.item) == false ) then
        return
    end

    local db = EntityService:GetDatabase( self.item )
    if( db == nil ) then
        return
    end

    if db:HasString("plant_blueprint") then
        self.spawn_blueprint = db:GetStringOrDefault( "plant_blueprint", "" )
        EntityService:RemoveComponent( self.entity, "FloraCultivatorComponent");
    else
        self.spawn_blueprint = nil
    end

    if db:HasString("plant_prefab") then
        self.spawn_prefab = BuildingService:CreateFloraCultivatorComponent( self.entity, db:GetStringOrDefault( "plant_prefab", "" ) )
    else
        self.spawn_prefab = nil
    end

    Assert( (self.spawn_blueprint or self.spawn_prefab) ~= nil, "ERROR: missing plant info! " .. db:GetStringOrDefault( "plant_prefab", "" ) .. " " .. db:GetStringOrDefault( "plant_blueprint", "" ) );
end

return wardrobe
