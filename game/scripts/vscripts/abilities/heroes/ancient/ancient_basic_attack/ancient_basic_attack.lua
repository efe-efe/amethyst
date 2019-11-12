ancient_basic_attack = class({})
LinkLuaModifier( "modifier_ancient_basic_attack", "abilities/heroes/ancient/ancient_basic_attack/modifier_ancient_basic_attack", LUA_MODIFIER_MOTION_NONE )

function ancient_basic_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	-- Projectile data
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

    -- Projectile
	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_ancient/ancient_apparition_base_attack.vpcf",
		vSpawnOrigin = origin + Vector(0,0, 96),
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
			caster:PerformAttack(
				unit, -- handle hTarget 
				true, -- bool bUseCastAttackOrb, 
				true, -- bool bProcessProcs,
				true, -- bool bSkipCooldown
				false, -- bool bIgnoreInvis
				false, -- bool bUseProjectile
				false, -- bool bFakeAttack
				true -- bool bNeverMiss
			)

			if _self.Source == caster then 
				-- Add modifier
				caster:AddNewModifier(
					caster, -- player source
					self, -- ability source
					"modifier_ancient_basic_attack", -- modifier name
					{  } -- kv
				)

				
				if unit:HasModifier("modifier_ancient_special_attack") then
					local ability = caster:FindAbilityByName("ancient_special_attack") 
					local extra_damage = ability:GetSpecialValueFor("extra_damage")

					local damage_table = {
						victim = unit,
						attacker = caster,
						damage = extra_damage,
						damage_type = DAMAGE_TYPE_PURE,
					}
					ApplyDamage( damage_table )
				end
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Misc
-- Add mana on attack modifier. Only first time upgraded
function ancient_basic_attack:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end

--------------------------------------------------------------------------------
-- Graphics & sounds

function ancient_basic_attack:PlayEffectsOnCast()
	EmitSoundOn( "Hero_Ancient_Apparition.Attack", self:GetCaster() )
end

function ancient_basic_attack:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()

	-- Create Sound
	EmitSoundOnLocationWithCaster( pos, "Hero_Ancient_Apparition.ProjectileImpact", caster )

	-- Create Particle
	local particle_cast = "particles/units/heroes/hero_ancient_apparition/ancient_apparition_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("abilities") end
Abilities.BasicAttack( ancient_basic_attack )
Abilities.Initialize( 
    ancient_basic_attack,
    { activity = ACT_DOTA_ATTACK, rate = 1.3 },
	{ movement_speed = 10, hide_indicator = 1, fixed_range = 1 }
)
