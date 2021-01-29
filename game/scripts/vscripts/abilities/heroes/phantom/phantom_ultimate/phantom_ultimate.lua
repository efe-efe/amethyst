phantom_ultimate = class({})

function phantom_ultimate:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_3 end
function phantom_ultimate:GetPlaybackRateOverride()		return 0.7 end
function phantom_ultimate:GetCastPointSpeed() 			return 0 end

function phantom_ultimate:OnAbilityPhaseStart()
	self:PlayEffectsOnCastPoint()
    return true
end

function phantom_ultimate:OnAbilityPhaseInterrupted()
	self:StopEffectsOnCastPoint()
end

function phantom_ultimate:OnSpellStart()
    local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	
    local max_range = self:GetSpecialValueFor("range")
    local damage = self:GetSpecialValueFor("ability_damage")
    local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")

	local projectile_name = "particles/phantom/phantom_ultimate.vpcf"
	local projectile_start_radius = 70
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local projectile_speed = 4000
	local stacks = CustomEntities:SafeGetModifierStacks(caster, "modifier_phantom_strike_stack")

	CustomEntities:ProjectileAttack(caster, {
		tProjectile  = {
			EffectName = projectile_name,
			vSpawnOrigin = origin + Vector(projectile_direction.x * 30, projectile_direction.y * 30, 96),
			fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
			fStartRadius = projectile_start_radius,
			fEndRadius = projectile_end_radius,
			Source = caster,
			bIsReflectable = false,
			bIsSlowable = false,
			vVelocity = projectile_direction * projectile_speed,
			UnitBehavior = PROJECTILES_DESTROY,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_NOTHING,
			GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntities:Allies(_self.Source, unit) end,
			OnUnitHit = function(_self, unit) 
				local final_damage = damage + (stacks * damage_per_stack)

				local damage_table = {
					victim = unit,
					attacker = _self.Source,
					damage = final_damage,
					damage_type = DAMAGE_TYPE_PHYSICAL,
				}
				
				ApplyDamage(damage_table)

				self:PlayEffectsOnCast(caster)
				FindClearSpaceForUnit(caster, unit:GetOrigin() , true)
				self:PlayEffectsOnImpact(unit)
			end,
			OnFinish = function(_self, pos)
				self:PlayEffectsOnFinish(pos)
			end,
		}
	})

	CustomEntities:SafeDestroyModifier(caster, "modifier_phantom_strike_stack")
	caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK_EVENT, 3.0)
	self:StopEffectsOnCastPoint()
end

function phantom_ultimate:PlayEffectsOnFinish(pos)
    EmitSoundOn("Hero_PhantomAssassin.Strike.End", self:GetCaster())
	EmitSoundOn("Hero_PhantomAssassin.Arcana_Layer", self:GetCaster())
end

function phantom_ultimate:PlayEffectsOnImpact(hTarget)
    EmitSoundOn("Hero_PhantomAssassin.Spatter", hTarget)
    EmitSoundOn("Hero_PhantomAssassin.CoupDeGrace", hTarget)

	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_impact_dagger_arcana.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)
    ParticleManager:SetParticleControl(effect_cast, 1, hTarget:GetOrigin())
    ParticleManager:SetParticleControlForward(effect_cast, 1, hTarget:GetForwardVector())
	ParticleManager:ReleaseParticleIndex(effect_cast)
	
	particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf"
	effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function phantom_ultimate:PlayEffectsOnCast(caster)
    local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, caster:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function phantom_ultimate:PlayEffectsOnCastPoint()
	EmitGlobalSound("phantom_assassin_phass_ability_coupdegrace_03")

	local particle_cast = "particles/econ/items/monkey_king/arcana/water/mk_spring_arcana_water_channel_powertrails.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:ReleaseParticleIndex(effect_cast)

	particle_cast = "particles/econ/items/wisp/wisp_relocate_channel_ti7.vpcf"
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(self.effect_cast, 1, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, 'attach_hitloc', self:GetCaster():GetAbsOrigin(), false);
end

function phantom_ultimate:StopEffectsOnCastPoint()
	if self.effect_cast ~= nil then
		ParticleManager:DestroyParticle(self.effect_cast, false)
		ParticleManager:ReleaseParticleIndex(self.effect_cast)
	end
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(phantom_ultimate)