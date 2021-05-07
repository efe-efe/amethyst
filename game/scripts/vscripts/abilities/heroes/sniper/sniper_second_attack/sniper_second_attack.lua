sniper_second_attack = class({})
sniper_ex_second_attack = class({})

function sniper_second_attack:GetCastAnimationCustom() 
	if self:GetLevel() >= 2 then
		return ACT_DOTA_DIE
	end
	return ACT_DOTA_CAST_ABILITY_1 
end

function sniper_second_attack:GetAnimationTranslate() 	
	if self:GetLevel() >= 2 then
		return "overkilled"
	end	
	return
end

function sniper_second_attack:GetPlaybackRateOverride() 	
	if self:GetLevel() >= 2 then
		return 0.8
	end	
	return 0.5
end

function sniper_second_attack:GetCastPointSpeed()
	if self:GetLevel() >= 2 then
		return 60
	end
	return 0 
end

function sniper_second_attack:OnAbilityPhaseStart()
	EmitGlobalSound("Ability.AssassinateLoad")
	
	self.efx = ParticleManager:CreateParticle('particles/econ/items/wisp/wisp_relocate_channel_ti7.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(self.efx, 1, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, 'attach_hitloc', self:GetCaster():GetAbsOrigin(), false)

	return true
end

function sniper_second_attack:OnAbilityPhaseInterrupted()
	DEFX(self.efx, true)
end

function sniper_second_attack:OnSpellStart()
	if self.efx then
		DEFX(self.efx, false)
	end 
    local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = CustomAbilities:GetCursorPosition(self)
	local damage = self:GetSpecialValueFor("ability_damage")

	local projectile_direction = Direction2D(origin, point)
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local stun_duration = self:GetSpecialValueFor("stun_duration")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local reduction_per_hit = self:GetSpecialValueFor("reduction_per_hit")/100
	local min_damage = self:GetSpecialValueFor("min_damage")
	
	local damage_table = {
		damage_type = DAMAGE_TYPE_MAGICAL,
	}

	CustomEntitiesLegacy:ProjectileAttack(caster, {
		tProjectile = {
			EffectName = "particles/sniper/sniper_second_attack.vpcf",
			vSpawnOrigin = origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96),
			fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
			fStartRadius = self:GetSpecialValueFor("hitbox"),
			Source = caster,
			vVelocity = projectile_direction * projectile_speed,
			UnitBehavior = PROJECTILES_NOTHING,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_DESTROY,
			GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) end,
			OnUnitHit = function(_self, unit)
				-- Count targets
				local counter = -1
				for k, v in pairs(_self.tHitLog) do
					counter = counter + 1
				end
				
				local final_damage = damage * (1 - (counter * reduction_per_hit))
				
				if final_damage < min_damage then 
					final_damage = min_damage 
				end

				damage_table.victim = unit
				damage_table.attacker = _self.Source
				damage_table.damage = final_damage
		
				
				if counter < 1 and _self.Source == caster then
					if CustomEntitiesLegacy:ProvidesMana(unit) then
						CustomEntitiesLegacy:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
					end
				end
		
				ApplyDamage(damage_table)

				unit:AddNewModifier(_self.Source, self , "modifier_generic_stunned", { duration = stun_duration})
				self:PlayEffectsOnHit(unit)
			end,
			OnFinish = function(_self, pos)
				self:PlayEffectsOnFinish(pos, 'particles/units/heroes/hero_sniper/sniper_assassinate_impact_sparks.vpcf')
			end,
		}
	})

	if self:GetLevel() >= 2 then
		EFX('particles/econ/items/phantom_lancer/phantom_lancer_fall20_immortal/phantom_lancer_fall20_immortal_doppelganger_aoe_gold_bits.vpcf', PATTACH_ABSORIGIN_FOLLOW, caster, {
			cp1 = origin,
			release = true
		})
	else 
		EFX('particles/sniper/sniper_second_attack_endcap_model.vpcf', PATTACH_ABSORIGIN_FOLLOW, caster, {
			cp1 = origin + projectile_direction * 100,
			cp1f = caster:GetForwardVector(),
			release = true
		})
	end

	self:PlayEffectsOnCast()
	caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 3.0)
	LinkAbilityCooldowns(caster, 'sniper_ex_second_attack')
