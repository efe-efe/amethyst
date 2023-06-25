import { registerAbility, registerModifier } from "../../../../lib/dota_ts_adapter";
import { ModifierThinker, ModifierThinkerParams } from "../../../../modifiers/modifier_thinker";
import { clampPosition, direction2D, giveMana } from "../../../../util";
import { CustomAbility } from "../../../framework/custom_ability";

@registerAbility("invoker_emp_custom")
class InvokerEMP extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_EMP;
    }
    GetPlaybackRateOverride() {
        return 1.0;
    }
    GetCastingCrawl() {
        return 10;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, { maxRange: this.GetCastRange(Vector(0, 0, 0), undefined) });

        ModifierInvokerEMP.createThinker(this.caster, this, point, {
            delayTime: this.GetSpecialValueFor("delay_time"),
            radius: this.GetSpecialValueFor("radius")
        });
    }
}

@registerModifier({ customNameForI18n: "modifier_invoker_emp_custom_thinker" })
class ModifierInvokerEMP extends ModifierThinker {
    particleId?: ParticleID;

    OnCreated(params: ModifierThinkerParams) {
        super.OnCreated(params);

        if (IsServer()) {
            AddFOWViewer(this.caster.GetTeamNumber(), this.origin, this.radius, this.GetDuration() + 0.2, true);
            this.StartIntervalThink(0.03);

            this.particleId = EFX("particles/units/heroes/hero_invoker/invoker_emp.vpcf", ParticleAttachment.WORLDORIGIN, this.caster, {
                cp0: this.origin,
                cp1: Vector(this.radius, 0, 0)
            });
            EmitSoundOn("Hero_Invoker.EMP.Charge", this.parent);
        }
    }

    OnReady() {
        if (IsServer()) {
            this.ManaBurnEnemies(this.radius / 2);
            this.ManaBurnEnemies(this.radius);

            if (this.particleId) {
                ParticleManager.DestroyParticle(this.particleId, true);
                ParticleManager.ReleaseParticleIndex(this.particleId);
            }

            StopSoundOn("Hero_Invoker.EMP.Charge", this.parent);
            EmitSoundOn("Hero_Invoker.EMP.Discharge", this.parent);

            this.Destroy();
        }
    }

    ManaBurnEnemies(radius: number) {
        const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
            this.caster,
            this.origin,
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
                damage: this.Value("mana_burn"),
                damage_type: DamageTypes.PURE
            });
            giveMana(enemy, -this.Value("mana_burn"), true, true);
        }
    }

    OnIntervalThink() {
        super.OnIntervalThink();

        if (IsServer()) {
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
                const direction = direction2D(enemy.GetAbsOrigin(), this.origin);
                const point = enemy.GetAbsOrigin().__add(direction.__mul(8));
                enemy.SetAbsOrigin(point);
                FindClearSpaceForUnit(enemy, enemy.GetAbsOrigin(), true);
            }
        }
    }
}
