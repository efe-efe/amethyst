tinker_ultimate = class({})
LinkLuaModifier( "modifier_tinker_ultimate", "abilities/heroes/tinker/tinker_ultimate/modifier_tinker_ultimate", LUA_MODIFIER_MOTION_NONE )

function tinker_ultimate:GetAOERadius()
	return self:GetSpecialValueFor( "hitbox" )
end

--------------------------------------------------------------------------------
-- Ability Start
function tinker_ultimate:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- play effects
	local sound_cast = "tinker_tink_laugh_04"
	EmitGlobalSound( sound_cast )

	-- Animation and pseudo cast point
	StartAnimation(caster, { duration=1.0, activity=ACT_DOTA_CAST_ABILITY_3, rate=1.0 })
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
		duration = cast_point,
		movement_speed = 10,
		fixed_range = 1,
		show_all = 1,
	})
end

function tinker_ultimate:OnEndPseudoCastPoint( pos )
	-- load data
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	local debuff_duration = self:GetSpecialValueFor("debuff_duration")
	local damage = self:GetAbilityDamage()
	local damage_bonus = self:GetSpecialValueFor("damage_bonus")

	-- Projectile data
	local projectile_name = ""
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = 8000

	-- Dinamyc data
	local origin = caster:GetOrigin()
	local projectile_direction = (Vector( pos.x-origin.x, pos.y-origin.y, origin.z )):Normalized()

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
		UnitBehavior = PROJECTILES_DESTROY,
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
			local modifier = unit:FindModifierByName( "modifier_tinker_ultimate" )
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
				"modifier_tinker_ultimate",
				{ duration = debuff_duration }
			)

			self:PlayEffects_a(_self.Source, unit)
		end,
		OnFinish = function(_self, pos)
			if next(_self.rehit) == nil then
				self:PlayEffects_b(_self.Source, pos)
			end
		end,
	}
	Projectiles:CreateProjectile(projectile)
end

--------------------------------------------------------------------------------
function tinker_ultimate:PlayEffects_a( source, target )
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
function tinker_ultimate:PlayEffects_b( source, point )
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
