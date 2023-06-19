invoker_meteor_custom = class({})
LinkLuaModifier("modifier_invoker_meteor_custom_thinker", "abilities/heroes/invoker/invoker_extra/modifier_invoker_meteor_custom_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_invoker_meteor_custom_impact_thinker", "abilities/heroes/invoker/invoker_extra/modifier_invoker_meteor_custom_impact_thinker", LUA_MODIFIER_MOTION_NONE)

function invoker_meteor_custom:GetCastAnimationCustom()		return ACT_DOTA_CAST_CHAOS_METEOR end
function invoker_meteor_custom:GetPlaybackRateOverride()	    return 1.0 end
function invoker_meteor_custom:GetCastPointSpeed() 			return 80 end

function invoker_meteor_custom:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local point = ClampPosition(caster:GetAbsOrigin(), CustomAbilitiesLegacy:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), self:GetSpecialValueFor("min_range"))
		
	CreateModifierThinker(
		caster,
		self,
		"modifier_invoker_meteor_custom_impact_thinker",
		{
			x = origin.x,
			y = origin.y
		},
		point,
		caster:GetTeamNumber(),
		false
	)
	self:PlayEffectsOnCast()
end

function invoker_meteor_custom:PlayEffectsOnCast()
	EFX("particles/invoker/invoker_meteor_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster(), {
		release = true
	})
	EmitSoundOn("Hero_Invoker.ChaosMeteor.Cast", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(invoker_meteor_custom)
