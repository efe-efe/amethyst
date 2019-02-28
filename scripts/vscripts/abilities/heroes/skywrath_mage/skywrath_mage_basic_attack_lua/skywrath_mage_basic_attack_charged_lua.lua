skywrath_mage_basic_attack_charged_lua = class({})
LinkLuaModifier( "modifier_skywrath_mage_basic_attack_charged_timer_lua", "abilities/heroes/skywrath_mage/skywrath_mage_basic_attack_lua/modifier_skywrath_mage_basic_attack_charged_timer_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_silenced_lua", "abilities/generic/modifier_generic_silenced_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_basic_attack_lua", "abilities/heroes/skywrath_mage/skywrath_mage_basic_attack_lua/modifier_skywrath_mage_basic_attack_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_basic_attack_charged_visuals_lua", "abilities/heroes/skywrath_mage/skywrath_mage_basic_attack_lua/modifier_skywrath_mage_basic_attack_charged_visuals_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_basic_attack_charged_debuff_visuals_lua", "abilities/heroes/skywrath_mage/skywrath_mage_basic_attack_lua/modifier_skywrath_mage_basic_attack_charged_debuff_visuals_lua", LUA_MODIFIER_MOTION_NONE )

-- This function is used to change between abilities and ex abilities
--------------------------------------------------------------------------------
function skywrath_mage_basic_attack_charged_lua:GetRelatedName()	
	local caster = self:GetCaster()
	local ability_name = ""

    -- find and destroy visual modifier
	local basic_attack_timer = caster:FindModifierByNameAndCaster( 
		"modifier_skywrath_mage_basic_attack_charged_timer_lua", caster 
    )

    if basic_attack_timer~=nil then
        if not basic_attack_timer:IsNull() then
            ability_name = "skywrath_mage_basic_attack_charged_lua"
        else
            ability_name = "skywrath_mage_ex_basic_attack_lua"
        end
    else
        ability_name = "skywrath_mage_ex_basic_attack_lua"
    end

    return ability_name
end


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
	local projectile_name = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot.vpcf"
	
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
	
	-- Blocked
	local is_blocker = hTarget:FindModifierByName("modifier_generic_projectile_blocker_lua")
	if is_blocker ~= nil then
		if not is_blocker:IsNull() then
			return true
		end
	end

	-- load variables
	local caster = self:GetCaster()

	-- Add damage
	modifier_attack_bonus = caster:AddNewModifier(
		caster, 
		self , 
		"modifier_skywrath_mage_basic_attack_lua", 
		{}
	)

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
	hTarget:AddNewModifier(caster, self , "modifier_skywrath_mage_basic_attack_charged_debuff_visuals_lua", { duration = self.debuff_duration})

	--Remove the extra attack
	if modifier_attack_bonus ~= nil then
		if not modifier_attack_bonus:IsNull() then
			modifier_attack_bonus:Destroy()
		end
	end

	-- Graphics
	self:PlayEffects2(hTarget)	
	

	return true
end

function skywrath_mage_basic_attack_charged_lua:PlayEffects()
	-- Get Resources
	local sound_cast = "Hero_SkywrathMage.ConcussiveShot.Cast"

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function skywrath_mage_basic_attack_charged_lua:PlayEffects2(hTarget)
	-- Get Resources
	local sound_cast = "Hero_SkywrathMage.ConcussiveShot.Target"

	-- Create Sound
	EmitSoundOn( sound_cast, hTarget )
end

-- Add mana on attack modifier and visuals. Only first time upgraded
function skywrath_mage_basic_attack_charged_lua:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Visuals
		caster:AddNewModifier(caster,self,"modifier_skywrath_mage_basic_attack_charged_visuals_lua", {} )
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end

