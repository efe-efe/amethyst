lich_ultimate_mobility = class({})
LinkLuaModifier( "modifier_lich_ultimate", "abilities/heroes/lich/lich_ultimate/modifier_lich_ultimate", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lich_decay", "abilities/heroes/lich/lich_shared_modifiers/modifier_lich_decay", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lich_frost", "abilities/heroes/lich/lich_shared_modifiers/modifier_lich_frost", LUA_MODIFIER_MOTION_NONE )

function lich_ultimate_mobility:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
    local damage = self:GetAbilityDamage()
    local ability = caster:FindAbilityByName("lich_ultimate_mobility")
	local ability_b = caster:FindAbilityByName("lich_ultimate")
	local hit_count = ability_b:GetSpecialValueFor("hit_count")
	local decay_duration = self:GetSpecialValueFor("decay_duration")
	local frost_duration = self:GetSpecialValueFor("frost_duration")

    local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = ( Vector( point.x - origin.x, point.y - origin.y, 0)):Normalized()
	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_lich/lich_chain_frost.vpcf",
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
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit"  and not _self.Source:IsAlly(unit) end,
        OnUnitHit = function(_self, unit)
			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_PURE,
			}
            ApplyDamage( damage_table )

			unit:AddNewModifier(_self.Source, self, "modifier_lich_decay", { duration = decay_duration })
			unit:AddNewModifier(_self.Source, self, "modifier_lich_frost", { duration = frost_duration })

            self:PlayEffectsOnImpact(unit, _self.current_position)
		end,
        OnFinish = function(_self, pos)
            self:PlayEffectsOnFinish(pos)
            FindClearSpaceForUnit( caster, pos , true )

            if next(_self.rehit) ~= nil then
                local stacks = SafeGetModifierStacks("modifier_lich_ultimate", caster, caster)

                if stacks < hit_count then 
                    caster:AddNewModifier(caster, self, "modifier_lich_ultimate", {})
                    caster:CastAbilityImmediately(ability, caster:GetEntityIndex())
                else
                    SafeDestroyModifier("modifier_lich_ultimate", caster, caster)
                    SafeDestroyModifier("modifier_lich_banish", caster, caster)
					StopSoundOn( "Hero_Lich.ChainFrostLoop.TI8" , caster)
                end
            else
				SafeDestroyModifier("modifier_lich_ultimate", caster, caster)
                SafeDestroyModifier("modifier_lich_banish", caster, caster)
				StopSoundOn( "Hero_Lich.ChainFrostLoop.TI8" , caster)
			end
		end,
	}
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)

	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Graphics & sounds
-- On Projectile Finish
function lich_ultimate_mobility:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()
	-- Create Particles
	local particle_cast = "particles/econ/items/lich/lich_ti8_immortal_arms/lich_ti8_chain_frost_explode.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    
    ParticleManager:CreateParticle( "particles/econ/events/nexon_hero_compendium_2014/blink_dagger_end_nexon_hero_cp_2014.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
end

function lich_ultimate_mobility:PlayEffectsOnCast( )
	local sound_cast = "Hero_Lich.ChainFrost"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

-- On Projectile Hit enemy
function lich_ultimate_mobility:PlayEffectsOnImpact( hTarget, pos )
	local sound_cast = "Hero_Lich.ChainFrostImpact.Creep"
	EmitSoundOn( sound_cast, hTarget )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	lich_ultimate_mobility,
    nil,
	{ movement_speed = 100, fixed_range = 1, hide_castbar = 1}
)