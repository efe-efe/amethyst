import { CustomAbility } from "./custom_ability";

type AbilityCategory = "basic" | "secondary" | "mobility" | "counter" | "special" | "extra";

type AbilityDefinition = {
    name: string;
    category: AbilityCategory;
    linkedAbility?: {
        name: string;
        shareCooldown: boolean;
    };
};

type AbilityOptions = {
    category: AbilityCategory;
    linkedAbility?: {
        name: string;
        shareCooldown: boolean;
    };
};

let listLocked = false;

const abilityDefinitions: AbilityDefinition[] = [];
const abilityDefinitionByName: Partial<Record<string, AbilityDefinition>> = {};

export function defineAbility(code: typeof CustomAbility, options: AbilityOptions) {
    // Top-level constructs are called every time an ability is spawned, so we need to prevent re-registration of abilities
    if (listLocked || IsClient()) return;

    const definition = {
        name: code.name,
        category: options.category,
        linkedAbility: options.linkedAbility
    };

    abilityDefinitions.push(definition);
    abilityDefinitionByName[definition.name] = definition;

    print("Registered ability", definition.name);
}

export function findAbilityDefinitionByName(name: string) {
    return abilityDefinitionByName[name];
}

export function lockAbilityList() {
    listLocked = true;
}
