local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 4,["13"] = 4,["14"] = 5,["15"] = 8,["16"] = 9,["17"] = 10,["19"] = 8,["20"] = 18,["21"] = 19,["22"] = 20,["23"] = 21,["25"] = 18,["26"] = 25,["27"] = 26,["28"] = 25,["29"] = 29,["30"] = 30,["31"] = 29,["32"] = 33,["33"] = 34,["34"] = 33,["35"] = 37,["36"] = 38,["37"] = 37,["38"] = 40,["39"] = 41,["40"] = 40,["41"] = 43,["42"] = 44,["43"] = 43,["44"] = 5,["45"] = 4,["46"] = 5});
local ____exports = {}
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ModifierSapphire = __TS__Class()
ModifierSapphire.name = "ModifierSapphire"
__TS__ClassExtends(ModifierSapphire, CustomModifier)
function ModifierSapphire.prototype.OnCreated(self)
    if IsServer() then
        self.particleId = ParticleManager:CreateParticle("particles/generic_gameplay/rune_doubledamage_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    end
end
function ModifierSapphire.prototype.OnDestroy(self)
    if IsServer() then
        ParticleManager:DestroyParticle(self.particleId, false)
        ParticleManager:ReleaseParticleIndex(self.particleId)
    end
end
function ModifierSapphire.prototype.GetTexture(self)
    return "modifier_sapphire"
end
function ModifierSapphire.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_TOOLTIP}
end
function ModifierSapphire.prototype.OnTooltip(self)
    return self:GetStackCount()
end
function ModifierSapphire.prototype.GetStatusLabel(self)
    return "Sapphire"
end
function ModifierSapphire.prototype.GetStatusPriority(self)
    return 2
end
function ModifierSapphire.prototype.GetStatusStyle(self)
    return "Sapphire"
end
ModifierSapphire = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_sapphire"})},
    ModifierSapphire
)
return ____exports
