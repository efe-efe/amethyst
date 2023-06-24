import { CustomAbility } from "../../../../abilities/framework/custom_ability";
import { CustomModifier } from "../../../../abilities/framework/custom_modifier";
import { registerAbility, registerModifier } from "../../../../lib/dota_ts_adapter";
import { ModifierFear } from "../../../../modifiers/modifier_fear";
import { direction2D } from "../../../../util";

@registerAbility("queen_scream")
class QueenScream extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_3;
    }

    GetPlaybackRateOverride() {
        return 0.8;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        const screams = 3;
        ModifierQueenScream.apply(this.caster, this.caster, this, { screams: screams });
    }
}

@registerModifier({ customNameForI18n: "modifier_queen_scream" })
class ModifierQueenScream extends CustomModifier {
    origin!: Vector;
    screams!: number;
    count = 0;

    OnCreated(params: { screams: number }) {
        if (IsServer()) {
            this.origin = this.caster.GetAbsOrigin();
            this.screams = params.screams;
            this.OnIntervalThink();
            this.StartIntervalThink(1.0);
            // this.radius_marker_modifier = CreateTimedRadiusMarker(this.caster, this.origin, 250, 1.25* this.screams, 0.2, RADIUS_SCOPE_PUBLIC):FindModifierByName('radius_marker_thinker')
        }
    }

    OnDestroy() {
        if (IsServer()) {
            // if(this.radius_marker_modifier ~= nil){
            //     if(not this.radius_marker_modifier:IsNull()){
            //         this.radius_marker_modifier:Destroy()
            //     }
            // }
            this.ability.StartCooldown(this.ability.GetLevel());
        }
    }

    OnIntervalThink() {
        if (this.count == this.screams) {
            this.Destroy();
            return;
        }

        const path =
            this.count == 0
                ? "particles/units/heroes/hero_dawnbreaker/dawnbreaker_elated_fury_landing.vpcf"
                : "particles/queen/queen_scream_no_ground.vpcf";

        this.caster.StartGestureWithPlaybackRate(GameActivity.DOTA_CAST_ABILITY_3, 1.5);

        EmitSoundOn("Hero_QueenOfPain.ScreamOfPain", this.caster);
        EFX(path, ParticleAttachment.WORLDORIGIN, this.caster, {
            cp0: this.origin,
            cp1: this.origin,
            release: true
        });
        const count = 12 + this.count * 5;
        const angleDiff = 360 / count;
        const vector = this.origin.__add(Vector(1, 0, 0));

        for (let i = 0; i < count; i++) {
            const location = RotatePosition(this.origin, QAngle(0, angleDiff * i, 0), vector);
            this.LaunchProjectile(location);
        }

        this.count = this.count + 1;
    }

    LaunchProjectile(point: Vector) {
        const origin = this.caster.GetOrigin();
        const projectileDirection = direction2D(origin, point);
        const projectileSpeed = 800;
        const projectileDistance = 2000;
        const damage = 12;
        const fearDuration = 1.0;

        this.ability.ProjectileAttack({
            source: this.caster,
            effectName: "particles/queen/queen_scream.vpcf",
            spawnOrigin: origin.__add(Vector(0, 0, 96)),
            distance: projectileDistance,
            startRadius: 70,
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: damage,
                    damage_type: DamageTypes.PHYSICAL,
                    ability: this.ability
                });

                ModifierFear.apply(unit, projectile.getSource(), this, { duration: fearDuration });
            },
            onFinish: projectile => {
                EFX(
                    "particles/units/heroes/hero_queenofpain/queen_shadow_strike_explosion.vpcf",
                    ParticleAttachment.WORLDORIGIN,
                    undefined,
                    {
                        cp0: projectile.getPosition(),
                        cp3: projectile.getPosition()
                    }
                );
                EmitSoundOn("Hero_QueenOfPain.ShadowStrike.Target", this.caster);
            }
        });
    }

    CheckState() {
        return {
            [ModifierState.COMMAND_RESTRICTED]: true,
            [ModifierState.STUNNED]: true
        };
    }
}
