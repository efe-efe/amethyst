import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { OnHitEvent } from "../../../modifiers/modifier_combat_events";
import { ModifierCounter } from "../../../modifiers/modifier_counter";
import { CustomAbility } from "../../framework/custom_ability";
import { PangoSecondAttack } from "./pango_second_attack";
import { PangoSpecialAttack } from "./pango_special_attack";

@registerAbility("pango_counter")
class PangoCounter extends CustomAbility {
    OnSpellStart() {
        ModifierPangoCounter.apply(this.caster, this.caster, this, {
            duration: this.GetSpecialValueFor("counter_duration")
        });
    }
}

@registerModifier()
class ModifierPangoCounter extends ModifierCounter {
    OnDestroy() {
        super.OnDestroy();
        if (IsServer()) {
            ParticleManager.ReleaseParticleIndex(
                ParticleManager.CreateParticle(
                    "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bonus.vpcf",
                    ParticleAttachment.ABSORIGIN_FOLLOW,
                    this.caster
                )
            );
        }
    }

    OnHit(event: OnHitEvent) {
        if (IsServer()) {
            if (!event.triggerCounters) {
                return true;
            }

            const origin = this.caster.GetAbsOrigin();
            const direction = this.caster.GetForwardVector();
            const pangoSecondAttack = PangoSecondAttack.findOne(this.caster);
            const range = (pangoSecondAttack?.GetCastRange(Vector(0, 0, 0), undefined) ?? 1) / 2;
            pangoSecondAttack?.Cut(origin, direction, range);
            pangoSecondAttack?.Cut(origin, direction.__mul(-1), range);

            const perpendicularDirection = Vector(direction.y, direction.x, 0);

            pangoSecondAttack?.Cut(origin, perpendicularDirection, range);
            pangoSecondAttack?.Cut(origin, perpendicularDirection.__mul(-1), range);

            const pangoSpecialAttack = PangoSpecialAttack.findOne(this.parent);
            pangoSpecialAttack?.EndCooldown();
            pangoSpecialAttack?.Crash(450);

            this.Destroy();

            if (event.attackCategory == "projectile" && event.projectile.getIsDestructible()) {
                event.projectile.scheduleDestroy();
            }
            return false;
        }

        return true;
    }

    GetMovementSpeedPercentage() {
        return 0;
    }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_3;
    }

    GetOverrideAnimationRate() {
        return 0.4;
    }
}
