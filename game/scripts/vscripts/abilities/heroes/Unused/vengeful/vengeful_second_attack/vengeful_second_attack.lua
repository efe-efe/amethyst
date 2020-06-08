vengeful_second_attack = class({})
vengeful_second_attack_ultimate = class({})
LinkLuaModifier("modifier_vengeful_second_attack", "abilities/heroes/vengeful/vengeful_second_attack/modifier_vengeful_second_attack", LUA_MODIFIER_MOTION_NONE)

function vengeful_second_attack:OnSpellStart()
	local particle_cast = "particles/monkey_king_spring_cast_spiral_ember.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 3, self:GetCaster():GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

--------------------------------------------------------------------------------
-- Ability Start
function vengeful_second_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local ability = caster:FindAbilityByName("vengeful_second_attack")
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = ability:GetSpecialValueFor("ability_damage")
	local duration = ability:GetSpecialValueFor("duration")
	local name = self:GetAbilityName()

	-- load data
    local mana_gain_pct = ability:GetSpecialValueFor("mana_gain_pct")
	
	-- Dynamic data
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local projectile_speed = ability:GetSpecialValueFor("projectile_speed")

	local projectile = {
		EffectName = 			"particles/vs_ti8_immortal_magic_missle_crimson.vpcf",
		vSpawnOrigin = 			caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance = 			ability:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius =			ability:GetSpecialValueFor("hitbox"),
		Source = 				caster,
		vVelocity = 			projectile_direction * projectile_speed,
		UnitBehavior = 			PROJECTILES_DESTROY,
		WallBehavior = 			PROJECTILES_DESTROY,
		TreeBehavior = 			PROJECTILES_NOTHING,
		GroundBehavior = 		PROJECTILES_NOTHING,
		fGroundOffset = 		80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self,
			}

			ApplyDamage(damage_table)

			if not string.ends(name, "_ultimate") then
				if _self.Source == caster then
					caster:GiveManaPercent(mana_gain_pct, unit)
					unit:AddNewModifier(caster, self, "modifier_vengeful_second_attack", { duration = duration })
				end
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function vengeful_second_attack:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()

	EmitSoundOnLocationWithCaster(pos, "Hero_VengefulSpirit.MagicMissileImpact", caster)

	-- Create Particles
	local particle_cast = "particles/econ/items/vengeful/vs_ti8_immortal_shoulder/vs_ti8_immortal_magic_missle_crimson_end.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function vengeful_second_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_VengefulSpirit.MagicMissile", self:GetCaster())
end

vengeful_second_attack_ultimate.OnSpellStart = vengeful_second_attack.OnSpellStart
vengeful_second_attack_ultimate.OnCastPointEnd = vengeful_second_attack.OnCastPointEnd
vengeful_second_attack_ultimate.PlayEffectsOnFinish = vengeful_second_attack.PlayEffectsOnFinish
vengeful_second_attack_ultimate.PlayEffectsOnCast = vengeful_second_attack.PlayEffectsOnCast



local animation = { activity = ACT_DOTA_SPAWN, rate = 2.0 }
local warmup = { movement_speed = 80, fixed_range = 1 }

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	vengeful_second_attack,
	animation,
	warmup
)
Abilities.Initialize(
	vengeful_second_attack_ultimate,
	animation,
	warmup
)