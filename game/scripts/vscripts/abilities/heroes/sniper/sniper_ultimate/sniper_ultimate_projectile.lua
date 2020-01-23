sniper_ultimate_projectile = class({})
LinkLuaModifier( "modifier_sniper_ultimate_thinker", "abilities/heroes/sniper/sniper_ultimate/modifier_sniper_ultimate_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_ultimate_movement", "abilities/heroes/sniper/sniper_ultimate/modifier_sniper_ultimate_movement", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_sniper_ultimate_hit", "abilities/heroes/sniper/sniper_ultimate/modifier_sniper_ultimate_hit", LUA_MODIFIER_MOTION_NONE )

function sniper_ultimate_projectile:OnCastPointEnd( )
	-- Initialize variables
    local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local ability = caster:FindAbilityByName("sniper_ultimate") -- Get special values from original
	local damage = ability:GetSpecialValueFor("ability_damage")

	self.radius = ability:GetSpecialValueFor("radius")
	self.aoe_damage = ability:GetSpecialValueFor("aoe_damage")

	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	-- Extra data
	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_sniper/sniper_assassinate.vpcf",
		vSpawnOrigin = origin + Vector(0,0, 96),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = self:GetSpecialValueFor("hitbox"),
		fEndRadius = projectile_end_radius,
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit)
			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}			
			
			ApplyDamage( damage_table )
			
			unit:AddNewModifier(_self.Source, self, "modifier_sniper_ultimate_hit", { duration = 0.1 })
			self:PlayEffectsTarget(unit, _self.current_position)
		end,
        OnFinish = function(_self, pos)
            self:Explosion(pos)
			self:PlayEffectsProjectileImpact(pos)
		end,
	}

    Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Helpers
function sniper_ultimate_projectile:Explosion( pos )
	local caster = self:GetCaster() 

    local enemies = caster:FindUnitsInRadius( 
        pos, 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
	)
	
	for _,enemy in pairs(enemies) do
        local damage = {
            victim = enemy,
            attacker = caster,
            damage = self.aoe_damage,
            damage_type = DAMAGE_TYPE_PURE,
		}
	
		if not enemy:HasModifier("modifier_sniper_ultimate_hit") then
        	ApplyDamage( damage )
		end
		
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
	EmitSoundOn( "Ability.Assassinate", self:GetCaster() )
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
	EmitSoundOnLocationWithCaster( pos, "Hero_Sniper.AssassinateDamage", caster )

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

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	sniper_ultimate_projectile,
	{ activity = ACT_DOTA_ATTACK, rate = 0.4 },
	{ movement_speed = 0, fixed_range = 1, disable_all = false }
)
