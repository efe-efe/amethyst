modifier_juggernaut_counter_countering = class({})

function modifier_juggernaut_counter_countering:OnDestroy()
	if IsServer() then
		EmitSoundOn("Hero_Juggernaut.Attack", self:GetCaster())
		local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bonus.vpcf"
		local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
		ParticleManager:ReleaseParticleIndex(effect_cast)
	end
end

function modifier_juggernaut_counter_countering:OnTrigger(params)
	if IsServer() then
		self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_juggernaut_counter_recast",
			{ duration = 5.0 }
		)
		
		CustomEntities:StrongPurge(self:GetParent())
		self:PlayEffectsOnTrigger()
		self:Destroy()
	end
end

function modifier_juggernaut_counter_countering:OnProjectileHitCustom(params)
	if IsServer() then
		local projectile = params.projectile

		self:OnTrigger({})
		
		if projectile.bIsReflectable == true then
			projectile:SetVelocity(projectile:GetVelocity() * -1, projectile:GetPosition())
			projectile:SetSource(self:GetParent())
			projectile:SetVisionTeam(self:GetParent():GetTeam())
			projectile:ResetDistanceTraveled()
			projectile:ResetRehit()
			
			return false
		end

		return true
	end
end

function modifier_juggernaut_counter_countering:GetMovementSpeedPercentage() return 0 end

function modifier_juggernaut_counter_countering:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_juggernaut_counter_countering:GetOverrideAnimation() 		return ACT_DOTA_SPAWN end
function modifier_juggernaut_counter_countering:GetOverrideAnimationRate() 	return 0.1 end

function modifier_juggernaut_counter_countering:PlayEffectsOnTrigger()
    EmitSoundOn("juggernaut_jug_ability_bladefury_05" , self:GetParent())

    local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger_sphere.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Counter(modifier_juggernaut_counter_countering)
Modifiers.OnProjectileHit(modifier_juggernaut_counter_countering)