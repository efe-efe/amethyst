pudge_extra = class({})

function pudge_extra:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	-- Projectile data
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	-- Probable data
    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
    local self_damage = self:GetSpecialValueFor("self_damage")
    local heal = self:GetSpecialValueFor("heal")
	local damage = caster:GetAttackDamage() -- or self:GetSpecialValueFor("ability_damage")

	-- Projectile
	local projectile = {
		EffectName = "particles/pudge_extra_projectile.vpcf",
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

            _self.Source:Heal(heal, _self.Source)

			if _self.Source == caster then 
				caster:GiveManaPercent(mana_gain_pct, unit)
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

    local damage_table = {
        victim = caster,
        attacker = caster,
        damage = self_damage,
        damage_type = DAMAGE_TYPE_PURE,
    }
    ApplyDamage( damage_table )

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

function pudge_extra:PlayEffectsOnCast()
	EmitSoundOn( "Hero_Pudge.AttackSpecial", self:GetCaster() )
end

function pudge_extra:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()

	-- Create Sound
	EmitSoundOnLocationWithCaster( pos, "Hero_Pudge.AttackHookImpact", caster )

	-- Create Particle
	local particle_cast = "particles/econ/items/centaur/centaur_ti9/centaur_double_edge_ti9_bloodspray_src.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
    ParticleManager:SetParticleControl( effect_cast, 2, pos )
    ParticleManager:SetParticleControl( effect_cast, 4, pos )

    ParticleManager:SetParticleControl( effect_cast, 5, pos )

	ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	pudge_extra,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 10, hide_indicator = 1, fixed_range = 1 }
)