the_swarm_lua = class ({})
--LinkLuaModifier( "modifier_weaver_basic_attack", "abilities/weaver/weaver_basic_attack/modifier_weaver_basic_attack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function the_swarm_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local wrapped_ability = caster:FindAbilityByName("weaver_the_swarm")
	local distance = self:GetCastRange( point, caster )

	self.mana_gain = self:GetSpecialValueFor("mana_gain")
	self.swarm_damage = self:GetSpecialValueFor("damage")
	
	if wrapped_ability:IsFullyCastable() then
		caster:CastAbilityImmediately(wrapped_ability, caster:GetPlayerOwnerID())
	end

	-- load data
	local projectile_speed = wrapped_ability:GetSpecialValueFor("speed")
	local projectile_distance = distance
	local projectile_start_radius = wrapped_ability:GetSpecialValueFor("radius")
	local projectile_end_radius = wrapped_ability:GetSpecialValueFor("radius")
	local projectile_vision = 0
	
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	-- logic

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetOrigin(),
		
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
	}

	ProjectileManager:CreateLinearProjectile(info)
end


--------------------------------------------------------------------------------
-- Projectile
function the_swarm_lua:OnProjectileHit( hTarget, vLocation )
	if hTarget ~= nil and ( not hTarget:IsInvulnerable() ) and ( not hTarget:TriggerSpellAbsorb( self ) ) then
		EmitSoundOn( "Hero_Weaver.ProjectileImpact", hTarget )
		local caster =  self:GetCaster()
		local damage = {
			victim = hTarget,
			attacker = caster,
			damage = self.swarm_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
		}

		ApplyDamage( damage )

		local mana_gain_final = caster:GetMaxMana() * self.mana_gain
		caster:GiveMana(mana_gain_final)
	end

	return true
end

function the_swarm_lua:GetAssociatedSecondaryAbilities()
	return "weaver_the_swarm"
end