phantom_second_attack = class({})

function phantom_second_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")

	local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	local projectile_speed = 2000
	local projectile_direction = ( Vector( point.x - origin.x, point.y - origin.y, 0)):Normalized()
	local offset = 50
	local stacks = SafeGetModifierStacks("modifier_phantom_strike_stack", caster, caster)

	local projectile = {
		vSpawnOrigin = origin + Vector(projectile_direction.x * offset, projectile_direction.y * offset, 0),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit)
			local counter = 0
			for k, v in pairs(_self.rehit) do counter = counter + 1 end
			if counter > 1 then return end

			local final_damage = damage + ( stacks * damage_per_stack )

			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = final_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage( damage_table )
			
			if _self.Source == caster then
				if stacks == 3 then
					local mobility = caster:FindAbilityByName("phantom_mobility")
					local modifier = caster:FindModifierByName("modifier_phantom_mobility_charges")
					modifier:IncrementStackCount()
					modifier:CalculateCharge()
				end
			end

			SendOverheadEventMessage(nil, OVERHEAD_ALERT_CRITICAL, unit, final_damage, nil )
			caster:GiveManaPercent(mana_gain_pct, unit)

			self:PlayEffectsOnImpact(unit, stacks)
		end,
		OnFinish = function(_self, pos)
			if _self.Source == caster then 
			end
			self:PlayEffectsOnFinish(pos)
		end,
	}

	SafeDestroyModifier("modifier_phantom_strike_stack", caster, caster)

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Effects
function phantom_second_attack:PlayEffectsOnImpact( hTarget, stacks )
	-- Create Sound
	EmitSoundOn( "Hero_PhantomAssassin.Arcana_Layer", hTarget )
	
	-- Create Particles
	local caster = self:GetCaster()
	local offset = 100
	local origin = caster:GetOrigin()
	local direction_normalized = (hTarget:GetOrigin() - origin):Normalized()
	local final_position = origin + Vector(direction_normalized.x * offset, direction_normalized.y * offset, 0)

	local particle_cast = ""

	if stacks == 3 then 
		particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf"
		EmitSoundOn( "Hero_PhantomAssassin.Spatter", hTarget )
	else 
		particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop_r.vpcf"
	end

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
    ParticleManager:SetParticleControl( effect_cast, 1, final_position )
    ParticleManager:SetParticleControlForward( effect_cast, 1, (origin - final_position):Normalized() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function phantom_second_attack:PlayEffectsOnCast()
	EmitSoundOn( "Hero_PhantomAssassin.Attack", self:GetCaster() )
end

-- On Projectile Miss
function phantom_second_attack:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()

	-- Create Particles
	local offset = 100
	local origin = caster:GetOrigin()
	local direction_normalized = (pos - origin):Normalized()
	local final_position = origin + Vector(direction_normalized.x * offset, direction_normalized.y * offset, 0)

	local particle_cast_a = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop_a.vpcf"
	local particle_cast_b = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop_b.vpcf"
	local particle_cast_c = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop_c.vpcf"

	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_POINT, caster )
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_POINT, caster )
	local effect_cast_c = ParticleManager:CreateParticle( particle_cast_c, PATTACH_POINT, caster )

	ParticleManager:SetParticleControl( effect_cast_a, 1, final_position )
	ParticleManager:SetParticleControl( effect_cast_b, 1, final_position )
	ParticleManager:SetParticleControl( effect_cast_c, 1, final_position )

	ParticleManager:SetParticleControlForward( effect_cast_a, 1, (origin - final_position):Normalized() )
	ParticleManager:SetParticleControlForward( effect_cast_b, 1, (origin - final_position):Normalized() )
	ParticleManager:SetParticleControlForward( effect_cast_c, 1, (origin - final_position):Normalized() )

	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
	ParticleManager:ReleaseParticleIndex( effect_cast_c )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	phantom_second_attack,
	{ activity = ACT_DOTA_ATTACK_EVENT, rate = 0.8 },
	{ movement_speed = 80 }
)