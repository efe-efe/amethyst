/* eslint-disable no-case-declarations */
import { UnitAIContext, updateUnitAI } from "./ai";
import { updateAnimations } from "./animation";
import { updateEntityData, updateEntityMovement } from "./common";
import { Entity, findEntityByHandle } from "./entities";
import { FindStage, Game } from "./game";
import { ModifierMiniStun } from "./modifiers/modifier_mini_stun";
import { ModifierShield } from "./modifiers/modifier_shield";
import { NpcDefinition, NpcId, findNpcDefinitionById } from "./npc_definitions";
import { precache, resource } from "./precache";
import { SimpleTrigger, allAbilities, simpleTrigger, takeRandomFromArrayWeightedUnsafe, triggerNow } from "./util";

const resources = precache({
    spawn: resource.fx("particles/econ/events/ti10/portal/portal_open_good.vpcf")
});

type AdventureStage = FindStage<Game, Stage.adventure>;

declare global {
    interface AddStage {
        [Stage.adventure]: BaseStage & {
            startedAt: number;
            worldDefinition: WorldDefinition;
            state:
                | {
                      id: "fight";
                      wave: Wave;
                      waveDefinitions: WaveDefinition[];
                      mapHandle: SpawnGroupHandle;
                  }
                | {
                      id: "reward";
                      mapHandle: SpawnGroupHandle;
                  };
        };
    }
}

type WorldDefinition = {
    chamberDefinitions: ChamberDefinition[];
};

type ChamberDefinition = {
    variations: {
        waveDefinitions: WaveDefinition[];
        map: string;
        chance: number;
    }[];
};

type WaveDefinition = {
    npcs: {
        npc: {
            id: NpcId;
            shieldPct: number;
        };
        amount: number;
    }[];
    maxNpcs?: number;
};

type Wave = {
    npcs: WaveNpc[];
    maxNpcs?: number;
};

type WaveNpc = {
    definition: NpcDefinition;
    shieldPct: number;
    instance:
        | {
              id: "standby";
          }
        | {
              id: "creating";
              origin: Vector;
              trigger: SimpleTrigger;
              particleId: ParticleID;
          }
        | {
              id: "created";
              trigger: SimpleTrigger;
              handle: CDOTA_BaseNPC;
              entity: Entity;
              tauntTrigger?: SimpleTrigger;
              cooldownTrigger?: SimpleTrigger;
              context: UnitAIContext;
          }
        | {
              id: "removed";
          };
};

function defineWave(
    npcs: {
        npc: { id: NpcId; shieldPct: number };
        amount: number;
    }[],
    maxNpcs?: number
): WaveDefinition {
    return {
        npcs: npcs,
        maxNpcs: maxNpcs
    };
}

const rangedsWave = defineWave([
    {
        npc: {
            id: NpcId.direRange,
            shieldPct: 50
        },
        amount: 1
    },
    {
        npc: {
            id: NpcId.direRangeMega,
            shieldPct: 0
        },
        amount: 1
    }
]);

const mixedRangeFlying = defineWave([
    {
        npc: {
            id: NpcId.direRange,
            shieldPct: 0
        },
        amount: 2
    },
    {
        npc: {
            id: NpcId.flyingSkull,
            shieldPct: 0
        },
        amount: 4
    }
]);

const onlyRangeWave = defineWave(
    [
        {
            npc: {
                id: NpcId.direRange,
                shieldPct: 0
            },
            amount: 5
        }
    ],
    1
);

const onlyFlyingWave = defineWave(
    [
        {
            npc: {
                id: NpcId.flyingSkull,
                shieldPct: 50
            },
            amount: 10
        }
    ],
    1
);

const centaurWave = defineWave([{ npc: { id: NpcId.centaur, shieldPct: 0 }, amount: 1 }]);

const direWorldDefinition: WorldDefinition = {
    chamberDefinitions: [
        {
            variations: [{ waveDefinitions: [rangedsWave], chance: 100, map: "dire_1" }]
        },
        {
            variations: [{ waveDefinitions: [centaurWave], chance: 100, map: "dire_2" }]
        }
    ]
};

function serializeWave(waveDefinition: WaveDefinition): Wave {
    const waveNpcs: WaveNpc[] = [];

    for (const npcs of waveDefinition.npcs) {
        const definition = findNpcDefinitionById(npcs.npc.id);

        if (definition) {
            for (let i = 0; i < npcs.amount; i++) {
                waveNpcs.push({
                    shieldPct: npcs.npc.shieldPct,
                    definition: definition,
                    instance: {
                        id: "standby"
                    }
                });
            }
        }
    }

    return {
        npcs: waveNpcs,
        maxNpcs: waveDefinition.maxNpcs
    };
}

