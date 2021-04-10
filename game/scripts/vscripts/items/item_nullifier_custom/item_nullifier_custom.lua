item_nullifier_custom = class({})
LinkLuaModifier("modifier_item_nullifier_custom", "items/item_nullifier_custom/modifier_item_nullifier_custom", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_item_nullifier_custom_slow", "items/item_nullifier_custom/modifier_item_nullifier_custom_slow", LUA_MODIFIER_MOTION_HORIZONTAL)

function item_nullifier_custom:OnAbilityPhaseStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_casting", { 
		duration = self:GetCastPoint(), 
		movement_speed = 10,
	})
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.0)
    return true
end

function item_nullifier_custom:OnAbilityPhaseInterrupted()
	self:GetCaster():FadeGesture(ACT_DOTA_ATTACK)
	self:GetCaster():RemoveModifierByName("modifier_casting")
end

function item_nullifier_custom:OnSpellStart()
	self:GetCaster():FadeGesture(ACT_DOTA_ATTACK)
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
	local point = CustomAbilities:GetCursorPosition(self)

	local initial_duration = self:GetSpecialValueFor("initial_duration")
	local duration = self:GetSpecialValueFor("duration")
	local ability_damage = self:GetSpecialValueFor("ability_damage")

	-- Dynamic data
	local projectile_direction = Direction2D(origin, point)
    local projectile_speed = self:GetSpecialValueFor("projectile_speed")
    
    local projectile = {
		EffectName = 			"particles/nullifier/nullifier_proj.vpcf",
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
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntities:Allies(_self.Source, unit) end,
		OnUnitHit = function(_self, unit)
			unit:AddNewModifier(_self.Source, self, "modifier_item_nullifier_custom", { duration = duration })
			unit:AddNewModifier(_self.Source, self, "modifier_item_nullifier_custom_slow", { duration = initial_duration })

			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = ability_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}
			ApplyDamage(damage_table)
			unit:Purge(true, false, false, false, false)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	-- Cast projectile
    ProjectilesManagerInstance:CreateProjectile(projectile)
    self:PlayEffectsOnCast()
end

function item_nullifier_custom:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()
	EmitSoundOnLocationWithCaster(pos, "DOTA_Item.Nullifier.Target", caster)

	-- Create Particles
	local particle_cast = "particles/items4_fx/nullifier_proj_impact.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function item_nullifier_custom:PlayEffectsOnCast()
	EmitSoundOn("DOTA_Item.Nullifier.Cast", self:GetCaster())
end
