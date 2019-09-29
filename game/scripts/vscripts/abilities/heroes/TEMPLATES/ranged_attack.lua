ability_name = class({})
LinkLuaModifier( "modifier", "abilities/heroes/hero/ability_name/modifier_name", LUA_MODIFIER_MOTION_NONE )

function ability_name:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	--local damage = caster:GetAttackDamage()
	--local damage = self:GetAbilityDamage()

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = ( Vector( point.x - origin.x, point.y - origin.y, 0)):Normalized()

	local projectile = {
		EffectName =		"particles/mod_units/heroes/hero_necrolyte/necrolyte_base_attack_ka.vpcf",
		vSpawnOrigin =		origin + Vector(0,0,80),
		fDistance =			self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = 	self:GetSpecialValueFor("hitbox"),
		Source =			caster,
		vVelocity =			projectile_direction * projectile_speed,
		UnitBehavior =		PROJECTILES_NOTHING,
		TreeBehavior =		PROJECTILES_NOTHING,
		WallBehavior =		PROJECTILES_DESTROY,
		GroundBehavior =	PROJECTILES_NOTHING,
		fGroundOffset =		0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit"  and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit)
			self:PlayEffectsOnImpact(unit, _self.currentPosition)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Graphics & sounds
-- On Projectile Finish
function ability_name:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()
	-- Create Particles
	local particle_cast = "particles/econ/items/necrolyte/necronub_base_attack/necrolyte_base_attack_ka_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function ability_name:PlayEffectsOnCast( )
	local sound_cast = "Hero_Treant.PreAttack"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

-- On Projectile Hit enemy
function ability_name:PlayEffectsOnImpact( hTarget, pos )
	local sound_cast = "Hero_Treant.Attack.Impact"
	EmitSoundOn( sound_cast, hTarget )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	ability_name,
	{ activity = ACT_DOTA_ATTACK, rate = 1.8 },
	{ movement_speed = 30 }
)
--Abilities.BasicAttack( ability_name )