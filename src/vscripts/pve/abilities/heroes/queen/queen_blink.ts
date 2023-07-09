import { CustomAbility } from "../../../../abilities/framework/custom_ability";
import { registerAbility } from "../../../../lib/dota_ts_adapter";
import { ModifierSilence } from "../../../../modifiers/modifier_silence";
import { clampPosition, createTimedRadiusMarker, findUnitsInRadius } from "../../../../util";

@registerAbility("queen_blink")
export class QueenBlink extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_2;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            const origin = this.caster.GetOrigin();
            const point = clampPosition(origin, this.GetCursorPosition(), {
                maxRange: this.GetCastRange(Vector(0, 0, 0), undefined)
            });
            const radius = this.GetSpecialValueFor("radius");
            createTimedRadiusMarker(this.caster, point, radius, this.GetCastPoint(), 0.2, "public");
            createTimedRadiusMarker(this.caster, origin, radius, this.GetCastPoint(), 0.2, "public");

            return true;
        }
        return false;
    }

    OnSpellStart() {
        const point = clampPosition(this.caster.GetOrigin(), this.GetCursorPosition(), {
            maxRange: this.GetCastRange(Vector(0, 0, 0), undefined)
        });

        this.Blink(point);
    }

    Blink(position: Vector) {
        this.BeforeBlink();
        FindClearSpaceForUnit(this.caster, position, true);
        this.AfterBlink();
        this.caster.StartGesture(GameActivity.DOTA_CAST_ABILITY_2_END);
    }

    AoeEffect() {
        const radius = 250;
        const origin = this.caster.GetOrigin();
        const silenceDuration = 1.0;

        const enemies = findUnitsInRadius(
            this.caster,
            origin,
            radius,
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE,
            FindOrder.ANY
        );

        for (const enemy of enemies) {
            ApplyDamage({
                victim: enemy,
                attacker: this.caster,
                damage: 7,
                damage_type: DamageTypes.PURE
            });
            ModifierSilence.apply(enemy, this.caster, this, { duration: silenceDuration });
        }
    }

    BeforeBlink() {
        const origin = this.caster.GetOrigin();
        EFX("particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_start.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: origin,
            cp1: this.caster.GetForwardVector(),
            cp4: Vector(10, 1, 0),
            release: true
        });
        EFX("particles/units/heroes/hero_queenofpain/queen_blink_shard_start.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: origin,
            cp2: Vector(this.GetSpecialValueFor("radius"), 0, 0),
            release: true
        });
        EmitSoundOn("Hero_QueenOfPain.Blink_out", this.caster);
        EmitSoundOn("Hero_QueenOfPain.Blink_out.Shard", this.caster);
        this.AoeEffect();
    }

    AfterBlink() {
        const origin = this.caster.GetOrigin();
        EmitSoundOn("Hero_QueenOfPain.Blink_in.Shard", this.caster);
        EmitSoundOn("Hero_QueenOfPain.Blink_in", this.caster);
        EFX("particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_end.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
            release: true
        });
        EFX("particles/units/heroes/hero_queenofpain/queen_blink_shard_end.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: origin,
            cp2: Vector(this.GetSpecialValueFor("radius"), 0, 0),
            release: true
        });
        this.AoeEffect();
    }
}
