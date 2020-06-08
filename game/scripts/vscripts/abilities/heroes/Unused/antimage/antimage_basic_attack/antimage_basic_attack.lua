antimage_basic_attack = class({})
-- [ Linking ]


-- [ Overides ]
--------------------------------------------------------------------------------
--Passive Modifier
function antimage_basic_attack:GetIntrinsicModifierName()
	--return "modifier_antimage_basic_attack"
end

--------------------------------------------------------------------------------
-- Ability Start
function antimage_basic_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	
	-- Animation and pseudo cast point
	StartAnimation(caster, {
		duration = cast_point + 0.1, 
		activity = ACT_DOTA_ATTACK_EVENT, 
		rate = 2.0
	})
	caster:AddNewModifier(
		caster, 
		self, 
		"modifier_cast_point_old",
		{ duration = cast_point }
	)
end

function antimage_basic_attack:OnCastPointEnd(point)
	local caster = self:GetCaster()
	local offset = 10

	-- Projectile data
	local projectile_name = ""
	local projectile_start_radius = 50
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = 3000

	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = (1 / attacks_per_second)
	
	-- Dinamyc data
	local origin = caster:GetOrigin()
	local direction_normalized = (point - origin):Normalized()
	local initial_position = origin + Vector(direction_normalized.x * offset, direction_normalized.y * offset, 0)
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()

	--logic
	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = initial_position + Vector(0,0,80),
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
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			self:PlayEffects_e(unit)
		end,
		OnFinish = function(_self, pos)
			if next(_self.rehit) == nil then
				self:PlayEffects_c(pos)
			end
			self:PlayEffects_d(pos)
		end
	}
	
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	self:StartCooldown(attack_speed)
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Projectile Finish (CHARGED)
function antimage_basic_attack:PlayEffects_a(pos)
	local caster = self:GetCaster()
	local offset = 50
	local new_position = caster:GetOrigin() + (pos - caster:GetOrigin()):Normalized() * offset

	-- Create Particles
	local particle_cast = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_crimson_blade_fury_abyssal_start.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(effect_cast, 2, caster:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)

	local particle_cast_b = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta_swipe.vpcf"
	local effect_cast_b = ParticleManager:CreateParticle(particle_cast_b, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast_b, 0, new_position)
	ParticleManager:SetParticleControlForward(effect_cast_b, 0, (pos - caster:GetOrigin()):Normalized())
	ParticleManager:ReleaseParticleIndex(effect_cast_b)
end

-- On Projectile hit enemy
-------------------------
function antimage_basic_attack:PlayEffects_b(hTarget)
	-- Create Sound
	local sound_cast = "Hero_BountyHunter.Jinada"
	EmitSoundOn(sound_cast, hTarget)
   
	-- Create Particles
	local particle_cast_a = "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_heal_eztzhok.vpcf"
	local particle_cast_b = "particles/econ/items/slark/slark_ti6_blade/slark_ti6_blade_essence_shift.vpcf"

	--local effect_cast_a = ParticleManager:CreateParticle(particle_cast_a, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	local effect_cast_b = ParticleManager:CreateParticle(particle_cast_b, PATTACH_POINT, hTarget)
	
	--ParticleManager:ReleaseParticleIndex(effect_cast_a)
	ParticleManager:ReleaseParticleIndex(effect_cast_b)
end
	
-- On Projectile Miss
-------------------------
function antimage_basic_attack:PlayEffects_c(pos)
	-- Create Sound
	local sound_cast = "Hero_Spectre.PreAttack"
	EmitSoundOnLocationWithCaster(pos, sound_cast, self:GetCaster())
end

-- On Projectile finish (NON CHARGED)
function antimage_basic_attack:PlayEffects_d(pos)
	
	local caster = self:GetCaster()
	local offset = 50
	local new_position = caster:GetOrigin() + (pos - caster:GetOrigin()):Normalized() * offset

	-- Create Particles
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_desolate.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControlForward(effect_cast, 0, (pos - caster:GetOrigin()):Normalized())
	ParticleManager:ReleaseParticleIndex(effect_cast)

	local particle_cast_b = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta_swipe.vpcf"
	local effect_cast_b = ParticleManager:CreateParticle(particle_cast_b, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast_b, 0, new_position)
	ParticleManager:SetParticleControlForward(effect_cast_b, 0, (pos - caster:GetOrigin()):Normalized())
	ParticleManager:ReleaseParticleIndex(effect_cast_b)
end

-- On Projectile hit enemy (NON CHARGED)
function antimage_basic_attack:PlayEffects_e(hTarget)
	-- Create Sound
	local sound_cast = "Hero_Spectre.Attack"
	EmitSoundOn(sound_cast, hTarget)
end
