phoenix_second_attack = class({})
LinkLuaModifier( "modifier_phoenix_second_attack_thinker", "abilities/heroes/phoenix/phoenix_second_attack/modifier_phoenix_second_attack_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phoenix_special_attack_charges", "abilities/heroes/phoenix/phoenix_second_attack/modifier_phoenix_special_attack_charges", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Set AOE indicator
function phoenix_second_attack:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
--Passive Modifier
function phoenix_second_attack:GetIntrinsicModifierName()
	return "modifier_phoenix_special_attack_charges"
end

--------------------------------------------------------------------------------
-- Ability Start
function phoenix_second_attack:OnSpellStart()
	-- Initialize bariables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=1.5, activity=ACT_DOTA_CAST_ABILITY_2, rate=1.5})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { duration = cast_point})
end

function phoenix_second_attack:OnEndPseudoCastPoint( pos )
	local caster = self:GetCaster()

	-- Projectile data
	local projectile_name = "particles/mod_units/heroes/hero_phoenix/phoenix_fire_spirit_launch.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local max_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	-- Dynamic data
	local origin = caster:GetOrigin()
	local projectile_direction = (Vector( pos.x-origin.x, pos.y-origin.y, 0 )):Normalized()

	local modifier = caster:FindModifierByName("modifier_phoenix_special_attack_charges")


    -- determine target position
    local difference = (pos - origin):Length2D()
	if difference > max_distance then
        difference = max_distance
	end
	
	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = origin + Vector(0, 0, 80),
		fDistance = difference,
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
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" end,
		OnUnitHit = function(_self, unit) 
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_b(pos)

			if next(_self.rehit) == nil then			
				CreateModifierThinker(
					_self.Source, --hCaster
					self, --hAbility
					"modifier_phoenix_second_attack_thinker", --modifierName
					{}, --paramTable
					pos, --vOrigin
					_self.Source:GetTeamNumber(), --nTeamNumber
					false --bPhantomBlocker
				)
			end

		end,
	}

	modifier:DecrementStackCount()
	modifier:CalculateCharge()
	
	self:PlayEffects_a()
	Projectiles:CreateProjectile(projectile)
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Projectile starts
function phoenix_second_attack:PlayEffects_a()
	local caster = self:GetCaster()

	-- Create Sound
	local sound_cast = "Hero_Phoenix.FireSpirits.Launch"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

-- On Projectile impacts
function phoenix_second_attack:PlayEffects_b( pos )
	local caster = self:GetCaster()

	-- Create Sound
	local sound_cast = "Hero_Phoenix.FireSpirits.Target"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Cast Particle
	local particle_cast = "particles/mod_units/heroes/hero_phoenix/phoenix_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 1, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function phoenix_second_attack:Animate()
	StartAnimation(self:GetCaster(), {duration=1.5, activity=ACT_DOTA_CAST_ABILITY_2, rate=1.5})
end

function phoenix_second_attack:Rotate(point)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local angles = caster:GetAngles()

	local direction = (point - origin)
	local directionAsAngle = VectorToAngles(direction)
	caster:SetAngles(angles.x, directionAsAngle.y, angles.z)
end