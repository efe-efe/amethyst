item_meteor_custom = class({})
LinkLuaModifier( "modifier_item_meteor_custom_thinker", "items/item_meteor_custom/modifier_item_meteor_custom_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_meteor_custom", "items/item_meteor_custom/modifier_item_meteor_custom", LUA_MODIFIER_MOTION_NONE )

function item_meteor_custom:OnSpellStart()
	local point = CalcPoint(self:GetCaster():GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
    self.channel_particle_caster = ParticleManager:CreateParticle("particles/items4_fx/meteor_hammer_cast.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
end

function item_meteor_custom:OnStopPseudoCastPoint()
	StopSoundOn("DOTA_Item.MeteorHammer.Cast", self:GetCaster())
    ParticleManager:DestroyParticle(self.channel_particle_caster, true)
	ParticleManager:ReleaseParticleIndex(self.channel_particle_caster)
end

function item_meteor_custom:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = CalcPoint(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local delay_time = self:GetSpecialValueFor( "delay_time" )
	local radius = self:GetSpecialValueFor("radius")

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_item_meteor_custom_thinker",
			show_all = 1,
			radius = radius,
			delay_time = delay_time,
			--thinker_duration = duration + delay_time ,
			--draw_clock = 1
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
	
	EmitSoundOn( "DOTA_Item.MeteorHammer.Cast", self:GetCaster() )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	item_meteor_custom,
	{ activity = ACT_DOTA_GENERIC_CHANNEL_1, rate = 1.0 },
	{ movement_speed = 10 }
)