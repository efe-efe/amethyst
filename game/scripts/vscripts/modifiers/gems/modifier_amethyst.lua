local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 4,["13"] = 4,["14"] = 5,["15"] = 8,["16"] = 9,["17"] = 10,["18"] = 11,["19"] = 11,["20"] = 11,["21"] = 11,["22"] = 11,["24"] = 8,["25"] = 20,["26"] = 21,["27"] = 22,["29"] = 20,["30"] = 27,["31"] = 28,["32"] = 29,["33"] = 30,["35"] = 27,["36"] = 34,["37"] = 35,["38"] = 34,["39"] = 38,["40"] = 39,["41"] = 38,["42"] = 5,["43"] = 4,["44"] = 5});
local ____exports = {}
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ModifierAmethyst = __TS__Class()
ModifierAmethyst.name = "ModifierAmethyst"
__TS__ClassExtends(ModifierAmethyst, CustomModifier)
function ModifierAmethyst.prototype.OnCreated(self, params)
    if IsServer() then
        self:SetStackCount(params.mana)
        self.particleId = ParticleManager:CreateParticle(
            "particles/generic_gameplay/rune_arcane_owner.vpcf",
            PATTACH_ABSORIGIN_FOLLOW,
            self:GetParent()
        )
    end
end
function ModifierAmethyst.prototype.OnRefresh(self, params)
    if IsServer() then
        self:SetStackCount(self:GetStackCount() + params.mana)
    end
end
function ModifierAmethyst.prototype.OnDestroy(self)
    if IsServer() then
        ParticleManager:DestroyParticle(self.particleId, false)
        ParticleManager:ReleaseParticleIndex(self.particleId)
    end
end
function ModifierAmethyst.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_EXTRA_MANA_BONUS}
end
function ModifierAmethyst.prototype.GetModifierExtraManaBonus(self)
    return self:GetStackCount()
end
ModifierAmethyst = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_amethyst"})},
    ModifierAmethyst
)
return ____exports
