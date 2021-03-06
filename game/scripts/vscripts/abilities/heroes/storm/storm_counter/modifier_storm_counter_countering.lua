modifier_storm_counter_countering = class({})

function modifier_storm_counter_countering:OnCreated(params)
	if IsServer() then
		self.mana_gain = self:GetAbility():GetSpecialValueFor('mana_gain')
		self.radius = self:GetAbility():GetSpecialValueFor('radius')
		self.knockback_distance = self:GetAbility():GetSpecialValueFor('knockback_distance')
		self.damage_table = {
			attacker = self:GetParent(),
			damage = self:GetAbility():GetSpecialValueFor("ability_damage"),
			damage_type = DAMAGE_TYPE_PURE,
		}
	end
end

function modifier_storm_counter_countering:OnDestroy()
	if IsServer() then
		EmitSoundOn("Hero_Juggernaut.Attack", self:GetParent())
		local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bonus.vpcf"
		local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
		ParticleManager:ReleaseParticleIndex(effect_cast)
	end
end

function modifier_storm_counter_countering:OnTrigger(params)
	if IsServer() then
		CustomEntitiesLegacy:GiveManaAndEnergy(self:GetParent(), self.mana_gain, true)
		
		local enemies = CustomEntitiesLegacy:FindUnitsInRadius(
			self:GetParent(),
			self:GetParent():GetAbsOrigin(), 
			self.radius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER
		)
	
		for _,enemy in pairs(enemies) do
			self.damage_table.victim = enemy
			ApplyDamage(self.damage_table)

			local direction = (enemy:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Normalized()

			enemy:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_storm_counter_displacement", { 
				x = direction.x,
				y = direction.y,
				r = self.knockback_distance,
				speed = (self.knockback_distance)/0.25,
				peak = 50,
			})
		end

		CustomEntitiesLegacy:StrongPurge(self:GetParent())
		self:PlayEffectsOnTrigger()
		
		CreateRadiusMarker(self:GetParent(), self:GetParent():GetAbsOrigin(), self.radius, RADIUS_SCOPE_PUBLIC, 0.1)
		ScreenShake(self:GetParent():GetAbsOrigin(), 100, 300, 0.45, 1000, 0, true)

		self:Destroy()
	end
end

function modifier_storm_counter_countering:OnHit(params)
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

function modifier_storm_counter_countering:GetMovementSpeedPercentage() return 0 end

function modifier_storm_counter_countering:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_storm_counter_countering:GetOverrideAnimation() 		return ACT_DOTA_CAST_ABILITY_1 end
function modifier_storm_counter_countering:GetOverrideAnimationRate() 	return 0.5 end

function modifier_storm_counter_countering:PlayEffectsOnTrigger()
    EmitSoundOn("stormspirit_ss_laugh_04" , self:GetParent())

	EFX("particles/units/heroes/hero_void_spirit/voidspirit_overload_discharge.vpcf", PATTACH_WORLDORIGIN, self:GetParent(), {
		cp0 = self:GetParent():GetAbsOrigin(),
		release = true,
	})
	
	local efx = EFX("particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_chakra_magic.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), {
		cp1 = self:GetParent():GetAbsOrigin(),
	})

	ParticleManager:SetParticleControlEnt(
        efx, 
        1, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        self:GetParent():GetAbsOrigin(), 
		true
	)
	ParticleManager:ReleaseParticleIndex(efx)
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Counter(modifier_storm_counter_countering)
Modifiers.OnHit(modifier_storm_counter_countering)