lich_extra_mobility = class({})
LinkLuaModifier( "modifier_lich_special_attack_thinker", "abilities/heroes/lich/lich_special_attack/modifier_lich_special_attack_thinker", LUA_MODIFIER_MOTION_NONE )

function lich_extra_mobility:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	--local damage = caster:GetAttackDamage()
	--local damage = caster:GetAbilityDamage()
    local ability = caster:FindAbilityByName("lich_special_attack")

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = ( Vector( point.x - origin.x, point.y - origin.y, 0)):Normalized()

	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_templar/hero_templar.vpcf",
		vSpawnOrigin = origin + Vector(0,0,80),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_NOTHING,
        GroundBehavior = PROJECTILES_NOTHING,
        bIsReflectable = false,
        bIsSlowable = false,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit"  and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
        OnUnitHit = function(_self, unit)
            ability:CreateShard(unit:GetOrigin(), nil)
            self:PlayEffectsOnImpact(unit, _self.currentPosition)
		end,
		OnFinish = function(_self, pos)
            self:PlayEffectsOnFinish(pos)
            SafeDestroyModifier("modifier_lich_banish", caster, caster)
            FindClearSpaceForUnit( caster, pos , true )
		end,
	}
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Graphics & sounds
-- On Projectile Finish
function lich_extra_mobility:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()
	-- Create Particles
	local particle_cast = "particles/units/heroes/hero_lich/lich_chain_frost_explode.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    
    ParticleManager:CreateParticle( "particles/econ/events/nexon_hero_compendium_2014/blink_dagger_end_nexon_hero_cp_2014.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
end

function lich_extra_mobility:PlayEffectsOnCast( )
	local sound_cast = "Hero_Lich.ChainFrost"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

-- On Projectile Hit enemy
function lich_extra_mobility:PlayEffectsOnImpact( hTarget, pos )
	local sound_cast = "Hero_Lich.ChainFrostImpact.Creep"
	EmitSoundOn( sound_cast, hTarget )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	lich_extra_mobility,
    nil,
	{ movement_speed = 100, fixed_range = 1 }
)