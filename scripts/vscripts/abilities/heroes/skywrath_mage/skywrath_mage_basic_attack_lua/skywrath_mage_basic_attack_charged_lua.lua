skywrath_mage_basic_attack_charged_lua = class({})
LinkLuaModifier( "modifier_skywrath_mage_basic_attack_charged_timer_lua", "abilities/heroes/skywrath_mage/skywrath_mage_basic_attack_lua/modifier_skywrath_mage_basic_attack_charged_timer_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_silenced_lua", "abilities/generic/modifier_generic_silenced_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function skywrath_mage_basic_attack_charged_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	
	--Attack speed (To put on cooldown the non charged version)
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

    -- load data
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	self.debuff_duration = self:GetSpecialValueFor("debuff_duration")

    local projectile_vision = 0
	local projectile_name = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt.vpcf"
	
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	-- logic

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = Vector(origin.x, origin.y, origin.z + 200),
		
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
    

    --Identify the non charged version, and puts it on cooldown
    local non_charged_version = caster:FindAbilityByName("skywrath_mage_basic_attack_lua")
    non_charged_version:StartCooldown(attack_speed)

    -- Put the non charged ability on the basic attack slot
	caster:SwapAbilities( 
		self:GetAbilityName(),
		"skywrath_mage_basic_attack_lua",
		false,
		true
	)
	
	-- find and destroy visual modifier
	local visual_effect = caster:FindModifierByNameAndCaster( 
		"modifier_skywrath_mage_basic_attack_charged_visuals_lua", caster 
	)
	if visual_effect~=nil then
		if not visual_effect:IsNull() then
			visual_effect:Destroy()
		end
	end

    --Adds the timer that swaps the abilities
	caster:AddNewModifier(caster, self , "modifier_skywrath_mage_basic_attack_charged_timer_lua", {duration = self:GetCooldown(0)})
    
    self:PlayEffects()
end


--------------------------------------------------------------------------------
-- Projectile
function skywrath_mage_basic_attack_charged_lua:OnProjectileHit_ExtraData( hTarget, vLocation, extraData )
	if hTarget==nil then return end
	
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

	--Silence enemy
	hTarget:AddNewModifier(caster, self , "modifier_generic_silenced_lua", { duration = self.debuff_duration})

	-- Graphics
	self:PlayEffects2(hTarget)	
	
	-- Gain mana
	caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})

	return true
end

function skywrath_mage_basic_attack_charged_lua:PlayEffects()
	-- Get Resources
	local sound_cast = "Hero_SkywrathMage.ArcaneBolt.Cast"

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function skywrath_mage_basic_attack_charged_lua:PlayEffects2(hTarget)
	-- Get Resources
	local sound_cast = "Hero_SkywrathMage.ArcaneBolt.Impact"

	-- Create Sound
	EmitSoundOn( sound_cast, hTarget )
end