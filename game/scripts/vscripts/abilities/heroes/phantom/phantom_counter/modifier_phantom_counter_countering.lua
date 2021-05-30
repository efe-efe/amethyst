modifier_phantom_counter_countering = class({})

function modifier_phantom_counter_countering:OnCreated(params)
    self.banish_duration = self:GetAbility():GetSpecialValueFor("banish_duration")
end

function modifier_phantom_counter_countering:OnDestroy()
	if IsServer() then
		local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bonus.vpcf"
		local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
		ParticleManager:ReleaseParticleIndex(effect_cast)
	end
end

function modifier_phantom_counter_countering:OnTrigger(params)
    if IsServer() then
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_phantom_counter_banish", { duration = self.banish_duration })
		self:Destroy()
	end
end

function modifier_phantom_counter_countering:OnHit(params)
	if IsServer() then
		if not params.bTriggerCounters then
			return true
		end
		
		self:OnTrigger({})

		if params.iType == PROJECTILE_HIT then
			local projectile = params.hProjectile
			if projectile.bIsDestructible then
				projectile:ScheduleDestroy()
			end

		end

		return false
	end
end

function modifier_phantom_counter_countering:DeactivateAbilities()
	if IsServer() then
		if self:GetParent():HasModifier('modifier_upgrade_phantom_act_while_countering') then
			return false
		end
		return true
	end
end

function modifier_phantom_counter_countering:OnOrder(params)
	if IsServer() then
		if self:GetParent():HasModifier('modifier_upgrade_phantom_act_while_countering') then
			return
		end

		if params.unit == self:GetParent() then
			if  params.order_type == DOTA_UNIT_ORDER_STOP or 
				params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION or 
				params.order_type == DOTA_UNIT_ORDER_CAST_POSITION or
				params.order_type == DOTA_UNIT_ORDER_CAST_NO_TARGET
			then
				self:Destroy()
			end
		end
	end
end

function modifier_phantom_counter_countering:GetMovementSpeedPercentage()
	if IsServer() then
		if self:GetParent():HasModifier('modifier_upgrade_phantom_act_while_countering') then
			return 100
		end

		return 0
	end
end

function modifier_phantom_counter_countering:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
		MODIFIER_EVENT_ON_ORDER,
	}
end

function modifier_phantom_counter_countering:GetOverrideAnimation() 		return ACT_DOTA_CAST_ABILITY_3 end
function modifier_phantom_counter_countering:GetOverrideAnimationRate() 	return 0.4 end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Counter(modifier_phantom_counter_countering)
Modifiers.OnHit(modifier_phantom_counter_countering)