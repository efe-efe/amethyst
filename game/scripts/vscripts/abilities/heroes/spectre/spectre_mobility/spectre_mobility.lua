spectre_mobility = class({})
LinkLuaModifier( "modifier_spectre_banish", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_banish", LUA_MODIFIER_MOTION_NONE )

function spectre_mobility:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = CalcPoint(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), min_range)
	local origin = caster:GetOrigin()
	local min_range = self:GetSpecialValueFor( "min_range" )
	local mana_gain_pct = self:GetSpecialValueFor( "mana_gain_pct" )
	self.radius = self:GetSpecialValueFor( "radius" )

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = ( Vector( point.x - origin.x, point.y - origin.y, 0)):Normalized()

	local projectile = {
		EffectName = "particles/econ/items/shadow_demon/sd_ti7_shadow_poison/sd_ti7_shadow_poison_proj.vpcf",
		vSpawnOrigin = origin + Vector(0,0,80),
		fDistance =  (point - origin):Length2D(),
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
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit"  and not _self.Source:IsAlly(unit) end,
		OnFinish = function(_self, pos)
			local enemies = self:GetCaster():FindUnitsInRadius( 
				pos, 
				self.radius, 
				DOTA_UNIT_TARGET_TEAM_ENEMY, 
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER
			)

			local charge = false

			for _, enemy in pairs(enemies) do 
				if not enemy:IsObstacle() then
					charge = true
				end
			end

			-- if at least 1 enemy
			if charge == true then
				-- Give Mana
				local modifier = caster:FindModifierByName("modifier_spectre_basic_attack")
				modifier:IncrementStackCount()
				modifier:StartIntervalThink(-1)
				modifier:CalculateCharge()

				if #enemies == 1 then
					caster:GiveManaPercent(mana_gain_pct, enemies[1])    
				else
					caster:GiveManaPercent(mana_gain_pct)
				end
			end
            self:PlayEffectsOnFinish(pos)
            SafeDestroyModifier("modifier_spectre_banish", caster, caster)
            FindClearSpaceForUnit( caster, pos , true )
		end,
	}
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()

	caster:AddNewModifier(caster, self, "modifier_spectre_banish", {})
end

function spectre_mobility:PlayEffectsOnCast()
    EmitSoundOn( "Hero_Spectre.HauntCast", self:GetCaster() )

	local particle_cast = "particles/econ/items/shadow_demon/sd_ti7_shadow_poison/sd_ti7_shadow_poison_release.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 2, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, Vector(250,0,0) )
    ParticleManager:SetParticleControl( effect_cast, 4, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

--Arrive
function spectre_mobility:PlayEffectsOnFinish( pos )
	-- particles 1
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_death.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	local particle_cast2 = "particles/sweep_generic/sweep_3.vpcf"
	local effect_cast2 = ParticleManager:CreateParticle( particle_cast2, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:ReleaseParticleIndex( effect_cast2 )
	
	local particle_cast_c = "particles/econ/items/dark_willow/dark_willow_ti8_immortal_head/dw_crimson_ti8_immortal_cursed_crownmarker.vpcf"
	local effect_cast_c = ParticleManager:CreateParticle( particle_cast_c, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl( effect_cast_c, 2, Vector(self.radius, 1, 1))
	ParticleManager:ReleaseParticleIndex( effect_cast_c )
    
end

function spectre_mobility:PlayEffectsOnImpact(hTarget)
	EmitSoundOn( "Hero_Spectre.Attack", hTarget )
end


if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	spectre_mobility,
    nil,
	{ movement_speed = 100 }
)
