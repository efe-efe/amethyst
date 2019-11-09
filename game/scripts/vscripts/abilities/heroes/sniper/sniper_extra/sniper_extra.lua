sniper_extra = class({})
LinkLuaModifier( "modifier_sniper_extra_movement", "abilities/heroes/sniper/sniper_extra/modifier_sniper_extra_movement", LUA_MODIFIER_MOTION_HORIZONTAL )

function sniper_extra:HasPriority()
    return true
end

function sniper_extra:OnSpellStart()
    self:PlayEffectsOnPhase()
end

function sniper_extra:OnCastPointEnd()
    -- Initialize variables
	local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local point = self:GetCursorPosition()
    local knockback_distance = self:GetSpecialValueFor("knockback_distance")
    local damage = self:GetSpecialValueFor("damage_per_bullet")
    local damage_on_collision = self:GetSpecialValueFor("damage_on_collision")
    
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
        EffectName = "particles/mod_units/heroes/hero_sniper/techies_base_attack.vpcf",
        vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,60),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
        fUniqueRadius = self:GetSpecialValueFor("hitbox"),
        Source = caster,
        vVelocity = projectile_direction * projectile_speed,
        UnitBehavior = PROJECTILES_DESTROY,
        TreeBehavior = PROJECTILES_NOTHING,
        WallBehavior = PROJECTILES_DESTROY,
        GroundBehavior = PROJECTILES_NOTHING,
        fGroundOffset = 80,
        UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
        OnUnitHit = function(_self, unit) 

            local x = unit:GetOrigin().x - origin.x
            local y = unit:GetOrigin().y - origin.y

            local distance = knockback_distance - (unit:GetOrigin() - origin):Length2D()

            unit:AddNewModifier(
                _self.Source, -- player source
                self, -- ability source
                "modifier_generic_displacement", -- modifier name
                {
                    x = x,
                    y = y,
                    r = distance,
                    speed = 1500,
                    peak = 32,
                    colliding = 1,
                    damage_on_collision = damage_on_collision
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
        end,
        OnFinish = function(_self, pos)
            self:PlayEffects_c(pos)
        end,
    }

    local direction = -(point - origin):Normalized()
    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_generic_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = knockback_distance,
            speed = 1500,
            peak = 64,
            colliding = 1,
            i_frame = 1,
        } -- kv
    )

    local projectile_b = DuplicateTable(projectile_a)
    local projectile_c = DuplicateTable(projectile_a)

    projectile_b.vVelocity = projectile_direction_b * projectile_speed
    projectile_c.vVelocity = projectile_direction_c * projectile_speed

    Projectiles:CreateProjectile(projectile_a)
    Projectiles:CreateProjectile(projectile_b)
    Projectiles:CreateProjectile(projectile_c)
    self:PlayEffectsOnCast()
end

function sniper_extra:PlayEffectsOnPhase()
    EmitSoundOn( "Ability.AssassinateLoad", self:GetCaster() )
end

function sniper_extra:PlayEffectsOnCast()
    EmitSoundOn( "Hero_Techies.LandMine.Detonate", self:GetCaster() )
end

-- On hit wall 
function sniper_extra:PlayEffects_c( pos )
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

if IsClient() then require("abilities") end
Abilities.Initialize( 
	sniper_extra,
	{ activity = ACT_DOTA_ATTACK, rate = 0.4 },
	{ movement_speed = 0, fixed_range = 1 }
)
