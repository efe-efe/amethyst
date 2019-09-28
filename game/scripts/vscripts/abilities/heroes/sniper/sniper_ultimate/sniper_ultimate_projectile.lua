sniper_ultimate_projectile = class({})
LinkLuaModifier( "modifier_sniper_ultimate_thinker", "abilities/heroes/sniper/sniper_ultimate/modifier_sniper_ultimate_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_ultimate_movement", "abilities/heroes/sniper/sniper_ultimate/modifier_sniper_ultimate_movement", LUA_MODIFIER_MOTION_HORIZONTAL )

--------------------------------------------------------------------------------
-- Ability Start
function sniper_ultimate_projectile:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	local ability = caster:FindAbilityByName("sniper_ultimate") -- Get special values from original

	self.radius = ability:GetSpecialValueFor("radius")
	self.damage = ability:GetAbilityDamage()
	self.knockback_distance = ability:GetSpecialValueFor("knockback_distance")
	self.aoe_damage = ability:GetSpecialValueFor("aoe_damage")

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.5, activity=ACT_DOTA_ATTACK, rate=0.4})
	caster:AddNewModifier(
		caster, 
		self, 
		"modifier_cast_point", 
		{ 
			duration = cast_point,
			can_walk = 0,
			radius = self.radius,
			fixed_range = 1,
		}
	)
end

function sniper_ultimate_projectile:OnCastPointEnd( pos )
	-- Initialize variables
    local caster = self:GetCaster()
	local origin = caster:GetOrigin()

	-- Projectile data
	local projectile_name = "particles/mod_units/heroes/hero_sniper/sniper_assassinate.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_direction = (Vector( pos.x-origin.x, pos.y-origin.y, 0 )):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	-- Extra data
	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = {unit=caster, attach="attach_attack1", offset=Vector(0,0,0)},
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
			-- Damage
			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = self.damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}			
			
			ApplyDamage( damage_table )
			
			self:PlayEffectsTarget(unit, _self.currentPosition)
		end,
        OnFinish = function(_self, pos)
            self:Explosion(pos)
			self:PlayEffectsProjectileImpact(pos)
		end,
	}

	self:PlayEffectsOnCast()
	-- Cast projectile
    Projectiles:CreateProjectile(projectile)
    SafeDestroyModifier("modifier_sniper_second_attack_timer", caster, caster)
end

--------------------------------------------------------------------------------
-- Helpers
function sniper_ultimate_projectile:Explosion( pos )
	local caster = self:GetCaster() 

    -- Find enemies
    local enemies = FindUnitsInRadius( 
        caster:GetTeamNumber(), -- int, your team number
        pos, -- point, center point
        nil, -- handle, cacheUnit. (not known)
        self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        0, -- int, flag filter
        0, -- int, order filter
        false -- bool, can grow cache
    )

	for _,enemy in pairs(enemies) do
        local damage = {
            victim = enemy,
            attacker = caster,
            damage = self.aoe_damage,
            damage_type = DAMAGE_TYPE_PURE,
        }

        ApplyDamage( damage )

        local x = enemy:GetOrigin().x - pos.x
        local y = enemy:GetOrigin().y - pos.y

        enemy:AddNewModifier(
            caster,
            self,
            "modifier_sniper_ultimate_movement",
            {
                x = x,
                y = y,
                r = self.radius,
				speed = 2000,
				origin_x = pos.x,
				origin_y = pos.y,
				origin_z = pos.z
            }
        )
	end

	CreateRadiusMarker(caster, pos, {
		show_all = 1,
		radius = self.radius
	})
	self:PlayEffectsExplosion( pos )
end


--------------------------------------------------------------------------------
-- Graphics & sounds
function sniper_ultimate_projectile:PlayEffectsOnCast()
	-- Cast Sound
	local sound_cast = "Ability.Assassinate"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

-- On hit wall 
function sniper_ultimate_projectile:PlayEffectsProjectileImpact( pos )
	local caster = self:GetCaster()

	-- Cast Sound
	EmitSoundOn( "Hero_Sniper.AssassinateDamage", caster )

	-- Cast Particle
	local particle_cast = "particles/mod_units/heroes/hero_sniper/sniper_assassinate_impact_sparks.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 1, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )

end

function sniper_ultimate_projectile:PlayEffectsTarget( hTarget, pos )
	local caster = self:GetCaster()
	-- Cast Sound
	local sound_cast = "Hero_Sniper.AssassinateDamage"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Cast Particles
	local particle_cast = "particles/mod_units/heroes/hero_sniper/sniper_assassinate_impact_blood.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )

	ParticleManager:SetParticleControl( effect_cast, 0, hTarget:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, hTarget:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end



function sniper_ultimate_projectile:PlayEffectsExplosion( pos )
    local particle_cast = "particles/econ/items/techies/techies_arcana/techies_suicide_arcana.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    
    ParticleManager:SetParticleControl( effect_cast, 0, pos )
    ParticleManager:SetParticleControl( effect_cast, 3, pos )

    ParticleManager:ReleaseParticleIndex( effect_cast )    
end
