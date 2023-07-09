import { UnitAIContext, updateUnitAI } from "./ai";
import { updateMovement } from "./common";
import { Entity, findEntityByHandle, setEntityDirection } from "./entities";
import { FindStage, Game } from "./game";
import { ModifierMiniStun } from "./modifiers/modifier_mini_stun";
import { ModifierShield } from "./modifiers/modifier_shield";
import { NpcDefinition, NpcId, findNpcDefinitionById } from "./npc_definitions";
import { precache, resource } from "./precache";
import {
    SimpleTrigger,
    allAbilities,
    direction2D,
    distanceBetweenPoints,
    simpleTrigger,
    takeRandomFromArrayWeightedUnsafe,
    triggerNow
} from "./util";

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
                      chamber: Chamber;
                  }
                | {
                      id: "reward";
                  };
        };
    }
}

type WorldDefinition = {
    chamberDefinitions: ChamberDefinition[];
};

type ChamberDefinition = {
    variations: {
        waves: WaveDefinition[];
        chance: number;
    }[];
};

type Chamber = WaveDefinition[];

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

const onlyRangeWave = defineWave([
    {
        npc: {
            id: NpcId.direRange,
            shieldPct: 0
        },
        amount: 5
    }
]);

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
    5
);

const centaurWave = defineWave([{ npc: { id: NpcId.centaur, shieldPct: 0 }, amount: 1 }]);

const direWorldDefinition: WorldDefinition = {
    chamberDefinitions: [
        {
            variations: [{ waves: [onlyFlyingWave, onlyRangeWave], chance: 100 }]
        },
        {
            variations: [{ waves: [centaurWave], chance: 100 }]
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

    const chamber = takeRandomFromArrayWeightedUnsafe(chamberDefinition.variations, variation => variation.chance).waves;
    const wave = serializeWave(chamber.splice(0, 1)[0]);

    return {
        stage: Stage.adventure,
        config,
        startedAt: GameRules.GetGameTime(),
        worldDefinition: direWorldDefinition,
        state: {
            id: "fight",
            wave: wave,
            chamber: chamber
        },
        players: () => config.players
    };
}

export function updateAdventureStage(game: AdventureStage) {
    function updateAI(npc: WaveNpc) {
        if (npc.instance.id != "created") {
            return;
        }

        // ListenToGameEvent("entity_hurt", event => OnUnitHurt(event), undefined);
        // function FindEnemy(radius: number): CDOTA_BaseNPC | undefined {
        //     const units = FindUnitsInRadius(
        //         unit.GetTeamNumber(),
        //         unit.GetAbsOrigin(),
        //         undefined,
        //         radius,
        //         UnitTargetTeam.ENEMY,
        //         UnitTargetType.HERO + UnitTargetType.BASIC,
        //         UnitTargetFlags.NO_INVIS,
        //         FindOrder.ANY,
        //         false
        //     );
        //     if (units.length > 0) {
        //         return units[0];
        //     } else {
        //         return undefined;
        //     }
        // }
        // function UpdateTarget(): void {
        //     const currentFollowRange = tauntedRemainingDuration > 0 ? tauntedFollowRange : followRange;
        //     if (followTarget) {
        //         if (distanceBetweenEntities(unit, followTarget) <= currentFollowRange && !followTarget.IsInvisible()) {
        //             return;
        //         } else {
        //             followTarget = undefined;
        //         }
        //     } else {
        //         followTarget = FindEnemy(followRange);
        //     }
        // }
        function follow(unit: CDOTA_BaseNPC) {
            // const origin = unit.GetAbsOrigin();
            // UpdateTarget();
            // if (followTarget && followTarget.IsAlive()) {
            //     const distance = distanceBetweenEntities(unit, followTarget);
            //     let direction = Vector(0, 0);
            //     if (followTarget.IsAlive() && distance > minFollowRange) {
            //         direction = followTarget.GetAbsOrigin().__sub(origin).Normalized();
            //     }
            //     CustomEntitiesLegacy.SetDirection(unit, direction.x, direction.y);
            //     return true;
            // }
            // return false;
        }

        // function StartRest(restTime: number): void {
        //     remainingRestTime = restTime * 30;
        // }
        // function BackToOrigin(origin: Vector): boolean {
        //     const distanceFromOrigin = originalPosition.__sub(origin).Length2D();
        //     if (rangeOfAction > distanceFromOrigin) {
        //         return false;
        //     }
        //     const direction = originalPosition.__sub(origin).Normalized();
        //     CustomEntitiesLegacy.SetDirection(unit, direction.x, direction.y);
        //     return true;
        // }

        // function ClearTargetPosition(): void {
        //     targetPosition = undefined;
        // }
        // function OnUnitHurt(event: EntityHurtEvent): void {
        //     const victim = EntIndexToHScript(event.entindex_killed) as CDOTA_BaseNPC;
        //     if (unit === victim) {
        //         tauntedRemainingDuration = tauntedDuration * 30;
        //     }
        // }

        if (npc.definition.behavior == "follower") {
            //             if (!Follow()) {
            //                 StopMoving();
            //             }
        }

        if (npc.instance.tauntTrigger && triggerNow(npc.instance.tauntTrigger)) {
        }
        //     if (remainingRestTime > 0) {
        //         remainingRestTime = remainingRestTime - 1;
        //     }
        //     if (!Cast()) {
        //         if (behavior === CustomAIBehavior.WANDERER) {
        //         } else {
        //         }
        //     } else {
        //         remainingRestTime = 1.0 * 30;
        //         ClearTargetPosition();
        //         StopMoving();
        //     }
    }

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
        updateMovement(entity);
    }

    switch (game.state.id) {
        case "fight":
            if (game.state.wave.npcs.every(npc => npc.instance.id == "removed")) {
                const waveDefinition = game.state.chamber.splice(0, 1)[0];

                if (!waveDefinition) {
                    game.state = {
                        id: "reward"
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
                        updateMovement(npc.instance.entity);
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

            const chamber = takeRandomFromArrayWeightedUnsafe(chamberDefinition.variations, variation => variation.chance).waves;
            const wave = serializeWave(chamber.splice(0, 1)[0]);

            game.state = {
                id: "fight",
                chamber: chamber,
                wave: wave
            };

            break;
    }
}
