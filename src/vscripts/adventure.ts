/* eslint-disable no-case-declarations */
import { UnitAIContext, updateUnitAI } from "./ai";
import { updateAnimations } from "./animation";
import { updateEntityData, updateEntityMovement } from "./common";
import { Entity, findEntityByHandle } from "./entities";
import { FindStage, Game, getGame } from "./game";
import { ModifierMiniStun } from "./modifiers/modifier_mini_stun";
import { ModifierShield } from "./modifiers/modifier_shield";
import { NpcDefinition, NpcId, findNpcDefinitionById } from "./npc_definitions";
import { Player } from "./players";
import { precache, resource } from "./precache";
import { RewardDefinition, blessingDefinitions, findRewardById } from "./reward_definitions";
import {
    SimpleTrigger,
    allAbilities,
    createTimedRadiusMarker,
    encodeToJson,
    fullyFaceTowards,
    simpleTrigger,
    takeRandomFromArrayWeightedUnsafe,
    triggerNow
} from "./util";

const resources = precache({
    spawn: resource.fx("particles/econ/events/ti10/portal/portal_open_good.vpcf"),
    death: resource.fx("particles/econ/events/new_bloom/dragon_death.vpcf"),
    breakableBounty: resource.unit("npc_dota_breakable_bounty"),
    bountySpawn1: resource.fx("particles/units/heroes/hero_chen/chen_hand_of_god.vpcf"),
    bountySpawn2: resource.fx("particles/reward_effect_impact.vpcf"),
    bountySpawn3: resource.fx("particles/econ/items/zeus/arcana_chariot/zeus_arcana_blink_start.vpcf"),
    bountySpawn4: resource.fx("particles/econ/items/zeus/arcana_chariot/zeus_arcana_blink_end.vpcf"),
    bountySpawn5: resource.fx("particles/reward_effect_extra.vpcf"),
    bountySpawn6: resource.fx("particles/reward_effect.vpcf"),
    bountyDeath1: resource.fx("particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf"),
    bountyDeath2: resource.fx("particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf")
});

type AdventureStage = FindStage<Game, Stage.adventure>;

type RewardParticipant = {
    player: Player;
    selected: boolean;
    options: UpgradeId[];
};

//TODO: Add the preselect into select thing
type ExitParticipant = {
    player: Player;
    // preSelected?: {};
};

type Exit = {
    origin: Vector;
    instance?: {
        chamberDefinition: ChamberDefinition;
        rewardId: RewardId;
    };
};

declare global {
    interface AddStage {
        [Stage.adventure]: BaseStage & {
            startedAt: number;
            worldDefinition: WorldDefinition;
            loading: boolean;
            state:
                | {
                      id: "fight";
                      wave: Wave;
                      waveDefinitions: WaveDefinition[];
                      mapHandle: SpawnGroupHandle;
                      exits: Exit[];
                  }
                | {
                      id: "reward";
                      mapHandle: SpawnGroupHandle;
                      participants: RewardParticipant[];
                      reward: Reward;
                      exits: Exit[];
                  }
                | {
                      id: "exit";
                      mapHandle: SpawnGroupHandle;
                      //   participants: ExitParticipant[];
                      exits: Exit[];
                      selected?: Exit;
                  };
        };
    }
}

type WorldDefinition = {
    chamberDefinitions: ChamberDefinition[];
};

type ChamberDefinition = {
    variations: ChamberVariation[];
};

