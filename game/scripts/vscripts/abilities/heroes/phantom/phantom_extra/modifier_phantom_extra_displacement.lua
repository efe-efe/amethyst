modifier_phantom_extra_displacement = class({})

function modifier_phantom_extra_displacement:OnCreated(params)
	if IsServer() then
		self.parent = self:GetParent()
		self.origin = self.parent:GetAbsOrigin()
		self.ability = self:GetAbility()
		self.radius = self.ability:GetSpecialValueFor('radius')
		self.fading_slow_duration = self.ability:GetSpecialValueFor("fading_slow_duration")
		self.fading_slow_pct = self.ability:GetSpecialValueFor("fading_slow_pct")
	
		self.damage_table = {
			attacker = self.parent,
			damage = self.ability:GetSpecialValueFor("ability_damage"),
			damage_type = DAMAGE_TYPE_PHYSICAL,
		}

		self.recast = false
	end
end

function modifier_phantom_extra_displacement:OnCollide(params)
	if IsServer() then
		if params.type == UNIT_COLLISION then
			for _,unit in pairs(params.units) do
				self:OnImpact(unit)
			end
		end
	end
end

function modifier_phantom_extra_displacement:OnDestroy()
	if IsServer() then
		local enemies = CustomEntities:FindUnitsInRadius(
			self.parent,
			self.parent:GetAbsOrigin(), 
			self.radius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER
		)

		for _,enemy in pairs(enemies) do
			self:OnImpact(enemy)
		end

		if self.ability:GetLevel() >= 2 then
			if self.recast then
				--To prevent recasting from a recast!
				if self.parent:HasModifier('modifier_phantom_extra_slashes') then
					self.parent:RemoveModifierByName('modifier_phantom_extra_slashes')
				else
					local modifier = self.parent:AddNewModifier(self.parent, self.ability, "modifier_phantom_extra_slashes", { duration = 3.0 })
					self.parent:AddNewModifier(self.parent, self.ability, "modifier_phantom_extra_recast", { duration = 3.0 })
				end
			end
		end
		
		local trail_pfx = ParticleManager:CreateParticle("particles/phantom/mobility_trail.vpcf", PATTACH_ABSORIGIN, self.parent)
		ParticleManager:SetParticleControl(trail_pfx, 0, self.origin)
		ParticleManager:SetParticleControl(trail_pfx, 1, self.parent:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(trail_pfx)
	end
end

function modifier_phantom_extra_displacement:OnImpact(hTarget)
	hTarget:AddNewModifier(self.parent, self.ability, "modifier_phantom_extra", { duration = 0.1 })

	CustomEntities:SingleAttack(self.parent, {
		hTarget = hTarget,
		Callback = function(hTarget)
			if not hTarget:HasModifier('modifier_phantom_extra') then
				if not CustomEntities:IsCountering(hTarget) and not self.recast then
					hTarget:AddNewModifier(self.parent, self.ability, "modifier_generic_fading_slow", { 
						duration = self.fading_slow_duration, 
						max_slow_pct = self.fading_slow_pct 
					})
					self.recast = true
				end
				
				self.damage_table.victim = hTarget
				ApplyDamage(self.damage_table)
					
				self:PlayEffectsOnImpact(hTarget)
			end
		end
	})
end

function modifier_phantom_extra_displacement:PlayEffectsOnImpact(hTarget)
	EFX('particles/phantom/phantom_basic_attack.vpcf', PATTACH_ABSORIGIN, hTarget, {
		release = true
	})
	EmitSoundOn("Hero_PhantomAssassin.Attack", hTarget)
end

function modifier_phantom_extra_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_phantom_extra_displacement:GetOverrideAnimation() 		return ACT_DOTA_CAST_ABILITY_2 end
function modifier_phantom_extra_displacement:GetOverrideAnimationRate() 	return 1.5 end

function modifier_phantom_extra_displacement:GetCollisionTeamFilter()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_phantom_extra_displacement)
Modifiers.Animation(modifier_phantom_extra_displacement)