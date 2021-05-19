nevermore_special_attack = class({})
LinkLuaModifier("modifier_nevermore_special_attack_thinker", "abilities/heroes/nevermore/nevermore_special_attack/modifier_nevermore_special_attack_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_special_attack_displacement", "abilities/heroes/nevermore/nevermore_special_attack/modifier_nevermore_special_attack_displacement", LUA_MODIFIER_MOTION_BOTH)

function nevermore_special_attack:GetCastAnimationCustom()		return ACT_DOTA_RAZE_3 end
function nevermore_special_attack:GetPlaybackRateOverride()		return 1.3 end
function nevermore_special_attack:GetCastPointSpeed() 			return 10 end
function nevermore_special_attack:GetFadeGestureOnCast()			return false end

function nevermore_special_attack:OnAbilityPhaseStart()
	self.effect_cast = ParticleManager:CreateParticle("particles/econ/items/sven/sven_warcry_ti5/sven_spell_warcry_ti_5.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())

	local random_number = RandomInt(0, 3)
	EmitSoundOn("nevermore_nev_cast_0" .. random_number, self:GetCaster())
	EmitSoundOn("Hero_Nevermore.Attack", self:GetCaster())
	
	return true
end

function nevermore_special_attack:OnAbilityPhaseInterrupted()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
end

function nevermore_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), nil)

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_nevermore_special_attack_thinker", --modifierName
		{ duration = self:GetSpecialValueFor("delay_time") + 0.2 }, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(nevermore_special_attack)