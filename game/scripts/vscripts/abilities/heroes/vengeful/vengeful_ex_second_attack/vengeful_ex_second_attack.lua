vengeful_ex_second_attack = class({})
vengeful_ex_second_attack_ultimate = class({})

-----------------------------------------------------------
-- Ability Start
function vengeful_ex_second_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local ability = caster:FindAbilityByName("vengeful_ex_second_attack")
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = ability:GetSpecialValueFor("ability_damage")
	local heal = ability:GetSpecialValueFor("heal")
	local name = self:GetAbilityName()

	-- load data
    local mana_gain_pct = ability:GetSpecialValueFor("mana_gain_pct")
	
	-- Dynamic data
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = ability:GetSpecialValueFor("projectile_speed")
	local projectile = {
		EffectName = 			"particles/mod_units/heroes/hero_venge/vs_ti8_immortal_magic_missle.vpcf",
		vSpawnOrigin = 			caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance = 			ability:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius =			ability:GetSpecialValueFor("hitbox"),
		Source = 				caster,
		vVelocity = 			projectile_direction * projectile_speed,
		UnitBehavior = 			PROJECTILES_DESTROY,
		WallBehavior = 			PROJECTILES_NOTHING,
		TreeBehavior = 			PROJECTILES_NOTHING,
		GroundBehavior = 		PROJECTILES_NOTHING,
		fGroundOffset = 		80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit ~= _self.Source and not unit:IsWall() end,
		OnUnitHit = function(_self, unit)
			if _self.Source:IsAlly(unit) then
				unit:Heal(heal, _self.Source )
			else 
				if not unit:IsCountering() then
					_self.Source:Heal(heal, _self.Source )

					local unit_origin = unit:GetOrigin()
					local source_origin = _self.Source:GetOrigin()
					
					FindClearSpaceForUnit( _self.Source, unit_origin , true )
					FindClearSpaceForUnit( unit, source_origin , true )

					if not string.ends(name, "_ultimate") then
						if _self.Source == caster then
							caster:GiveManaPercent(mana_gain_pct, unit)
						end
					end
					self:PlayEffectsSwap(unit)
				end
				
				local damage_table = {
					victim = unit,
					attacker = caster,
					damage = damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
					ability = self,
				}
	
				ApplyDamage( damage_table )
			end

		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

-----------------------------------------------------------
-- Graphics and sounds
function vengeful_ex_second_attack:PlayEffectsOnCast()
    local caster = self:GetCaster()
    -- Sound
    EmitSoundOn("Hero_PhantomAssassin.Strike.Start", caster)

    local effect_cast = ParticleManager:CreateParticle("particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_n_cowlofice.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function vengeful_ex_second_attack:PlayEffectsSwap( hTarget )
    local caster = self:GetCaster()
	local particle_cast = "particles/units/heroes/hero_vengeful/vengeful_nether_swap.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, nil )
	ParticleManager:SetParticleControlEnt( 
		effect_cast, 
		0, 
		caster, 
		PATTACH_POINT_FOLLOW, 
		"attach_hitloc", 
		caster:GetOrigin(), 
		true 
	);
	ParticleManager:SetParticleControlEnt( 
		effect_cast, 
		1, 
		hTarget, 
		PATTACH_POINT_FOLLOW, 
		"attach_hitloc", 
		hTarget:GetOrigin(), 
		true 
    );
    
    ParticleManager:ReleaseParticleIndex( effect_cast )

    EmitSoundOn("Hero_VengefulSpirit.NetherSwap", caster)
    EmitSoundOn("Hero_VengefulSpirit.NetherSwap", hTarget)
end

function vengeful_ex_second_attack:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()

	EmitSoundOnLocationWithCaster( pos, "Hero_VengefulSpirit.MagicMissileImpact", caster )

	-- Create Particles
	local particle_cast = "particles/econ/items/vengeful/vs_ti8_immortal_shoulder/vs_ti8_immortal_magic_missle_end.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

vengeful_ex_second_attack_ultimate.OnCastPointEnd = vengeful_ex_second_attack.OnCastPointEnd
vengeful_ex_second_attack_ultimate.PlayEffectsOnCast = vengeful_ex_second_attack.PlayEffectsOnCast
vengeful_ex_second_attack_ultimate.PlayEffectsSwap = vengeful_ex_second_attack.PlayEffectsSwap
vengeful_ex_second_attack_ultimate.PlayEffectsOnFinish = vengeful_ex_second_attack.PlayEffectsOnFinish

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	vengeful_ex_second_attack,
	{ activity = ACT_DOTA_CAST_ABILITY_2, rate = 0.8 },
	{ movement_speed = 10, fixed_range = 1 }
)
Abilities.Initialize( 
	vengeful_ex_second_attack_ultimate,
	{ activity = ACT_DOTA_CAST_ABILITY_2, rate = 0.8 },
	{ movement_speed = 10, fixed_range = 1 }
)