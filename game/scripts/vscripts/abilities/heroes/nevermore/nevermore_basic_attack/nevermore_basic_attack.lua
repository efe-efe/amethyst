nevermore_basic_attack = class({})
LinkLuaModifier("modifier_nevermore_souls", "abilities/heroes/nevermore/nevermore_shared_modifiers/modifier_nevermore_souls", LUA_MODIFIER_MOTION_NONE)

function nevermore_basic_attack:GetCastPoint()
	if IsServer() then
		return self.BaseClass.GetCastPoint(self) + self:GetCaster():GetAttackAnimationPoint()
	end
end

function nevermore_basic_attack:GetCooldown(iLevel)
	if IsServer() then
        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = (1 / attacks_per_second)
		
		return self.BaseClass.GetCooldown(self, self:GetLevel()) + attack_speed
	end
end

function nevermore_basic_attack:GetCastAnimationCustom()	return ACT_DOTA_ATTACK end
function nevermore_basic_attack:GetPlaybackRateOverride() 	return 1.5 end
function nevermore_basic_attack:GetCastPointSpeed() 		return 10 end

function nevermore_basic_attack:GetIntrinsicModifierName()
	return 'modifier_nevermore_souls'
end

function nevermore_basic_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = CustomAbilitiesLegacy:GetCursorPosition(self)
	local origin = caster:GetOrigin()

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = Direction2D(origin, point)

    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	local damage = caster:GetAverageTrueAttackDamage(caster)

	local projectile = {
		EffectName = "particles/nevermore/nevermore_basic_attack.vpcf",
		vSpawnOrigin = origin + Vector(0, 0, 96),
		fDistance = self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				ability = self
			}
			ApplyDamage(damage_table)

			if _self.Source == caster and not CustomEntitiesLegacy:IsObstacle(unit) then
				if CustomEntitiesLegacy:ProvidesMana(unit) then
					CustomEntitiesLegacy:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
				end

				if not CustomEntitiesLegacy:IsGem(unit) then
					caster:FindModifierByName('modifier_nevermore_souls'):IncrementStackCount()
					self:PlayEffectsSoul(unit)
				end
			end

			CustomEntitiesLegacy:OnBasicAttackImpact(_self.Source, unit)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	ProjectilesManagerInstance:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

function nevermore_basic_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_Nevermore.Attack", self:GetCaster())
end

function nevermore_basic_attack:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()

	EmitSoundOnLocationWithCaster(pos, "Hero_Nevermore.ProjectileImpact", caster)

	local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_base_attack_impact.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 1, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function nevermore_basic_attack:PlayEffectsSoul(hTarget)
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
Abilities.Castpoint(nevermore_basic_attack)