ability_name = class({})
LinkLuaModifier("modifier_ability_name_thinker", "abilities/heroes/hero_name/ability_name/modifier_ability_name_thinker", LUA_MODIFIER_MOTION_NONE)

function ability_name:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = Clamp(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local delay_time = self:GetSpecialValueFor("delay_time")
	local radius = self:GetSpecialValueFor("radius")

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_ability_name_thinker",
			show_all = 1,
			radius = radius,
			delay_time = delay_time,
			--thinker_duration = duration + delay_time ,
			--draw_clock = 1
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	ability_name,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 1.0 },
	{ movement_speed = 10 }
)