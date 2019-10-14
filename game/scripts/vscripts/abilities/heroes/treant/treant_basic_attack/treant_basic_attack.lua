treant_basic_attack = class({})
LinkLuaModifier( "modifier_treant_natures_punishment", "abilities/heroes/treant/treant_shared_modifiers/modifier_treant_natures_punishment", LUA_MODIFIER_MOTION_NONE )

function treant_basic_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local attack_damage = caster:GetAttackDamage()

	local reduction_per_hit = self:GetSpecialValueFor("reduction_per_hit_pct")/100
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local heal = self:GetSpecialValueFor("heal")
	local debuff_duration = self:GetSpecialValueFor("debuff_duration")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	
	local projectile_direction = ( Vector( point.x - origin.x, point.y - origin.y, 0)):Normalized()

	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_necrolyte/necrolyte_base_attack_ka.vpcf",
		vSpawnOrigin = origin + Vector(0,0,80),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" end,
		OnUnitHit = function(_self, unit)
			-- Count targets
			local counter = -1
			for k, v in pairs(_self.rehit) do
				counter = counter + 1
			end

			local final_damage = attack_damage * (1 - (counter * reduction_per_hit))
			local final_heal = heal * (1 - (counter * reduction_per_hit))

			-- ENEMIES
			if unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() then
				local damage_table = {
					victim = unit,
					attacker = _self.Source,
					damage = final_damage,
					damage_type = DAMAGE_TYPE_PHYSICAL,
				}
				ApplyDamage( damage_table )

				if unit:IsRealHero() then
					unit:AddNewModifier(_self.Source, self, "modifier_treant_natures_punishment", { duration = debuff_duration })
				end
			end

			-- ALLIES
			if unit:GetTeamNumber() == _self.Source:GetTeamNumber() then
				unit:Heal(final_heal, _self.Source )
			end

			-- Give Mana
			if counter < 1 then
				_self.Source:GiveManaPercent(mana_gain_pct, unit)
			end

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
-- Misc
-- Add mana on attack modifier. Only first time upgraded
function treant_basic_attack:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Projectile Finish
function treant_basic_attack:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()
	-- Create Particles
	local particle_cast = "particles/econ/items/necrolyte/necronub_base_attack/necrolyte_base_attack_ka_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function treant_basic_attack:PlayEffectsOnCast( )
	local sound_cast = "Hero_Treant.PreAttack"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

-- On Projectile Hit enemy
function treant_basic_attack:PlayEffectsOnImpact( hTarget, pos )
	local sound_cast = "Hero_Treant.Attack.Impact"
	EmitSoundOn( sound_cast, hTarget )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	treant_basic_attack,
	{ activity = ACT_DOTA_ATTACK, rate = 1.8 },
	{ movement_speed = 30, hide_indicator = 1 }
)
Abilities.BasicAttack( treant_basic_attack )