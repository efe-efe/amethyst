puck_second_attack = class({})

function puck_second_attack:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function puck_second_attack:GetPlaybackRateOverride() 	    return 1.0 end
function puck_second_attack:GetCastPointSpeed() 			return 10 end

function puck_second_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local silence_duration = self:GetSpecialValueFor("silence_duration")
	
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local hitbox = self:GetSpecialValueFor("hitbox")

	local projectile = {
		EffectName = "particles/puck/puck_second_attack_projectile.vpcf",
		vSpawnOrigin = origin + Vector(projectile_direction.x * hitbox, projectile_direction.y * hitbox, 96),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius = hitbox,
        Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntities:Allies(_self.Source, unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self,
			}
			ApplyDamage(damage_table)

			if unit:HasModifier("modifier_puck_fairy_dust") then
				unit:AddNewModifier(_self.Source, self, "modifier_generic_silence", { duration = silence_duration })
				unit:RemoveModifierByName("modifier_puck_fairy_dust")

				EmitSoundOn("Hero_Puck.EtherealJaunt", unit)
				local particle_cast = "particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_start_embers.vpcf"
				local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, unit)
				ParticleManager:ReleaseParticleIndex(effect_cast)
			end

			if _self.Source == caster then
				if CustomEntities:ProvidesMana(unit) and self:GetLevel() >=2 then
					caster:FindAbilityByName("puck_special_attack"):EndCooldown()
				end
				if CustomEntities:ProvidesMana(unit) then
					CustomEntities:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
				end
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

    local projectile = Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

function puck_second_attack:PlayEffectsOnFinish(pos)
	
	local particle_cast = "particles/econ/items/puck/puck_merry_wanderer/puck_illusory_orb_explode_merry_wanderer.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function puck_second_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_Oracle.FortunesEnd.Target", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(puck_second_attack)