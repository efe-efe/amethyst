import { Upgrade, UpgradeTypes } from "./common";

const Shards: Upgrade[] = [];

const Favors: Upgrade[] = [
    {
        id: "sniper_snipe_cast_fast",
        name: "Quick snipe",
        description: "Your Snipe cast point is reduced drastically.",
        ability: "sniper_second_attack",
        maxStacks: 1,
        modifier: {
            name: "ModifierUpgradeSniperFastSnipe"
        },
        tier: 1,
        type: UpgradeTypes.FAVOR
    },
    {
        id: "sniper_jump_knockback",
        name: "Jump knockback",
        description: "Your jump knocks back enemies and deals damage to enemies at the arrival area.",
        ability: "sniper_mobility",
        maxStacks: 1,
        modifier: {
            name: "ModifierUpgradeSniperJumpKnockback"
        },
        tier: 1,
        type: UpgradeTypes.FAVOR
    }
];

const SniperRewards = {
    Shards,
    Favors
};

export default SniperRewards;
