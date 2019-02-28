skywrath_mage_ex_second_attack_lua = class({})
LinkLuaModifier( "modifier_skywrath_mage_ex_second_attack_buff_lua", "abilities/heroes/skywrath_mage/skywrath_mage_ex_second_attack_lua/modifier_skywrath_mage_ex_second_attack_buff_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_ex_second_attack_debuff_lua", "abilities/heroes/skywrath_mage/skywrath_mage_ex_second_attack_lua/modifier_skywrath_mage_ex_second_attack_debuff_lua", LUA_MODIFIER_MOTION_NONE )

-- This function is used to change between abilities and ex abilities
--------------------------------------------------------------------------------
function skywrath_mage_ex_second_attack_lua:GetRelatedName()
    return "skywrath_mage_second_attack_lua"
end

--------------------------------------------------------------------------------
-- Set the AOE indicator
function skywrath_mage_ex_second_attack_lua:GetAOERadius()
	return self:GetSpecialValueFor( "hitbox" )
end

--------------------------------------------------------------------------------
-- Ability Start
function skywrath_mage_ex_second_attack_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	
	-- load data
	
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_vision = 0
    local projectile_name = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt.vpcf"
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
    self.buff_duration = self:GetSpecialValueFor("buff_duration")
    self.heal_damage = self:GetSpecialValueFor("heal_damage")
    
	-- logic

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = Vector(origin.x, origin.y, origin.z + 256),
		
		bDeleteOnHit = true,
		
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_BOTH,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		
		EffectName = projectile_name,
		fDistance = projectile_distance,
		fStartRadius = 0,
		fEndRadius = projectile_end_radius,
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
	self:PlayEffects()
end


--------------------------------------------------------------------------------
-- Projectile
function skywrath_mage_ex_second_attack_lua:OnProjectileHit_ExtraData( hTarget, vLocation, extraData )
	if hTarget==nil then return end

	-- load variables
	local caster = self:GetCaster()

	-- Blocked
	local is_blocker = hTarget:FindModifierByName("modifier_generic_projectile_blocker_lua")
	if is_blocker ~= nil then
		if not is_blocker:IsNull() then
			return true
		end
	end

	--If target is ally
    if hTarget:GetTeamNumber() == caster:GetTeamNumber() then
        --speed
        hTarget:AddNewModifier(
            caster, -- player source
            self, -- ability source
            "modifier_skywrath_mage_ex_second_attack_buff_lua", -- modifier name
            { duration = self.buff_duration }
        )

        --Heal
        hTarget:Heal(self.heal_damage, caster)

		self:PlayEffects2(hTarget)
    -- If target is enemy
    else	

        local damage = {
            victim = hTarget,
            attacker = caster,
            damage = self.heal_damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
        }

        ApplyDamage( damage )

        --slow
        hTarget:AddNewModifier(
            caster, -- player source
            self, -- ability source
            "modifier_skywrath_mage_ex_second_attack_debuff_lua", -- modifier name
			{ duration = self.buff_duration }
        )
		self:PlayEffects3(hTarget)
    end

	return true
end

function skywrath_mage_ex_second_attack_lua:PlayEffects()
	-- Get Resources
	local sound_cast = "Hero_SkywrathMage.ArcaneBolt.Cast"

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function skywrath_mage_ex_second_attack_lua:PlayEffects2(hTarget)
	-- Get Resources
	local sound_cast = "Hero_Omniknight.GuardianAngel"

	-- Create Sound
	EmitSoundOn( sound_cast, hTarget )
end

function skywrath_mage_ex_second_attack_lua:PlayEffects3(hTarget)
	-- Get Resources
	local sound_cast = "Hero_SkywrathMage.ArcaneBolt.Impact"

	-- Create Sound
	EmitSoundOn( sound_cast, hTarget )
end


