ability_name = class({})
LinkLuaModifier( "modifier_ability_name", "abilities/heroes/hero_name/ability_name/modifier_ability_name", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
--Passive Modifier
function ability_name:GetIntrinsicModifierName()
	return "modifier_ability_name"
end

function ability_name:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	-- Projectile data
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	-- Probable data
    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local damage = caster:GetAttackDamage() -- or self:GetSpecialValueFor("ability_damage")

	-- Projectile
	local projectile = {
		EffectName = "PROJECTILE_PARTICLE_NAME",
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

			
			if _self.Source == caster then 
				caster:GiveManaPercent(mana_gain_pct, unit)
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

function ability_name:PlayEffectsOnCast()
	EmitSoundOn( "CAST_SOUND", self:GetCaster() )
end

function ability_name:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()

	-- Create Sound
	EmitSoundOnLocationWithCaster( pos, "IMPACT_SOUND", caster )

	-- Create Particle
	local particle_cast = "IMPACT_PARTICLE"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	--ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("wrappers/abilities") end
--Abilities.BasicAttack( ability_name )
Abilities.Initialize( 
	ability_name,
	{ activity = ACT_DOTA_RUN, rate = 1.0 },
	{ movement_speed = 10, hide_indicator = 1, fixed_range = 1 }
)