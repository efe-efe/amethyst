storm_special_attack = class({})
storm_ex_special_attack = class({})
storm_special_attack_recast = class({})

LinkLuaModifier("modifier_storm_special_attack_recast", "abilities/heroes/storm/storm_special_attack/modifier_storm_special_attack_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_storm_special_attack_displacement", "abilities/heroes/storm/storm_special_attack/modifier_storm_special_attack_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_storm_special_attack", "abilities/heroes/storm/storm_special_attack/modifier_storm_special_attack", LUA_MODIFIER_MOTION_NONE)

LinkLuaModifier("modifier_storm_ex_special_attack_displacement", "abilities/heroes/storm/storm_special_attack/modifier_storm_ex_special_attack_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_storm_ex_special_attack", "abilities/heroes/storm/storm_special_attack/modifier_storm_ex_special_attack", LUA_MODIFIER_MOTION_NONE)

function storm_special_attack:GetCastAnimationCustom()		return ACT_DOTA_ATTACK end
function storm_special_attack:GetPlaybackRateOverride() 	    return 1.5 end
function storm_special_attack:GetCastPointSpeed() 			return 10 end
function storm_special_attack:GetAnimationTranslate() 		return "overload" end

function storm_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()

	local projectile = {
		EffectName = "particles/storm/storm_special_attack.vpcf",
		vSpawnOrigin = origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius = self:GetSpecialValueFor("hitbox"),
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
				ability = self,
			}
			ApplyDamage(damage_table)

			if _self.Source == caster then
                caster:GiveManaPercent(mana_gain_pct, unit)
				
				if unit:IsAlive() then
					unit:AddNewModifier(caster, self, 'modifier_storm_special_attack', { duration = 1.0 })
					caster:FindAbilityByName("storm_special_attack_recast"):SetTargetIndex(unit:GetEntityIndex())
					caster:AddNewModifier(caster, self, "modifier_storm_special_attack_recast", { duration = 1.0 })
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

function storm_special_attack:PlayEffectsOnFinish(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.ProjectileImpact", caster)
	
	local particle_cast = "particles/units/heroes/hero_stormspirit/stormspirit_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function storm_special_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_StormSpirit.Attack", self:GetCaster())
end

function storm_special_attack_recast:GetCastAnimationCustom()		return ACT_DOTA_ATTACK end
function storm_special_attack_recast:GetPlaybackRateOverride() 	    return 1.5 end
function storm_special_attack_recast:GetCastPointSpeed() 			return 50 end
function storm_special_attack_recast:GetAnimationTranslate() 		return "overload" end

function storm_special_attack_recast:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()
    local target_entity = EntIndexToHScript(self.target_index)
    local targetOrigin = target_entity:GetAbsOrigin()
	local direction = (origin - targetOrigin):Normalized()
	local distance = (origin - targetOrigin):Length2D()
	local final_point = targetOrigin + direction * distance

	target_entity:RemoveModifierByName('modifier_storm_special_attack')
    target_entity:AddNewModifier(caster, self, 'modifier_storm_special_attack_displacement', {
        x = direction.x,
        y = direction.y,
        originX = final_point.x,
        originY = final_point.y,
        r = distance,
        speed = distance/1.0,
        peak = 1,
    })

    EmitSoundOn('Hero_StormSpirit.ElectricVortexCast', caster)
end

function storm_special_attack_recast:SetTargetIndex(target_index)
    self.target_index = target_index
end


function storm_ex_special_attack:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_4 end
function storm_ex_special_attack:GetPlaybackRateOverride()      return 1.0 end
function storm_ex_special_attack:GetCastPointSpeed() 			return 0 end

function storm_ex_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
    local min_range = self:GetSpecialValueFor("min_range")
    local speed = self:GetSpecialValueFor("speed")
	local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), min_range)

	local direction = (point - origin):Normalized()
    local distance = (point - origin):Length2D()

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_storm_ex_special_attack_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = speed,
            peak = 1,
        }
    )

    local random_number = RandomInt(1, 32)
    local sound_name = 'stormspirit_ss_ability_lightning_'
    if random_number < 10 then
        sound_name = sound_name .. '0' .. random_number
    else 
        sound_name = sound_name ..random_number 
    end
    EmitSoundOn(sound_name, caster)
    self:EndCooldown()
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(storm_special_attack)
Abilities.Castpoint(storm_special_attack_recast)
Abilities.Castpoint(storm_ex_special_attack)