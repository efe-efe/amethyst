lich_ex_second_attack = class({})
LinkLuaModifier( "modifier_lich_decay", "abilities/heroes/lich/lich_shared_modifiers/modifier_lich_decay", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lich_frost", "abilities/heroes/lich/lich_shared_modifiers/modifier_lich_frost", LUA_MODIFIER_MOTION_NONE )

function lich_ex_second_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = self:GetAbilityDamage()

	local decay_duration = self:GetSpecialValueFor("decay_duration")
	local frost_duration = self:GetSpecialValueFor("frost_duration")
	local heal = self:GetSpecialValueFor("heal")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = ( Vector( point.x - origin.x, point.y - origin.y, 0)):Normalized()

	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_ancient/apparition_chilling_touch_projectile.vpcf",
		vSpawnOrigin = origin + Vector(0,0,80),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit)

			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}
			ApplyDamage( damage_table )

			unit:AddNewModifier(_self.Source, self, "modifier_lich_decay", { duration = decay_duration })
			unit:AddNewModifier(_self.Source, self, "modifier_lich_frost", { duration = frost_duration })
            _self.Source:Heal(heal, _self.Source)

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
function lich_ex_second_attack:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()
	-- Create Particles
	local particle_cast = "particles/units/heroes/hero_ancient_apparition/ancient_apparition_chilling_touch_projectile_hit.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 1, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function lich_ex_second_attack:PlayEffectsOnCast( )
	local sound_cast = "Hero_Lich.ChainFrost.TI8"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

-- On Projectile Hit enemy
function lich_ex_second_attack:PlayEffectsOnImpact( hTarget, pos )
	local sound_cast = "Hero_Lich.ProjectileImpact"
	EmitSoundOn( sound_cast, hTarget )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	lich_ex_second_attack,
	{ activity = ACT_DOTA_CAST_ABILITY_6, rate = 0.8 },
	{ movement_speed = 10, fixed_range = 1 }
)

