import { Upgrade, UpgradeTypes } from "./common";

const Shards: Upgrade[] = [
  {
    id: "phantom_dash_damage",
    name: "Swift knives",
    description: "Your Swift leaves a fan of knives on its original position.",
    ability: "phantom_mobility",
    maxStacks: 5,
    modifier: {},
    tier: 1,
  },
  {
    id: "phantom_dash_shield",
    name: "Swift shield",
    description:
      "Your Swift gives you shield for a short period of time after passing through enemies and increases its range.",
    ability: "phantom_mobility",
    maxStacks: 5,
    modifier: {},
    tier: 1,
  },
  {
    id: "phantom_strike_knives",
    name: "Strike knives",
    description:
      "Your Phantom Strike leaves a fan of knives on the arival location.",
    ability: "phantom_counter",
    maxStacks: 5,
    modifier: {},
    tier: 1,
  },
].map((shard) => ({
  ...shard,
  type: UpgradeTypes.SHARD,
  modifier: {
    ...shard.modifier,
    name: `modifier_upgrade_${shard.id}`,
  },
}));

const Favors: Upgrade[] = [
  {
    id: "phantom_extra_daggers",
    name: "Extra daggers",
    description: "Your Stiffling Daggers throws 3 daggers.",
    ability: "phantom_special_attack",
    maxStacks: 1,
    modifier: {},
    tier: 1,
  },
  {
    id: "phantom_fast_daggers",
    name: "Fast daggers",
    description:
      "Your Stiffling Daggers cooldown is two times to your attack speed, but no longer apply slow.",
    ability: "phantom_special_attack",
    maxStacks: 1,
    modifier: {},
    tier: 1,
  },
  {
    id: "phantom_coup_cast_fast",
    name: "Coup de Grace cast fast",
    description: "Reduces the cast time of Coup de Grace considerably.",
    ability: "phantom_ultimate",
    maxStacks: 1,
    modifier: {},
    tier: 1,
  },
  {
    id: "phantom_countering_stacks",
    name: "Phantom Strike stacks",
    description:
      "Your Phantom Strike consumes all your Phantom Stacks to multiply your damage while the attack speed buff is on.",
    ability: "phantom_counter",
    maxStacks: 1,
    modifier: {},
    tier: 1,
  },
  {
    id: "phantom_act_while_countering",
    name: "Phantom Strike while acting",
    description:
      "You can act while in counter state but the counter state duration its reduced.",
    ability: "phantom_counter",
    maxStacks: 1,
    modifier: {},
    tier: 1,
  },
  {
    id: "phantom_strike_instant",
    name: "Phantom Strike instant effect",
    description:
      "Your Phantom Strike is activated instantly without the need to be activated by an attack, but no longer heals and the banish duration is reduced.",
    ability: "phantom_counter",
    maxStacks: 1,
    modifier: {},
    tier: 1,
  },
  {
    id: "phantom_quick_recast",
    name: "Phantom Quick Strike recast",
    description:
      "Your Quick Strike can be used again for free after hitting at least one enemy.",
    ability: "phantom_extra",
    maxStacks: 1,
    modifier: {},
    tier: 1,
  },
  {
    id: "phantom_critical_recast",
    name: "Phantom Critical Strike recast",
    description:
      "Your Critical Strike can be used again after hitting at least one enemy.",
    ability: "phantom_second_attack",
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

const PhantomRewards = {
  Shards,
  Favors,
};

export default PhantomRewards;
