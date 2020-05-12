
juggernaut_special_attack = class({})

function juggernaut_special_attack:GetCastPoint()
	return self:GetSpecialValueFor("cast_point")
end

function juggernaut_special_attack:OnAbilityPhaseStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_casting", { 
		duration = self:GetCastPoint(), 
		translate = "odachi",
		movement_speed = 10,
	})
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_TAUNT, 2.0)

	return true
end

function juggernaut_special_attack:OnAbilityPhaseInterrupted()
	self:GetCaster():FadeGesture(ACT_DOTA_TAUNT)
	self:GetCaster():RemoveModifierByName("modifier_casting")
end

function juggernaut_special_attack:OnSpellStart()
	self:GetCaster():FadeGesture(ACT_DOTA_TAUNT)

	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")
	local fading_slow_pct = self:GetSpecialValueFor("fading_slow_pct")
	local fading_slow_duration = self:GetSpecialValueFor("fading_slow_duration")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_silencer/silencer_ti8_glaive.vpcf",
		vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,80),
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
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}
			ApplyDamage( damage_table )

			unit:AddNewModifier(_self.Source, self, "modifier_generic_fading_slow", { 
				duration = fading_slow_duration,
				max_slow_pct = fading_slow_pct 
			})

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

function juggernaut_special_attack:PlayEffectsOnFinish( pos )
	EmitSoundOnLocationWithCaster( pos, "Hero_Juggernaut.Attack", self:GetCaster() )
	
	local particle_cast = "particles/econ/items/arc_warden/arc_warden_ti9_immortal/arc_warden_ti9_wraith_impact_start.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function juggernaut_special_attack:PlayEffectsOnCast()
	EmitSoundOn("juggernaut_jug_spawn_02", self:GetCaster())
	EmitSoundOn("Hero_Juggernaut.ArcanaTrigger", self:GetCaster())	
	EmitSoundOn( "Hero_Juggernaut.BladeDance", self:GetCaster() )
end