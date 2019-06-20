tinker_ultimate_lua = class({})
LinkLuaModifier( "modifier_generic_pseudo_cast_point_lua", "abilities/generic/modifier_generic_pseudo_cast_point_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tinker_ultimate_lua", "abilities/heroes/tinker/tinker_ultimate_lua/modifier_tinker_ultimate_lua", LUA_MODIFIER_MOTION_NONE )

function tinker_ultimate_lua:GetAOERadius()
	return self:GetSpecialValueFor( "hitbox" )
end

--------------------------------------------------------------------------------
-- Ability Phase Start
function tinker_ultimate_lua:OnAbilityPhaseStart()
	-- play effects
	local sound_cast = "tinker_tink_laugh_04"
	EmitGlobalSound( sound_cast )
	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function tinker_ultimate_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
    self.point = self:GetCursorPosition()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	self:Animate(self.point)
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point_lua", { duration = cast_point})
end

function tinker_ultimate_lua:OnStopPseudoCastPoint()
	-- Give Mana
	self:GetCaster():GiveMana(self:GetManaCost(-1))    
end

function tinker_ultimate_lua:OnEndPseudoCastPoint()
	-- load data
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	local debuff_duration = self:GetSpecialValueFor("debuff_duration")
	local damage = self:GetSpecialValueFor("damage")
	local damage_bonus = self:GetSpecialValueFor("damage_bonus")
	local mana_gain = self:GetSpecialValueFor("mana_gain")

	-- Projectile data
	local projectile_name = ""
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = 8000

	-- Dinamyc data
	local origin = caster:GetOrigin()
	local projectile_direction = (Vector( self.point.x-origin.x, self.point.y-origin.y, origin.z )):Normalized()

	-- Projectile
	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin =  {unit=caster, attach="attach_attack1", offset=Vector(0,0,0)},
		fDistance = projectile_distance,
		fStartRadius = projectile_start_radius,
		fEndRadius = projectile_end_radius,
		Source = caster,
		fExpireTime = 8.0,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		bMultipleHits = true,
		bIgnoreSource = true,
		TreeBehavior = PROJECTILES_NOTHING,
		bCutTrees = true,
		bTreeFullCollision = false,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		nChangeMax = 1,
		bRecreateOnChange = true,
		bZCheck = false,
		bGroundLock = true,
		bProvidesVision = true,
		iVisionRadius = 200,
		iVisionTeamNumber = caster:GetTeam(),
		bFlyingVision = false,
		bIsSlowable = false,
		fVisionTickTime = .1,
		fVisionLingerDuration = 1,
		draw = false,
		fRehitDelay = 1.0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit) 
			-- Count targets
			local counter = 0
			for k, v in pairs(_self.rehit) do
				counter = counter + 1
			end

			if counter > 0 then return end

			local modifier = unit:FindModifierByName( "modifier_tinker_ultimate_lua" )
			local final_damage = damage

			-- Safe destroying
			if modifier~=nil then
				if not modifier:IsNull() then
					final_damage = damage + damage_bonus
				end
			end

			-- precache damage
			local damage = {
				victim = unit,
				attacker = _self.Source,
				damage = final_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self
			}
			
			ApplyDamage( damage )

			unit:AddNewModifier(
				_self.Source,
				self,
				"modifier_tinker_ultimate_lua",
				{ duration = debuff_duration }
			)

			self:PlayEffects_a(_self.Source, unit)
			_self.Destroy()
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_b(_self.Source, pos)
		end,
	}
	Projectiles:CreateProjectile(projectile)
end

--------------------------------------------------------------------------------
function tinker_ultimate_lua:PlayEffects_a( source, target )
	-- Get Resources
	local particle_cast = "particles/items_fx/dagon.vpcf"
	local sound_cast = "DOTA_Item.Dagon.Activate"
	local sound_target = "DOTA_Item.Dagon5.Target"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, source )

	local attach = "attach_attack1"
	if source:ScriptLookupAttachment( "attach_attack2" )~=0 then attach = "attach_attack2" end
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		source,
		PATTACH_POINT_FOLLOW,
		attach,
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end


--------------------------------------------------------------------------------
function tinker_ultimate_lua:PlayEffects_b( source, point )
	-- Get Resources
	local particle_cast = "particles/items_fx/dagon.vpcf"
	local sound_cast = "DOTA_Item.Dagon.Activate"
	local sound_target = "DOTA_Item.Dagon5.Target"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, source )

	local attach = "attach_attack1"
	if source:ScriptLookupAttachment( "attach_attack2" )~=0 then attach = "attach_attack2" end
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		source,
		PATTACH_POINT_FOLLOW,
		attach,
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1, point )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, source )
	EmitSoundOnLocationWithCaster( point, sound_target, source )
end

function tinker_ultimate_lua:Animate(point)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local angles = caster:GetAngles()

	local direction = (point - origin)
	local directionAsAngle = VectorToAngles(direction)
	caster:SetAngles(angles.x, directionAsAngle.y, angles.z)
	StartAnimation(caster, {duration=1.0, activity=ACT_DOTA_TELEPORT_END, translate="bot", rate=1.0})
end

