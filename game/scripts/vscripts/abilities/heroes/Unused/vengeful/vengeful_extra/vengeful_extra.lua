vengeful_extra = class({})
vengeful_extra_ultimate = class({})

LinkLuaModifier("modifier_vengeful_extra_thinker", "abilities/heroes/vengeful/vengeful_extra/modifier_vengeful_extra_thinker", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Ability Start
function vengeful_extra:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = Clamp(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local ability = caster:FindAbilityByName("vengeful_extra")
    local delay_time = ability:GetSpecialValueFor("delay_time")
	local radius = ability:GetSpecialValueFor("radius")
	
    CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			show_all = 1,
			thinker = "modifier_vengeful_extra_thinker",
			radius = radius,
			delay_time = delay_time,
			draw_clock = 1
		}, --paramTable
		Vector(point.x, point.y, caster:GetOrigin().z), --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
end

vengeful_extra_ultimate.OnCastPointEnd = vengeful_extra.OnCastPointEnd


if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	vengeful_extra,
	{ activity = ACT_DOTA_CAST_ABILITY_2, rate = 1.5 },
	{ movement_speed = 10 }
)
Abilities.Initialize(
	vengeful_extra_ultimate,
	{ activity = ACT_DOTA_CAST_ABILITY_2, rate = 1.5 },
	{ movement_speed = 10 }
)