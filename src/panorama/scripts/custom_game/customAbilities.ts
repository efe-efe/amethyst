import { subscribeToNetTableKey } from "./util";
import { TargetingIndicator } from "./types";

export default class CustomAbilities {
    private static instance: CustomAbilities;
    private abilities: any = {};

    private constructor() {
        subscribeToNetTableKey("main", "abilities", true, data => {
            for (const key in data) {
                this.abilities[key] = data[key];
            }
        });
    }

    public static GetInstance(): CustomAbilities {
        if (!CustomAbilities.instance) {
            CustomAbilities.instance = new CustomAbilities();
        }

        return CustomAbilities.instance;
    }

    public GetTargetingIndicator(abilityIndex: AbilityEntityIndex): TargetingIndicator | undefined {
        const abilityName = Abilities.GetAbilityName(abilityIndex);
        if (this.abilities[abilityName].targetingIndicator) {
            return this.abilities[abilityName].targetingIndicator;
        }
        return undefined;
    }

    public GetEnergyCost(abilityIndex: AbilityEntityIndex): number {
        const abilityName = Abilities.GetAbilityName(abilityIndex);
        if (this.abilities[abilityName]) {
            return this.abilities[abilityName].energyCost;
        }
        return 0;
    }
}
