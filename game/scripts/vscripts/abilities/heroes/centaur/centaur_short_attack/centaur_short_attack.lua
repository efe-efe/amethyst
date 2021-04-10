centaur_short_attack = class({})
function centaur_short_attack:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end 
function centaur_short_attack:GetPlaybackRateOverride()    return 0.7 end
function centaur_short_attack:GetCastPointSpeed() 			return 0 end

function centaur_short_attack:OnAbilityPhaseStart()
    local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()
    local radius = self:GetSpecialValueFor("radius")
    self.radius_marker_modifier = CreateTimedRadiusMarker(caster, origin, radius, self:GetCastPoint(), 0.2, RADIUS_SCOPE_PUBLIC):FindModifierByName('radius_marker_thinker')

    return true
end

function centaur_short_attack:OnSpellStart()
    print('HE')
    local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()
    local radius = self:GetSpecialValueFor("radius")
    local stun_duration = 0.5
    local damage_table = {
        attacker = caster,
        damage = 20,
        damage_type = DAMAGE_TYPE_PURE,
    }

    EmitSoundOn('Hero_Centaur.HoofStomp', caster)
    ApplyCallbackForUnitsInArea(caster, origin, radius/2, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
        damage_table.victim = unit
        ApplyDamage(damage_table)
        unit:AddNewModifier(caster, self, 'modifier_generic_stunned', { duration = stun_duration })
    end)
end

function centaur_short_attack:OnAbilityPhaseInterrupted()
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(centaur_short_attack)