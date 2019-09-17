sniper_ex_second_attack = class({})
LinkLuaModifier( "modifier_generic_rooted_lua", "abilities/generic/modifier_generic_rooted_lua", LUA_MODIFIER_MOTION_NONE )

function sniper_ex_second_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("sniper_second_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function sniper_ex_second_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	
    EmitGlobalSound( "Ability.AssassinateLoad")

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.5, activity=ACT_DOTA_ATTACK, rate=0.8})
	caster:AddNewModifier(
		caster, 
		self, 
		"modifier_generic_pseudo_cast_point", 
		{ 
			duration = cast_point,
			can_walk = 0,
			show_all = 1
		}
	)
end

function sniper_ex_second_attack:OnEndPseudoCastPoint( pos )
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
	local damage = self:GetAbilityDamage()
	local root_duration = self:GetSpecialValueFor("root_duration")
	local mana_gain = self:GetSpecialValueFor("mana_gain")/100

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
		fVisionTickTime = .1,
		fVisionLingerDuration = 1,
		draw = false,
		fRehitDelay = 1.0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit)
			-- Damage
			local damage = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}			

			ApplyDamage( damage )
			-- Stun
			unit:AddNewModifier(_self.Source, self , "modifier_generic_rooted_lua", { duration = root_duration })
	
			self:PlayEffects_c(unit, _self.currentPosition)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_b(pos)
		end,
	}

	
	-- Put CD on the alternate version of the ability
	local alternate_version = caster:FindAbilityByName("sniper_second_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))

	-- Cast projectile
    Projectiles:CreateProjectile(projectile)
	self:PlayEffects_a()
end


--------------------------------------------------------------------------------
-- Graphics & sounds
function sniper_ex_second_attack:PlayEffects_a()
	-- Cast Sound
	local sound_cast = "Ability.Assassinate"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

-- On hit wall 
function sniper_ex_second_attack:PlayEffects_b( pos )
	local caster = self:GetCaster()
	
	-- Cast Sound
	local sound_cast = "Hero_Sniper.AssassinateDamage"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Cast Particle
	local particle_cast = "particles/mod_units/heroes/hero_sniper/sniper_assassinate_impact_sparks.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 1, pos )
	
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function sniper_ex_second_attack:PlayEffects_c( hTarget, pos )
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
