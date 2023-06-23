import { CustomAbility } from "../../../abilities/framework/custom_ability";
import { registerAbility } from "../../../lib/dota_ts_adapter";

@registerAbility("dire_creep_grenade")
class DireCreepGrenade extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
    }

    GetPlaybackRateOverride() {
        return 1.2;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        //     const point = this.GetCursorPosition()
        //     const origin = this.caster.GetOrigin()
        //     const projectile_direction = Direction2D(origin, point)
        //     const projectile_speed = RandomInt(1000, 1200)
        //     const radius = 300
        //     const distance = (this.caster.GetAbsOrigin() - point):Length2D()
        // 	const time = distance/projectile_speed
        //     const damage = 30
        //     const damage_table = {
        //         attacker = this.caster,
        //         damage = damage,
        //         damage_type = DAMAGE_TYPE_MAGICAL,
        //     }
        //     // CreateTimedRadiusMarker(this.caster, point, radius, time, 0.2, RADIUS_SCOPE_PUBLIC)
        //     CurveProjectile(this.caster, point, projectile_speed, function()
        //         ApplyCallbackForUnitsInArea(this.caster, point, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
        //             damage_table.victim = unit
        //             ApplyDamage(damage_table)
        //         })
        //         EFX("particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_ground_rings.vpcf", ParticleAttachment.WORLDORIGIN, nil, {
        //             cp0 = point,
        //             cp5 = point,
        //             release = true,
        //         })
        //         EFX("particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_impact_refract.vpcf", ParticleAttachment.WORLDORIGIN, nil, {
        //             cp0 = point,
        //             cp5 = point,
        //             release = true,
        //         })
        //         EFX("particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_impact_smoke.vpcf", ParticleAttachment.WORLDORIGIN, nil, {
        //             cp0 = point,
        //             cp3 = point,
        //             release = true,
        //         })
        //         EFX("particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_impact_sparks.vpcf", ParticleAttachment.WORLDORIGIN, nil, {
        //             cp0 = point,
        //             cp5 = point,
        //             release = true,
        //         })
        //         CreateRadiusMarker(this.caster, point, radius, RADIUS_SCOPE_PUBLIC, 0.1)
        //     })
        //     EmitSoundOn("General.Attack", this.caster)
    }
}
