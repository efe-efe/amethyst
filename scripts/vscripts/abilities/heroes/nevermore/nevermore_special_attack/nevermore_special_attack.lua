nevermore_special_attack = class({})
LinkLuaModifier( "modifier_nevermore_souls", "abilities/heroes/nevermore/nevermore_shared_modifiers/modifier_nevermore_souls", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nevermore_special_attack_movement", "abilities/heroes/nevermore/nevermore_special_attack/modifier_nevermore_special_attack_movement", LUA_MODIFIER_MOTION_VERTICAL )
LinkLuaModifier( "modifier_generic_pseudo_cast_point_lua", "abilities/generic/modifier_generic_pseudo_cast_point_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_special_attack:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()


end

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_special_attack:OnSpellStart()
	-- Initialize bariables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	self.point = self:GetCursorPosition()

    EmitSoundOn("Hero_Nevermore.PreAttack", caster)

	-- Animation and pseudo cast point
	self:Animate()
	self:Rotate(self.point)
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point_lua", { duration = cast_point })
end


function nevermore_special_attack:OnEndPseudoCastPoint()
	local caster = self:GetCaster()

	-- Projectile data
	local projectile_name = "particles/mod_units/heroes/hero_nevermore/invoker_tornado_ti6.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local mana_gain = self:GetSpecialValueFor("mana_gain")

	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

	-- Dynamic data
	local origin = caster:GetOrigin()
	local projectile_direction = (Vector( self.point.x-origin.x, self.point.y-origin.y, 0 )):Normalized()

	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = origin + Vector(0, 0, 80),
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
			
			-- Give Mana
			local mana_gain_final = caster:GetMaxMana() * mana_gain
			caster:GiveMana(mana_gain_final)

			self:TornadoLogic( _self.Source, unit )
			
			--Effects
			self:PlayEffects_b(_self:GetPosition())
			_self.Destroy()
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_b(pos)
		end,
	}
	
	self:PlayEffects_a()
	Projectiles:CreateProjectile(projectile)
	self:StartCooldown(attack_speed)

	-- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("nevermore_ex_special_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Projectile starts
function nevermore_special_attack:PlayEffects_a()
	-- Create Sound
	local sound_cast = "Hero_Nevermore.Attack"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

-- On Projectile impacts
function nevermore_special_attack:PlayEffects_b( pos )
	local caster = self:GetCaster()

	-- Create Sound
	local sound_cast = "Hero_Nevermore.Shadowraze.Arcana"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Cast Particle
	local particle_cast = "particles/econ/items/shadow_fiend/sf_desolation/sf_base_attack_desolation_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )

	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function nevermore_special_attack:TornadoLogic( hSource, hTarget )
	local damage = self:GetSpecialValueFor("damage")
	local duration = 3.0 -- self:GetSpecialValueFor("duration")

	-- Apply damage
	local damageTable = {
		victim = hTarget,
		attacker = hSource,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}
	ApplyDamage( damageTable )

	--Add stack
	hSource:AddNewModifier(
		hSource,
		self:GetCaster():FindAbilityByName("nevermore_basic_attack"),
		"modifier_nevermore_souls",
		{ duration = 5.0 }
	)
	--Add stack
	caster:AddNewModifier(
		hSource,
		self:GetCaster():FindAbilityByName("nevermore_basic_attack"),
		"modifier_nevermore_souls",
		{ duration = 5.0 }
	)

	hTarget:AddNewModifier(
		hSource,
		self,
		"modifier_nevermore_special_attack_movement",
		{ duration = duration }
	)
end

function nevermore_special_attack:Animate()
	StartAnimation(self:GetCaster(), {duration=2.0, activity=ACT_DOTA_RAZE_1, rate=0.8})
end

function nevermore_special_attack:Rotate(point)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local angles = caster:GetAngles()

	local direction = (point - origin)
	local directionAsAngle = VectorToAngles(direction)
	caster:SetAngles(angles.x, directionAsAngle.y, angles.z)
end
