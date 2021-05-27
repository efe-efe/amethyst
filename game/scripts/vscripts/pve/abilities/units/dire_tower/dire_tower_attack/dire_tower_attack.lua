dire_tower_attack = class({})
LinkLuaModifier("modifier_dire_tower_attack", "pve/abilities/units/dire_tower/dire_tower_attack/modifier_dire_tower_attack", LUA_MODIFIER_MOTION_NONE)

function dire_tower_attack:GetCastAnimationCustom()		return ACT_DOTA_CUSTOM_TOWER_ATTACK end
function dire_tower_attack:GetPlaybackRateOverride()       return 1.0 end
function dire_tower_attack:GetCastPointSpeed() 			return 0 end
function dire_tower_attack:GetCastPoint()
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
	end
end

function dire_tower_attack:GetIntrinsicModifierName()
    return "modifier_dire_tower_attack"
end

function dire_tower_attack:GetCooldown(iLevel)
	if IsServer() then
        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = (1 / attacks_per_second)
		
		return self.BaseClass.GetCooldown(self, self:GetLevel()) + attack_speed
	end
end

function dire_tower_attack:OnSpellStart()
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
    local projectile_direction = Direction2D(origin, point)

    CustomEntitiesLegacy:ProjectileAttack(caster, {
		bIsBasicAttack = true,
        tProjectile = {
            EffectName = "particles/dire_tower/ti10_dire_tower_attack.vpcf",
            vSpawnOrigin = origin + Vector(0, 0, 200),
            fDistance = self:GetCastRange(Vector(0,0,0), nil),
            fStartRadius = 70,
            Source = caster,
            vVelocity = projectile_direction * 1000,
            UnitBehavior = PROJECTILES_DESTROY,
            TreeBehavior = PROJECTILES_NOTHING,
            WallBehavior = PROJECTILES_DESTROY,
            GroundBehavior = PROJECTILES_NOTHING,
            fGroundOffset = 0,
            UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) end,
            OnUnitHit = function(_self, unit) 
				CustomEntitiesLegacy:AttackWithBaseDamage(caster, {
					hTarget = unit,
					hAbility = self,
				})
            end,
            OnFinish = function(_self, pos)
                EFX("particles/econ/world/towers/ti10_dire_tower/ti10_dire_tower_attack_impact.vpcf", PATTACH_WORLDORIGIN, nil, {
                    cp0 = pos,
                    cp3 = pos,
                })
                EmitSoundOn('Tower.HeroImpact', caster)
            end,
        }
    })

    EmitSoundOn('Tower.HeroImpact', caster)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(dire_tower_attack)