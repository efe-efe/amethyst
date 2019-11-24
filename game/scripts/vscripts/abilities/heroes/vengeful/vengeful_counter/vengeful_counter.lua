vengeful_counter = class({})
vengeful_counter_ultimate = class({})
LinkLuaModifier("modifier_vengeful_counter", "abilities/heroes/vengeful/vengeful_counter/modifier_vengeful_counter", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Ability Start
function vengeful_counter:OnCastPointEnd()
	local caster = self:GetCaster()
	local ability = caster:FindAbilityByName("vengeful_counter")
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = ability:GetSpecialValueFor("ability_damage")
	local counter = 0

	-- load data
    local mana_gain_pct = ability:GetSpecialValueFor("mana_gain_pct")
	local backwards_damage = ability:GetSpecialValueFor("backwards_damage")
	local duration = ability:GetSpecialValueFor("duration")
	local ms_buff_per_stack_pct = ability:GetSpecialValueFor("ms_buff_per_stack_pct")
	local targets = 0
	
	-- Dynamic data
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = ability:GetSpecialValueFor("projectile_speed")

	local projectile_forward = {
		EffectName = 			"particles/units/heroes/hero_vengeful/vengeful_wave_of_terror.vpcf",
		vSpawnOrigin = 			caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance = 			ability:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius =			ability:GetSpecialValueFor("hitbox"),
		Source = 				caster,
		vVelocity = 			projectile_direction * projectile_speed,
		UnitBehavior = 			PROJECTILES_NOTHING,
		WallBehavior = 			PROJECTILES_NOTHING,
		TreeBehavior = 			PROJECTILES_NOTHING,
        GroundBehavior = 		PROJECTILES_NOTHING,
        bIsReflectable =        false,
        bIsSlowable =           false,
		fGroundOffset = 		80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage,
				ability = self,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage( damage_table )

			if not unit:IsObstacle() then
				targets = targets + 1
			end

			if not string.ends(self:GetAbilityName(), "_ultimate") then
				if _self.Source == caster then
					caster:GiveManaPercent(mana_gain_pct, unit)
				end
			end
			self:PlayEffectsOnImpact(unit)
		end,
		OnFinish = function(_self, pos)
			local initial_direction_to_owner = (caster:GetOrigin() - _self.currentPosition):Normalized()

			local projectile_backwards = {
				--EffectName = 			"particles/units/heroes/hero_vengeful/vengeful_wave_of_terror.vpcf",
				vSpawnOrigin = 			pos,
				fDistance = 			99999,
				fStartRadius =			ability:GetSpecialValueFor("hitbox"),
				fEndRadius =			0,
				Source = 				caster,
				vVelocity = 			initial_direction_to_owner * projectile_speed,
				UnitBehavior = 			PROJECTILES_NOTHING,
				WallBehavior = 			PROJECTILES_NOTHING,
				TreeBehavior = 			PROJECTILES_NOTHING,
				GroundBehavior = 		PROJECTILES_NOTHING,
				bIsReflectable =        false,
				bIsSlowable =           false,
				bIgnoreSource = 		false,
				fGroundOffset = 		80,
				UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit"end,
				OnUnitHit = function(_self, unit)
					if unit == caster then
						self:PlayEffectsOnImpact(unit)
						self:PlayEffectsOnImpactCaster(unit)
						self:StopEffectsProjectile()
						if targets > 0 then
							_self.Source:AddNewModifier(_self.Source, self, "modifier_vengeful_counter", { duration = duration, stacks = targets * ms_buff_per_stack_pct })
						end
						_self:Destroy()
						return
					else
						if not unit:IsObstacle() then
							targets = targets + 1
						end
					end

					if _self.Source:IsAlly(unit) then return end
				
					self:PlayEffectsOnImpact(unit)
					local damage_table_backwards = {
						victim = unit,
						attacker = caster,
						damage = backwards_damage,
						damage_type = DAMAGE_TYPE_PURE,
						ability = self,
					}
		
					ApplyDamage( damage_table_backwards )
		
					if not string.ends(self:GetAbilityName(), "_ultimate") then
						if _self.Source == caster then
							caster:GiveManaPercent(mana_gain_pct, unit)
						end
					end

				end,
				OnFinish = function(_self, pos)
					self:PlayEffectsOnFinish(pos)
				end,
				OnThinkBegin = function(_self)	
					counter = counter + 1
					local direction_to_owner = (caster:GetOrigin() - _self.currentPosition ):Normalized()
					--[[DebugDrawLine_vCol(
						_self.currentPosition, 
						(_self.currentPosition + direction_to_owner * (caster:GetOrigin() - _self.currentPosition):Length2D()), 
						Vector(255,255,255), 
						true, 
						0.1
					)]]
					_self.currentVelocity = direction_to_owner * projectile_speed / 30

					if counter == 2 then
						self:StopEffectsProjectile()
						self:PlayEffectsProjectile(_self.currentPosition, _self.currentVelocity)
						counter = 0
					end
				end
			}
            Projectiles:CreateProjectile(projectile_backwards)
			self:PlayEffectsOnFinish(pos, _self.Source)
			self:PlayEffectsOnReCast(_self.Source)
		end,
    }

	-- Cast projectile
	Projectiles:CreateProjectile(projectile_forward)
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Graphics & sounds

function vengeful_counter:PlayEffectsOnFinish( pos, caster )
	-- Create Particles
	local particle_cast = "particles/meteor_hammer_spell_ground_impact.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:SetParticleControl( effect_cast, 4, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function vengeful_counter:PlayEffectsOnCast()
	EmitSoundOn( "Hero_VengefulSpirit.WaveOfTerror", self:GetCaster() )
end

function vengeful_counter:PlayEffectsOnReCast(caster)
	EmitSoundOn( "Hero_VengefulSpirit.Death", caster )
end


function vengeful_counter:PlayEffectsOnImpactCaster(caster)
	local particle_cast = "particles/items4_fx/meteor_hammer_spell_impact_ember.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, caster:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 3, caster:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 4, caster:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function vengeful_counter:PlayEffectsOnImpact(hTarget)
	local particle_cast = "particles/units/heroes/hero_vengeful/vengeful_wave_of_terror_recipient.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, hTarget )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function vengeful_counter:PlayEffectsProjectile(pos, vel)
	local particle_cast = "particles/units/heroes/hero_vengeful/vengeful_wave_of_terror_orig.vpcf"
	self.effect_cast_projectile = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( self.effect_cast_projectile, 0, pos )
	ParticleManager:SetParticleControl( self.effect_cast_projectile, 1, vel )
	ParticleManager:SetParticleControlForward(self.effect_cast_projectile, 0, vel:Normalized())

end

function vengeful_counter:StopEffectsProjectile()
	if self.effect_cast_projectile then
		ParticleManager:DestroyParticle(self.effect_cast_projectile, false)
		ParticleManager:ReleaseParticleIndex( self.effect_cast_projectile )
	end
end

vengeful_counter_ultimate.OnCastPointEnd = vengeful_counter.OnCastPointEnd
vengeful_counter_ultimate.PlayEffectsOnFinish = vengeful_counter.PlayEffectsOnFinish
vengeful_counter_ultimate.PlayEffectsOnCast = vengeful_counter.PlayEffectsOnCast
vengeful_counter_ultimate.PlayEffectsProjectile = vengeful_counter.PlayEffectsProjectile
vengeful_counter_ultimate.StopEffectsProjectile = vengeful_counter.StopEffectsProjectile
vengeful_counter_ultimate.PlayEffectsOnReCast = vengeful_counter.PlayEffectsOnReCast
vengeful_counter_ultimate.PlayEffectsOnImpact = vengeful_counter.PlayEffectsOnImpact
vengeful_counter_ultimate.PlayEffectsOnImpactCaster = vengeful_counter.PlayEffectsOnImpactCaster

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	vengeful_counter,
	{ activity = ACT_DOTA_CAST_ABILITY_2, rate = 1.0 },
	{ movement_speed = 0, fixed_range = 1}
)
Abilities.Initialize( 
	vengeful_counter_ultimate,
	{ activity = ACT_DOTA_CAST_ABILITY_2, rate = 1.0 },
	{ movement_speed = 0, fixed_range = 1}
)

