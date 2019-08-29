axe_second_attack = class({})
LinkLuaModifier( "modifier_axe_second_attack_thinker", "abilities/heroes/axe/axe_second_attack/modifier_axe_second_attack_thinker", LUA_MODIFIER_MOTION_HORIZONTAL )

function axe_second_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("axe_ex_second_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function axe_second_attack:OnSpellStart()
	
	local sound_cast = "Hero_Axe.BerserkersCall.Item.Shoutmask"
	EmitSoundOn( sound_cast, self:GetCaster() )

	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	self.radius = self:GetSpecialValueFor("radius")

	-- Animation and pseudo cast point
	StartAnimation(caster, {
		duration = cast_point + 0.1, 
		translate = "come_get_it", 
		activity = ACT_DOTA_TAUNT, 
		rate = 1.3
	})
	
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
		duration = cast_point,
		can_walk = 0,
		radius = self.radius,
	})
end

function axe_second_attack:OnEndPseudoCastPoint( point )
	local caster = self:GetCaster()
	local delay_time = self:GetSpecialValueFor( "delay_time" )

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_axe_second_attack_thinker",
			show_all = 1,
			radius = self.radius,
			delay_time = delay_time,
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
end
