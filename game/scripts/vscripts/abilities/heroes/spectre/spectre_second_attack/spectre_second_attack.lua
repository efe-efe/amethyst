spectre_second_attack = class({})

--------------------------------------------------------------------------------
-- Ability Start
function spectre_second_attack:OnSpellStart()
	self:PlayEffectsOnPhase()
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_second_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = self:GetAbilityDamage()

	-- load data
	local projectile_name = "particles/mod_units/heroes/hero_bane/bane_projectile.vpcf"
	local hitbox = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	
	-- Dynamic data
	local origin = caster:GetOrigin()
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	local projectile = {
		EffectName = 			projectile_name,
		vSpawnOrigin = 			caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance = 			self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		bUniqueRadius =			hitbox,
		Source = 				caster,
		vVelocity = 			projectile_direction * projectile_speed,
		UnitBehavior = 			PROJECTILES_DESTROY,
		WallBehavior = 			PROJECTILES_DESTROY,
		TreeBehavior = 			PROJECTILES_NOTHING,
		GroundBehavior = 		PROJECTILES_NOTHING,
		fGroundOffset = 		80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage( damage_table )

			caster:GiveManaPercent(mana_gain_pct)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	StartAnimation(caster, {duration=0.2, activity=ACT_DOTA_CAST_ABILITY_1, rate=2.0})
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- Cast
function spectre_second_attack:PlayEffectsOnPhase()
	EmitSoundOn( "Hero_Spectre.Haunt", self:GetCaster())
	-- Get Resources
	local particle_cast = "particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8_swirl_rope.vpcf"

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 15, Vector(128, 32, 108) )
	ParticleManager:SetParticleControl( effect_cast, 16, Vector(1, 0, 0) )

	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- Impact
function spectre_second_attack:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()

	-- Create Sound
    local sound_cast = "Hero_Nevermore.RequiemOfSouls.Damage"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Create Particles
	local particle_cast_a = "particles/econ/items/death_prophet/death_prophet_ti9/death_prophet_silence_ti9_ground_smoke.vpcf"
	local particle_cast_b = "particles/units/heroes/hero_bane/bane_projectile_explosion.vpcf"
	
	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN, caster )
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN, caster )
	
	ParticleManager:SetParticleControl( effect_cast_a, 0, pos )
	ParticleManager:SetParticleControl( effect_cast_b, 0, pos )

	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
end

function spectre_second_attack:PlayEffectsOnCast()
	EmitSoundOn( "Hero_Nevermore.Raze_Flames", self:GetCaster() )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	spectre_second_attack,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 0.25 },
	{ movement_speed = 0, fixed_range = 1}
)