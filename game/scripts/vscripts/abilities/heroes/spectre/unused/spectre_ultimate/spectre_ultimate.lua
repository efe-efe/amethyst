spectre_ultimate = class({})
LinkLuaModifier( "modifier_spectre_ultimate_thinker", "abilities/heroes/spectre/spectre_ultimate/modifier_spectre_ultimate_thinker", LUA_MODIFIER_MOTION_NONE )

function spectre_ultimate:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function spectre_ultimate:GetPlaybackRateOverride() 	return 0.6 end
function spectre_ultimate:GetCastPointSpeed() 			return 0 end

function spectre_ultimate:OnAbilityPhaseStart()
	EmitGlobalSound("Hero_Spectre.Haunt")
end

function spectre_ultimate:OnSpellStart()
	local caster = self:GetCaster()
	local delay_time = self:GetSpecialValueFor("delay_time")
	local duration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("radius")
	local point = Clamp(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_spectre_ultimate_thinker", --modifierName
		{ duration = delay_time + duration }, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
end

function spectre_ultimate:PlayEffectsOnCast(pos)
	local caster = self:GetCaster()

end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(spectre_ultimate)