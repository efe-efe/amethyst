export interface UpgradeModifier {
  name: string;
  duration?: number;
}

export enum UpgradeTypes {
  FAVOR = 0,
  SHARD,
  ITEM,
}
export interface Upgrade {
  id: string;
  name: string;
  description: string;
  hero?: string;
  ability?: string;
  attackCapability?: UnitAttackCapability;
  maxStacks: number;
  modifier?: UpgradeModifier;
  tier: number;
  minLevel?: number;
  effect?(hero: CDOTA_BaseNPC_Hero): void;
  type: UpgradeTypes;
  abilityIconName?: string;
  secondaryAbilities?: string[];
  ingredients?: string[];
  itemName?: string;
}
