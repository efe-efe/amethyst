modifier_terrorblade_extra_recast = class({})

function modifier_terrorblade_extra_recast:OnCreated()
	if IsServer() then
		self:PlayEffects()
	end
end


function modifier_terrorblade_extra_recast:OnDestroy()
	if IsServer() then
		if self:GetRemainingTime() < 0.05 then 
			local ability = self:GetCaster():FindAbilityByName("terrorblade_extra_recast")
			self:GetParent():CastAbilityImmediately(ability, self:GetParent():GetEntityIndex())
		end
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

function modifier_terrorblade_extra_recast:StopEffects()
    ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast)
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast( 
	modifier_terrorblade_extra_recast,
	{ ability_name = "terrorblade_extra_recast", key = "R" }
)
