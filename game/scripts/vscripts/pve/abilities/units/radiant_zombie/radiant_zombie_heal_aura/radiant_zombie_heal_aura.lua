radiant_zombie_heal_aura = class({})

function radiant_zombie_heal_aura:GetCastAnimationCustom()		return ACT_DOTA_ATTACK end
function radiant_zombie_heal_aura:GetPlaybackRateOverride()    return 1.0 end
function radiant_zombie_heal_aura:GetCastPointSpeed() 			return 0 end

function radiant_zombie_heal_aura:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()
    local radius = self:GetSpecialValueFor("radius")
    local heal = self:GetSpecialValueFor("heal")

    ApplyCallbackForUnitsInArea(caster, origin, radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, function(unit)
        caster:Heal(heal, unit)
    end)

    CreateRadiusMarker(self:GetCaster(), self:GetCaster():GetAbsOrigin(), radius, RADIUS_SCOPE_PUBLIC, 0.15)
    EmitSoundOn("General.Attack", self:GetCaster())

    EFX("particles/radiant_zombie/heal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster(), {
        release = true,
    })
end

function radiant_zombie_heal_aura:OnUpgrade()
    EFX("particles/radiant_zombie/heal_aura.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster(), {
        release = true,
    })
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(radiant_zombie_heal_aura)