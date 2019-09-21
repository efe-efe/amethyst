
juggernaut_ex_special_attack = class({})
LinkLuaModifier( 
	"modifier_juggernaut_ex_special_attack", 
	"abilities/heroes/juggernaut/juggernaut_ex_special_attack/modifier_juggernaut_ex_special_attack",
	LUA_MODIFIER_MOTION_NONE
)

function juggernaut_ex_special_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("juggernaut_special_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function juggernaut_ex_special_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	
	EmitSoundOn("juggernaut_jug_spawn_02", caster)
	-- Animation and pseudo cast point
	StartAnimation(caster, { 
		duration= cast_point + 0.1,
		translate = "odachi",
		activity = ACT_DOTA_TAUNT,
		rate = 1.3
	})
	caster:AddNewModifier(caster, self , "modifier_cast_point", { 
		duration = cast_point,
		movement_speed = 10,
		fixed_range = 1,
	})
end

function juggernaut_ex_special_attack:OnCastPointEnd( pos )
	local caster = self:GetCaster()

	-- Projectile data
    local projectile_name = "particles/mod_units/heroes/hero_silencer/silencer_ti8_glaive.vpcf"
	local projectile_start_radius = 50
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	-- Extra data
	local slow_duration = self:GetSpecialValueFor("slow_duration")
	local crit_multiplier = self:GetSpecialValueFor("crit_multiplier")

	-- Dinamyc data
	local origin = caster:GetOrigin()
	local projectile_direction = (Vector( pos.x-origin.x, pos.y-origin.y, 0 )):Normalized()

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
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
			}
			ApplyDamage( damage_table )

			-- Add modifier
			unit:AddNewModifier(
				_self.Source, -- player source
				self, -- ability source
				"modifier_juggernaut_ex_special_attack", -- modifier name
				{ duration = slow_duration } -- kv
            )

            local particle_cast = "particles/econ/events/nexon_hero_compendium_2014/blink_dagger_start_nexon_hero_cp_2014.vpcf"
            local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, _self.Source )
            ParticleManager:ReleaseParticleIndex( effect_cast )
            
            FindClearSpaceForUnit( _self.Source, unit:GetOrigin() , true )
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_a(pos)
		end,
	}

	self:PlayEffects_b()
	-- Cast projectile
    Projectiles:CreateProjectile(projectile)
    
    -- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("juggernaut_special_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))
end


--------------------------------------------------------------------------------
-- Effects

-- On Projectile Finish
function juggernaut_ex_special_attack:PlayEffects_a( pos )
	-- Create Sound
	local sound_cast = "Hero_Juggernaut.Attack"
	EmitSoundOnLocationWithCaster( pos, sound_cast, self:GetCaster() )
	
	-- Create Particles
	local particle_cast = "particles/units/heroes/hero_luna/luna_base_attack_impact.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 1, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function juggernaut_ex_special_attack:PlayEffects_b( )
	-- Create Sound
	 local sound_cast = "Hero_Juggernaut.BladeDance"
	EmitSoundOn("Hero_Juggernaut.ArcanaTrigger", caster)	 
	EmitSoundOn( sound_cast, self:GetCaster() )
end
