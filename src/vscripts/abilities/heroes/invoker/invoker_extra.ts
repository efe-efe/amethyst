import { registerAbility } from "../../../lib/dota_ts_adapter";
import { CustomAbility } from "../../framework/custom_ability";
import { InvokerOrbType } from "./invoker_common";
import { ModifierInvokerHelper } from "./invoker_helper";

type ComboDefinition = [[InvokerOrbType, InvokerOrbType, InvokerOrbType], string];

const comboDefinitions: ComboDefinition[] = [
    [["q", "q", "q"], "invoker_snap_custom"],
    [["q", "q", "w"], "invoker_walk_custom"],
    [["q", "q", "e"], "invoker_wall_custom"],

    [["w", "w", "w"], "invoker_emp_custom"],
    [["w", "w", "q"], "invoker_tornado_custom"],
    [["w", "w", "e"], "invoker_alacrity_custom"],

    [["e", "e", "e"], "invoker_sun_custom"],
    [["e", "e", "q"], "invoker_spirit_custom"],
    [["e", "e", "w"], "invoker_meteor_custom"],

    [["q", "w", "e"], "invoker_blast_custom"]
];

type Combo = {
    orbs: Record<InvokerOrbType, number>;
    abilityName: string;
};

const combos: Combo[] = comboDefinitions.map(([combo, ability]) => {
    return {
        orbs: serializeOrbs(combo),
        abilityName: ability
    };
});

function serializeOrbs(orbs: InvokerOrbType[]) {
    function count(orb: InvokerOrbType) {
        return orbs.filter(x => x == orb).length;
    }

    return {
        q: count("q"),
        w: count("w"),
        e: count("e")
    };
}

@registerAbility("invoker_extra")
export class InvokerExtra extends CustomAbility {
    OnSpellStart() {
        const orbs = serializeOrbs(ModifierInvokerHelper.findOne(this.caster)?.orbs ?? []);
        const combo = combos.find(combo => combo.orbs.q == orbs.q && combo.orbs.w == orbs.w && combo.orbs.e == orbs.e);

        if (combo) {
            const invokedAbility = this.caster.FindAbilityByName(combo.abilityName);
            const currentAbilities = [this.caster.GetAbilityByIndex(7), this.caster.GetAbilityByIndex(8)];

            if (!invokedAbility || !currentAbilities[0] || !currentAbilities[1]) {
                return;
            }

            this.caster.SwapAbilities(currentAbilities[0].GetName(), currentAbilities[1].GetName(), true, true);

            if (currentAbilities.includes(invokedAbility)) {
                return;
            }

            this.caster.SwapAbilities(invokedAbility.GetName(), currentAbilities[0].GetName(), true, false);
            EmitSoundOn("Hero_Invoker.Invoke", this.caster);
        }
    }
}
