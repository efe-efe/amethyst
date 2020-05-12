nevermore_ex_mobility = class({})
LinkLuaModifier( "modifier_nevermore_ex_mobility_thinker", "abilities/heroes/nevermore/nevermore_ex_mobility/modifier_nevermore_ex_mobility_thinker", LUA_MODIFIER_MOTION_NONE )

function nevermore_ex_mobility:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = CalcPoint(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local delay_time = self:GetSpecialValueFor( "delay_time" )
	local radius = self:GetSpecialValueFor("radius")

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_nevermore_ex_mobility_thinker",
			show_all = 1,
			radius = radius,
			delay_time = delay_time,
			--thinker_duration = duration + delay_time ,
			draw_clock = 1
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
    )
    
	caster:AddNewModifier(caster, nil, "modifier_banish", {})
	
	self:PlayEffects()
end

function nevermore_ex_mobility:PlayEffects()
	EmitSoundOn( "DOTA_Item.SoulRing.Activate", self:GetCaster() )
	local particle_cast = "particles/blink_purple.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	
	particle_cast = "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
	effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )	
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 60, Vector(157, 0, 243) )
	ParticleManager:SetParticleControl( effect_cast, 61, Vector(1, 0, 0) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	nevermore_ex_mobility,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 1.0 },
	{ movement_speed = 10 }
)