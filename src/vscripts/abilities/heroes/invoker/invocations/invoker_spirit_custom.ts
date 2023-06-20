import { registerAbility, registerModifier } from "../../../../lib/dota_ts_adapter";
import { clampPosition, direction2D, fullyFaceTowards, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../../util";
import { CustomAbility } from "../../../framework/custom_ability";
import { CustomModifier } from "../../../framework/custom_modifier";
import { InvokerBasicAttack } from "../invoker_basic_attack";

@registerAbility("invoker_spirit_custom")
class InvokerSpirit extends CustomAbility {
    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, { maxRange: this.GetCastRange(Vector(0, 0, 0), undefined) });

        const spirit = CreateUnitByName(
            "npc_dota_creature_invoker_spirit_custom",
            point,
            true,
            this.caster,
            this.caster,
            this.caster.GetTeam()
        );
        ModifierInvokerSpirit.apply(spirit, this.caster, this, { duration: this.GetSpecialValueFor("duration") });
    }
}

@registerModifier({ customNameForI18n: "modifier_invoker_spirit_custom" })
class ModifierInvokerSpirit extends CustomModifier {
    particleId?: ParticleID;

    OnCreated() {
        if (IsServer()) {
            this.particleId = EFX(
                "particles/econ/items/invoker/ti8_invoker_prism_crystal_spellcaster/ti8_invoker_prism_forge_spirit_ambient.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent,
                {}
            );
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_ABILITY_EXECUTED];
    }

    OnAbilityExecuted(event: ModifierAbilityEvent) {
        if (IsServer()) {
            if (event.unit != this.caster) {
                return;
            }

            const invokerBasicAttack = InvokerBasicAttack.findOne(this.caster);
            if (event.ability == invokerBasicAttack) {
                const origin = this.parent.GetAbsOrigin();
                const point = CustomAbilitiesLegacy.GetCursorPosition(this.ability);
                const direction = direction2D(origin, point);

                fullyFaceTowards(this.parent, direction);
                this.LaunchProjectile(point);
                this.parent.StartGesture(GameActivity.DOTA_ATTACK);
            }
        }
    }

    OnDestroy() {
        if (IsServer()) {
            if (this.particleId) {
                DEFX(this.particleId, true);
            }
            this.parent.Kill(undefined, this.parent);
        }
    }

    LaunchProjectile(point: Vector) {
        if (IsServer()) {
            const origin = this.parent.GetAbsOrigin();
            const manaGainPct = this.ability.GetSpecialValueFor("mana_gain_pct");
            const projectileSpeed = this.ability.GetSpecialValueFor("projectile_speed");
            const projectileDirection = direction2D(origin, point);
            const damage = this.parent.GetAverageTrueAttackDamage(this.parent);

            this.ability.ProjectileAttack({
                source: this.caster,
                effectName: "particles/invoker/invoker_spirit_projectile.vpcf",
                spawnOrigin: origin.__add(Vector(0, 0, 96)),
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

                    if (projectile.getSource() == this.parent) {
                        if (!isObstacle(unit) && !isGem(unit)) {
                            giveManaAndEnergyPercent(this.caster, manaGainPct, true);
                        }
                    }
                },
                onFinish: projectile => {
                    EFX(
                        "particles/units/heroes/hero_invoker_kid/invoker_kid_forged_spirit_projectile_end.vpcf",
                        ParticleAttachment.WORLDORIGIN,
                        undefined,
                        {
                            cp0: projectile.getPosition(),
                            cp3: projectile.getPosition()
                        }
                    );
                }
            });
        }
    }
}
