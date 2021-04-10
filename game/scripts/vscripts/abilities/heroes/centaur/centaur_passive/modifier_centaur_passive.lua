modifier_centaur_passive = class({})

function modifier_centaur_passive:OnTrigger(params)
	if IsServer() then
		self:PlayEffectsOnTrigger()
	end
end

function modifier_centaur_passive:OnHit(params)
	if IsServer() then
		if not params.bTriggerCounters then
			return true
		end

		self:OnTrigger({})

		if params.iType == PROJECTILE_HIT then
			local projectile = params.hProjectile

			if projectile.bIsReflectable == true then
				projectile:SetVelocity(projectile:GetVelocity() * -1.2, projectile:GetPosition())
				projectile:SetSource(self:GetParent())
				projectile:SetVisionTeam(self:GetParent():GetTeam())
				projectile:ResetDistanceTraveled()
				projectile:ResetRehit()
			else
				if projectile.bIsDestructible then
					projectile:ScheduleDestroy()
				end
			end
		end
		
		return false
	end
end

function modifier_centaur_passive:GetMovementSpeedPercentage() return 100 end

function modifier_centaur_passive:PlayEffectsOnTrigger()
    EmitSoundOn("juggernaut_jug_ability_bladefury_05" , self:GetParent())

    local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger_sphere.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.OnHit(modifier_centaur_passive)