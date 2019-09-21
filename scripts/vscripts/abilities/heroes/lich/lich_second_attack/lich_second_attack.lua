lich_second_attack = class({})
LinkLuaModifier( "modifier_lich_judgement", "abilities/heroes/lich/lich_shared_modifiers/modifier_lich_judgement", LUA_MODIFIER_MOTION_NONE )

function lich_second_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = self:GetAbilityDamage()

	local judgement_duration = self:GetSpecialValueFor("judgement_duration")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")/100
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = ( Vector( point.x - origin.x, point.y - origin.y, 0)):Normalized()

	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_venge/vengeful_magic_missle.vpcf",
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
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit)

			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}
			ApplyDamage( damage_table )

			unit:AddNewModifier(_self.Source, self, "modifier_lich_judgement", { duration = judgement_duration })
			
			local mana_gain_final = _self.Source:GetMaxMana() * mana_gain_pct
			_self.Source:GiveMana(mana_gain_final)

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
function lich_second_attack:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()
	-- Create Particles
	local particle_cast = "particles/units/heroes/hero_ancient_apparition/ancient_apparition_chilling_touch_projectile_hit.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 1, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function lich_second_attack:PlayEffectsOnCast( )
	local sound_cast = "Hero_Lich.SinisterGaze.Target"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

-- On Projectile Hit enemy
function lich_second_attack:PlayEffectsOnImpact( hTarget, pos )
	local sound_cast = "Hero_Lich.ProjectileImpact"
	EmitSoundOn( sound_cast, hTarget )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	lich_second_attack,
	{ activity = ACT_DOTA_CAST_ABILITY_6, rate = 0.8 },
	{ movement_speed = 10, fixed_range = 1 }
)