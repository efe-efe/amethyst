modifier_terrorblade_extra_recast = class({})
LinkLuaModifier( "modifier_terrorblade_extra", "abilities/heroes/terrorblade/terrorblade_extra/modifier_terrorblade_extra", LUA_MODIFIER_MOTION_NONE )

function modifier_terrorblade_extra_recast:OnCreated()
	if IsServer() then
		self.stun_duration = 0
		self.radius = 0
		self.damage = 0
		self:StartIntervalThink(0.1)
		self:PlayEffects()
	end
end

function modifier_terrorblade_extra_recast:OnIntervalThink()
	local remaining_time = self:GetRemainingTime() > 0 and self:GetRemainingTime() or 0
	self.stun_duration = 2.0 - remaining_time
	self.radius = 350 - remaining_time * 100
	self.damage = 35 - remaining_time * 10

	self:PlayEffectsAoe(self.radius)
end

function modifier_terrorblade_extra_recast:OnDestroy()
	if IsServer() then
		local iframe_duration = self:GetAbility():GetSpecialValueFor("iframe_duration")

		self:GetCaster():AddNewModifier(
			self:GetCaster(), 
			self:GetAbility(), 
			"modifier_terrorblade_extra", 
			{ 
				duration = iframe_duration, 
				stun_duration = self.stun_duration, 
				radius = self.radius,
				damage = self.damage
			}
		)
		self:StopEffects()
	end
end

function modifier_terrorblade_extra_recast:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_slark/slark_shadow_dance.vpcf"
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( 
		self.effect_cast, 
		1, 
		self:GetParent(), 
		PATTACH_POINT_FOLLOW, 
		"attach_hitloc", 
		self:GetParent():GetOrigin(), 
		true 
	);
end

function modifier_terrorblade_extra_recast:PlayEffectsAoe( radius )
    local particle_cast = "particles/aoe_marker.vpcf"

    local effect_cast = ParticleManager:CreateParticleForPlayer( particle_cast, PATTACH_WORLDORIGIN, nil, self:GetParent():GetPlayerOwner() )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin())
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 2, Vector( 255, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 3, Vector(0.1, 0, 0) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_terrorblade_extra_recast:StopEffects()
    ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast)
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast( 
	modifier_terrorblade_extra_recast,
	{ ability_name = "terrorblade_extra_recast", key = "R" }
)
