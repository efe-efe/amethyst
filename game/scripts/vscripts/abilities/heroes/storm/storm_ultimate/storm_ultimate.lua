storm_ultimate = class({})
LinkLuaModifier("modifier_storm_ultimate", "abilities/heroes/storm/storm_ultimate/modifier_storm_ultimate", LUA_MODIFIER_MOTION_BOTH)

function storm_ultimate:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function storm_ultimate:GetPlaybackRateOverride()       return 1.0 end
function storm_ultimate:GetCastPointSpeed() 			return 0 end

function storm_ultimate:OnAbilityPhaseStart()
    local caster = self:GetCaster()
    self.efx = EFX('particles/storm/storm_ultimate_casting.vpcf', PATTACH_ABSORIGIN_FOLLOW, caster, {
        cp1 = Vector(100, 0, 0)
    })
    EmitGlobalSound('stormspirit_ss_spawn_07')

    return true
end

function storm_ultimate:OnAbilityPhaseInterrupted()
    DEFX(self.efx, false)
end

function storm_ultimate:OnSpellStart()
    DEFX(self.efx, false)
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    
    EmitSoundOn('Hero_StormSpirit.StaticRemnantExplode', caster)
    caster:AddNewModifier(caster, self, 'modifier_storm_ultimate', { duration = duration })
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(storm_ultimate)