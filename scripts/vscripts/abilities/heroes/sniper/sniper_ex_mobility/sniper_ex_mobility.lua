sniper_ex_mobility = class({})
LinkLuaModifier( "modifier_sniper_ex_mobility_thinker", "abilities/heroes/sniper/sniper_ex_mobility/modifier_sniper_ex_mobility_thinker", LUA_MODIFIER_MOTION_NONE )

function sniper_ex_mobility:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("sniper_mobility")
end

--------------------------------------------------------------------------------
-- Ability Start
function sniper_ex_mobility:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
    local radius = self:GetSpecialValueFor("radius")

    EmitGlobalSound( "Ability.AssassinateLoad")

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.5, activity=ACT_DOTA_CAST_ABILITY_1, rate=1.5})
	caster:AddNewModifier(
		caster, 
		self, 
		"modifier_generic_pseudo_cast_point", 
		{ 
			duration = cast_point,
            movement_speed = 50,
            radius = radius, 
		}
	)
end

function sniper_ex_mobility:OnEndPseudoCastPoint( point )
    -- Initialize variables
	local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local damage = self:GetSpecialValueFor("damage")
	local duration = self:GetSpecialValueFor( "duration" )

	-- Projectile data
	local projectile_name = "particles/mod_units/heroes/hero_sniper/techies_base_attack.vpcf"
	local projectile_start_radius = 80--self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = 80--self:GetSpecialValueFor("hitbox")
	local projectile_distance = (origin - point):Length2D()
	local projectile_speed = 1700--self:GetSpecialValueFor("projectile_speed")
    local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, -100 )):Normalized()

    -- Projectile
    local projectile = {
        EffectName = projectile_name,
        vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,60),
        fDistance = projectile_distance,
        fStartRadius = projectile_start_radius,
        fEndRadius = projectile_end_radius,
        Source = caster,
        fExpireTime = 8.0,
        vVelocity = projectile_direction * projectile_speed,
        UnitBehavior = PROJECTILES_DESTROY,
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
            -- Effect thinker
            CreateModifierThinker(
                _self.Source, --hCaster
                self, --hAbility
                "modifier_sniper_ex_mobility_thinker", --modifierName
                { duration = duration }, --paramTable
                pos, --vOrigin
                _self.Source:GetTeamNumber(), --nTeamNumber
                false --bPhantomBlocker
            )
            self:PlayEffects_b(pos)
        end,
    }

    Projectiles:CreateProjectile(projectile)
    self:PlayEffects_a( pos )
    
    -- Put CD on the alternate version of the ability
	local alternate_version = caster:FindAbilityByName("sniper_mobility")
	alternate_version:StartCooldown(self:GetCooldown(0))

end

--------------------------------------------------------------------------------
function sniper_ex_mobility:PlayEffects_a( point )
	-- Cast Sound
	local sound_cast = "Hero_Sniper.ShrapnelShoot"
    EmitSoundOn( sound_cast, self:GetCaster() )
end

-- On hit wall 
function sniper_ex_mobility:PlayEffects_b( pos )
	local caster = self:GetCaster()
	
	-- Cast Sound
	local sound_cast = "Hero_Sniper.AssassinateDamage"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Cast Particle
	local particle_cast = "particles/econ/items/storm_spirit/strom_spirit_ti8/storm_spirit_ti8_overload_flash.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

