import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierCharges } from "../../../modifiers/modifier_charges";
import { giveMana } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { InvokerOrbType } from "./invoker_common";

@registerAbility("invoker_helper")
class InvokerHelper extends CustomAbility {
    GetIntrinsicModifierName() {
        return ModifierInvokerHelper.name;
    }
}

@registerModifier({ customNameForI18n: "modifier_invoker_helper" })
export class ModifierInvokerHelper extends ModifierCharges {
    orbs: InvokerOrbType[] = [];

    OnCreated() {
        super.OnCreated();

        if (IsServer()) {
            this.parent.FindAbilityByName("invoker_extra")?.SetHidden(false);
            this.parent.FindAbilityByName("invoker_ultimate")?.SetHidden(false);
            this.parent.FindAbilityByName("invoker_empty1")?.SetHidden(false);
            this.parent.FindAbilityByName("invoker_empty2")?.SetHidden(false);
            this.SetStackCount(this.orbs.length);
        }
    }

    OnAbilityFullyCast(event: ModifierAbilityEvent) {
        super.OnAbilityFullyCast(event);

        const orb = abilityToOrb[event.ability.GetName()];
        if (orb != undefined) {
            this.RemoveCharge();
            this.AddOrb(orb.type);
            this.Update();
        }
    }

    GetMaxCharges() {
        return this.Value("max_charges");
    }

    GetReplenishType(): "sync" | "async" {
        return "sync";
    }

    GetReplenishTime() {
        return this.Value("replenish_time");
    }

    AddOrb(orb: InvokerOrbType) {
        if (this.orbs.length === 3) {
            this.orbs.shift();
        }

        this.orbs.push(orb);
    }

    Update() {
        for (const orb of Object.values(abilityToOrb)) {
            this.parent.RemoveAllModifiersOfName(orb.modifier.name);
        }

        this.orbs.forEach((orb, index) => {
            orbToModifier[orb]?.apply(this.parent, this.caster, undefined, { index: index + 1 });
        });
    }
}

abstract class ModifierInvokerOrb extends CustomModifier<undefined> {
    particleId!: ParticleID;

    abstract GetParticleName(): string;

    IsDebuff() {
        return false;
    }

    IsPurgable() {
        return false;
    }

    RemoveOnDeath() {
        return false;
    }

    OnCreated(params: { index: number }) {
        if (IsServer()) {
            this.particleId = EFX(this.GetParticleName(), ParticleAttachment.OVERHEAD_FOLLOW, this.parent, {});
            ParticleManager.SetParticleControlEnt(
                this.particleId,
                1,
                this.parent,
                ParticleAttachment.POINT_FOLLOW,
                `attach_orb${params.index}`,
                this.parent.GetAbsOrigin(),
                false
            );
        }
    }

    OnDestroy() {
        if (IsServer()) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }

    GetAttributes() {
        return ModifierAttribute.MULTIPLE;
    }
}

@registerModifier({ customNameForI18n: "modifier_invoker_orb_quas" })
class ModifierInvokerQuas extends ModifierInvokerOrb {
    GetParticleName() {
        return "particles/units/heroes/hero_invoker/invoker_quas_orb.vpcf";
    }

    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE];
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return 3;
    }

    GetTexture() {
        return "invoker_quas";
    }
}

@registerModifier({ customNameForI18n: "modifier_invoker_orb_exort" })
class ModifierInvokerExort extends ModifierInvokerOrb {
    GetParticleName() {
        return "particles/units/heroes/hero_invoker/invoker_exort_orb.vpcf";
    }

    DeclareFunctions() {
        return [ModifierFunction.PREATTACK_BONUS_DAMAGE];
    }

    GetModifierPreAttack_BonusDamage() {
        return 1;
    }

    GetTexture() {
        return "invoker_exort";
    }
}

@registerModifier({ customNameForI18n: "modifier_invoker_orb_wex" })
class ModifierInvokerWex extends ModifierInvokerOrb {
    OnCreated(params: { index: number }) {
        super.OnCreated(params);

        if (IsServer()) {
            this.StartIntervalThink(3.0);
        }
    }

    OnIntervalThink() {
        giveMana(this.parent, 1, true, true);
    }

    GetParticleName() {
        return "particles/units/heroes/hero_invoker/invoker_wex_orb.vpcf";
    }

    GetTexture() {
        return "invoker_wex";
    }
}

export type ModifierInvokerOrbType = typeof ModifierInvokerQuas | typeof ModifierInvokerWex | typeof ModifierInvokerExort;

const orbToModifier: Record<InvokerOrbType, ModifierInvokerOrbType> = {
    ["q"]: ModifierInvokerQuas,
    ["w"]: ModifierInvokerWex,
    ["e"]: ModifierInvokerExort
};

const abilityToOrb: Record<string, { type: InvokerOrbType; modifier: ModifierInvokerOrbType }> = {
    ["invoker_counter"]: { type: "q", modifier: orbToModifier["q"] },
    ["invoker_special_attack"]: { type: "e", modifier: orbToModifier["e"] },
    ["invoker_ultimate"]: { type: "w", modifier: orbToModifier["w"] }
};

export abstract class InvokerOrb extends CustomAbility {
    CastFilterResult() {
        const charges = ModifierInvokerHelper.findOne(this.caster)?.GetStackCount() ?? 0;
        return charges <= 0 ? UnitFilterResult.FAIL_CUSTOM : UnitFilterResult.SUCCESS;
    }

    GetCustomCastError() {
        return "Not orb charges";
    }

    OnSpellStart() {
        this.caster.StartGestureWithPlaybackRate(
            RandomInt(0, 1) == 0 ? GameActivity.DOTA_OVERRIDE_ABILITY_1 : GameActivity.DOTA_OVERRIDE_ABILITY_2,
            1.0
        );
    }
}
