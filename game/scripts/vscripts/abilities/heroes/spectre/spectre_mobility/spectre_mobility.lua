spectre_mobility = class({})
spectre_ex_mobility = class({})

LinkLuaModifier("modifier_spectre_banish", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_banish", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_mobility_charges", "abilities/heroes/spectre/spectre_mobility/modifier_spectre_mobility_charges", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_mobility_thinker", "abilities/heroes/spectre/spectre_mobility/modifier_spectre_mobility_thinker", LUA_MODIFIER_MOTION_NONE)

function spectre_mobility:GetIntrinsicModifierName()
	return "modifier_spectre_mobility_charges"
end

function spectre_mobility:GetCooldown()
	if self:GetCaster():HasModifier("modifier_spectre_ultimate") then
		if self:GetCaster():FindModifierByName("modifier_spectre_ultimate"):GetCaster() == self:GetCaster() then
			return 1.0
		else
			return self.BaseClass.GetCooldown(self, self:GetLevel())
		end
	else
		return self.BaseClass.GetCooldown(self, self:GetLevel())
	end
end

function spectre_mobility:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local min_range = self:GetSpecialValueFor("min_range")
	local point = Clamp(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), min_range)
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local damage = self:GetSpecialValueFor("ability_damage")
	self.radius = self:GetSpecialValueFor("radius")

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector(point.x - origin.x, point.y - origin.y, 0)):Normalized()

	local projectile = {
		EffectName = "particles/econ/items/shadow_demon/sd_ti7_shadow_poison/sd_ti7_shadow_poison_proj.vpcf",
		vSpawnOrigin = origin + Vector(0,0,80),
		fDistance =  (point - origin):Length2D(),
		fStartRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_NOTHING,
        GroundBehavior = PROJECTILES_NOTHING,
        bIsReflectable = false,
        bIsSlowable = false,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit"  and not _self.Source:IsAlly(unit) end,
		OnFinish = function(_self, pos)
			local enemies = self:GetCaster():FindUnitsInRadius(
				pos, 
				self.radius, 
				DOTA_UNIT_TARGET_TEAM_ENEMY, 
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER
			)

			local charge = false

			for _, enemy in pairs(enemies) do 
				if not enemy:IsObstacle() then
					charge = true
				end

				local damage_table = {
					victim = enemy,
					attacker = _self.Source,
					damage = damage,
					damage_type = DAMAGE_TYPE_PURE,
					ability = self
				}
				ApplyDamage(damage_table)
			end

			-- if at least 1 enemy
			if charge == true then
				local modifier = caster:FindModifierByName("modifier_spectre_basic_attack_cooldown"):Replenish()

				if #enemies == 1 then
					caster:GiveManaPercent(mana_gain_pct, enemies[1])    
				else
					caster:GiveManaPercent(mana_gain_pct)
				end
			end
            self:PlayEffectsOnFinish(pos)
            SafeDestroyModifier("modifier_spectre_banish", caster, caster)
            FindClearSpaceForUnit(caster, pos , true)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
	caster:AddNewModifier(caster, self, "modifier_spectre_banish", {})
end

function spectre_mobility:OnUpgrade()
	if self:GetLevel() == 2 then
		self:GetCaster():FindModifierByName("modifier_spectre_mobility_charges"):AddCharge()
	end
end

function spectre_mobility:PlayEffectsOnCast()
    EmitSoundOn("Hero_Spectre.HauntCast", self:GetCaster())

	local particle_cast = "particles/econ/items/shadow_demon/sd_ti7_shadow_poison/sd_ti7_shadow_poison_release.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
    ParticleManager:SetParticleControl(effect_cast, 2, self:GetCaster():GetOrigin())
    ParticleManager:SetParticleControl(effect_cast, 3, Vector(250,0,0))
    ParticleManager:SetParticleControl(effect_cast, 4, self:GetCaster():GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function spectre_mobility:PlayEffectsOnFinish(pos)
	EFX('particles/units/heroes/hero_spectre/spectre_death.vpcf', PATTACH_WORLDORIGIN, self:GetCaster(), {
		cp0 = self:GetCaster():GetAbsOrigin(),
		cp3 = self:GetCaster():GetAbsOrigin(),
		release = true,
	})

	EFX('particles/sweep_generic/sweep_3.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetCaster(), {
		release = true,
	})
	EFX('particles/spectre/spectre_mobility.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetCaster(), {
		cp2 = Vector(self.radius, 1, 1),
		release = true,
	})
end

function spectre_mobility:PlayEffectsOnImpact(hTarget)
	EmitSoundOn("Hero_Spectre.Attack", hTarget)
end


function spectre_ex_mobility:GetCastAnimationCustom()	return ACT_DOTA_ATTACK end
function spectre_ex_mobility:GetPlaybackRateOverride() return 1.0 end
function spectre_ex_mobility:GetCastPointSpeed() 		return 0 end

function spectre_ex_mobility:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local min_range = self:GetSpecialValueFor("min_range")
	local delay = self:GetSpecialValueFor("delay")
	local point = Clamp(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), min_range)
	
	EFX('particles/units/heroes/hero_spectre/spectre_death.vpcf', PATTACH_WORLDORIGIN, self:GetCaster(), {
		cp0 = self:GetCaster():GetAbsOrigin(),
		cp3 = self:GetCaster():GetAbsOrigin(),
		release = true,
	})

	EFX('particles/econ/items/outworld_devourer/od_shards_exile_gold/od_shards_exile_prison_start_gold.vpcf', PATTACH_WORLDORIGIN, caster, {
		cp0 = origin,
		cp1 = origin,
		release = true,
	})
	EmitSoundOn("Hero_Spectre.HauntCast", caster)

	caster:AddNewModifier(caster, self, "modifier_spectre_banish", {})
	CreateModifierThinker(caster, self, 'modifier_spectre_mobility_thinker', { duration = delay }, point, caster:GetTeam(), false)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(spectre_mobility)
Abilities.Castpoint(spectre_ex_mobility)
Abilities.Tie(spectre_mobility, 'spectre_ex_mobility')
Abilities.Tie(spectre_ex_mobility, 'spectre_mobility')