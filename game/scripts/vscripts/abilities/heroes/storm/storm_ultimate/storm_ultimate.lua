storm_ultimate = class({})
LinkLuaModifier("modifier_storm_ultimate", "abilities/heroes/storm/storm_ultimate/modifier_storm_ultimate", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_storm_ultimate_thinker", "abilities/heroes/storm/storm_ultimate/modifier_storm_ultimate_thinker", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_storm_ultimate_banish", "abilities/heroes/storm/storm_ultimate/modifier_storm_ultimate_banish", LUA_MODIFIER_MOTION_BOTH)

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
	local origin = caster:GetAbsOrigin()
	local point = Clamp(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
    
    EmitSoundOn('Hero_StormSpirit.StaticRemnantExplode', caster)
    EmitSoundOn('Hero_Zeus.BlinkDagger.Arcana', caster)
    EmitSoundOn('Hero_Zuus.GodsWrath.PreCast.Arcana', caster)
    
    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_storm_ultimate_thinker", --modifierName
        { duration = 1.0 },
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )

    EFX('particles/econ/items/zeus/arcana_chariot/zeus_arcana_blink_start.vpcf', PATTACH_WORLDORIGIN, caster, {
        cp0 = origin,
        release = true,
    })
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(storm_ultimate)