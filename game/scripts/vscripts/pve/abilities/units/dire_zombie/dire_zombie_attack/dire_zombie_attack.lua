dire_zombie_attack = class({})

function dire_zombie_attack:GetCastAnimationCustom()		return ACT_DOTA_ATTACK end
function dire_zombie_attack:GetPlaybackRateOverride()       return 1.5 end
function dire_zombie_attack:GetCastPointSpeed() 			return 0 end

function dire_zombie_attack:OnSpellStart()
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
    local projectile_direction = Direction2D(origin, point)

    CustomEntitiesLegacy:ProjectileAttack(caster, {
		bIsBasicAttack = true,
        tProjectile = {
            EffectName = "particles/dire_zombie/dire_zombie_projectile.vpcf",
            vSpawnOrigin = origin + Vector(0, 0, 96),
            fDistance = self:GetCastRange(Vector(0,0,0), nil),
            fStartRadius = 70,
            Source = caster,
            vVelocity = projectile_direction * 1500,
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
                EFX("particles/base_attacks/ti9_dire_ranged_explosion.vpcf", PATTACH_WORLDORIGIN, nil, {
                    cp0 = pos,
                    cp3 = pos,
                })
                EmitSoundOn('Hero_QueenOfPain.ShadowStrike.Target', caster)
            end,
        }
    })


    EmitSoundOn("General.Attack", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(dire_zombie_attack)