skywrath_mage_ex_second_attack_lua = class({})
LinkLuaModifier( "modifier_skywrath_mage_ex_second_attack_buff_lua", "abilities/heroes/skywrath_mage/skywrath_mage_ex_second_attack_lua/modifier_skywrath_mage_ex_second_attack_buff_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_ex_second_attack_debuff_lua", "abilities/heroes/skywrath_mage/skywrath_mage_ex_second_attack_lua/modifier_skywrath_mage_ex_second_attack_debuff_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Set the AOE indicator
function skywrath_mage_ex_second_attack_lua:GetAOERadius()
	return self:GetSpecialValueFor( "hitbox" )
end

--------------------------------------------------------------------------------
-- Ability Start
function skywrath_mage_ex_second_attack_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local ability = self

	-- load data
    local projectile_name = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	
	local buff_duration = self:GetSpecialValueFor("buff_duration")
    local heal_damage = self:GetSpecialValueFor("heal_damage")

	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,80) + caster:GetForwardVector() * 100,
		fDistance = projectile_distance,
		fStartRadius = 70,
		fEndRadius = projectile_end_radius,
		Source = caster,
		fExpireTime = 8.0,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		bIgnoreSource = false,
		TreeBehavior = PROJECTILES_NOTHING,
		bCutTrees = true,
		bTreeFullCollision = false,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		nChangeMax = 1,
		bRecreateOnChange = true,
		bZCheck = false,
		bGroundLock = true,
		bProvidesVision = true,
		bisReflectableByAllies = false,
		iVisionRadius = 200,
		iVisionTeamNumber = caster:GetTeam(),
		bFlyingVision = false,
		fVisionTickTime = .1,
		fVisionLingerDuration = 1,
		draw = false,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" end,
		OnUnitHit = function(_self, unit)
			-- Hit
			--------------------
			--If target is ally
			if unit:GetTeamNumber() == _self.Source:GetTeamNumber() then
				--speed
				unit:AddNewModifier(
					_self.Source, -- player source
					ability, -- ability source
					"modifier_skywrath_mage_ex_second_attack_buff_lua", -- modifier name
					{ duration = buff_duration }
				)
	
				--Heal
				unit:Heal(heal_damage, _self.Source)
	
				self:PlayEffects_c(unit, _self:GetPosition())
			-- If target is enemy
			else	
				local damage = {
					victim = unit,
					attacker = _self.Source,
					damage = heal_damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
				}
		
				ApplyDamage( damage )
		
				--slow
				unit:AddNewModifier(
					_self.Source, -- player source
					ability, -- ability source
					"modifier_skywrath_mage_ex_second_attack_debuff_lua", -- modifier name
					{ duration = buff_duration }
				)

				self:PlayEffects_b(_self:GetPosition())
			end
			_self.Destroy()
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_b(pos)
		end,
	}

	self:PlayEffects_a()

	-- Put CD on the non ex version of the ability
	local non_ex_version = caster:FindAbilityByName("skywrath_mage_second_attack_lua")
	non_ex_version:StartCooldown(self:GetCooldown(0))

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function skywrath_mage_ex_second_attack_lua:PlayEffects_a()
	-- Create Sound
	local sound_cast = "Hero_SkywrathMage.ArcaneBolt.Cast"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function skywrath_mage_ex_second_attack_lua:PlayEffects_b( pos )
	local caster = self:GetCaster()
	
	-- Create Sound
	local sound_cast = "Hero_SkywrathMage.ArcaneBolt.Impact"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Cast Particles
	local particle_cast_a = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt_hit.vpcf"
	local particle_cast_b = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt_launch.vpcf"

	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN, caster )
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN, caster )

	ParticleManager:SetParticleControl( effect_cast_a, 0, pos )
	ParticleManager:SetParticleControl( effect_cast_a, 3, pos )
	ParticleManager:SetParticleControl( effect_cast_b, 0, pos )
	ParticleManager:SetParticleControl( effect_cast_b, 9, pos )

	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
end

function skywrath_mage_ex_second_attack_lua:PlayEffects_c( hTarget, pos )
	-- Create Sound
	local sound_cast = "Hero_Omniknight.GuardianAngel"
	EmitSoundOn( sound_cast, hTarget )

	-- Cast Particles
	local particle_cast = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt_launch.vpcf"
	
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )

	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 9, pos )

	ParticleManager:ReleaseParticleIndex( effect_cast )
end


