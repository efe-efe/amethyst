treant_ex_second_attack = class({})
LinkLuaModifier( "modifier_treant_ex_second_attack_thinker", "abilities/heroes/treant/treant_ex_second_attack/modifier_treant_ex_second_attack_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function treant_ex_second_attack:OnCastPointEnd()
	-- unit identifier
	local caster = self:GetCaster()
    local delay_time = self:GetSpecialValueFor( "delay_time" )
    local radius = self:GetSpecialValueFor( "radius" )
	local point = Clamp(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	
	--PrintTable(self:GetAbilityKeyValues())
    CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_treant_ex_second_attack_thinker",
			show_all = 1,
			radius = radius,
			delay_time = delay_time,
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	treant_ex_second_attack,
	{ activity = ACT_DOTA_CAST_ABILITY_2, rate = 1.0 },
	{ movement_speed = 10 }
)