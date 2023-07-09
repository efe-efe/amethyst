import { createRadiusMarker, findUnitsInRadius } from "../../../util";
import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierDisplacement } from "../../../modifiers/modifier_displacement";
import { ModifierShield } from "../../../modifiers/modifier_shield";
import { direction2D, getCursorPosition, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { ModifierPangoMobility } from "./modifier_pango_mobility";
import { PangoSecondAttack } from "./pango_second_attack";

@registerAbility("pango_special_attack")
export class PangoSpecialAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_FORCESTAFF_END;
    }

    GetPlaybackRateOverride() {
        return 0.5;
    }

    GetCastingCrawl() {
        return 20;
    }

    GetCastRange(location: Vector, target?: CDOTA_BaseNPC) {
        if (ModifierPangoMobility.findOne(this.caster) && IsServer()) {
            return super.GetCastRange(location, target) * 1.2;
        }
        return super.GetCastRange(location, target);
    }

    GetCastPoint() {
        if (ModifierPangoMobility.findOne(this.caster)) {
            return 0.0;
        }
        return super.GetCastPoint();
    }

    // function pango_special_attack:HasPriority()
    //     return true
    // }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const distance = this.GetCastRange(Vector(0, 0, 0), undefined);
        const airTime = 0.4;

        const modifier = ModifierPangoMobility.findOne(this.caster);
        modifier?.SetDuration(modifier?.GetRemainingTime() + airTime, true);
        const direction = modifier ? CustomEntitiesLegacy.GetDirection(this.caster) : direction2D(origin, point);

        ModifierPangoSpecialAttack.apply(this.caster, this.caster, this, {
            x: direction.x,
            y: direction.y,
            distance: distance,
            speed: distance / airTime,
            peak: 250
        });

        EmitSoundOn("Hero_Pangolier.TailThump.Cast", this.caster);
    }

    Crash(radius: number) {
        const origin = this.caster.GetAbsOrigin();
        const damageBlock = this.GetSpecialValueFor("damage_block");
        const shieldDuration = this.GetSpecialValueFor("duration");
        const enemies = findUnitsInRadius(
            this.caster,
            origin,
            radius,
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE,
            FindOrder.ANY
        );

        const shieldProviders = enemies.filter(enemy => !isObstacle(enemy)).length;

        for (const enemy of enemies) {
            ApplyDamage({
                victim: enemy,
                attacker: this.caster,
                damage: this.GetSpecialValueFor("ability_damage"),
                damage_type: DamageTypes.PURE
            });
        }

        if (shieldProviders > 0) {
            ModifierShield.apply(this.caster, this.caster, undefined, {
                duration: shieldDuration,
                damageBlock: damageBlock * shieldProviders
            });
        }

        EFX("particles/units/heroes/hero_pangolier/pangolier_tailthump.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: origin
        });
        createRadiusMarker(this.caster, origin, radius, "public", 0.1);
        EmitSoundOn("Hero_Pangolier.TailThump", this.caster);
    }
}

@registerModifier()
class ModifierPangoSpecialAttack extends ModifierDisplacement<PangoSpecialAttack> {
    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            this.ability.Crash(this.radius);

            if (this.ability.GetLevel() >= 2) {
                const origin = this.caster.GetAbsOrigin();
                const direction = this.caster.GetForwardVector();
                const pangoSecondAttack = PangoSecondAttack.findOne(this.caster);
                const range = (pangoSecondAttack?.GetCastRange(Vector(0, 0, 0), undefined) ?? 1) / 2;
                pangoSecondAttack?.Cut(origin, direction, range);
                pangoSecondAttack?.Cut(origin, direction.__mul(-1), range);
            }
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        if (ModifierPangoMobility.findOne(this.parent)) {
            return GameActivity.IDLE;
        }
        return GameActivity.DOTA_CAST_ABILITY_2;
    }

    GetOverrideAnimationRate() {
        return 1.0;
    }

    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.NO_HEALTH_BAR]: true,
            [ModifierState.INVULNERABLE]: true,
            [ModifierState.OUT_OF_GAME]: true,
            [ModifierState.NO_UNIT_COLLISION]: true
        };
    }
}