export function initAdventureStage(config: GameConfig): AdventureStage {
    const chamberDefinition = direWorldDefinition.chamberDefinitions.splice(0, 1)[0];

    if (!chamberDefinition) {
        throw "Unable to find chamber definition";
    }

    const chamber = takeRandomFromArrayWeightedUnsafe(chamberDefinition.variations, variation => variation.chance);
    const wave = serializeWave(chamber.waveDefinitions.splice(0, 1)[0]);

    const mapHandle = DOTA_SpawnMapAtPosition(
        chamber.map,
        Vector(0, 0, 0),
        true,
        maps => ManuallyTriggerSpawnGroupCompletion(maps),
        () => {},
        undefined
    );

    return {
        stage: Stage.adventure,
        config,
        startedAt: GameRules.GetGameTime(),
        worldDefinition: direWorldDefinition,
        state: {
            id: "fight",
            wave: wave,
            waveDefinitions: chamber.waveDefinitions,
            mapHandle: mapHandle
        },
        players: () => config.players
    };
}

export function updateAdventureStage(game: AdventureStage) {
    function canCreateUnit(wave: Wave) {
        if (!wave.maxNpcs) {
            return true;
        }

        const maxNpcs = wave.maxNpcs;
        const npcs = wave.npcs.filter(npc => npc.instance.id == "created" || npc.instance.id == "creating");

        return npcs.length < maxNpcs;
    }

    const entities = game
        .players()
        .map(player => player.entity)
        .filter((entity): entity is Entity => entity != undefined);

    for (const entity of entities) {
        updateEntityMovement(entity);
        updateEntityData(entity);
    }

    switch (game.state.id) {
        case "fight":
            if (game.state.wave.npcs.every(npc => npc.instance.id == "removed")) {
                const waveDefinition = game.state.waveDefinitions.splice(0, 1)[0];

                if (!waveDefinition) {
                    game.state = {
                        id: "reward",
                        mapHandle: game.state.mapHandle
                    };

                    break;
                }

                game.state = {
                    ...game.state,
                    wave: serializeWave(waveDefinition)
                };

                break;
            }

            for (const npc of game.state.wave.npcs) {
                if (npc.instance.id == "standby" && canCreateUnit(game.state.wave)) {
                    const origin = Vector(RandomInt(-1000, 1000), RandomInt(-1000, 1000), 128);
                    const particleId = EFX(resources.spawn.path, ParticleAttachment.WORLDORIGIN, undefined, {
                        cp0: origin
                    });

                    npc.instance = {
                        id: "creating",
                        particleId: particleId,
                        origin: origin,
                        trigger: simpleTrigger(GameRules.GetGameTime() + 1.5)
                    };
                }

                if (npc.instance.id == "creating" && triggerNow(npc.instance.trigger)) {
                    ParticleManager.DestroyParticle(npc.instance.particleId, false);
                    ParticleManager.ReleaseParticleIndex(npc.instance.particleId);

                    const handle = CreateUnitByName(npc.definition.unit, npc.instance.origin, true, undefined, undefined, DotaTeam.NOTEAM);
                    const entity = findEntityByHandle(handle);

                    if (npc.definition.hullRadius) {
                        handle.SetHullRadius(npc.definition.hullRadius);
                    }

                    if (entity) {
                        if (npc.shieldPct > 0) {
                            ModifierShield.apply(handle, handle, undefined, {
                                damageBlock: (handle.GetMaxHealth() * npc.shieldPct) / 100
                            });
                        }

                        ModifierMiniStun.apply(handle, handle, undefined, {});

                        npc.instance = {
                            id: "created",
                            handle: handle,
                            entity: entity,
                            context: { id: "idle" },
                            trigger: npc.instance.trigger
                        };
                    }
                }

                if (npc.instance.id == "created") {
                    if (!npc.instance.handle.IsAlive()) {
                        npc.instance = {
                            id: "removed"
                        };
                    } else {
                        npc.instance.context = updateUnitAI({
                            entity: npc.instance.entity,
                            unit: npc.instance.handle,
                            abilities: [...allAbilities(npc.instance.handle)],
                            allies: [],
                            enemies: entities.map(entity => entity.handle),
                            context: npc.instance.context,
                            behavior: npc.definition.behavior,
                            minFollowRange: npc.definition.minFollowRange,
                            followRange: npc.definition.followRange
                        });
                        updateEntityMovement(npc.instance.entity);
                        updateEntityData(npc.instance.entity);
                    }
                }
            }

            break;
        case "reward":
            const chamberDefinition = direWorldDefinition.chamberDefinitions.splice(0, 1)[0];

            if (!chamberDefinition) {
                //End...
                break;
            }

            const chamber = takeRandomFromArrayWeightedUnsafe(chamberDefinition.variations, variation => variation.chance);
            const wave = serializeWave(chamber.waveDefinitions.splice(0, 1)[0]);

            UnloadSpawnGroupByHandle(game.state.mapHandle);

            const mapHandle = DOTA_SpawnMapAtPosition(
                chamber.map,
                Vector(0, 0, 0),
                true,
                maps => ManuallyTriggerSpawnGroupCompletion(maps),
                () => {},
                undefined
            );

            game.state = {
                id: "fight",
                waveDefinitions: chamber.waveDefinitions,
                wave: wave,
                mapHandle: mapHandle
            };

            break;
    }

    updateAnimations();
}
