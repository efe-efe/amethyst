treant_ex_special_attack = class({})
LinkLuaModifier( "modifier_treant_ex_special_attack_thinker", "abilities/heroes/treant/treant_ex_special_attack/modifier_treant_ex_special_attack_thinker", LUA_MODIFIER_MOTION_NONE )

function treant_ex_special_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("treant_special_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function treant_ex_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
    self.radius = self:GetSpecialValueFor( "radius" )

    StartAnimation(caster, {
        duration = cast_point + 0.1, 
        activity=ACT_DOTA_CAST_ABILITY_2, 
        rate=1.0
    })
	-- Animation and pseudo cast point
	caster:AddNewModifier(
		caster,
		self,
		"modifier_generic_pseudo_cast_point",
		{ 
			duration = cast_point, 
            movement_speed = 10,
            radius = self.radius,
            no_target = 1,
		}
	)
end

--------------------------------------------------------------------------------
-- Ability Start
function treant_ex_special_attack:OnEndPseudoCastPoint( )
	-- unit identifier
	local caster = self:GetCaster()
    local delay_time = self:GetSpecialValueFor( "delay_time" )

    CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_treant_ex_special_attack_thinker",
			show_all = 1,
			radius = self.radius,
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