type ChamberVariation = {
    waveDefinitions: WaveDefinition[];
    map: string;
    chance: number;
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

type Reward = {
    definition: RewardDefinition;
    handle?: CDOTA_BaseNPC;
    particles: ParticleID[];
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
    7
);

const centaurWave = defineWave([{ npc: { id: NpcId.centaur, shieldPct: 0 }, amount: 1 }]);

const direWorldDefinition: WorldDefinition = {
    chamberDefinitions: [
        {
            variations: [{ waveDefinitions: [], chance: 100, map: "dire_0" }]
        },
        {
            variations: [{ waveDefinitions: [rangedsWave], chance: 100, map: "dire_1" }]
        },
        {
            variations: [{ waveDefinitions: [onlyFlyingWave], chance: 100, map: "dire_2" }]
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

function serializeParticipants(config: GameConfig): RewardParticipant[] {
    return config.players.map(player => ({
        player: player,
        selected: false,
        options: []
    }));
}

function createReward(definition: RewardDefinition, origin: Vector): Reward {
    const handle = CreateUnitByName(resources.breakableBounty.path, origin, true, undefined, undefined, DotaTeam.NOTEAM);
    handle.SetModel(definition.model);
    handle.SetModelScale(definition.scale);
    handle.SetMaxHealth(Constants.bountyHealth);
    handle.SetBaseMaxHealth(Constants.bountyHealth);
    handle.SetHealth(Constants.bountyHealth);

    EmitSoundOn("Hero_Oracle.FortunesEnd.Target", handle);
    const particles: ParticleID[] = [
        EFX(resources.bountySpawn1.path, ParticleAttachment.ABSORIGIN_FOLLOW, handle, {}),
        EFX(resources.bountySpawn2.path, ParticleAttachment.ABSORIGIN_FOLLOW, handle, {
            cp1: handle.GetAbsOrigin()
        }),
        EFX(resources.bountySpawn3.path, ParticleAttachment.ABSORIGIN_FOLLOW, handle, {}),
        EFX(resources.bountySpawn4.path, ParticleAttachment.ABSORIGIN_FOLLOW, handle, {}),
        EFX(resources.bountySpawn5.path, ParticleAttachment.ABSORIGIN_FOLLOW, handle, {}),
        EFX(resources.bountySpawn6.path, ParticleAttachment.ABSORIGIN_FOLLOW, handle, {
            cp1: Vector(100, 100, 100)
        })
    ];

    return {
        definition: definition,
        handle: handle,
        particles: particles
    };
}

function spawnMap(map: string, origin: Vector): Promise<SpawnGroupHandle> {
    return new Promise(resolve => {
        DOTA_SpawnMapAtPosition(
            map,
            origin,
            true,
            maps => ManuallyTriggerSpawnGroupCompletion(maps),
            maps => resolve(maps),
            undefined
        );
    });
}

function tryCreatingRewardById(RewardId: RewardId, origin: Vector) {
    const rewardDefinition = findRewardById(RewardId);

    if (!rewardDefinition) {
        throw "ERROR, REWARD NOT FOUND";
    }

    return createReward(rewardDefinition, GetGroundPosition(origin, undefined));
}

function tryGettingChamberDefinition(worldDefinition: WorldDefinition) {
    const chamberDefinition = worldDefinition.chamberDefinitions.splice(0, 1)[0];
    if (!chamberDefinition) {
        throw "Unable to find chamber definition";
    }

    return chamberDefinition;
}

function tryGeneratingExits(): Exit[] {
    const exits = Entities.FindAllByName("exit")?.map(entity => ({
        origin: entity.GetAbsOrigin()
    }));

    if (!exits) {
        throw "ERROR, NOT EXIT FOUND";
    }

    return exits;
}

function getPlayersEntities(config: GameConfig) {
    return config.players.map(player => player.entity).filter((entity): entity is Entity => entity != undefined);
}

function repositionHeroes(config: GameConfig) {
    const spawnOrigin = Entities.FindByName(undefined, "spawn")?.GetAbsOrigin() ?? Vector(0, 0, 0);
    for (const entity of getPlayersEntities(config)) {
        FindClearSpaceForUnit(entity.handle, spawnOrigin, true);
    }
}

export async function initAdventureStage(config: GameConfig): Promise<AdventureStage> {
    const chamberDefinition = tryGettingChamberDefinition(direWorldDefinition);
    const chamberVariation = takeRandomFromArrayWeightedUnsafe(chamberDefinition.variations, variation => variation.chance);
    const mapHandle = await spawnMap(chamberVariation.map, Vector(0, 0, 0));

    repositionHeroes(config);

    return {
        stage: Stage.adventure,
        config,
        startedAt: GameRules.GetGameTime(),
        worldDefinition: direWorldDefinition,
        loading: false,
        state: {
            id: "reward",
            mapHandle: mapHandle,
            participants: serializeParticipants(config),
            reward: tryCreatingRewardById(RewardId.blessing, GetGroundPosition(Vector(0, 0, 0), undefined)),
            exits: tryGeneratingExits()
        },
        players: () => config.players
    };
}

export async function updateAdventureStage(game: AdventureStage) {
    function generateBlessingsForPlayer(player: Player) {
        const elegible = blessingDefinitions
            .filter(
                blessing =>
                    !player.upgrades.some(upgradeId => upgradeId == blessing.id) && blessing.hero == player.entity?.handle.GetUnitName()
            )
            .map(blessing => blessing.id);

        return elegible;
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
        updateEntityMovement(entity);
        updateEntityData(entity);
    }

    if (game.loading) {
        return;
    }

    switch (game.state.id) {
        case "reward":
            const rewardHandle = game.state.reward.handle;

            if (rewardHandle) {
                if (rewardHandle.IsAlive()) {
                    const currentAngle = (GameRules.GetGameTime() % (Math.PI * 2)) * 2.0;
                    fullyFaceTowards(rewardHandle, Vector(Math.cos(currentAngle), Math.sin(currentAngle)));
                    rewardHandle.SetModel(game.state.reward.definition.model);
                    rewardHandle.SetModelScale(game.state.reward.definition.scale);
                } else {
                    for (const particleId of game.state.reward.particles) {
                        ParticleManager.DestroyParticle(particleId, false);
                        ParticleManager.ReleaseParticleIndex(particleId);
                    }

                    EmitSoundOn("Hero_Magnataur.ReversePolarity.Cast", rewardHandle);
                    EFX(resources.bountyDeath1.path, ParticleAttachment.WORLDORIGIN, undefined, {
                        cp0: rewardHandle.GetAbsOrigin(),
                        cp2: Vector(255, 80, 230),
                        release: true
                    });
                    EFX(resources.bountyDeath2.path, ParticleAttachment.WORLDORIGIN, undefined, {
                        cp0: rewardHandle.GetAbsOrigin(),
                        cp5: rewardHandle.GetAbsOrigin(),
                        release: true
                    });
                    rewardHandle.AddNoDraw();

                    game.state.reward.handle = undefined;

                    game.state.participants = game.state.participants.map(participant => ({
                        ...participant,
                        options: generateBlessingsForPlayer(participant.player)
                    }));

                    for (const participant of game.state.participants) {
                        CustomNetTables.SetTableValue("pve", participant.player.id.toString(), {
                            selection: {
                                upgrades: encodeToJson(participant.options),
                                type: game.state.reward.definition.id
                            }
                        });
                    }
                }
            }

            if (game.state.participants.some(participant => !participant.selected)) {
                break;
            }

            const chamberDefinition = tryGettingChamberDefinition(game.worldDefinition);

            for (const exit of game.state.exits) {
                createTimedRadiusMarker(
                    getPlayersEntities(game.config).map(entity => entity.handle)[0],
                    exit.origin,
                    250,
                    0,
                    999,
                    "public"
                );
            }

            game.state = {
                id: "exit",
                mapHandle: game.state.mapHandle,
                exits: game.state.exits.map(exit => ({
                    origin: exit.origin,
                    instance: {
                        chamberDefinition: chamberDefinition,
                        rewardId: RewardId.blessing
                    }
                }))
            };

            break;

        case "exit":
            const selectedExit = game.state.selected;
            const heroes = getPlayersEntities(game.config).map(entity => entity.handle);

            if (!selectedExit || !selectedExit.instance) {
                for (const exit of game.state.exits) {
                    const units = FindUnitsInRadius(
                        DotaTeam.NOTEAM,
                        exit.origin,
                        undefined,
                        250,
                        UnitTargetTeam.BOTH,
                        UnitTargetType.HERO,
                        UnitTargetFlags.NONE,
                        FindOrder.ANY,
                        false
                    ).filter(unit => heroes.includes(unit));

                    if (units.length > 0) {
                        game.state.selected = exit;
                    }
                }
                break;
            }

            const chamberVariation = takeRandomFromArrayWeightedUnsafe(
                selectedExit.instance.chamberDefinition.variations,
                variation => variation.chance
            );

            UnloadSpawnGroupByHandle(game.state.mapHandle);

            game.loading = true;

            const mapHandle = await spawnMap(chamberVariation.map, Vector(0, 0, 0));
            const exits = tryGeneratingExits();
            const wave = serializeWave(chamberVariation.waveDefinitions.splice(0, 1)[0]);

            repositionHeroes(game.config);

            game.state = {
                id: "fight",
                exits: exits,
                mapHandle: mapHandle,
                wave: wave,
                waveDefinitions: chamberVariation.waveDefinitions
            };

            game.loading = false;

            break;
        case "fight":
            if (game.state.wave.npcs.every(npc => npc.instance.id == "removed")) {
                const waveDefinition = game.state.waveDefinitions.splice(0, 1)[0];

                if (!waveDefinition) {
                    game.state = {
                        id: "reward",
                        mapHandle: game.state.mapHandle,
                        participants: serializeParticipants(game.config),
                        reward: tryCreatingRewardById(RewardId.blessing, GetGroundPosition(Vector(0, 0, 0), undefined)),
                        exits: game.state.exits
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
                        EFX(resources.death.path, ParticleAttachment.ABSORIGIN_FOLLOW, npc.instance.handle, {
                            release: true
                        });

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
    }

    updateAnimations();
}

CustomGameEventManager.RegisterListener("pickUpgrade", (_, event) => {
    const game = getGame();
    const playerId = event.PlayerID;

    if (game.stage == Stage.adventure && game.state.id == "reward") {
        const participant = game.state.participants.find(participant => participant.player.id == playerId);

        if (participant) {
            participant.selected = true;
            participant.options = [];

            CustomNetTables.SetTableValue("pve", participant.player.id.toString(), {
                selection: undefined
            });
        }
    }
});
