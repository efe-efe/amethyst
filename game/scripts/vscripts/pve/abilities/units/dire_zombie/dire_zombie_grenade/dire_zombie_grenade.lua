dire_zombie_grenade = class({})

function dire_zombie_grenade:GetCastAnimationCustom()		return ACT_DOTA_ATTACK end
function dire_zombie_grenade:GetPlaybackRateOverride()       return 1.2 end
function dire_zombie_grenade:GetCastPointSpeed() 			return 0 end

function dire_zombie_grenade:OnSpellStart()
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
    local projectile_direction = Direction2D(origin, point)
    local projectile_speed = RandomInt(1000, 1200)
    local radius = 300
    local distance = (caster:GetAbsOrigin() - point):Length2D()
	local time = distance/projectile_speed
    local damage = 30
    local damage_table = {
        attacker = caster,
        damage = damage,
        damage_type = DAMAGE_TYPE_MAGICAL,
    }

    CreateTimedRadiusMarker(caster, point, radius, time, 0.2, RADIUS_SCOPE_PUBLIC)
    CurveProjectile(caster, point, projectile_speed, function()
        ApplyCallbackForUnitsInArea(caster, point, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
            damage_table.victim = unit
            ApplyDamage(damage_table)
        end)
        EFX("particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_ground_rings.vpcf", PATTACH_WORLDORIGIN, nil, {
            cp0 = point,
            cp5 = point,
            release = true,
        })
        EFX("particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_impact_refract.vpcf", PATTACH_WORLDORIGIN, nil, {
            cp0 = point,
            cp5 = point,
            release = true,
        })
        EFX("particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_impact_smoke.vpcf", PATTACH_WORLDORIGIN, nil, {
            cp0 = point,
            cp3 = point,
            release = true,
        })
        EFX("particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_impact_sparks.vpcf", PATTACH_WORLDORIGIN, nil, {
            cp0 = point,
            cp5 = point,
            release = true,
        })
        CreateRadiusMarker(caster, point, radius, RADIUS_SCOPE_PUBLIC, 0.1)
    end)
    
    EmitSoundOn("General.Attack", caster)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(dire_zombie_grenade)