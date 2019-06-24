axe_basic_attack = class({})
LinkLuaModifier( "modifier_generic_pseudo_cast_point_lua", "abilities/generic/modifier_generic_pseudo_cast_point_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function axe_basic_attack:OnSpellStart()
	self:SetActivated(false)
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = caster:GetAttackAnimationPoint()
	-- Animation and pseudo cast point
	self:Animate()
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point_lua", { duration = cast_point})
end

function axe_basic_attack:OnEndPseudoCastPoint()
	local caster = self:GetCaster()
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

	-- Projectile data
    local projectile_name = ""
	local projectile_start_radius = 250
	local projectile_end_radius = 250--self:GetSpecialValueFor("hitbox")
	local projectile_distance = 10
	local projectile_speed = 100

	-- Dinamyc data
	local origin = caster:GetOrigin()
	local projectile_direction = (Vector( 0, 0, 0 )):Normalized()

	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = origin + Vector(0,0,80),
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
		iVisionRadius = 200,
		iVisionTeamNumber = caster:GetTeam(),
		bFlyingVision = false,
		fVisionTickTime = .1,
		fVisionLingerDuration = 1,
		draw = false,
		fRehitDelay = 1.0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit) 
			-- perform the actual attack
			caster:PerformAttack(
				unit, -- handle hTarget 
				true, -- bool bUseCastAttackOrb, 
				true, -- bool bProcessProcs,
				true, -- bool bSkipCooldown
				false, -- bool bIgnoreInvis
				false, -- bool bUseProjectile
				false, -- bool bFakeAttack
				true -- bool bNeverMiss
			)
			
			self:PlayEffects_a(unit)
			_self.Destroy()
		end,
	}

	self:PlayEffects_b()
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	self:StartCooldown(attack_speed)
	self:SetActivated(true)
end

function axe_basic_attack:OnStopPseudoCastPoint()
	self:SetActivated(true)
end

--------------------------------------------------------------------------------
-- Misc
-- Add mana on attack modifier. Only first time upgraded
function axe_basic_attack:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Projectile Hit enemy
function axe_basic_attack:PlayEffects_a( hTarget )
	local sound_cast = "Hero_PhantomAssassin.Attack"
	EmitSoundOn( sound_cast, hTarget )
end

-- On Spell start
function axe_basic_attack:PlayEffects_b( )
	local caster = self:GetCaster()
	
	-- Create Sound
	local sound_cast = "Hero_Axe.CounterHelix"
	EmitSoundOn( sound_cast, caster )

	-- Create Particles
	local particle_cast = "particles/econ/items/axe/axe_weapon_bloodchaser/axe_attack_blur_counterhelix_bloodchaser_b.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, caster:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function axe_basic_attack:Animate()
	StartAnimation(self:GetCaster(), {duration=1.0, activity=ACT_DOTA_CAST_ABILITY_3, rate=1.0})
end

 
