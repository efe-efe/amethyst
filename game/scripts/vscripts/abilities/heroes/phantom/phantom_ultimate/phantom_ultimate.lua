phantom_ultimate = class({})

function phantom_ultimate:OnSpellStart()
	-- play effects
	local cast_point = self:GetCastPoint()
	local caster = self:GetCaster()

	StartAnimation(caster, { 
		duration = cast_point + 0.1, 
		activity = ACT_DOTA_CAST_ABILITY_3, 
		rate = 0.7 
	})

	caster:AddNewModifier(
		caster, 
		self, 
		"modifier_cast_point", 
		{
			duration = cast_point, 
			can_walk = 0,
			fixed_range = 1,
			show_all = 1
		}
	)
    ProgressBars:AddProgressBar(caster, "modifier_cast_point", {
		style = "Ultimate",
		text = "ultimate",
		progressBarType = "duration",
		priority = 1,
		reversedProgress = true,
	})
end

function phantom_ultimate:OnCastPointEnd( point )
    --Initialize variables
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local max_range = self:GetSpecialValueFor("range")
    local damage = self:GetAbilityDamage()
    local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")

	-- load data
	local projectile_name = "particles/mod_units/heroes/hero_luna/luna_base_attack.vpcf"
	local projectile_start_radius = 70
	local projectile_end_radius = 100
	local projectile_distance = max_range
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = 6000

	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = {unit=caster, attach="attach_attack1", offset=Vector(0,0,0)},
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
		bTreeFullCollision = false,
		WallBehavior = PROJECTILES_NOTHING,
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
		bIsSlowable = false,
		bIsReflectable = false,
		fVisionTickTime = .1,
		fVisionLingerDuration = 1,
		draw = false,
		fRehitDelay = 1.0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit) 

			local stacks = SafeGetModifierStacks("modifier_phantom_strike_stack", caster, caster)
			local final_damage = damage + ( stacks * damage_per_stack )

			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = final_damage,
				damage_type = DAMAGE_TYPE_PURE,
			}
			
			ApplyDamage( damage_table )
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_CRITICAL, unit, final_damage, nil )

            self:PlayEffects_c(unit)

		end,
        OnFinish = function(_self, pos)
            
            -- teleport
            FindClearSpaceForUnit( caster, pos , true )

            --Effects
			self:PlayEffects_b(pos)

			SafeDestroyModifier("modifier_phantom_strike_stack", caster, caster)
		end,
	}
	self:PlayEffects_d()
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
end

-- On projectile finish
function phantom_ultimate:PlayEffects_b(pos)
	-- Cast Sound
    local sound_cast_a = "Hero_PhantomAssassin.Strike.End"
    local sound_cast_b = "Hero_PhantomAssassin.Arcana_Layer"
    EmitSoundOn(sound_cast_a, self:GetCaster())
	EmitSoundOn( sound_cast_b, self:GetCaster() )
    
    -- Cast Particles
	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- On Projectile hit an enemy
function phantom_ultimate:PlayEffects_c(hTarget)
	-- Cast Sound
    local sound_cast = "Hero_PhantomAssassin.Spatter"
    local sound_cast_b = "Hero_PhantomAssassin.CoupDeGrace"

    EmitSoundOn(sound_cast, hTarget)
    EmitSoundOn(sound_cast, hTarget)

    -- Cast Particles
	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_impact_dagger_arcana.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )
    ParticleManager:SetParticleControl( effect_cast, 1, hTarget:GetOrigin() )
    ParticleManager:SetParticleControlForward( effect_cast, 1, hTarget:GetForwardVector() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- On spell start
function phantom_ultimate:PlayEffects_d()
    -- Cast Particles
    local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )

	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end