wisp_basic_attack_lua = class ({})
LinkLuaModifier( "modifier_wisp_basic_attack_lua", "abilities/heroes/wisp/wisp_basic_attack_lua/modifier_wisp_basic_attack_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function wisp_basic_attack_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )
	local ex_ultimate_modifier = caster:FindModifierByNameAndCaster( "modifier_wisp_ex_ultimate_lua", caster )
	local projectile_name = "particles/mod_units/heroes/hero_wisp/wisp_base_attack.vpcf"

	-- If have the ex-ultimate, change the visuals
	if ex_ultimate_modifier ~= nil then
		projectile_name="particles/mod_units/heroes/hero_batrider/batrider_base_attack.vpcf"
	end
	
	-- load data
	
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_vision = 0
	
	self.modifier_duration_bonus = self:GetSpecialValueFor("modifier_duration_bonus")
	
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	-- logic

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = Vector(origin.x, origin.y, origin.z + 128),
		
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
function wisp_basic_attack_lua:OnProjectileHit_ExtraData( hTarget, vLocation, extraData )
	if hTarget==nil then return end
	
	-- load variables
	local caster = self:GetCaster()
	local guardian_essence = hTarget:FindModifierByNameAndCaster( "modifier_wisp_guardian_essence_lua", caster )
	local modifier_attack_bonus = nil

	-- If have the debuff, adds extra attack and extends debuff duration
	if guardian_essence ~= nil then
		local new_duration = guardian_essence:GetRemainingTime() + self.modifier_duration_bonus
		guardian_essence:SetDuration(new_duration, true)
		modifier_attack_bonus = caster:AddNewModifier(caster, self , "modifier_wisp_basic_attack_lua", {})
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

	self:PlayEffects2(hTarget)	
	caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})

	--Remove the extra attack
	if modifier_attack_bonus ~= nil then
		if not modifier_attack_bonus:IsNull() then
			modifier_attack_bonus:Destroy()
		end
	end

	return true
end

function wisp_basic_attack_lua:PlayEffects()
	-- Get Resources
	local sound_cast = "Hero_Wisp.Attack"

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function wisp_basic_attack_lua:PlayEffects2(hTarget)
	-- Get Resources
	local sound_cast = "Hero_Wisp.ProjectileImpact"

	-- Create Sound
	EmitSoundOn( sound_cast, hTarget )
end