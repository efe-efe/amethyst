interface AbilityMeta {
  targetingIndicator: string;
  energyCost: number;
}

type AbilitiesMeta = {
  [key: string]: AbilityMeta;
};

const abilitiesKv = LoadKeyValues("scripts/npc/npc_abilities_custom.txt");
const meta: AbilitiesMeta = {};

for (const [key, ability] of Object.entries(abilitiesKv)) {
  meta[key] = {
    targetingIndicator: ability.TargetingIndicator ?? {},
    energyCost: ability.AbilityEnergyCost ?? 0,
  };
}

CustomNetTables.SetTableValue("main" as never, "abilities", meta as never);
