skywrath_mage_basic_attack_lua = class({})

-- This function is used to change between abilities and ex abilities
--------------------------------------------------------------------------------
function skywrath_mage_basic_attack_lua:GetRelatedName()
	local caster = self:GetCaster()
	local ability_name = ""

    -- find and destroy visual modifier
	local basic_attack_timer = caster:FindModifierByNameAndCaster( 
		"modifier_skywrath_mage_basic_attack_charged_timer_lua", caster 
    )

    if basic_attack_timer~=nil then
        if not basic_attack_timer:IsNull() then
            ability_name = "skywrath_mage_ex_basic_attack_lua"
        else
            ability_name = "skywrath_mage_basic_attack_lua"
        end
    else
        ability_name = "skywrath_mage_basic_attack_lua"
    end

    return ability_name
end

--------------------------------------------------------------------------------
-- Ability Start
function skywrath_mage_basic_attack_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local ability = self
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

	-- load data
    local projectile_name = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_base_attack.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local debuff_duration = self:GetSpecialValueFor("debuff_duration")
	local modifier_duration_bonus = self:GetSpecialValueFor("modifier_duration_bonus")

	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance = projectile_distance,
		fStartRadius = projectile_start_radius,
		fEndRadius = projectile_end_radius,
		Source = caster,
		fExpireTime = 8.0,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		bMultipleHits = true,
		bIgnoreSource = true,
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
		iVisionRadius = 200,
		iVisionTeamNumber = caster:GetTeam(),
		bFlyingVision = false,
		fVisionTickTime = .1,
		fVisionLingerDuration = 1,
		draw = false,
		fRehitDelay = 1.0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= caster:GetTeamNumber() end,
		OnUnitHit = function(_self, unit) 
			
			-- Blocked
			--------------------
			local is_slower = unit:FindModifierByName("modifier_generic_projectile_blocker_lua")
			if is_slower ~= nil then
				if not is_slower:IsNull() then
					_self.SetVelocity(0, projectile_direction * projectile_speed * 0.15)
					return
				end
			end

			-- Hit
			--------------------
			-- perform the actual attack
			caster:PerformAttack(
				unit, -- handle hTarget 
				true, -- bool bUseCastAttackOrb, 
				true, -- bool bProcessProcs,
				true, -- bool bSkipCooldown
				false, -- bool bIgnoreInvis
				false, -- bool bUseProjectile
				false, -- bool bFakeAttack
				false -- bool bNeverMiss
			)

			self:PlayEffects_b(_self:GetPosition())
			_self.Destroy()
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_b(pos)
		end,
	}

	self:StartCooldown(attack_speed)
	self:PlayEffects_a()

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function skywrath_mage_basic_attack_lua:PlayEffects_a()
	-- Create Sound
	local sound_cast = "Hero_SkywrathMage.Attack"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function skywrath_mage_basic_attack_lua:PlayEffects_b( pos )
	local caster = self:GetCaster()
	
	-- Create Sound
	local sound_cast = "Hero_SkywrathMage.ProjectileImpact"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Cast Particle
	local particle_cast = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
end

