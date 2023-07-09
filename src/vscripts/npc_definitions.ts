import { UnitAIBehavior } from "./ai";
import { precache, resource } from "./precache";

const npcDefinitions: NpcDefinition[] = [];

export const enum NpcId {
    queenOfPain = "queenOfPain",
    centaur = "centaur",
    radiantRangeMega = "radiantRangeMega",
    radiantMeeleMega = "radiantMeeleMega",
    direMeeleMega = "direMeeleMega",
    direRangeMega = "direRangeMega",
    direRange = "direRange",
    direTower = "direTower",
    flyingSkull = "flyingSkull"
}

const resources = precache({
    queenOfPain: resource.unit("npc_dota_hero_queenofpain"),
    centaur: resource.unit("npc_dota_hero_centaur"),
    radiantRangeMega: resource.unit("npc_dota_radiant_creep_range_mega"),
    radiantMeeleMega: resource.unit("npc_dota_radiant_creep_meele_mega"),
    direMeeleMega: resource.unit("npc_dota_dire_creep_meele_mega"),
    direRangeMega: resource.unit("npc_dota_dire_creep_range_mega"),
    direRange: resource.unit("npc_dota_dire_creep_range"),
    direTower: resource.unit("npc_dota_dire_tower"),
    flyingSkull: resource.unit("npc_dota_flying_skull")
});

export type NpcDefinition = {
    id: NpcId;
    unit: string;
    followRange: number;
    minFollowRange: number;
    restTime: number;
    behavior: UnitAIBehavior;
    tauntedFollowRange: number;
    tauntedDuration: number;
    rangeOfAction: number; //How far can they move from the starting position
    tier: "boss" | "miniBoss" | "hard" | "medium" | "basic";
    hullRadius?: number;
};

type NpcOptions = {
    id: NpcId;
    unit: string;
    followRange?: number;
    minFollowRange?: number;
    restTime?: number;
    behavior?: UnitAIBehavior;
    tauntedFollowRange?: number;
    tauntedDuration?: number;
    rangeOfAction?: number;
    tier: "boss" | "miniBoss" | "hard" | "medium" | "basic";
    hullRadius?: number;
};

function defineNpc(options: NpcOptions) {
    const followRange = options.followRange ?? 2500;
    const restTime = options.restTime ?? 1;
    const tauntedFollowRange = followRange * 1.5;
    const minFollowRange = options.minFollowRange ?? 0;
    const behavior = options.behavior ?? "follower";
    const tauntedDuration = options.tauntedDuration ?? 3;
    const rangeOfAction = options.rangeOfAction ?? 3000;

    const definition = {
        id: options.id,
        unit: options.unit,
        followRange: followRange,
        minFollowRange: minFollowRange,
        restTime: restTime,
        behavior: behavior,
        tauntedFollowRange: tauntedFollowRange,
        tauntedDuration: tauntedDuration,
        rangeOfAction: rangeOfAction,
        tier: options.tier,
        hullRadius: options.hullRadius
    };

    npcDefinitions.push(definition);

    return definition;
}

defineNpc({
    id: NpcId.queenOfPain,
    unit: resources.queenOfPain.path,
    minFollowRange: 500,
    tier: "boss"
});

defineNpc({
    id: NpcId.centaur,
    unit: resources.centaur.path,
    tier: "boss"
});

defineNpc({
    id: NpcId.radiantRangeMega,
    unit: resources.radiantRangeMega.path,
    behavior: "wanderer",
    tier: "medium"
});

defineNpc({
    id: NpcId.radiantMeeleMega,
    unit: resources.radiantMeeleMega.path,
    behavior: "wanderer",
    tier: "medium"
});

defineNpc({
    id: NpcId.direRange,
    unit: resources.direRange.path,
    behavior: "wanderer",
    tier: "basic"
});

defineNpc({
    id: NpcId.direRangeMega,
    unit: resources.direRangeMega.path,
    behavior: "wanderer",
    tier: "medium",
    hullRadius: 95
});

defineNpc({
    id: NpcId.direMeeleMega,
    unit: resources.direMeeleMega.path,
    behavior: "wanderer",
    tier: "medium"
});

defineNpc({
    id: NpcId.flyingSkull,
    unit: resources.flyingSkull.path,
    behavior: "follower",
    tier: "basic",
    followRange: 800,
    minFollowRange: 150
});

defineNpc({
    id: NpcId.direTower,
    unit: resources.direTower.path,
    behavior: "static",
    tier: "hard",
    hullRadius: 100
});

export function findNpcDefinitionById(id: NpcId) {
    return npcDefinitions.find(definition => definition.id == id);
}
