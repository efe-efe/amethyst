sniper_ex_ultimate_lua = class({})
LinkLuaModifier( "modifier_sniper_ex_ultimate_movement_lua", "abilities/heroes/sniper/sniper_ex_ultimate_lua/modifier_sniper_ex_ultimate_movement_lua", LUA_MODIFIER_MOTION_HORIZONTAL )

function sniper_ex_ultimate_lua:OnAbilityPhaseStart()
	-- play effects
	self:PlayEffects_a()

	return true -- if success
end

function sniper_ex_ultimate_lua:OnSpellStart()
    -- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
    local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
    local knockback_distance = self:GetSpecialValueFor("knockback_distance")
    local damage = self:GetSpecialValueFor("damage")

	-- Projectile data
	local projectile_name = "particles/mod_units/heroes/hero_sniper/techies_base_attack.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
    local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

    local a_x = projectile_direction.x
    local a_y = projectile_direction.y
    local b_x = ( (a_x * math.cos(50)) - (a_y * math.sin(50)) )
    local b_y = ( (a_x * math.sin(50)) + (a_y * math.cos(50)) )
    local c_x = ( (a_x * math.cos(-50)) - (a_y * math.sin(-50)) )
    local c_y = ( (a_x * math.sin(-50)) + (a_y * math.cos(-50)) )
    local projectile_direction_b = Vector(b_x, b_y, 0)
    local projectile_direction_c = Vector(c_x, c_y, 0)

    -- Projectile
    local projectile_a = {
        EffectName = projectile_name,
        vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,60),
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
        UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
        OnUnitHit = function(_self, unit) 

            local x = unit:GetOrigin().x - origin.x
            local y = unit:GetOrigin().y - origin.y
            local movement_modifier = unit:AddNewModifier(
                _self.Source, -- player source
                self, -- ability source
                "modifier_sniper_ex_ultimate_movement_lua", -- modifier name
                {
                    x = x,
                    y = y,
                    r = knockback_distance,
                    speed = 2000,
                } -- kv
            )
            
            --Damage
            local damage = {
                victim = unit,
                attacker = _self.Source,
                damage = damage,
                damage_type = DAMAGE_TYPE_MAGICAL,
            }
            ApplyDamage( damage )
            self:PlayEffects_c(_self:GetPosition())
            _self.Destroy()
        end,
        OnFinish = function(_self, pos)
            self:PlayEffects_c(pos)
        end,
    }

    local projectile_b = self:Copy(projectile_a)
    local projectile_c = self:Copy(projectile_a)

    projectile_b.vVelocity = projectile_direction_b * projectile_speed
    projectile_c.vVelocity = projectile_direction_c * projectile_speed

    self:PlayEffects_b()
    Projectiles:CreateProjectile(projectile_a)
    Projectiles:CreateProjectile(projectile_b)
    Projectiles:CreateProjectile(projectile_c)
end

function sniper_ex_ultimate_lua:PlayEffects_a()
    local sound_cast = "Ability.AssassinateLoad"
    EmitSoundOn( sound_cast, self:GetCaster() )
end

function sniper_ex_ultimate_lua:PlayEffects_b()
    local sound_cast = "Hero_Techies.LandMine.Detonate"
    EmitSoundOn( sound_cast, self:GetCaster() )
end

-- On hit wall 
function sniper_ex_ultimate_lua:PlayEffects_c( pos )
	local caster = self:GetCaster()
	
	-- Cast Sound
	local sound_cast = "Hero_Sniper.ProjectileImpact"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Cast Particle
	local particle_cast = "particles/mod_units/heroes/hero_sniper/techies_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
    ParticleManager:SetParticleControl( effect_cast, 0, pos )
    ParticleManager:SetParticleControl( effect_cast, 3, pos )
	
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function sniper_ex_ultimate_lua:Copy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[self:Copy(k, s)] = self:Copy(v, s) end
    return res
end