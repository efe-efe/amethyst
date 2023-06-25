import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierDisplacement } from "../../../modifiers/modifier_displacement";
import { direction2D, getCursorPosition, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { ModifierPangoStacks, PangoBasicAttack } from "./pango_basic_attack";

@registerAbility("pango_second_attack")
export class PangoSecondAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_TELEPORT_END;
    }

    GetPlaybackRateOverride() {
        return 2.0;
    }

    GetCastingCrawl() {
        return 80;
    }

    GetFadeGestureOnCast() {
        return false;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const distance = this.GetCastRange(Vector(0, 0, 0), undefined);
        const direction = direction2D(origin, point);

        if (CustomEntitiesLegacy.GetDirection(this.caster).x != 0 || CustomEntitiesLegacy.GetDirection(this.caster).y != 0) {
            this.Dash(CustomEntitiesLegacy.GetDirection(this.caster), distance);
        } else {
            this.Cut(origin, direction, distance);
        }
        EmitSoundOn("Hero_Pangolier.Swashbuckle.Cast", this.caster);
    }

    Dash(direction: Vector, distance: number) {
        ModifierPangoSecondAttackDisplacement.apply(this.caster, this.caster, this, {
            x: direction.x,
            y: direction.y,
            distance: distance,
            speed: distance / 0.2,
            peak: 1
        });
    }

    Cut(origin: Vector, direction: Vector, distance: number) {
        const point = origin.__add(direction.__mul(distance));

        CreateModifierThinker(
            this.caster,
            this,
            "modifier_pango_second_attack_thinker",
            {
                x: point.x,
                y: point.y
            },
            origin,
            this.caster.GetTeamNumber(),
            false
        );
    }
}

@registerModifier({ customNameForI18n: "modifier_pango_second_attack_displacement" })
class ModifierPangoSecondAttackDisplacement extends ModifierDisplacement<PangoSecondAttack> {
    OnDestroy() {
        super.OnDestroy();
        if (IsServer()) {
            const origin = this.caster.GetAbsOrigin();
            const range = this.ability.GetCastRange(Vector(0, 0, 0), undefined);
            const direction = direction2D(origin, getCursorPosition(this.caster));
            this.ability.Cut(origin, direction, range);

            const trail_pfx = ParticleManager.CreateParticle(
                "particles/phantom/mobility_trail.vpcf",
                ParticleAttachment.ABSORIGIN,
                this.parent
            );
            ParticleManager.SetParticleControl(trail_pfx, 0, this.origin);
            ParticleManager.SetParticleControl(trail_pfx, 1, this.parent.GetAbsOrigin());
            ParticleManager.SetParticleControl(trail_pfx, 60, Vector(188, 7, 229));
            ParticleManager.SetParticleControl(trail_pfx, 61, Vector(1, 0, 0));
            ParticleManager.ReleaseParticleIndex(trail_pfx);
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
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

@registerModifier({ customNameForI18n: "modifier_pango_second_attack_thinker" })
class ModifierPangoSecondAttack extends CustomModifier {
    point!: Vector;
    attacks!: number;
    particleIds: ParticleID[] = [];

    OnCreated(params: { x: number; y: number }) {
        if (IsServer()) {
            this.point = Vector(params.x, params.y);
            this.attacks = this.Value("attacks");

            this.OnIntervalThink();
            this.StartIntervalThink(0.1);

            EmitSoundOn("Hero_Pangolier.Swashbuckle", this.caster);
        }
    }

    OnDestroy() {
        if (IsServer()) {
            for (const particleId of this.particleIds) {
                ParticleManager.DestroyParticle(particleId, false);
                ParticleManager.ReleaseParticleIndex(particleId);
            }

            UTIL_Remove(this.parent);
        }
    }

    OnIntervalThink() {
        const enemies = CustomEntitiesLegacy.FindUnitsInLine(
            this.caster,
            this.parent.GetAbsOrigin(),
            this.point,
            150,
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE
        );

        const pangoBasicAttack = PangoBasicAttack.findOne(this.caster);

        for (const enemy of enemies) {
            pangoBasicAttack?.TryProc(enemy);

            if (!isObstacle(enemy) && pangoBasicAttack) {
                ModifierPangoStacks.apply(this.caster, this.caster, pangoBasicAttack, {});
            }

            ApplyDamage({
                victim: enemy,
                attacker: this.caster,
                damage: this.Value("ability_damage"),
                damage_type: DamageTypes.PHYSICAL
            });
            EmitSoundOn("Hero_Pangolier.Swashbuckle.Attack", enemy);
            EmitSoundOn("Hero_Pangolier.Attack", enemy);
        }

        const direction = direction2D(this.parent.GetAbsOrigin(), this.point);
        const range = this.point.__sub(this.parent.GetAbsOrigin()).Length2D();

        this.particleIds.push(
            EFX("particles/units/heroes/hero_pangolier/pangolier_swashbuckler.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
                cp0: this.parent.GetAbsOrigin(),
                cp1: direction.__mul(range)
            })
        );

        this.attacks--;

        if (this.attacks <= 0) {
            this.Destroy();
        }
    }
}
