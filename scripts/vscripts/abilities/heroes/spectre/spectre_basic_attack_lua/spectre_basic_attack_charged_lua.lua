spectre_basic_attack_charged_lua = class({})

LinkLuaModifier( "modifier_spectre_basic_attack_charged_lua", "abilities/heroes/spectre/spectre_basic_attack_lua/modifier_spectre_basic_attack_charged_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_basic_attack_charged_timer_lua", "abilities/heroes/spectre/spectre_basic_attack_lua/modifier_spectre_basic_attack_charged_timer_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_basic_attack_charged_visuals_lua", "abilities/heroes/spectre/spectre_basic_attack_lua/modifier_spectre_basic_attack_charged_visuals_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_desolate_lua", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_desolate_lua/modifier_spectre_desolate_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_silenced_lua", "abilities/generic/modifier_generic_silenced_lua", LUA_MODIFIER_MOTION_NONE )

function spectre_basic_attack_charged_lua:GetAOERadius()
	return self:GetSpecialValueFor( "hitbox" )
end
--------------------------------------------------------------------------------
-- Ability Start
function spectre_basic_attack_charged_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	self.point = self:GetCursorPosition()

	--Attack speed (To put on cooldown the non charged version)
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

	-- load data
	self.debuff_duration = self:GetSpecialValueFor("debuff_duration")
	self.heal_amount = self:GetSpecialValueFor("heal_amount")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox") + 10
	local projectile_vision = 0
    local projectile_name = ""

	local projectile_direction = (Vector( self.point.x-origin.x, self.point.y-origin.y, 0 )):Normalized()

	-- logic

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = origin,
		
		bDeleteOnHit = true,
		
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		
		EffectName = projectile_name,
		fDistance = projectile_distance,
		fStartRadius = projectile_start_radius,
		fEndRadius =projectile_end_radius,
		vVelocity = projectile_direction * projectile_speed,

		bHasFrontalCone = true,
		bReplaceExisting = false,
		fExpireTime = GameRules:GetGameTime() + 10.0,
		
		bProvidesVision = false,
		iVisionRadius = projectile_vision,
        iVisionTeamNumber = caster:GetTeamNumber(),
        
        ExtraData = {
			
		}
	}
	
    ProjectileManager:CreateLinearProjectile(info)
    
    --Identify the non charged version, and puts it on cooldown
    local non_charged_version = caster:FindAbilityByName("spectre_basic_attack_lua")
    non_charged_version:StartCooldown(attack_speed)

    -- Put the non charged ability on the basic attack slot
	caster:SwapAbilities( 
		self:GetAbilityName(),
		"spectre_basic_attack_lua",
		false,
		true
	)
	
	-- find and destroy visual modifier
	local visual_effect = caster:FindModifierByNameAndCaster( 
		"modifier_spectre_basic_attack_charged_visuals_lua", caster 
	)

	if visual_effect~=nil then
		if not visual_effect:IsNull() then
			visual_effect:Destroy()
		end
	end

    --Adds the timer that swaps the abilities
	caster:AddNewModifier(caster, self , "modifier_spectre_basic_attack_charged_timer_lua", {duration = self:GetCooldown(0)})

	--Adds the damage bonus modifier
	self.modifier_attack_bonus = caster:AddNewModifier(caster, self , "modifier_spectre_basic_attack_charged_lua", {})

	self:PlayEffectsOnCast()
end


--------------------------------------------------------------------------------
-- Projectile
function spectre_basic_attack_charged_lua:OnProjectileHit_ExtraData( hTarget, vLocation, extraData )
	-- load variables
	local caster = self:GetCaster()

	if hTarget==nil then 
		--Remove the extra attack
		if self.modifier_attack_bonus ~= nil then
			if not self.modifier_attack_bonus:IsNull() then
			self.modifier_attack_bonus:Destroy()
			end
		end
	    self:PlayEffectsMiss()
        return 
	end
	
	-- Blocked
	local is_blocker = hTarget:FindModifierByName("modifier_generic_projectile_blocker_lua")
	if is_blocker ~= nil then
		if not is_blocker:IsNull() then
			return true
		end
	end

	-- Slowed

	-- Hasted
	
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

	self:PlayEffects(hTarget)
    self:GetCaster():Heal( self.heal_amount, self )
    
	hTarget:AddNewModifier(caster, self , "modifier_generic_silenced_lua", { duration = self.debuff_duration})
	hTarget:AddNewModifier(caster, self , "modifier_spectre_desolate_lua", {})
	
	--Remove the extra attack
	if self.modifier_attack_bonus ~= nil then
		if not self.modifier_attack_bonus:IsNull() then
			self.modifier_attack_bonus:Destroy()
		end
	end
    return true
end

--------------------------------------------------------------------------------
-- Effects

-- Self glow on cast
-------------------------
function spectre_basic_attack_charged_lua:PlayEffectsOnCast()
    -- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- Hit attack effects
-------------------------
function spectre_basic_attack_charged_lua:PlayEffects(hTarget)
	-- Create Sound
	local sound_cast = "Hero_BountyHunter.Jinada"
	EmitSoundOn( sound_cast, self:GetCaster() )

	-- Load Particles
	local particle_cast_a = "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_heal_eztzhok.vpcf"
	local particle_cast_b = "particles/econ/items/slark/slark_ti6_blade/slark_ti6_blade_essence_shift.vpcf"
	local particle_cast_c = "particles/econ/items/spectre/spectre_transversant_soul/spectre_ti7_crimson_spectral_dagger_path_owner_glow.vpcf"

    -- Create Particles
	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_POINT, hTarget )
	local effect_cast_c = ParticleManager:CreateParticle( particle_cast_c, PATTACH_ABSORIGIN_FOLLOW, hTarget )
	
	-- Release Particles
	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
	ParticleManager:ReleaseParticleIndex( effect_cast_c )
end
	
--Miss attack effects
-------------------------
function spectre_basic_attack_charged_lua:PlayEffectsMiss()
	-- Create Sound
	local sound_cast = "Hero_Spectre.PreAttack"
	EmitSoundOn( sound_cast, self:GetCaster() )

	-- Create Particles
	local particle_cast = "particles/econ/items/spectre/spectre_weapon_diffusal/spectre_desolate_diffusal.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, self.point)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- Add mana on attack modifier and visuals. Only first time upgraded
function spectre_basic_attack_charged_lua:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		
		--Visuals
		caster:AddNewModifier( caster, self, "modifier_spectre_basic_attack_charged_visuals_lua", {} )
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end