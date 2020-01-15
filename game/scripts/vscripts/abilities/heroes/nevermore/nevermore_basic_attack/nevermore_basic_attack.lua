nevermore_basic_attack = class({})
LinkLuaModifier( "modifier_nevermore_souls", "abilities/heroes/nevermore/nevermore_shared_modifiers/modifier_nevermore_souls", LUA_MODIFIER_MOTION_NONE )

function nevermore_basic_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	-- Projectile data
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	-- Probable data
    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
    local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")
	local attack_damage = caster:GetAttackDamage() -- or self:GetSpecialValueFor("ability_damage")
	local duration = self:GetSpecialValueFor("duration")
	local stacks = SafeGetModifierStacks("modifier_nevermore_souls", caster, caster)

	-- Projectile
	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_nevermore/nevermore_base_attack.vpcf",
		vSpawnOrigin = origin + Vector(0, 0, 96),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			local final_damage = attack_damage + stacks * damage_per_stack

			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = final_damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				ability = self
			}
			ApplyDamage( damage_table )

			if _self.Source == caster and not unit:IsObstacle() then 
				caster:GiveManaPercent(mana_gain_pct, unit)

				caster:AddNewModifier(
					caster,
					self,
					"modifier_nevermore_souls",
					{ duration = duration }
				)

				self:PlayEffectsSoul(unit)
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

function nevermore_basic_attack:PlayEffectsOnCast()
	EmitSoundOn( "Hero_Nevermore.Attack", self:GetCaster() )
end

function nevermore_basic_attack:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()

	-- Create Sound
	EmitSoundOnLocationWithCaster( pos, "Hero_Nevermore.ProjectileImpact", caster )

	-- Create Particle
	local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_base_attack_impact.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 1, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function nevermore_basic_attack:PlayEffectsSoul( hTarget )
	local info = {
		Target = self:GetCaster(),
		Source = hTarget,
		EffectName = "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf",
		iMoveSpeed = 400,
		vSourceLoc= hTarget:GetAbsOrigin(),                -- Optional
		bDodgeable = false,                                -- Optional
		bReplaceExisting = false,                         -- Optional
		flExpireTime = GameRules:GetGameTime() + 5,      -- Optional but recommended
		bProvidesVision = false,                           -- Optional
	}
	ProjectileManager:CreateTrackingProjectile(info)
end

if IsClient() then require("wrappers/abilities") end
Abilities.BasicAttack( nevermore_basic_attack )
Abilities.Initialize( 
	nevermore_basic_attack,
	{ activity = ACT_DOTA_ATTACK, rate = 1.5 },
	{ movement_speed = 10, hide_indicator = 1, fixed_range = 1 }
)


--[[
--------------------------------------------------------------------------------
-- Ability Start
function nevermore_basic_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = caster:GetAttackAnimationPoint()
	
    EmitSoundOn("Hero_Nevermore.PreAttack", caster)

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.6, activity=ACT_DOTA_ATTACK, rate=1.8})
	caster:AddNewModifier(caster, self , "modifier_cast_point_old", { 
		duration = cast_point,
		movement_speed = 10,
		placeholder = 0,
	})
end

function nevermore_basic_attack:OnCastPointEnd( pos )
	local caster = self:GetCaster()

	-- Get Stack
	local modifier = caster:FindModifierByNameAndCaster("modifier_nevermore_ex_special_attack", caster)
	local stacks = 0
	if modifier~=nil then
		stacks = modifier:GetStackCount()
	end
	-- Projectile data
	local projectile_name = "particles/mod_units/heroes/hero_nevermore/nevermore_base_attack.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	if stacks > 0 then
		projectile_name = "particles/mod_units/heroes/hero_nevermore/sf_base_attack_desolation_desolator.vpcf"
	end

	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

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
		bMultipleHits = false,
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
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			-- perform the actual attack
			_self.Source:PerformAttack(
				unit, -- handle hTarget 
				true, -- bool bUseCastAttackOrb, 
				true, -- bool bProcessProcs,
				true, -- bool bSkipCooldown
				false, -- bool bIgnoreInvis
				false, -- bool bUseProjectile
				false, -- bool bFakeAttack
				true -- bool bNeverMiss
			)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_b(pos)
		end,
	}
	
	self:PlayEffects_a()
	Projectiles:CreateProjectile(projectile)
	self:StartCooldown(attack_speed)
end
]]
