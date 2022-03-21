--- Enables the Discovery System at the start of the campaign

local campaignDef = ResourceManager:GetResource("CampaignDef", "campaigns/story/story.campaign")
local discoverable_system_enabled = campaignDef:GetField("discoverable_system_enabled")
LogService:Log(tostring(discoverable_system_enabled:GetValue()))
discoverable_system_enabled:SetValue("true")
LogService:Log(tostring(discoverable_system_enabled:GetValue()))