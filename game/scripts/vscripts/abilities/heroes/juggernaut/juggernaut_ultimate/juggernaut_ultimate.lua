juggernaut_ultimate = class({})
LinkLuaModifier(
    "modifier_juggernaut_ultimate_movement",
    "abilities/heroes/juggernaut/juggernaut_ultimate/modifier_juggernaut_ultimate_movement", 
    LUA_MODIFIER_MOTION_HORIZONTAL
)
LinkLuaModifier(
    "modifier_juggernaut_ultimate_slashing",
    "abilities/heroes/juggernaut/juggernaut_ultimate/modifier_juggernaut_ultimate_slashing", 
    LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
    "modifier_generic_fading_slow_lua",
    "abilities/generic/modifier_generic_fading_slow_lua",
    LUA_MODIFIER_MOTION_NONE
)

--------------------------------------------------------------------------------
-- Ability Start
function juggernaut_ultimate:OnSpellStart()
	-- Initialize bariables
	local caster = self:GetCaster()
    local cast_point = self:GetCastPoint()

    EmitGlobalSound("juggernaut_jug_ability_omnislash_01")

    
    local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_death_model.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_omni_end.vpcf"
	effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:SetParticleControl( effect_cast, 2, caster:GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, caster:GetOrigin() )

    ParticleManager:ReleaseParticleIndex( effect_cast )
    
	-- Animation and pseudo cast point
	StartAnimation(caster, {
        duration=cast_point + 0.1,
		translate= "sharp_blade",
		activity = ACT_DOTA_TAUNT,
        rate=2.5
    })
	caster:AddNewModifier(caster, self , "modifier_cast_point", { 
        duration = cast_point,
        can_walk = 0,
        fixed_range = 1,
	})
end


function juggernaut_ultimate:OnStopPseudoCastPoint()
	StopGlobalSound( "juggernaut_jug_ability_omnislash_01" )
end


function juggernaut_ultimate:OnCastPointEnd( point )
    local caster = self:GetCaster()
    local distance = self:GetSpecialValueFor( "range" )
    local omni_duration = self:GetSpecialValueFor( "duration" )
    
    local direction = caster:GetForwardVector()
    local speed = 3000
    local radius = 80

    local x = direction.x * distance
    local y = direction.y * distance

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_juggernaut_ultimate_movement", -- modifier name
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
	local projectile_start_radius = radius
	local projectile_end_radius = radius
	local projectile_distance = distance
	local projectile_speed = speed - 200
	
    -- Dinamyc data
    local origin = caster:GetOrigin()
    local direction_normal = (point - origin):Normalized()
    local initial_position = origin + Vector(direction_normal.x * offset, direction_normal.y * offset, 0)
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
        UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() and unit:Attribute_GetIntValue("dummy", 0) ~= 1 end,
        OnUnitHit = function(_self, unit) 
            if _self.Source == caster then
                if caster:HasModifier("modifier_juggernaut_ultimate_movement") then
                    SafeDestroyModifier("modifier_juggernaut_ultimate_movement", caster, caster)
                end
            end

            -- Add modifier
            caster:AddNewModifier(
                caster, -- player source
                self, -- ability source
                "modifier_juggernaut_ultimate_slashing", -- modifier name
                { duration = omni_duration } -- kv
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
function juggernaut_ultimate:PlayEffects_a()
    -- Cast Sound
    local sound_cast = "Hero_PhantomAssassin.Strike.End"
    EmitSoundOn(sound_cast, self:GetCaster())
end

-- On Projectile Finish
function juggernaut_ultimate:PlayEffects_b( pos )
end

-- On Projectile Hit enemy
function juggernaut_ultimate:PlayEffects_c( hTarget )
    -- Cast Sound
    local sound_cast = "Hero_PhantomAssassin.Attack"
    EmitSoundOn(sound_cast, hTarget)
end
