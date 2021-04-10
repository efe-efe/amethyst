invoker_emp_custom = class({})
LinkLuaModifier("modifier_invoker_emp_custom_thinker", "abilities/heroes/invoker/invoker_extra/modifier_invoker_emp_custom_thinker", LUA_MODIFIER_MOTION_NONE)

function invoker_emp_custom:GetCastAnimationCustom()		return ACT_DOTA_CAST_EMP end
function invoker_emp_custom:GetPlaybackRateOverride() 	    return 1.0 end
function invoker_emp_custom:GetCastPointSpeed() 			return 10 end

function invoker_emp_custom:OnSpellStart()
	local caster = self:GetCaster()
    local delay_time = self:GetSpecialValueFor('delay_time')
	local point = ClampPosition(caster:GetOrigin(), CustomAbilities:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), nil)

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_invoker_emp_custom_thinker", --modifierName
		{ duration = delay_time },
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(invoker_emp_custom)