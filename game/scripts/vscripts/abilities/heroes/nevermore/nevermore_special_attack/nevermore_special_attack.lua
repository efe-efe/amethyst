nevermore_special_attack = class({})
LinkLuaModifier( "modifier_nevermore_special_attack_thinker", "abilities/heroes/nevermore/nevermore_special_attack/modifier_nevermore_special_attack_thinker", LUA_MODIFIER_MOTION_NONE )

function nevermore_special_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = CalcRange(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local delay_time = self:GetSpecialValueFor( "delay_time" )
	local radius = self:GetSpecialValueFor("radius")

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_nevermore_special_attack_thinker",
			show_all = 1,
			radius = radius,
			delay_time = delay_time,
			draw_clock = 1
			--thinker_duration = duration + delay_time ,
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
end

function nevermore_special_attack:PlayEffectsTornado( hTarget )
	local particle_cast = "particles/mod_units/heroes/hero_nevermore/invoker_tornado_ti6_funnel.vpcf"
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( self.effect_cast, 0, hTarget:GetOrigin() )
	ParticleManager:SetParticleControl( self.effect_cast, 3, hTarget:GetOrigin() )
end

function nevermore_special_attack:OnDisplacementEnd()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )    
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	nevermore_special_attack,
	{ activity = ACT_DOTA_RAZE_2, rate = 1.5 },
	{ movement_speed = 10 }
)