end

function sniper_second_attack:PlayEffectsOnCast()
	EmitSoundOn("Ability.Assassinate", self:GetCaster())
end

function sniper_second_attack:PlayEffectsOnFinish(pos, particle_cast)
	local caster = self:GetCaster()
	EmitSoundOnLocationWithCaster(pos, "Hero_Sniper.AssassinateDamage", caster)

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 1, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	
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

function sniper_ex_second_attack:GetCastAnimationCustom()
	return ACT_DOTA_CAST_ABILITY_1
end

function sniper_ex_second_attack:GetPlaybackRateOverride()
	return 0.5
end

function sniper_ex_second_attack:GetCastPointSpeed()
	return 0
end

sniper_ex_second_attack.PlayEffectsOnCast = sniper_second_attack.PlayEffectsOnCast
sniper_ex_second_attack.PlayEffectsOnFinish = sniper_second_attack.PlayEffectsOnFinish
sniper_ex_second_attack.PlayEffectsOnHit = sniper_second_attack.PlayEffectsOnHit

function sniper_ex_second_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = CustomAbilities:GetCursorPosition(self)
	local projectile_direction = Direction2D(origin, point)
	local projectile_origin = origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96),
	self:ThrowProjectile(origin + Vector(0, 0, 96), projectile_direction, true, caster)

	self:PlayEffectsOnCast()
	caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.5)
	LinkAbilityCooldowns(caster, 'sniper_second_attack')
end

function sniper_ex_second_attack:ThrowProjectile(vOrigin, vDirection, bFirstTime, hSource)
	local damage = self:GetSpecialValueFor("ability_damage")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local root_duration = self:GetSpecialValueFor("root_duration")
	local reduction_per_hit = self:GetSpecialValueFor("reduction_per_hit")/100
	local min_damage = self:GetSpecialValueFor("min_damage")

	local damage_table = {
		damage_type = DAMAGE_TYPE_MAGICAL,
	}			
	
	CustomEntitiesLegacy:ProjectileAttack(caster, {
		tProjectile = {
			EffectName = "particles/sniper/sniper_ex_second_attack_new.vpcf",
			vSpawnOrigin = vOrigin,
			fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
			fStartRadius = self:GetSpecialValueFor("hitbox"),
			Source = hSource,
			vVelocity = vDirection * projectile_speed,
			UnitBehavior = PROJECTILES_NOTHING,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_DESTROY,
			GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) end,
			OnUnitHit = function(_self, unit)
				-- Count targets
				local counter = -1
				for k, v in pairs(_self.tHitLog) do
					counter = counter + 1
				end
				
				local final_damage = damage * (1 - (counter * reduction_per_hit))
				
				if final_damage < min_damage then 
					final_damage = min_damage 
				end

				damage_table.victim = unit
				damage_table.attacker = _self.Source
				damage_table.damage = final_damage

				ApplyDamage(damage_table)

				unit:AddNewModifier(_self.Source, self , "modifier_generic_root", { duration = root_duration})
				self:PlayEffectsOnHit(unit)
			end,
			OnFinish = function(_self, pos)
				if self:GetLevel() >= 2 and bFirstTime then
					local new_direction = ((_self.Source:GetAbsOrigin() + Vector(0, 0, 96)) - pos):Normalized()
					local projectile_origin = pos + Vector(new_direction.x * 45, new_direction.y * 45, 0)
					self:ThrowProjectile(projectile_origin, new_direction, false, _self.Source)
				end
				self:PlayEffectsOnFinish(pos, 'particles/econ/items/sniper/sniper_fall20_immortal/sniper_fall20_immortal_base_attack_impact.vpcf')
			end,
		}
	})
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(sniper_second_attack)
Abilities.Castpoint(sniper_ex_second_attack)