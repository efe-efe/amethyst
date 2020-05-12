sniper_special_attack = class({})
LinkLuaModifier("modifier_sniper_shrapnel_thinker_custom", "abilities/heroes/sniper/sniper_shared_modifiers/modifier_sniper_shrapnel_thinker_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sniper_shrapnel_debuff", "abilities/heroes/sniper/sniper_shared_modifiers/modifier_sniper_shrapnel_debuff", LUA_MODIFIER_MOTION_NONE)

function sniper_special_attack:GetCastPoint()
	return self:GetSpecialValueFor("cast_point")
end

function sniper_special_attack:OnAbilityPhaseStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_casting", { 
		duration = self:GetCastPoint(), 
		movement_speed = 10,
	})
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.5)
	return true
end

function sniper_special_attack:OnAbilityPhaseInterrupted()
	self:GetCaster():FadeGesture(ACT_DOTA_CAST_ABILITY_1)
	self:GetCaster():RemoveModifierByName("modifier_casting")
end

function sniper_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = CalcPoint(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local duration = self:GetSpecialValueFor( "duration" )

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_sniper_shrapnel_thinker_custom", --modifierName
		{ duration = duration },
		Vector(point.x, point.y, caster:GetOrigin().z), --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
	
	self:PlayEffects(point)
end

function sniper_special_attack:PlayEffects(point)
	EmitSoundOn("Hero_Sniper.ShrapnelShoot", self:GetCaster())

	local particle_cast = "particles/units/heroes/hero_sniper/sniper_shrapnel_launch.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		self:GetCaster():GetOrigin(), -- unknown
		false -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1, point + Vector(0, 0, 2000) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end