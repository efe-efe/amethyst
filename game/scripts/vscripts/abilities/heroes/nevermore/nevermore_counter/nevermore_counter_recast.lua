nevermore_counter_recast = class({})
LinkLuaModifier( "modifier_nevermore_counter_thinker", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_thinker", LUA_MODIFIER_MOTION_NONE )

function nevermore_counter_recast:OnCastPointEnd()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	
	local point = CalcPoint(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local delay_time = self:GetSpecialValueFor( "delay_time" )
	local radius = self:GetSpecialValueFor("radius")
	local ability = caster:FindAbilityByName("nevermore_counter")
	local damage = ability:GetSpecialValueFor("ability_damage")
	local lift_duration = ability:GetSpecialValueFor("lift_duration")
	
	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_nevermore_counter_thinker",
			show_all = 1,
			radius = radius,
			delay_time = delay_time,
			lift_duration = lift_duration,
			damage = damage,
			draw_clock = 1
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
    nevermore_counter_recast,
	nil,
	{ movement_speed = 0 },
	{ modifier_name = "modifier_nevermore_counter_recast" }
)
