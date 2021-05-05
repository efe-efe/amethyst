dire_zombie_attack = class({})

function dire_zombie_attack:GetCastAnimationCustom()		return ACT_DOTA_ATTACK end
function dire_zombie_attack:GetPlaybackRateOverride()       return 1.5 end
function dire_zombie_attack:GetCastPointSpeed() 			return 0 end

function dire_zombie_attack:OnSpellStart()
    local point = self:GetCursorPosition()
    self:LaunchProjectile(point, 1500, self:GetCastRange(Vector(0,0,0), nil), 5)
    EmitSoundOn("General.Attack", self:GetCaster())
end

function dire_zombie_attack:LaunchProjectile(vPoint, nSpeed, nDistance, nDamage)
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local point = vPoint
    local projectile_direction = Direction2D(origin, point)
    local poison_duration = 4.0
    local fading_slow_duration = 4.0
    local fading_slow_pct = 80

    CustomEntities:ProjectileAttack(caster, {
        tProjectile = {
            EffectName = "particles/dire_zombie/dire_zombie_projectile.vpcf",
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
            UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntities:Allies(_self.Source, unit) end,
            OnUnitHit = function(_self, unit) 
                local damage_table = {
                    victim = unit,
                    attacker = _self.Source,
                    damage = nDamage,
                    damage_type = DAMAGE_TYPE_PHYSICAL,
                    ability = self
                }
                ApplyDamage(damage_table)
            end,
            OnFinish = function(_self, pos)
                EFX("particles/base_attacks/ti9_dire_ranged_explosion.vpcf", PATTACH_WORLDORIGIN, nil, {
                    cp0 = pos,
                    cp3 = pos,
                })
                EmitSoundOn('Hero_QueenOfPain.ShadowStrike.Target', caster)
            end,
        }
    })
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(dire_zombie_attack)