nevermore_special_attack = class({})
LinkLuaModifier( "modifier_nevermore_souls", "abilities/heroes/nevermore/nevermore_shared_modifiers/modifier_nevermore_souls", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nevermore_special_attack_movement", "abilities/heroes/nevermore/nevermore_special_attack/modifier_nevermore_special_attack_movement", LUA_MODIFIER_MOTION_VERTICAL )

function nevermore_special_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("nevermore_ex_special_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_special_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

    EmitSoundOn("Hero_Nevermore.PreAttack", caster)

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.7, activity=ACT_DOTA_RAZE_1, rate=1.0})
	caster:AddNewModifier(caster, self , "modifier_cast_point", { 
		duration = cast_point, 
		can_walk = 0,
		fixed_range = 1,
	})
end


function nevermore_special_attack:OnCastPointEnd( pos )
	local caster = self:GetCaster()

	-- Projectile data
	local projectile_name = "particles/mod_units/heroes/hero_nevermore/invoker_tornado_ti6.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local mana_gain = self:GetSpecialValueFor("mana_gain")/100

	-- Dynamic data
	local origin = caster:GetOrigin()
	local projectile_direction = (Vector( pos.x-origin.x, pos.y-origin.y, 0 )):Normalized()

	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = origin + Vector(0, 0, 80),
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
			-- Give Mana
			local mana_gain_final = caster:GetMaxMana() * mana_gain
			caster:GiveMana(mana_gain_final)

			self:TornadoLogic( _self.Source, unit )
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_b(pos)
		end,
	}
	
	self:PlayEffects_a()
	Projectiles:CreateProjectile(projectile)

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
	local particle_cast = "particles/econ/items/lanaya/lanaya_epit_trap/templar_assassin_epit_trap_explode.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )

	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function nevermore_special_attack:TornadoLogic( hSource, hTarget )
	local damage = self:GetAbilityDamage()
	local duration = self:GetSpecialValueFor("lift_duration")
	local basic_attack = self:GetCaster():FindAbilityByName("nevermore_basic_attack")
	-- Apply damage
	local damageTable = {
		victim = hTarget,
		attacker = hSource,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}
	ApplyDamage( damageTable )
	
	if not hTarget:IsRealHero() then return end

	--Add stack
	hSource:AddNewModifier(
		hSource,
		basic_attack,
		"modifier_nevermore_souls",
		{ duration = basic_attack:GetSpecialValueFor("duration") }
	)
	--Add stack
	hSource:AddNewModifier(
		hSource,
		basic_attack,
		"modifier_nevermore_souls",
		{ duration = basic_attack:GetSpecialValueFor("duration") }
	)

	hTarget:AddNewModifier(
		hSource,
		self,
		"modifier_nevermore_special_attack_movement",
		{ duration = duration }
	)
end
