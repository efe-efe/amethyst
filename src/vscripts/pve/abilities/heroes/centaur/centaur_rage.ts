import { CustomAbility } from "../../../../abilities/framework/custom_ability";
import { CustomModifier } from "../../../../abilities/framework/custom_modifier";
import { registerAbility, registerModifier } from "../../../../lib/dota_ts_adapter";
import { ModifierThinker } from "../../../../modifiers/modifier_thinker";

@registerAbility("centaur_rage")
class CentaurRage extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CENTAUR_STAMPEDE;
    }

    GetPlaybackRateOverride() {
        return 1.5;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        this.caster.AddNewModifier(this.caster, this, "modifier_centaur_rage_channeling", {
            duration: this.GetSpecialValueFor("duration")
        });
    }
}

@registerModifier({ customNameForI18n: "modifier_centaur_rage_channeling" })
class ModifierCentaureRageChanneling extends CustomModifier {
    count = 7;
    angleDiff = 360 / this.count;
    radius!: number;
    team!: DotaTeam;

    OnCreated() {
        if (IsServer()) {
            this.team = this.caster.GetTeamNumber();
            this.radius = this.ability.GetSpecialValueFor("radius");
            this.OnIntervalThink();
            this.StartIntervalThink(1.0);
        }
    }

    OnIntervalThink() {
        this.caster.StartGestureWithPlaybackRate(GameActivity.DOTA_CAST_ABILITY_1, 1.5);
        const origin = this.caster.GetAbsOrigin();
        EmitSoundOn("Hero_Centaur.HoofStomp", this.caster);

        for (let i = 0; i < this.count; i++) {
            const direction = RotatePosition(Vector(0, 0, 0), QAngle(0, 200 + this.angleDiff * i, 0), Vector(1, 0, 0));
            let previousRange = 0;

            for (let j = 0; j < 2; j++) {
                const range = previousRange + RandomInt(this.radius * 2, 1000);
                const point = RotatePosition(origin, QAngle(0, this.angleDiff * i, 0), origin.__add(Vector(range, 0, 0)));

                ModifierCentaurRageThinker.createThinker(this.caster, this.ability, point, {
                    delayTime: 0.6,
                    radius: this.ability.GetSpecialValueFor("radius")
                });

                previousRange = range;
            }
        }
    }

    OnDestroy() {
        if (IsServer()) {
            this.ability.StartCooldown(this.ability.GetCooldown(0));
            this.caster.FadeGesture(GameActivity.DOTA_CAST_ABILITY_1);
        }
    }

    // function modifier_centaur_rage_channeling:GetStatusLabel() return "Ultimate" }
    // function modifier_centaur_rage_channeling:GetStatusPriority() return 5 }
    // function modifier_centaur_rage_channeling:GetStatusStyle() return "Ultimate" }
}
// if(IsClient()){ require("wrappers/modifiers") }
// Modifiers.Channeling(modifier_centaur_rage_channeling)
// Modifiers.Status(modifier_centaur_rage_channeling)

@registerModifier({ customNameForI18n: "modifier_centaur_rage_thinker" })
class ModifierCentaurRageThinker extends ModifierThinker {
    OnIntervalThink() {
        super.OnIntervalThink();

        const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
            this.caster,
            this.origin,
            this.radius,
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE,
            FindOrder.ANY
        );

        for (const enemy of enemies) {
            ApplyDamage({
                victim: enemy,
                attacker: this.caster,
                damage: this.ability.GetSpecialValueFor("ability_damage"),
                damage_type: DamageTypes.PURE
            });
        }

        EFX("particles/units/heroes/hero_sandking/sandking_epicenter.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: this.origin,
            cp1: Vector(this.radius, 0, 0),
            release: true
        });
        this.Destroy();
    }
}
