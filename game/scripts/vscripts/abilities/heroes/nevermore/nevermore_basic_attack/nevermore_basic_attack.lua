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

	local ability = caster:FindAbilityByName("nevermore_ex_basic_attack")
	local fading_slow_pct = ability:GetSpecialValueFor("fading_slow_pct")
	local fading_slow_duration = ability:GetSpecialValueFor("fading_slow_duration")

	local damage = caster:GetAverageTrueAttackDamage(caster) -- or self:GetSpecialValueFor("ability_damage")
	local particle = "particles/mod_units/heroes/hero_nevermore/nevermore_base_attack.vpcf"
	local slow = false

	if caster:HasModifier("modifier_nevermore_ex_basic_attack") then
		particle = "particles/mod_units/heroes/hero_nevermore/sf_base_attack_desolation_desolator.vpcf"
		slow = true 
	end
	
	-- Projectile
	local projectile = {
		EffectName = particle,
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
			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				ability = self
			}
			ApplyDamage( damage_table )

			if slow then
				unit:AddNewModifier(_self.Source, self, "modifier_generic_fading_slow_new", { 
					duration = fading_slow_duration,
					max_slow_pct = fading_slow_pct
				})
			end

			if _self.Source == caster and not unit:IsObstacle() then 
				caster:GiveManaPercent(mana_gain_pct, unit)

				caster:AddNewModifier(
					caster,
					self,
					"modifier_nevermore_souls",
					{}
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
