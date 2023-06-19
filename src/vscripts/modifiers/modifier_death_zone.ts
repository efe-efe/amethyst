import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier({ customNameForI18n: "modifier_death_zone" })
export class ModifierDeathZone extends CustomModifier<undefined> {
    origin!: Vector;
    radiusReduction = 30;
    milestones: {
        radiusReduction: number;
        startTime: number;
    }[] = [
        { radiusReduction: 20, startTime: 100 },
        { radiusReduction: 15, startTime: 200 },
        { radiusReduction: 10, startTime: 250 },
        { radiusReduction: 8, startTime: 300 },
        { radiusReduction: 6, startTime: 350 },
        { radiusReduction: 3, startTime: 400 },
        { radiusReduction: 2, startTime: 450 },
        { radiusReduction: 0, startTime: 550 },
        { radiusReduction: 1, startTime: 700 }
    ];
    minRadius = 1;
    maxRadius = 8000;
    radius = this.maxRadius;
    counter = 0;
    timeCounter = 0;

    OnCreated() {
        this.origin = this.parent.GetAbsOrigin();
        if (IsServer()) {
            this.StartIntervalThink(0.1);
            EmitGlobalSound("MegaCreeps.Dire");
        }
    }

    OnRemoved() {
        if (IsServer()) {
            UTIL_Remove(this.parent);
        }
    }

    OnIntervalThink() {
        this.timeCounter++;
        this.radiusReduction =
            this.milestones.find(milestone => milestone.startTime == this.timeCounter)?.radiusReduction ?? this.radiusReduction;

        const allUnits = FindUnitsInRadius(
            DotaTeam.NOTEAM,
            this.origin,
            undefined,
            FIND_UNITS_EVERYWHERE,
            UnitTargetTeam.BOTH,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.PLAYER_CONTROLLED,
            0,
            false
        );

        const notAffected = FindUnitsInRadius(
            DotaTeam.NOTEAM,
            this.origin,
            undefined,
            this.radius,
            UnitTargetTeam.BOTH,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.PLAYER_CONTROLLED,
            0,
            false
        );

        for (const unit of allUnits) {
            if (notAffected.includes(unit)) {
                unit.RemoveModifierByName(ModifierDeathZoneDamage.name);
            } else {
                ModifierDeathZoneDamage.apply(unit, unit, undefined, {});
            }
        }

        if (this.counter == 10) {
            this.PlayEffectsMeteor();
            for (let i = this.radius; i <= this.maxRadius; i = i + 200) {
                this.PlayEffectsAoe(i, 0);
            }
            this.counter = 0;
        }

        this.radius = Math.max(this.minRadius, this.radius - this.radiusReduction);
        this.counter++;
        this.PlayEffectsAoe(this.radius, 512);
    }

    PlayEffectsMeteor() {
        const direction = Vector(RandomFloat(-1.0, 1.0), RandomFloat(-1.0, 1.0), 0).Normalized();
        const radius = this.radius + RandomInt(300, 1000);
        const origin = this.origin.__add(direction.__mul(radius));
        EFX("particles/units/heroes/hero_invoker/invoker_sun_strike.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: Vector(origin.x, origin.y, 0),
            cp1: Vector(300, 0, 0),
            release: true
        });
    }

    PlayEffectsAoe(radius: number, zOffset: number) {
        const origin = this.origin.__add(Vector(0, 0, zOffset));
        EFX("particles/aoe_marker/aoe_marker_enemy.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: origin,
            cp2: Vector(radius, 0, 0),
            cp4: origin,
            release: true
        });
    }
}

@registerModifier({ customNameForI18n: "modifier_death_zone_damage" })
class ModifierDeathZoneDamage extends CustomModifier<undefined> {
    particleIds: ParticleID[] = [];

    IsHidden() {
        return false;
    }

    IsDebuff() {
        return true;
    }

    OnCreated() {
        if (IsServer()) {
            this.StartIntervalThink(1.0);

            EmitSoundOn("Hero_Phoenix.SuperNova.Cast", this.parent);
            ScreenShake(this.parent.GetAbsOrigin(), 100, 300, 0.45, 1000, 0, true);
            this.PlayEffectsOnTarget(this.parent);
            this.particleIds.push(
                ParticleManager.CreateParticle(
                    "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_ignite_burn.vpcf",
                    ParticleAttachment.ABSORIGIN_FOLLOW,
                    this.parent
                )
            );
            this.particleIds.push(
                ParticleManager.CreateParticle(
                    "particles/units/heroes/hero_phoenix/phoenix_fire_spirit_burn.vpcf",
                    ParticleAttachment.ABSORIGIN_FOLLOW,
                    this.parent
                )
            );
            this.particleIds.push(
                ParticleManager.CreateParticle(
                    "particles/econ/events/ti10/radiance_ti10.vpcf",
                    ParticleAttachment.ABSORIGIN_FOLLOW,
                    this.parent
                )
            );
        }
    }

    OnDestroy() {
        if (IsServer()) {
            StopSoundOn("Hero_Phoenix.SuperNova.Cast", this.parent);
            for (const particleId of this.particleIds) {
                ParticleManager.DestroyParticle(particleId, false);
                ParticleManager.ReleaseParticleIndex(particleId);
            }
        }
    }

    OnIntervalThink() {
        ApplyDamage({
            damage: 15,
            damage_type: DamageTypes.PURE,
            victim: this.parent,
            attacker: this.parent
        });
        this.PlayEffectsOnTarget(this.parent);
        this.Destroy();
    }

    PlayEffectsOnTarget(target: CDOTA_BaseNPC) {
        ParticleManager.ReleaseParticleIndex(
            ParticleManager.CreateParticle(
                "particles/econ/items/lion/fish_stick_retro/fish_stick_spell_fish_retro_b.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                target
            )
        );
        ParticleManager.ReleaseParticleIndex(
            ParticleManager.CreateParticleForPlayer(
                "particles/econ/items/zeus/arcana_chariot/zeus_tgw_screen_damage.vpcf",
                ParticleAttachment.EYES_FOLLOW,
                target,
                target.GetPlayerOwner()
            )
        );
    }

    GetTexture() {
        return "modifier_death_zone_damage";
    }
}
