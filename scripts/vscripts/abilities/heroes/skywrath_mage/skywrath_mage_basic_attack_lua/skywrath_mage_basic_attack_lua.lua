skywrath_mage_basic_attack_lua = class({})

--------------------------------------------------------------------------------
-- Ability Start
function skywrath_mage_basic_attack_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )
	
	-- load data
	
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_vision = 0
    local projectile_name = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_base_attack.vpcf"
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	-- logic

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = Vector(origin.x, origin.y, origin.z + 256),
		
		bDeleteOnHit = true,
		
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		
		EffectName = projectile_name,
		fDistance = projectile_distance,
		fStartRadius = projectile_start_radius,
		fEndRadius =projectile_end_radius,
		vVelocity = projectile_direction * projectile_speed,

		bHasFrontalCone = false,
		bReplaceExisting = false,
		fExpireTime = GameRules:GetGameTime() + 10.0,
		
		bProvidesVision = false,
		iVisionRadius = projectile_vision,
        iVisionTeamNumber = caster:GetTeamNumber(),
        
        ExtraData = {
			
		}
	}
	
	ProjectileManager:CreateLinearProjectile(info)
	self:StartCooldown(attack_speed)
	self:PlayEffects()
end


--------------------------------------------------------------------------------
-- Projectile
function skywrath_mage_basic_attack_lua:OnProjectileHit_ExtraData( hTarget, vLocation, extraData )
	if hTarget==nil then return end
	
	-- Blocked
	local is_blocker = hTarget:FindModifierByName("modifier_generic_projectile_blocker_lua")
	if is_blocker ~= nil then
		if not is_blocker:IsNull() then
			return true
		end
	end
	
	-- load variables
	local caster = self:GetCaster()

	-- perform the actual attack
	caster:PerformAttack(
		hTarget, -- handle hTarget 
		true, -- bool bUseCastAttackOrb, 
		true, -- bool bProcessProcs,
		true, -- bool bSkipCooldown
		false, -- bool bIgnoreInvis
		false, -- bool bUseProjectile
		false, -- bool bFakeAttack
		false -- bool bNeverMiss
	)

	self:PlayEffects2(hTarget)	
	caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})

	return true
end

function skywrath_mage_basic_attack_lua:PlayEffects()
	-- Get Resources
	local sound_cast = "Hero_SkywrathMage.Attack"

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function skywrath_mage_basic_attack_lua:PlayEffects2(hTarget)
	-- Get Resources
	local sound_cast = "Hero_SkywrathMage.ProjectileImpact"

	-- Create Sound
	EmitSoundOn( sound_cast, hTarget )
end

