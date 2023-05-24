local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 4,["13"] = 4,["14"] = 5,["15"] = 8,["16"] = 9,["17"] = 10,["18"] = 11,["19"] = 12,["21"] = 8,["22"] = 20,["23"] = 21,["24"] = 22,["25"] = 23,["27"] = 20,["28"] = 27,["29"] = 28,["30"] = 28,["31"] = 28,["32"] = 28,["33"] = 30,["34"] = 30,["35"] = 30,["36"] = 30,["37"] = 34,["38"] = 34,["39"] = 34,["40"] = 30,["41"] = 30,["42"] = 39,["43"] = 47,["44"] = 27,["45"] = 56,["46"] = 57,["47"] = 56,["48"] = 60,["49"] = 61,["50"] = 60,["51"] = 64,["52"] = 65,["53"] = 64,["54"] = 5,["55"] = 4,["56"] = 5});
local ____exports = {}
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ModifierRuby = __TS__Class()
ModifierRuby.name = "ModifierRuby"
__TS__ClassExtends(ModifierRuby, CustomModifier)
function ModifierRuby.prototype.OnCreated(self, params)
    if IsServer() then
        self:SetStackCount(params.healPerSecond)
        self:StartIntervalThink(1)
        self.particleId = ParticleManager:CreateParticle("particles/gems/emerald_regen_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    end
end
function ModifierRuby.prototype.OnDestroy(self)
    if IsServer() then
        ParticleManager:DestroyParticle(self.particleId, false)
        ParticleManager:ReleaseParticleIndex(self.particleId)
    end
end
function ModifierRuby.prototype.OnIntervalThink(self)
    self.parent:Heal(
        self:GetStackCount(),
        nil
    )
    EFX(
        "particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_target_death_beam.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        self.parent,
        {
            cp1 = self.parent:GetAbsOrigin(),
            release = true
        }
    )
    EFX("particles/econ/items/dazzle/dazzle_ti6_gold/dazzle_ti6_shallow_grave_gold_flash.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, {release = true})
    EFX("particles/gems/emerald_hammers.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, {cp3 = {ent = self.parent, point = "attach_hitloc"}, release = true})
end
function ModifierRuby.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_TOOLTIP}
end
function ModifierRuby.prototype.OnTooltip(self)
    return self:GetStackCount()
end
function ModifierRuby.prototype.GetTexture(self)
    return "modifier_emerald"
end
ModifierRuby = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_emerald"})},
    ModifierRuby
)
return ____exports
