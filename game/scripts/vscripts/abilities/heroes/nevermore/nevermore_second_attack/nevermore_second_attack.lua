nevermore_second_attack = class({})
LinkLuaModifier("modifier_nevermore_souls", "abilities/heroes/nevermore/nevermore_shared_modifiers/modifier_nevermore_souls", LUA_MODIFIER_MOTION_NONE)

function nevermore_second_attack:GetCastAnimationCustom()	return ACT_DOTA_ATTACK end
function nevermore_second_attack:GetPlaybackRateOverride() 	return 1.3 end
function nevermore_second_attack:GetCastPointSpeed() 		return 10 end

function nevermore_second_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	local damage = self:GetSpecialValueFor("ability_damage")
	local fading_slow_pct = self:GetSpecialValueFor("fading_slow_pct")
	local fading_slow_duration = self:GetSpecialValueFor("fading_slow_duration")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local cd_reduction_per_soul = self:GetSpecialValueFor("cd_reduction_per_soul")
	
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local modifier = self:GetCaster():FindModifierByName('modifier_nevermore_souls')
	local souls = modifier:GetStackCount()
	modifier:SetStackCount(0)

	local projectile = {
		EffectName = "particles/nevermore/nevermore_second_attack_projectile.vpcf",
		vSpawnOrigin = origin + Vector(0, 0, 96),
		fDistance = self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				ability = self
			}
			ApplyDamage(damage_table)

			
			unit:AddNewModifier(_self.Source, self, "modifier_generic_fading_slow", { 
				duration = fading_slow_duration,
				max_slow_pct = fading_slow_pct 
			})

			if _self.Source == caster and not unit:IsObstacle() then
				caster:GiveManaPercent(mana_gain_pct, unit)

				local is_amethyst = false
				if unit.GetParentEntity then
					local entity = unit:GetParentEntity()
			
					if instanceof(entity, Amethyst) then 
						is_amethyst = true
					end
				end
				if not is_amethyst then
					modifier:IncrementStackCount()
					self:PlayEffectsSoul(unit)
				end
			end

			if _self.Source.OnBasicAttackImpact then
				_self.Source:OnBasicAttackImpact(unit)
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	
	local cooldown = self:GetCooldown(self:GetLevel()) - (souls * cd_reduction_per_soul)
	self:EndCooldown()
	self:StartCooldown(cooldown)

	self:PlayEffectsOnCast()
end

function nevermore_second_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_Nevermore.Attack", self:GetCaster())
    EmitSoundOn("Hero_Nevermore.Death", self:GetCaster())
end

function nevermore_second_attack:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()

	EmitSoundOnLocationWithCaster(pos, "Hero_Nevermore.ProjectileImpact", caster)

	local particle_cast = "particles/nevermore/nevermore_second_attack_impact.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 1, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function nevermore_second_attack:PlayEffectsSoul(hTarget)
	local info = {
		Target = self:GetCaster(),
		Source = hTarget,
		EffectName = "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf",
		iMoveSpeed = 400,
		vSourceLoc= hTarget:GetAbsOrigin(),                -- Optional
		bDodgeable = false,                                -- Optional
		bReplaceExisting = false,                         -- Optional
		flExpireTime = GameRules:GetGameTime() + 5,      -- Optional but recommended
		bProvidesVision = false,                           -- Optional
	}
	ProjectileManager:CreateTrackingProjectile(info)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(nevermore_second_attack)