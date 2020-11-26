storm_special_attack = class({})
LinkLuaModifier("modifier_storm_special_attack_thinker", "abilities/heroes/storm/storm_special_attack/modifier_storm_special_attack_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_storm_special_attack_efx", "abilities/heroes/storm/storm_special_attack/modifier_storm_special_attack_efx", LUA_MODIFIER_MOTION_NONE)

function storm_special_attack:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_2 end
function storm_special_attack:GetPlaybackRateOverride()		return 2.0 end
function storm_special_attack:GetCastPointSpeed() 			return 10 end

function storm_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local point = Clamp(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

	local damage = self:GetSpecialValueFor("ability_damage")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_storm_special_attack_thinker", --modifierName
		{},
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

	self:PlayEffectsOnCast(caster, origin, point)
    EmitSoundOn('Hero_StormSpirit.ElectricVortexCast', caster)
end

function storm_special_attack:PlayEffectsOnFinish(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.ProjectileImpact", caster)
	
	local particle_cast = "particles/units/heroes/hero_stormspirit/stormspirit_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function storm_special_attack:PlayEffectsOnCast(caster, origin, point)
	local efx = EFX("particles/storm/storm_special_attack_launch.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster, {
		cp1 = point + Vector(0, 0, 2000)
	})
	ParticleManager:SetParticleControlEnt(
		efx,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		origin, -- unknown
		false -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex(efx)
	EmitSoundOn("Hero_StormSpirit.Attack", caster)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(storm_special_attack)