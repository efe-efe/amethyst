treant_ex_special_attack = class({})
LinkLuaModifier( "modifier_treant_ex_special_attack_thinker", "abilities/heroes/treant/treant_ex_special_attack/modifier_treant_ex_special_attack_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function treant_ex_special_attack:OnCastPointEnd( )
	local caster = self:GetCaster()
    local delay_time = self:GetSpecialValueFor( "delay_time" )
    local radius = self:GetSpecialValueFor( "radius" )

    CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_treant_ex_special_attack_thinker",
			show_all = 1,
			radius = radius,
			delay_time = delay_time,
		}, --paramTable
		caster:GetOrigin(), --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
	
	-- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("treant_special_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	treant_ex_special_attack,
	{ activity = ACT_DOTA_CAST_ABILITY_2, rate = 1.0 },
	{ movement_speed = 10 }
)