spectre_basic_attack_lua = class ({})
LinkLuaModifier( "modifier_spectre_basic_attack_lua", "abilities/heroes/spectre/spectre_basic_attack_lua/modifier_spectre_basic_attack_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function spectre_basic_attack_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

	-- load data
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox") + 50
	local projectile_vision = 0
    local projectile_name = ""
	self.heal_amount = self:GetSpecialValueFor("heal_amount")

	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

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
	self:StartCooldown(attack_speed)
end

--------------------------------------------------------------------------------
-- Projectile
function spectre_basic_attack_lua:OnProjectileHit_ExtraData( hTarget, vLocation, extraData )
    if hTarget==nil then 
	    self:PlayEffectsMiss()
        return 
    end
	
	-- load variables
	local caster = self:GetCaster()
	local desolate = hTarget:FindModifierByNameAndCaster( "modifier_spectre_desolate_lua", caster )
	local modifier_attack_bonus = nil

	-- If have the debuff, adds extra attack and extends debuff duration
	if desolate ~= nil then
		modifier_attack_bonus = caster:AddNewModifier(caster, self , "modifier_spectre_basic_attack_lua", {})
		caster:Heal( self.heal_amount, self )
		self:PlayEffects2()
	end

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
    caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	
	--Remove the extra attack
	if modifier_attack_bonus ~= nil then
		if not modifier_attack_bonus:IsNull() then
			modifier_attack_bonus:Destroy()
		end
	end

	return true
end

--------------------------------------------------------------------------------
-- Effects
function spectre_basic_attack_lua:PlayEffects(hTarget)
	-- Get Resources
	local sound_cast = "Hero_Spectre.Attack"

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function spectre_basic_attack_lua:PlayEffectsMiss()
	-- Get Resources
	local sound_cast = "Hero_Spectre.PreAttack"

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function spectre_basic_attack_lua:PlayEffects2()
	-- Heal Particles
	local particle_cast = "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_heal_eztzhok.vpcf"

    -- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end