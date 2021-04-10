invoker_sun_custom = class({})
LinkLuaModifier("modifier_invoker_sun_custom_thinker", "abilities/heroes/invoker/invoker_extra/modifier_invoker_sun_custom_thinker", LUA_MODIFIER_MOTION_NONE)

function invoker_sun_custom:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function invoker_sun_custom:GetPlaybackRateOverride() 	    return 1.0 end
function invoker_sun_custom:GetCastPointSpeed() 			return 10 end

function invoker_sun_custom:OnSpellStart()
	local caster = self:GetCaster()
	local point = CustomAbilities:GetCursorPosition(self)
	
	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_invoker_sun_custom_thinker", --modifierName
		{},
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(invoker_sun_custom)

