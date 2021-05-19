item_atos_custom = class({})

function item_atos_custom:OnAbilityPhaseStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_casting", { 
		duration = self:GetCastPoint(), 
		movement_speed = 10,
	})
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.0)
    return true
end

function item_atos_custom:OnAbilityPhaseInterrupted()
	self:GetCaster():FadeGesture(ACT_DOTA_ATTACK)
	self:GetCaster():RemoveModifierByName("modifier_casting")
end

function item_atos_custom:OnSpellStart()
	self:GetCaster():FadeGesture(ACT_DOTA_ATTACK)
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
	local point = CustomAbilitiesLegacy:GetCursorPosition(self)

	local duration = self:GetSpecialValueFor("duration")

	local projectile_direction = Direction2D(origin, point)
    local projectile_speed = self:GetSpecialValueFor("projectile_speed")
    
    local projectile = {
		EffectName = 			"particles/rod_of_atos/rod_of_atos_attack.vpcf",
		vSpawnOrigin = 			caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance = 			self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius =			self:GetSpecialValueFor("hitbox"),
		Source = 				caster,
		vVelocity = 			projectile_direction * projectile_speed,
		UnitBehavior = 			PROJECTILES_DESTROY,
		WallBehavior = 			PROJECTILES_DESTROY,
		TreeBehavior = 			PROJECTILES_NOTHING,
		GroundBehavior = 		PROJECTILES_NOTHING,
		fGroundOffset = 		0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) end,
		OnUnitHit = function(_self, unit)
            unit:AddNewModifier(_self.Source, self, "modifier_generic_root", { duration = duration })
            self:PlayEffectsOnImpact(unit)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

    ProjectilesManagerInstance:CreateProjectile(projectile)
    self:PlayEffectsOnCast()
end

function item_atos_custom:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()
	EmitSoundOnLocationWithCaster(pos, "DOTA_Item.RodOfAtos.Cast", caster)

	local particle_cast = "particles/items2_fx/rod_of_atos_attack_impact.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function item_atos_custom:PlayEffectsOnImpact(target)
	local particle_cast = "particles/items2_fx/rod_of_atos_impact.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, target)
	ParticleManager:SetParticleControl(effect_cast, 1, target:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function item_atos_custom:PlayEffectsOnCast()
	EmitSoundOn("DOTA_Item.RodOfAtos.Target", self:GetCaster())
end