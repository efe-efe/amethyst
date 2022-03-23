import { Upgrade, UpgradeTypes } from "./common";

const Shards: Upgrade[] = [
];

const Favors: Upgrade[] = [
    {
        id: "juggernaut_blade_dance_recast",
        name: "Blade Dance recast",
        description: "Blade Dance can be recasted to perform a slash. Can be used freely for a short time while not missing. The recast duration dependes on the stacks used.",
        ability: "juggernaut_second_attack",
        maxStacks: 1,
        modifier: {},
        tier: 0,
    },
    {
        id: "juggernaut_fury_reflects",
        name: "Blade Fury reflects",
        description: "Blade Fury reflect enemy projectiles.",
        ability: "juggernaut_mobility",
        maxStacks: 1,
        modifier: {},
        tier: 0,
    },
    {
        id: "juggernaut_fury_attack",
        name: "Blade Fury attacks",
        description: "Blade Fury damage count as basic attacks",
        ability: "juggernaut_mobility",
        maxStacks: 1,
        modifier: {},
        tier: 0,
    },
    {
        id: "juggernaut_refresh_dagger",
        name: "Refreshing dagger",
        description: "Your dagger cooldown is drastically reduced when succesfully hitting enemies but increased when missing.",
        ability: "juggernaut_special_attack",
        maxStacks: 1,
        modifier: {},
        tier: 1,
    },
    {
        id: "juggernaut_spinning_ward",
        name: "Spinning Ward",
        description: "Your Healing Ward also spins when you activates your Blade Fury. It also resists 5 hits instead of 1.",
        ability: "juggernaut_extra",
        //secondaryAbilities: ['juggernaut_mobility'],
        maxStacks: 1,
        modifier: {},
        tier: 1,
    },
].map((favor) => ({
    ...favor,
    type: UpgradeTypes.FAVOR,
    modifier: {
        ...favor.modifier,
        name: `modifier_upgrade_${favor.id}`,
    },
}));

const JuggernautRewards = {
    Shards,
    Favors,
};

export default JuggernautRewards;