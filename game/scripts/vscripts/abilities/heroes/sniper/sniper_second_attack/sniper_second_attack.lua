sniper_second_attack = class({})
sniper_ex_second_attack = class({})

function sniper_second_attack:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function sniper_second_attack:GetPlaybackRateOverride() 	return 1.1 end
function sniper_second_attack:GetCastPointSpeed() 			return 0 end

function sniper_second_attack:OnAbilityPhaseStart()
    EmitGlobalSound("Ability.AssassinateLoad")
	return true
end

function sniper_second_attack:OnSpellStart()
    local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local damage = self:GetSpecialValueFor("ability_damage")

	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local stun_duration = self:GetSpecialValueFor("stun_duration")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local reduction_per_hit = self:GetSpecialValueFor("reduction_per_hit")/100
	local min_damage = self:GetSpecialValueFor("min_damage")

	local projectile = {
		EffectName = "particles/sniper/sniper_second_attack.vpcf",
		vSpawnOrigin = origin + Vector(0, 0, 96),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit)
			-- Count targets
			local counter = -1
			for k, v in pairs(_self.rehit) do
				counter = counter + 1
			end
			
			local final_damage = damage * (1 - (counter * reduction_per_hit))
			
			if final_damage < min_damage then 
				final_damage = min_damage 
			end

			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = final_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}			
			
			if counter < 1 then
				_self.Source:GiveManaPercent(mana_gain_pct, unit)
			end
	
			ApplyDamage(damage_table)

			unit:AddNewModifier(_self.Source, self , "modifier_generic_stunned", { duration = stun_duration})
			self:PlayEffectsOnHit(unit)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

    Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
	caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.5)
end

function sniper_second_attack:PlayEffectsOnCast()
	EmitSoundOn("Ability.Assassinate", self:GetCaster())
end

function sniper_second_attack:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()
	EmitSoundOnLocationWithCaster(pos, "Hero_Sniper.AssassinateDamage", caster)

	local particle_cast = "particles/units/heroes/hero_sniper/sniper_assassinate_impact_sparks.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 1, pos)
	
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function sniper_second_attack:PlayEffectsOnHit(hTarget)
	local caster = self:GetCaster()
	EmitSoundOn("Hero_Sniper.AssassinateDamage", caster)

	local particle_cast = "particles/units/heroes/hero_sniper/sniper_assassinate_impact_blood.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)

	ParticleManager:SetParticleControl(effect_cast, 0, hTarget:GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, hTarget:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

sniper_ex_second_attack.GetCastAnimationCustom = sniper_second_attack.GetCastAnimationCustom
sniper_ex_second_attack.GetPlaybackRateOverride = sniper_second_attack.GetPlaybackRateOverride
sniper_ex_second_attack.GetCastPointSpeed = sniper_second_attack.GetCastPointSpeed
sniper_ex_second_attack.PlayEffectsOnCast = sniper_second_attack.PlayEffectsOnCast
sniper_ex_second_attack.PlayEffectsOnFinish = sniper_second_attack.PlayEffectsOnFinish
sniper_ex_second_attack.PlayEffectsOnHit = sniper_second_attack.PlayEffectsOnHit

function sniper_second_attack:OnAbilityPhaseStart()
    EmitGlobalSound("Ability.AssassinateLoad")
	return true
end
function sniper_ex_second_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local damage = self:GetSpecialValueFor("ability_damage")

	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local root_duration = self:GetSpecialValueFor("root_duration")
	local reduction_per_hit = self:GetSpecialValueFor("reduction_per_hit")/100
	local min_damage = self:GetSpecialValueFor("min_damage")

	local projectile = {
		EffectName = "particles/sniper/sniper_second_attack.vpcf",
		vSpawnOrigin = origin + Vector(0, 0, 96),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit)
			-- Count targets
			local counter = -1
			for k, v in pairs(_self.rehit) do
				counter = counter + 1
			end
			
			local final_damage = damage * (1 - (counter * reduction_per_hit))
			
			if final_damage < min_damage then 
				final_damage = min_damage 
			end

			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = final_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}			
			
			ApplyDamage(damage_table)

			unit:AddNewModifier(_self.Source, self , "modifier_generic_root", { duration = root_duration})
			self:PlayEffectsOnHit(unit)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

    Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
	caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.5)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(sniper_second_attack)
Abilities.Castpoint(sniper_ex_second_attack)
Abilities.Tie(sniper_second_attack, 'sniper_ex_second_attack')
Abilities.Tie(sniper_ex_second_attack, 'sniper_second_attack')