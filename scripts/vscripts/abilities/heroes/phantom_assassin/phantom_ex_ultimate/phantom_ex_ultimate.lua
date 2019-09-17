phantom_ex_ultimate = class({})
LinkLuaModifier( "modifier_phantom_ex_ultimate_movement", "abilities/heroes/phantom_assassin/phantom_ex_ultimate/modifier_phantom_ex_ultimate_movement", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_generic_fading_slow_lua", "abilities/generic/modifier_generic_fading_slow_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function phantom_ex_ultimate:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
    local cast_point = self:GetCastPoint()
    self.radius = 200

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.2, activity=ACT_DOTA_CAST_ABILITY_1, rate=1.5})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
        duration = cast_point,
        can_walk = 0,
        radius = self.radius,
		fixed_range= 1
	})
end

function phantom_ex_ultimate:OnEndPseudoCastPoint( point )
    local caster = self:GetCaster()
	local distance = self:GetSpecialValueFor( "range" )
	local damage = self:GetAbilityDamage()
    local direction = caster:GetForwardVector()
    local speed = 1700
    local slow_duration = self:GetSpecialValueFor( "slow_duration" )

    local x = direction.x * distance
    local y = direction.y * distance

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_phantom_ex_ultimate_movement", -- modifier name
        {
            x = x,
            y = y,
            r = distance,
            speed = speed,
        } -- kv
    )

    -- Initialize variables
	local offset = 100

	-- load data
    local projectile_name = ""
	local projectile_start_radius = 0
	local projectile_end_radius = self.radius
	local projectile_distance = distance
	local projectile_speed = speed + 200
	
    -- Dinamyc data
    local origin = caster:GetOrigin()
    local initial_position = origin + Vector(direction.x * offset, direction.y * offset, 0)
    local projectile_direction = direction

    local projectile = {
        EffectName = projectile_name,
        vSpawnOrigin = initial_position + Vector(0,0,80),
        fDistance = projectile_distance,
        fStartRadius = projectile_start_radius,
        fEndRadius = projectile_end_radius,
        Source = caster,
        fExpireTime = 8.0,
        vVelocity = projectile_direction * projectile_speed,
        UnitBehavior = PROJECTILES_NOTHING,
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
        bIsReflectable = false,
        bIsSlowable = false,
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
                attacker = _self.Source,
                damage = damage,
                damage_type = DAMAGE_TYPE_PHYSICAL,
            }

            ApplyDamage( damage_table )

            -- Add modifier
            unit:AddNewModifier(
                caster, -- player source
                self, -- ability source
                "modifier_generic_fading_slow_lua", -- modifier name
                { duration = slow_duration } -- kv
            )

            self:PlayEffects_c(unit)
        end,
        OnFinish = function(_self, pos)
            self:PlayEffects_b(pos)
        end,
    }
    -- Cast projectile
    self:PlayEffects_a()
    Projectiles:CreateProjectile(projectile)
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Spell start
function phantom_ex_ultimate:PlayEffects_a()
    -- Cast Sound
    local sound_cast = "Hero_PhantomAssassin.Strike.End"
    EmitSoundOn(sound_cast, self:GetCaster())
end

-- On Projectile Finish
function phantom_ex_ultimate:PlayEffects_b( pos )
	local caster = self:GetCaster()
	local offset = 120
	local origin = caster:GetOrigin()
	local direction_normal = (pos - origin):Normalized()
	local final_position = origin + Vector(direction_normal.x * offset, direction_normal.y * offset, 0)
	
	-- Create Particles
	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_attack_crit_blur.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
    ParticleManager:SetParticleControl( effect_cast, 1, final_position )
    ParticleManager:SetParticleControlForward( effect_cast, 1, caster:GetForwardVector() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- On Projectile Hit enemy
function phantom_ex_ultimate:PlayEffects_c( hTarget )
    -- Cast Sound
    local sound_cast = "Hero_PhantomAssassin.Attack"
    EmitSoundOn(sound_cast, hTarget)
end
