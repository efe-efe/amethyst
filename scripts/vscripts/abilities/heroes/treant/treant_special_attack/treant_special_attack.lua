treant_special_attack = class({})
LinkLuaModifier( "modifier_treant_leeching_seed", "abilities/heroes/treant/treant_shared_modifiers/modifier_treant_leeching_seed", LUA_MODIFIER_MOTION_NONE )

function treant_special_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("treant_ex_special_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function treant_special_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	
	-- Animation and pseudo cast point
	StartAnimation(caster, { 
		duration= cast_point + 0.1,
		translate = "odachi",
		activity = ACT_DOTA_ATTACK2,
		rate = 1.0
	})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
		duration = cast_point,
		movement_speed = 10,
		fixed_range = 1,
	})
end

function treant_special_attack:OnEndPseudoCastPoint( point )
	local caster = self:GetCaster()

	-- Projectile data
    local projectile_name = "particles/mod_units/heroes/hero_treant/treant_leech_seed_projectile.vpcf"
	local projectile_start_radius = 50
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	-- Extra data
	local slow_duration = self:GetSpecialValueFor("slow_duration")
    local mana_gain = self:GetSpecialValueFor("mana_gain")/100
    local leeching_duration = self:GetSpecialValueFor("leeching_duration")

	-- Dinamyc data
	local origin = caster:GetOrigin()
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	local damage = self:GetAbilityDamage()

	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance = projectile_distance,
		fStartRadius = projectile_start_radius,
		fEndRadius = projectile_end_radius,
		Source = caster,
		fExpireTime = 8.0,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		bMultipleHits = false,
		bIgnoreSource = true,
		TreeBehavior = PROJECTILES_NOTHING,
		bCutTrees = true,
		bTreeFullCollision = false,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
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
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
			}
			ApplyDamage( damage_table )

            unit:AddNewModifier(caster, self, "modifier_treant_leeching_seed", { duration = leeching_duration }) 

            if _self.Source == caster then
				-- Give Mana
				local mana_gain_final = caster:GetMaxMana() * mana_gain
				caster:GiveMana(mana_gain_final)
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_a(pos)
		end,
	}

	self:PlayEffectsOnLaunch()
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)	

	-- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("treant_ex_special_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))
end


--------------------------------------------------------------------------------
-- Effects

-- On Projectile Finish
function treant_special_attack:PlayEffects_a( pos )
	-- Create Sound
	local sound_cast = "Hero_Treant.LeechSeed.Target"
	EmitSoundOnLocationWithCaster( pos, sound_cast, self:GetCaster() )
	
	-- Create Particles
	local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_guardian_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function treant_special_attack:PlayEffectsOnLaunch( )
	-- Create Sound
    EmitSoundOn( "Hero_Treant.NaturesGuise.On", self:GetCaster() )
end
