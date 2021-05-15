dire_zombie_rage_aura = class({})
LinkLuaModifier("modifier_dire_zombie_rage_aura", "pve/abilities/units/dire_zombie/dire_zombie_rage_aura/modifier_dire_zombie_rage_aura", LUA_MODIFIER_MOTION_NONE)

function dire_zombie_rage_aura:GetCastAnimationCustom()		return ACT_DOTA_ATTACK end
function dire_zombie_rage_aura:GetPlaybackRateOverride()    return 1.0 end
function dire_zombie_rage_aura:GetCastPointSpeed() 			return 0 end

function dire_zombie_rage_aura:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()
    local radius = self:GetSpecialValueFor("radius")
    local duration = self:GetSpecialValueFor("duration")

    ApplyCallbackForUnitsInArea(caster, origin, radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, function(unit)
        unit:AddNewModifier(caster, self, 'modifier_dire_zombie_rage_aura', { duration = duration })
    end)

    CreateRadiusMarker(self:GetCaster(), self:GetCaster():GetAbsOrigin(), radius, RADIUS_SCOPE_PUBLIC, 0.15)
    EmitSoundOn("General.Attack", self:GetCaster())
end

function dire_zombie_rage_aura:OnUpgrade()
    EFX("particles/econ/items/invoker/invoker_ti7/invoker_ti7_alacrity_buff.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetCaster(), {})
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(dire_zombie_rage_aura)