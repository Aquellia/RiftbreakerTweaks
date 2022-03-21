local building = require("lua/buildings/building.lua")

class 'ore_boosted_synthesizer' ( building )

function ore_boosted_synthesizer:__init()
    building.__init(self,self)
end

function ore_boosted_synthesizer:OnBuild()
    LogPossibleProperties(self, "Ore Synthesizer OnBuild")
    LogFieldList(self, "Ore Synthesizer OnBuild")
    local resourceConverterComponent = EntityService:GetComponent(self.entity, "ResourceConverterComponent")
    local vein_field = resourceConverterComponent:GetField("vein")
    LogContainerItems(vein_field, "vein")
end

return ore_boosted_synthesizer
