import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { direction2D, getCursorPosition } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

@registerAbility("invoker_second_attack")
class InvokerSecondAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_GHOST_WALK;
    }
    GetPlaybackRateOverride() {
        return 1.5;
    }
    GetCastingCrawl() {
        return 20;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);
        const damage = this.GetSpecialValueFor("ability_damage");
        const duration = this.GetSpecialValueFor("duration");

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/invoker/invoker_second_attack.vpcf",
            spawnOrigin: origin.__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: damage,
                    damage_type: DamageTypes.PURE
                });

                ModifierInvokerSecondAttack.apply(unit, projectile.getSource(), this, {
                    duration: duration
                });
            },
            onFinish: projectile => {
                EFX(
                    "particles/units/heroes/hero_invoker_kid/invoker_kid_forged_spirit_projectile_end.vpcf",
                    ParticleAttachment.WORLDORIGIN,
                    undefined,
                    {
                        cp0: projectile.getPosition(),
                        cp3: projectile.getPosition(),
                        release: true
                    }
                );
            }
        });

        EmitSoundOn("Hero_Invoker.Attack", this.caster);
        EmitSoundOn("Hero_Invoker.ColdSnap.Cast", this.caster);
    }
}

@registerModifier({ customNameForI18n: "modifier_invoker_second_attack" })
class ModifierInvokerSecondAttack extends CustomModifier {
    OnCreated() {
        if (IsServer()) {
            this.StartIntervalThink(1.0);
        }
    }

    OnIntervalThink() {
        ApplyDamage({
            victim: this.parent,
            attacker: this.caster,
            damage: this.Value("dps"),
            damage_type: DamageTypes.PURE
        });
    }

    // function modifier_invoker_second_attack:GetStatusLabel() return "Burning" }
    // function modifier_invoker_second_attack:GetStatusPriority() return 2 }
    // function modifier_invoker_second_attack:GetStatusStyle() return "Burning" }
}
// if(IsClient() ) { require("wrappers/modifiers") }
// Modifiers.Status(modifier_invoker_second_attack)
