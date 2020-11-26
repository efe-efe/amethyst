puck_special_attack = class({})
puck_ex_special_attack = class({})
puck_ex_special_attack_recast = class({})

LinkLuaModifier("modifier_puck_special_attack_recast", "abilities/heroes/puck/puck_special_attack/modifier_puck_special_attack_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_ex_special_attack_recast", "abilities/heroes/puck/puck_special_attack/modifier_puck_ex_special_attack_recast", LUA_MODIFIER_MOTION_NONE)

function puck_special_attack:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function puck_special_attack:GetPlaybackRateOverride() 	    return 1.0 end
function puck_special_attack:GetCastPointSpeed() 			return 10 end

function puck_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()

	local projectile = {
		EffectName = "particles/econ/items/puck/puck_alliance_set/puck_illusory_orb_aproset.vpcf",
		vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius = self:GetSpecialValueFor("hitbox"),
        Source = caster,
		bIsReflectable = false,
		bIsDestructible = false,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_NOTHING,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}
			ApplyDamage(damage_table)

			if _self.Source == caster then
                caster:GiveManaPercent(mana_gain_pct, unit)
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos, 'particles/econ/items/puck/puck_merry_wanderer/puck_illusory_orb_explode_merry_wanderer.vpcf')
		end,
	}

    local projectile = Projectiles:CreateProjectile(projectile)
    local time = self:GetCastRange(Vector(0,0,0), nil)/projectile_speed
    caster:AddNewModifier(caster, self, "modifier_puck_special_attack_recast", { duration = time })
    caster:FindAbilityByName("puck_special_attack_recast"):SetProjectile(projectile)
	self:PlayEffectsOnCast()
end

function puck_special_attack:PlayEffectsOnFinish(pos, particle, exParticle)
	StopSoundOn("Hero_Puck.Illusory_Orb", self:GetCaster())
	
	local effect_cast = ParticleManager:CreateParticle(particle, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	if exParticle then
		effect_cast = ParticleManager:CreateParticle(exParticle, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(effect_cast, 0, pos)
		ParticleManager:SetParticleControl(effect_cast, 1, pos)
		ParticleManager:ReleaseParticleIndex(effect_cast)
	end
end

function puck_special_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_Puck.Illusory_Orb", self:GetCaster())
end





puck_ex_special_attack.GetCastAnimationCustom = puck_special_attack.GetCastAnimationCustom
puck_ex_special_attack.PlayEffectsOnCast = puck_special_attack.PlayEffectsOnCast
puck_ex_special_attack.PlayEffectsOnFinish = puck_special_attack.PlayEffectsOnFinish

function puck_ex_special_attack:GetPlaybackRateOverride() 	    return 0.5 end
function puck_ex_special_attack:GetCastPointSpeed() 			return 10 end

function puck_ex_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()

	local radius = self:GetSpecialValueFor('radius')
	local fading_slow_duration = self:GetSpecialValueFor('fading_slow_duration')
	local root_duration = self:GetSpecialValueFor('root_duration')
	local fading_slow_pct = self:GetSpecialValueFor('fading_slow_pct')
	local explosion_damage = self:GetSpecialValueFor("explosion_damage")
	local explosion_damage_table = {
		attacker = caster,
		damage = explosion_damage,
		damage_type = DAMAGE_TYPE_PURE,
	}

	local projectile = {
		EffectName = "particles/puck/puck_ex_special_attack.vpcf",
		vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius = self:GetSpecialValueFor("hitbox"),
        Source = caster,
		bIsReflectable = false,
		bIsDestructible = false,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_NOTHING,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}
			ApplyDamage(damage_table)
		end,
		OnFinish = function(_self, pos)
			local enemies = _self.Source:FindUnitsInRadius(
				pos, 
				radius, 
				DOTA_UNIT_TARGET_TEAM_ENEMY, 
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
				DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
				FIND_ANY_ORDER
			   )
		
			for _,enemy in pairs(enemies) do
				explosion_damage_table.victim = enemy
				ApplyDamage(explosion_damage_table)
				
				if self:GetLevel() >= 2 then
					enemy:AddNewModifier(caster, self, "modifier_generic_root", { 
						duration = root_duration,
					})
				else 
					enemy:AddNewModifier(caster, self, "modifier_generic_fading_slow", { 
						duration = fading_slow_duration,
						max_slow_pct = fading_slow_pct 
					})
				end
			end

			ScreenShake(point, 100, 300, 0.45, 1000, 0, true)
			CreateRadiusMarker(_self.Source, pos, radius, RADIUS_SCOPE_PUBLIC, 0.1)
			EmitSoundOn("Hero_Puck.EtherealJaunt", _self.Source)
			EmitSoundOnLocationWithCaster(pos, 'Hero_Puck.Waning_Rift', _self.Source)
			StopSoundOn("Hero_Puck.Illusory_Orb", _self.Source)
			self:PlayEffectsOnFinish(pos, 'particles/econ/items/puck/puck_alliance_set/puck_illusory_orb_explode_aproset.vpcf', 'particles/econ/items/abaddon/abaddon_alliance/abaddon_death_coil_alliance_explosion.vpcf')
		end,
	}

    local projectile = Projectiles:CreateProjectile(projectile)
    local time = self:GetCastRange(Vector(0,0,0), nil)/projectile_speed
    caster:AddNewModifier(caster, self, "modifier_puck_ex_special_attack_recast", { duration = time })
	caster:AddNewModifier(caster, caster:FindAbilityByName('puck_special_attack'), "modifier_puck_special_attack_recast", { duration = time })
	
    caster:FindAbilityByName("puck_special_attack_recast"):SetProjectile(projectile)
    caster:FindAbilityByName("puck_ex_special_attack_recast"):SetProjectile(projectile)
	self:PlayEffectsOnCast()
end


function puck_ex_special_attack_recast:GetCastPointSpeed()    return 0 end
function puck_ex_special_attack_recast:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_2 end
function puck_ex_special_attack_recast:OnSpellStart()
	self:GetCaster():RemoveModifierByName('modifier_puck_special_attack_recast')
    self.projectile:Destroy(false)
end

function puck_ex_special_attack_recast:SetProjectile(projectile)
    if IsServer() then
        self.projectile = projectile
    end
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(puck_special_attack)
Abilities.Castpoint(puck_ex_special_attack)
Abilities.Castpoint(puck_ex_special_attack_recast)
Abilities.Tie(puck_ex_special_attack, 'puck_special_attack')
Abilities.Tie(puck_special_attack, 'puck_ex_special_attack')