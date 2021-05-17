sniper_extra = class({})
LinkLuaModifier("modifier_sniper_extra_displacement", "abilities/heroes/sniper/sniper_extra/modifier_sniper_extra_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_sniper_extra_displacement_enemy", "abilities/heroes/sniper/sniper_extra/modifier_sniper_extra_displacement_enemy", LUA_MODIFIER_MOTION_BOTH)

function sniper_extra:OnAbilityPhaseStart()
    EmitSoundOn("Ability.AssassinateLoad", self:GetCaster())
    return true
end

function sniper_extra:GetCastAnimationCustom()		return ACT_DOTA_ATTACK end
function sniper_extra:GetPlaybackRateOverride() 	return 0.4 end
function sniper_extra:GetCastPointSpeed() 			return 0 end

function sniper_extra:OnSpellStart()
	local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()
    local point = CustomAbilities:GetCursorPosition(self)
    local knockback_distance = self:GetSpecialValueFor("knockback_distance")
    local damage = self:GetSpecialValueFor("damage_per_bullet")
    
    local projectile_speed = self:GetSpecialValueFor("projectile_speed")
    local projectile_distance = self:GetCastRange(Vector(0,0,0), nil)
    local straight_direction = Direction2D(origin, point)
    
    local directions = {}
    table.insert(directions, straight_direction)
    table.insert(directions, RotatePoint(Vector(0,0,0), Vector(0,0,0) + straight_direction, -30):Normalized())
    table.insert(directions, RotatePoint(Vector(0,0,0), Vector(0,0,0) + straight_direction, 30):Normalized())

    for _,direction in ipairs(directions) do
        CustomEntitiesLegacy:ProjectileAttack(caster, {
            tProjectile = {
                EffectName = "particles/sniper/sniper_extra.vpcf",
                vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,60),
                fDistance = projectile_distance,
                fStartRadius = self:GetSpecialValueFor("hitbox"),
                Source = caster,
                vVelocity = direction * projectile_speed,
                UnitBehavior = PROJECTILES_DESTROY,
                TreeBehavior = PROJECTILES_NOTHING,
                WallBehavior = PROJECTILES_DESTROY,
                GroundBehavior = PROJECTILES_NOTHING,
                fGroundOffset = 0,
                UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) end,
                OnUnitHit = function(_self, unit) 
                    local x = unit:GetOrigin().x - origin.x
                    local y = unit:GetOrigin().y - origin.y
        
                    local distance = knockback_distance - (unit:GetOrigin() - origin):Length2D()
                    
                    unit:AddNewModifier(
                        _self.Source, -- player source
                        self, -- ability source
                        "modifier_sniper_extra_displacement_enemy", -- modifier name
                        {
                            x = x,
                            y = y,
                            r = distance,
                            speed = (distance/0.35),
                            peak = 32,
                        }
                    )
        
                    local damage_table = {
                        victim = unit,
                        attacker = _self.Source,
                        damage = damage,
                        damage_type = DAMAGE_TYPE_MAGICAL,
                    }
                    ApplyDamage(damage_table)
                end,
                OnFinish = function(_self, pos)
                    self:PlayEffectsOnFinish(pos)
                end,
            }
        })
    end

    local knockback_direction = -(point - origin):Normalized()

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_sniper_mobility_displacement", -- modifier name
        {
            x = knockback_direction.x,
            y = knockback_direction.y,
            r = knockback_distance,
            speed = (knockback_distance/0.35),
			peak = 64,
        }
    )

    self:PlayEffectsOnCast()
end

function sniper_extra:PlayEffectsOnCast()
    EmitSoundOn("Hero_Techies.LandMine.Detonate", self:GetCaster())
end

function sniper_extra:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()
	EmitSoundOnLocationWithCaster(pos, "Hero_Sniper.ProjectileImpact", caster)

	local particle_cast = "particles/units/heroes/hero_techies/techies_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
    ParticleManager:SetParticleControl(effect_cast, 0, pos)
    ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(sniper_extra)