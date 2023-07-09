import Items from "./items";
import Shards from "./shards";
import Favors from "./favors";
import { Upgrade, UpgradeTypes } from "./common";
import { CustomPlayerHeroNPC } from "../clases/pve/custom_npc";
import Math from "../util/math";
import { CustomEvents } from "../custom_events";
import { findPlayerById } from "../game";
import { CustomActionEvent } from "../game_init";

const Upgrades: Upgrade[] = [...Items, ...Shards, ...Favors];

interface GenerateUpgradesOptions {
    amount: number;
    existingOnly: boolean;
    allowDuplicates: boolean;
    type: UpgradeTypes;
}

export const UpgradeManager = {
    Upgrades,
    ClearUpgrades(customNpc: CustomPlayerHeroNPC): void {
        customNpc.ClearTable("custom_npc_favors");
        const customEvents = CustomEvents.GetInstance();
        customEvents.EmitEvent("pve:current_reward_applied", { customNpc });
    },
    ApplyUpgrade(customNpc: CustomPlayerHeroNPC, upgrade: Upgrade): void {
        if (upgrade.modifier) {
            const ability = upgrade.ability ? customNpc.unit.FindAbilityByName(upgrade.ability) : undefined;
            customNpc.unit.AddNewModifier(customNpc.unit, ability, upgrade.modifier.name, { duration: upgrade.modifier.duration });

            let found = false;
            customNpc.heroUpgrades = customNpc.heroUpgrades.map(heroUpgrade => {
                if (heroUpgrade.id === upgrade.id) {
                    found = true;
                    return {
                        ...heroUpgrade,
                        level: heroUpgrade.level + 1
                    };
                }
                return heroUpgrade;
            });

            if (!found) {
                customNpc.heroUpgrades.push({
                    ...upgrade,
                    level: 1
                });
            }
        }

        if (upgrade.effect) {
            upgrade.effect(customNpc.unit as CDOTA_BaseNPC_Hero);
        }
        if (upgrade.type === UpgradeTypes.ITEM) {
            customNpc.ApplyItem(upgrade);
        }
        if (upgrade.type === UpgradeTypes.FAVOR) {
            customNpc.ApplyFavor(upgrade);
        }
        if (upgrade.type === UpgradeTypes.SHARD) {
            customNpc.ApplyShard(upgrade);
        }

        const customEvents = CustomEvents.GetInstance();
        customEvents.EmitEvent("pve:current_reward_applied", { customNpc });
        this.ClearUpgrades(customNpc);
    },
    GenerateFavors(customNpc: CustomPlayerHeroNPC, amount: number): Upgrade[] {
        return this.GenerateUpgrades(customNpc, {
            amount,
            type: UpgradeTypes.FAVOR,
            allowDuplicates: false,
            existingOnly: false
        });
    },
    GenerateShards(customNpc: CustomPlayerHeroNPC, amount: number): Upgrade[] {
        return this.GenerateUpgrades(customNpc, {
            amount,
            type: UpgradeTypes.SHARD,
            allowDuplicates: false,
            existingOnly: false
        });
    },
    GenerateKnowledge(customNpc: CustomPlayerHeroNPC, amount: number): Upgrade[] {
        return this.GenerateUpgrades(customNpc, {
            amount,
            type: UpgradeTypes.SHARD,
            allowDuplicates: true,
            existingOnly: true
        });
    },
    GenerateItems(customNpc: CustomPlayerHeroNPC, amount: number): Upgrade[] {
        return this.GenerateUpgrades(customNpc, {
            amount,
            type: UpgradeTypes.ITEM,
            allowDuplicates: false,
            existingOnly: false
        });
    },
    GenerateUpgrades(customNpc: CustomPlayerHeroNPC, options: GenerateUpgradesOptions): Upgrade[] {
        const upgrades = Upgrades.filter(upgrade => {
            if (!this.ValidateUpgradeType(upgrade, options.type)) {
                return false;
            }
            if (!this.ValidateUpgradeHero(customNpc, upgrade)) {
                return false;
            }
            if (!this.ValidateUpgradeAbility(customNpc, upgrade)) {
                return false;
            }
            if (!this.ValidateUpgradeAttackCapabilities(customNpc, upgrade)) {
                return false;
            }
            if (!this.ValidateUpgradeStacks(customNpc, upgrade)) {
                return false;
            }
            if (!this.ValidateUpgradeLevel(upgrade)) {
                return false;
            }
            if (!this.ValidateUpgradeIngredients(customNpc, upgrade)) {
                return false;
            }
            if (!options.allowDuplicates && this.ValidateUpgradeAlreadyExists(customNpc, upgrade)) {
                return false;
            }
            if (options.existingOnly && !this.ValidateUpgradeAlreadyExists(customNpc, upgrade)) {
                return false;
            }
            return true;
        });

        return Math.GetRandomElementsFromArray(upgrades, Clamp(options.amount, upgrades.length, 0));
    },
    ValidateUpgradeType: (upgrade: Upgrade, type: UpgradeTypes): boolean => {
        return upgrade.type === type;
    },
    ValidateUpgradeHero: (customNpc: CustomPlayerHeroNPC, upgrade: Upgrade): boolean => {
        if (!upgrade.hero) {
            return true;
        }
        return upgrade.hero === customNpc.unit.GetName();
    },
    ValidateUpgradeAbility: (customNpc: CustomPlayerHeroNPC, upgrade: Upgrade): boolean => {
        if (!upgrade.ability) {
            return true;
        }

        const ability = customNpc.unit.FindAbilityByName(upgrade.ability);
        if (!ability || ability.GetLevel() === 0) {
            return false;
        }

        if (!upgrade.secondaryAbilities) {
            return true;
        }

        for (let i = 0; i < upgrade.secondaryAbilities.length; i++) {
            const secondaryAbilityName = upgrade.secondaryAbilities[i];
            const secondaryAbility = customNpc.unit.FindAbilityByName(secondaryAbilityName);
            if (!secondaryAbility || secondaryAbility.GetLevel() === 0) {
                return false;
            }
        }

        return true;
    },
    ValidateUpgradeAttackCapabilities: (customNpc: CustomPlayerHeroNPC, upgrade: Upgrade): boolean => {
        if (!upgrade.attackCapability) {
            return true;
        }
        if (
            (upgrade.attackCapability === UnitAttackCapability.MELEE_ATTACK && !customNpc.IsMeele()) ||
            (upgrade.attackCapability === UnitAttackCapability.RANGED_ATTACK && !customNpc.IsRanged())
        ) {
            return false;
        }

        return true;
    },
    ValidateUpgradeAlreadyExists: (customNpc: CustomPlayerHeroNPC, upgrade: Upgrade): boolean => {
        const heroUpgrade = customNpc.heroUpgrades.filter(heroUpgrade => heroUpgrade.id === upgrade.id)[0];

        if (!heroUpgrade) {
            return false;
        }

        return true;
    },
    ValidateUpgradeLevel: (upgrade: Upgrade): boolean => {
        if (!upgrade.minLevel) {
            return true;
        }
        if (GameRules.Addon.currentRoom < upgrade.minLevel - 1) {
            return false;
        }
        return true;
    },
    ValidateUpgradeStacks: (customNpc: CustomPlayerHeroNPC, upgrade: Upgrade): boolean => {
        const heroUpgrade = customNpc.heroUpgrades.filter(heroUpgrade => heroUpgrade.id === upgrade.id)[0];

        if (!heroUpgrade) {
            return true;
        }

        if (heroUpgrade.level >= upgrade.maxStacks) {
            return false;
        }

        return true;
    },
    ValidateUpgradeIngredients: (customNpc: CustomPlayerHeroNPC, upgrade: Upgrade): boolean => {
        if (!upgrade.ingredients) {
            return true;
        }

        for (let i = 0; i < upgrade.ingredients.length; i++) {
            const ingredientId = upgrade.ingredients[i];
            const heroUpgrade = customNpc.heroUpgrades.filter(heroUpgrade => heroUpgrade.id === ingredientId)[0];

            if (!heroUpgrade) {
                return false;
            }
        }

        return true;
    }
};

CustomGameEventManager.RegisterListener<CustomActionEvent>("custom_npc:apply_favor", (eventSourceIndex, event) => {
    const playerId = event.playerIndex;
    const player = findPlayerById(playerId);

    if (player) {
        const customNpc = player.customNpc;
        if (customNpc) {
            const upgrade = Upgrades.find(currentUpgrade => currentUpgrade.id === event.payload.upgradeId);
            if (upgrade) {
                UpgradeManager.ApplyUpgrade(customNpc, upgrade);
            }
        }
    }
});

export default Upgrades;
