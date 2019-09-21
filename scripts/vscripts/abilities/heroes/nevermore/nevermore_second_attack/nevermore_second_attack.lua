nevermore_second_attack = class({})
LinkLuaModifier( "modifier_nevermore_second_attack_thinker", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack_thinker", LUA_MODIFIER_MOTION_NONE )


function nevermore_second_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("nevermore_ex_second_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_second_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	self.radius = self:GetSpecialValueFor("radius")
	
	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=1.0, activity=ACT_DOTA_RAZE_2, rate=1.6})
	caster:AddNewModifier(caster, self , "modifier_cast_point", { 
		duration = cast_point,
		movement_speed = 10,
		radius = self.radius,
	})
end

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_second_attack:OnCastPointEnd( point )
	local caster = self:GetCaster()
	local delay_time = self:GetSpecialValueFor( "delay_time" )

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_nevermore_second_attack_thinker",
			show_all = 1,
			radius = self.radius,
			delay_time = delay_time,
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

	-- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("nevermore_ex_second_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))
end