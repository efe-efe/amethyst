phantom_assassin_ultimate_lua = class({})
LinkLuaModifier( "modifier_phantom_assassin_ultimate_lua", "abilities/heroes/phantom_assassin/phantom_assassin_ultimate_lua/modifier_phantom_assassin_ultimate_lua", LUA_MODIFIER_MOTION_NONE )

function phantom_assassin_ultimate_lua:OnAbilityPhaseStart()
	-- play effects
	self:PlayEffects_a()

	return true -- if success
end

function phantom_assassin_ultimate_lua:OnAbilityPhaseInterrupted()
	ParticleManager:DestroyParticle( self.effect_cast_a, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast_a )

	return true -- if success
end

function phantom_assassin_ultimate_lua:OnSpellStart()
    --Initialize variables
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local point = self:GetCursorPosition()
    local max_range = self:GetSpecialValueFor("range")
    local damage = self:GetSpecialValueFor("damage")


    -- determine target position
    local difference = point - origin
    local target =  origin + (point - origin):Normalized() * max_range

	-- load data
	local projectile_name = "particles/mod_units/heroes/hero_luna/luna_base_attack.vpcf"
	local projectile_start_radius = 220
	local projectile_end_radius = 220
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
		bIsSlowable = false,
		bIsReflectable = false,
		fVisionTickTime = .1,
		fVisionLingerDuration = 1,
		draw = false,
		fRehitDelay = 1.0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit) 
			local damage = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_PURE,
			}

            ApplyDamage( damage )
            self:PlayEffects_c(unit)

		end,
        OnFinish = function(_self, pos)
            
            -- teleport
            FindClearSpaceForUnit( caster, target , true )

            --Effects
			self:PlayEffects_b(pos)

			ParticleManager:DestroyParticle( self.effect_cast_a, false )
			ParticleManager:ReleaseParticleIndex( self.effect_cast_a )
			
		end,
	}
	self:PlayEffects_d()
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
end

function phantom_assassin_ultimate_lua:PlayEffects_a()
	local point = self:GetCursorPosition()
	local origin = self:GetCaster():GetOrigin()
    local max_range = self:GetSpecialValueFor("range")
	local target =  origin + (point - origin):Normalized() * max_range

	-- Cast Sound
    local sound_cast = "phantom_assassin_phass_cast_02"
    EmitGlobalSound(sound_cast)
    
    -- Cast Particles
    local particle_cast_a = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_gravemarker.vpcf"
	local particle_cast_b = "particles/econ/items/mirana/mirana_starstorm_bow/mirana_starstorm_starfall_c.vpcf"

	self.effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_WORLDORIGIN, nil )
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, nil )

    ParticleManager:SetParticleControl( self.effect_cast_a, 0, target )
	ParticleManager:SetParticleControl( effect_cast_b, 3, target )
	
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
	
end

function phantom_assassin_ultimate_lua:PlayEffects_b(pos)
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

function phantom_assassin_ultimate_lua:PlayEffects_c(hTarget)
	-- Cast Sound
    local sound_cast = "Hero_PhantomAssassin.Spatter"
    local sound_cast_b = "Hero_PhantomAssassin.CoupDeGrace"

    EmitSoundOnLocationWithCaster(hTarget:GetOrigin(), sound_cast, self:GetCaster())
    EmitSoundOnLocationWithCaster(hTarget:GetOrigin(), sound_cast_b, self:GetCaster())



    -- Cast Particles
	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_impact_dagger_arcana.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )
    ParticleManager:SetParticleControl( effect_cast, 1, hTarget:GetOrigin() )
    ParticleManager:SetParticleControlForward( effect_cast, 1, hTarget:GetForwardVector() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end


function phantom_assassin_ultimate_lua:PlayEffects_d()
    -- Cast Particles
    local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )

	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	
end