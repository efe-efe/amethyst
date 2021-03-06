queen_attack = class({})
LinkLuaModifier("modifier_queen_attack", "pve/abilities/heroes/queen/queen_attack/modifier_queen_attack", LUA_MODIFIER_MOTION_NONE)

function queen_attack:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function queen_attack:GetPlaybackRateOverride()    return 0.9 end
function queen_attack:GetCastPointSpeed() 			return 0 end

function queen_attack:OnSpellStart()
    local point = self:GetCursorPosition()
    self:LaunchProjectile(point, 1500, self:GetCastRange(Vector(0,0,0), nil), 20)
    EmitSoundOn("Hero_QueenOfPain.ShadowStrike", self:GetCaster())
end

function queen_attack:LaunchProjectile(vPoint, nSpeed, nDistance, nDamage)
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local point = vPoint
    local projectile_direction = Direction2D(origin, point)
    local poison_duration = 4.0
    local fading_slow_duration = 4.0
    local fading_slow_pct = 80

    CustomEntitiesLegacy:ProjectileAttack(caster, {
        tProjectile = {
            EffectName = "particles/queen/queen_dagger.vpcf",
            vSpawnOrigin = origin + Vector(0, 0, 96),
            fDistance = nDistance,
            fStartRadius = 70,
            Source = caster,
            vVelocity = projectile_direction * nSpeed,
            UnitBehavior = PROJECTILES_DESTROY,
            TreeBehavior = PROJECTILES_NOTHING,
            WallBehavior = PROJECTILES_DESTROY,
            GroundBehavior = PROJECTILES_NOTHING,
            fGroundOffset = 0,
            UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) end,
            OnUnitHit = function(_self, unit) 
                local damage_table = {
                    victim = unit,
                    attacker = _self.Source,
                    damage = nDamage,
                    damage_type = DAMAGE_TYPE_PHYSICAL,
                    ability = self
                }
                ApplyDamage(damage_table)

                unit:AddNewModifier(_self.Source, self, "modifier_queen_attack", { duration = poison_duration })
                unit:AddNewModifier(_self.Source, self, "modifier_generic_fading_slow", { 
                    duration = fading_slow_duration,
                    max_slow_pct = fading_slow_pct 
                })
            end,
            OnFinish = function(_self, pos)
                EFX("particles/units/heroes/hero_queenofpain/queen_shadow_strike_explosion.vpcf", PATTACH_WORLDORIGIN, nil, {
                    cp0 = pos,
                    cp3 = pos,
                })
                EmitSoundOn('Hero_QueenOfPain.ShadowStrike.Target', caster)
            end,
        }
    })
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(queen_attack)