wisp_basic_attack = class ({})
LinkLuaModifier( "modifier_wisp_basic_attack", "abilities/heroes/wisp/wisp_basic_attack/modifier_wisp_basic_attack", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_wisp_basic_attack_link", "abilities/heroes/wisp/wisp_basic_attack/modifier_wisp_basic_attack_link", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_wisp_basic_attack_link_negative", "abilities/heroes/wisp/wisp_basic_attack/modifier_wisp_basic_attack_link_negative", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function wisp_basic_attack:OnSpellStart()
	local caster = self:GetCaster()
	local cast_point = caster:GetAttackAnimationPoint()
	self:SetActivated(false)

	-- Animation and pseudo cast point
	caster:AddNewModifier(
		caster,
		self,
		"modifier_generic_pseudo_cast_point",
		{ duration = cast_point }
	)
end

function wisp_basic_attack:OnEndPseudoCastPoint( pos )
	self:SetActivated(true)
	local caster = self:GetCaster()
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

	-- Projectile Data
	local projectile_name = "particles/mod_units/heroes/hero_wisp/wisp_base_attack.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local modifier_duration_bonus = self:GetSpecialValueFor("modifier_duration_bonus")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	-- Dinamyc data
	local origin = caster:GetOrigin()
	local projectile_direction = (Vector( pos.x-origin.x, pos.y-origin.y, 0 )):Normalized()

	-- Extra data
	local link_duration = self:GetSpecialValueFor("link_duration")
	local heal = self:GetSpecialValueFor("heal")

	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = {unit=caster, attach="attach_attack1", offset=Vector(0,0,0)},
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
		fVisionTickTime = .1,
		fVisionLingerDuration = 1,
		draw = false,
		fRehitDelay = 1.0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" end,
		OnUnitHit = function(_self, unit)
			-- ENEMIES
			if unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() then

				_self.Source:AddNewModifier(
					unit,
					self,
					"modifier_wisp_basic_attack_link_negative",
					{ duration = link_duration }
				)

				-- perform the actual attack
				caster:PerformAttack(
					unit, -- handle hTarget 
					true, -- bool bUseCastAttackOrb, 
					true, -- bool bProcessProcs,
					true, -- bool bSkipCooldown
					false, -- bool bIgnoreInvis
					false, -- bool bUseProjectile
					false, -- bool bFakeAttack
					true -- bool bNeverMiss
				)
				self:PlayEffects_b(_self:GetPosition())
			end
			-- ALLIES
			if unit:GetTeamNumber() == _self.Source:GetTeamNumber() then
				_self.Source:AddNewModifier(
					unit,
					self,
					"modifier_wisp_basic_attack_link",
					{ duration = link_duration }
				)
				unit:Heal( heal, _self.Source )
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_b(pos)
		end,
	}

	self:StartCooldown(attack_speed)
	self:PlayEffects_a()

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
end

function wisp_basic_attack:OnStopPseudoCastPoint()
	self:SetActivated(true)
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function wisp_basic_attack:PlayEffects_a()
	-- Get Resources
	local sound_cast = "Hero_Wisp.Attack"

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

-- On hit wall 
function wisp_basic_attack:PlayEffects_b( pos )
	local caster = self:GetCaster()
	
	-- Cast Sound
	local sound_cast = "Hero_Wisp.ProjectileImpact"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Cast Particle
	local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 1, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	
	ParticleManager:ReleaseParticleIndex( effect_cast )
end


--------------------------------------------------------------------------------
-- Misc
-- Add mana on attack modifier. Only first time upgraded
function wisp_basic_attack:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end