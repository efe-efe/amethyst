local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 14,["6"] = 14,["7"] = 1,["8"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 4,["15"] = 5,["16"] = 6,["17"] = 7,["18"] = 9,["19"] = 11,["21"] = 14,["22"] = 15,["23"] = 17,["24"] = 18,["25"] = 19,["26"] = 19,["27"] = 19,["28"] = 19,["29"] = 19,["30"] = 20,["31"] = 20,["32"] = 20,["33"] = 20,["34"] = 20,["35"] = 21,["36"] = 21,["37"] = 21,["38"] = 21,["39"] = 21,["40"] = 22,["41"] = 25,["42"] = 26,["43"] = 27});
function item_shadow_blade_custom(self)
end
____class_0 = __TS__Class()
____class_0.name = ""
function ____class_0.prototype.____constructor(self)
end
item_shadow_blade_custom = ____class_0(nil, {})
LinkLuaModifier("modifier_item_shadow_blade_custom", "items/item_shadow_blade_custom/modifier_item_shadow_blade_custom", LUA_MODIFIER_MOTION_HORIZONTAL)
OnSpellStart(nil)
do
    local caster = self.caster
    local origin = caster:GetOrigin()
    local duration = self:GetSpecialValueFor("duration")
    caster:AddNewModifier(caster, self, "modifier_item_shadow_blade_custom", {duration = duration})
    self:PlayEffects()
end
local ____ = ____
EmitSoundOn("DOTA_Item.InvisibilitySword.Activate", self.caster)
particle_cast = "particles/econ/items/riki/riki_immortal_ti6/riki_immortal_ti6_blinkstrike.vpcf"
particleId = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, ____nil)
ParticleManager:SetParticleControl(
    particleId,
    0,
    self.caster:GetOrigin()
)
ParticleManager:SetParticleControl(
    particleId,
    1,
    self.caster:GetOrigin()
)
ParticleManager:SetParticleControl(
    particleId,
    3,
    self.caster:GetOrigin()
)
ParticleManager:ReleaseParticleIndex(particleId)
particle_cast = "particles/units/heroes/hero_spirit_breaker/spirit_breaker_haste_owner_runes.vpcf"
particleId = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.caster)
ParticleManager:ReleaseParticleIndex(particleId)
