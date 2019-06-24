
tinker_second_attack = class({})
LinkLuaModifier( "modifier_generic_pseudo_cast_point_lua", "abilities/generic/modifier_generic_pseudo_cast_point_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tinker_second_attack", "abilities/heroes/tinker/tinker_second_attack/modifier_tinker_second_attack", LUA_MODIFIER_MOTION_NONE )

function tinker_second_attack:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function tinker_second_attack:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	self.point = self:GetCursorPosition()
	self.radius = self:GetSpecialValueFor("radius")
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	self:Animate(self.point)
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point_lua", { duration = cast_point })
end


function tinker_second_attack:OnEndPseudoCastPoint()
	local caster = self:GetCaster()

	-- load data
	local damage = self:GetAbilityDamage()	
	local targets = 3
	local projectile_name = "particles/units/heroes/hero_tinker/tinker_missile.vpcf"
	local projectile_speed = 1000--self:GetSpecialValueFor("speed")
	
	-- find enemies
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		self.point,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- create projectile for each enemy
	local info = {
		Source = caster,
		-- Target = target,
		Ability = self,
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = false,
		flExpireTime = GameRules:GetGameTime() + 1.8, 
		ExtraData = {
			damage = damage,
		}
	}
	for i=1,math.min(targets,#enemies) do
		info.Target = enemies[i]
		ProjectileManager:CreateTrackingProjectile( info )
	end

	-- effects
	if #enemies<1 then
		self:PlayEffects_b()
	else
		local sound_cast = "Hero_Tinker.Heat-Seeking_Missile"
		EmitSoundOn( sound_cast, caster )
	end
	
	self:PlayEffects()
end

--------------------------------------------------------------------------------
-- Projectile
function tinker_second_attack:OnProjectileHit_ExtraData( target, location, extraData )
	local mana_gain = self:GetSpecialValueFor("mana_gain")/100
	local stacks_duration = self:GetSpecialValueFor("stacks_duration")
	local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")
	local caster = self:GetCaster()
	local stacks = 0

	if target ~=nil then
		if target:TriggerSpellAbsorb( self ) then return end
		stacks = SafeGetModifierStacks("modifier_tinker_second_attack", target, caster)
	
		-- Apply damage
		local damage = {
			victim = target,
			attacker = caster,
			damage = extraData.damage + (damage_per_stack * stacks),
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self
		}
		ApplyDamage( damage )

		target:AddNewModifier(
			caster,
			self,
			"modifier_tinker_second_attack",
			{ duration = stacks_duration }
		)
		
		-- Give Mana
		local mana_gain_final = caster:GetMaxMana() * mana_gain
		caster:GiveMana(mana_gain_final)    

		-- effects
		self:PlayEffects_a( target )
	end
end

function tinker_second_attack:PlayEffects()

    local particle_cast = "particles/econ/events/darkmoon_2017/darkmoon_calldown_marker_ring.vpcf"
	
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	
	ParticleManager:SetParticleControl( effect_cast, 0, self.point )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( 1, 1, 1 ) )

    ParticleManager:ReleaseParticleIndex( effect_cast )
end
--------------------------------------------------------------------------------
-- Effects
function tinker_second_attack:PlayEffects_a( target )
	local particle_cast = "particles/units/heroes/hero_tinker/tinker_missle_explosion.vpcf"
	local sound_cast = "Hero_Tinker.Heat-Seeking_Missile.Impact"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, target )
end

function tinker_second_attack:PlayEffects_b()
	local particle_cast = "particles/units/heroes/hero_tinker/tinker_missile_dud.vpcf"
	local sound_cast = "Hero_Tinker.Heat-Seeking_Missile_Dud"

	local attach = "attach_attack1"
	if self:GetCaster():ScriptLookupAttachment( "attach_attack3" )~=0 then attach = "attach_attack3" end
	local point = self:GetCaster():GetAttachmentOrigin( self:GetCaster():ScriptLookupAttachment( attach ) )

	-- play particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControlForward( effect_cast, 0, self:GetCaster():GetForwardVector() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, self:GetCaster() )
end

function tinker_second_attack:Animate(point)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local angles = caster:GetAngles()

	local direction = (point - origin)
	local directionAsAngle = VectorToAngles(direction)
	caster:SetAngles(angles.x, directionAsAngle.y, angles.z)
	StartAnimation(caster, {duration=1.0, activity=ACT_DOTA_VICTORY, rate=1.0})
end

