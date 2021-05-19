modifier_pango_counter_countering = class({})

function modifier_pango_counter_countering:OnDestroy()
	if IsServer() then
		local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bonus.vpcf"
		local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
		ParticleManager:ReleaseParticleIndex(effect_cast)
	end
end

function modifier_pango_counter_countering:OnTrigger(params)
	if IsServer() then
		local pango_special_attack = self:GetParent():FindAbilityByName("pango_special_attack")
		pango_special_attack:EndCooldown()
		pango_special_attack:Crash(450)
        self:GetParent():AddNewModifier(self:GetParent(), self:GetParent():FindAbilityByName("pango_mobility"), "modifier_pango_mobility", { duration = 1.5 })
		self:Destroy()
	end
end

function modifier_pango_counter_countering:OnProjectileHitCustom(params)
	if IsServer() then
		self:OnTrigger({})
		if params.projectile.bIsDestructible then
			params.projectile:Destroy(true)
		end
	end
end

function modifier_pango_counter_countering:GetMovementSpeedPercentage() return 0 end

function modifier_pango_counter_countering:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_pango_counter_countering:GetOverrideAnimation() 		return ACT_DOTA_CAST_ABILITY_3 end
function modifier_pango_counter_countering:GetOverrideAnimationRate() 	return 0.4 end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Counter(modifier_pango_counter_countering)
Modifiers.OnProjectileHit(modifier_pango_counter_countering)