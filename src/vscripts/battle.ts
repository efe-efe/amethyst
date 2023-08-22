import { CustomModifier } from "./abilities/framework/custom_modifier";
import { updateAnimations } from "./animation";
import { updateEntityData, updateEntityMovement } from "./common";
import { Entity, findEntityByHandle, trueHealEntity } from "./entities";
import { FindStage, Game } from "./game";
import { GemDefinition, findGemDefinitionByType, gemDefinitions } from "./gem_definitions";
import { registerModifier } from "./lib/dota_ts_adapter";
import { ModifierAdrenaline } from "./modifiers/modifier_adrenaline";
import { ModifierCasting } from "./modifiers/modifier_casting";
import { ModifierShield } from "./modifiers/modifier_shield";
import { precache, resource } from "./precache";
import {
    SimpleTrigger,
    direction2D,
    fullyFaceTowards,
    giveManaAndEnergy,
    randomInArray,
    refreshCooldowns,
    setEnergy,
    simpleTrigger,
    strongPurge,
    triggerNow
} from "./util";

type Respawnable = {
    origin: Vector;
    unit: string;
    trigger: SimpleTrigger;
    handle?: CDOTA_BaseNPC;
};

type Pickup = {
    radius: number;
    effect: (unit: CDOTA_BaseNPC) => void;
    particle: string;
    respawnable: Respawnable;
    model: string;
};

type Gem = {
    definition: GemDefinition;
    respawnable: Respawnable;
    progressParticleId: ParticleID;
    lightParticleIds: ParticleID[];
    startedAt: number;
    listener?: EventListenerID;
};

const gems = gemDefinitions.map(definition => definition.type);

declare global {
    interface AddStage {
        [Stage.battle]: BaseStage & {
            startedAt: number;
            round: number;
            spawnPoints: {
                dummies: Vector[];
                gems: Vector[];
            };
            state:
                | { id: "afterFightPreview"; finishAt: number }
                | {
                      id: "warmup";
                      finishAt: number;
                      dummies: Respawnable[];
                  }
                | {
                      id: "fight";
                      healthOrbs: Pickup[];
                      manaOrbs: Pickup[];
                      shieldOrbs: Pickup[];
                      deathOrbs: Pickup[];
                      gem: Gem;
                      arrowParticles: ParticleID[];
                      lights: {
                          trigger: SimpleTrigger;
                          particleId?: ParticleID;
                      }[];
                  };
        };
    }
}

const resources = precache({
    dummy: resource.unit("npc_dota_creature_dummy_target"),
    pickup: resource.unit("npc_dota_pickup"),
    gem: resource.unit("npc_dota_breakable_bounty"),
    clarity: resource.model("models/props_gameplay/clarity.vmdl"),
    salve: resource.model("models/props_gameplay/salve.vmdl"),
    shield: resource.model("models/props_gameplay/stout_shield.vmdl"),
    death: resource.model("models/props_items/bloodstone.vmdl"),
    healthParticle: resource.fx("particles/generic_gameplay/rune_regeneration.vpcf"),
    manaParticle: resource.fx("particles/generic_gameplay/rune_doubledamage.vpcf"),
    shieldParticle: resource.fx("particles/generic_gameplay/rune_bounty.vpcf"),
    deathParticle: resource.fx("particles/generic_gameplay/rune_haste.vpcf"),
    gemArrow: resource.fx("particles/gem_finder.vpcf"),
    gemProgress: resource.fx("particles/progress_circle/generic_progress_circle.vpcf"),
    gemExplosion: resource.fx("particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf"),
    gemExplosionNova: resource.fx("particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf"),
    gemSpawn: resource.fx("particles/units/heroes/hero_chen/chen_hand_of_god.vpcf"),
    gemSpawnLight: resource.fx("particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf")
});

type BattleStage = FindStage<Game, Stage.battle>;

@registerModifier()
class ModifierPickup extends CustomModifier<undefined> {
    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_ITEM_DROP;
    }

    GetOverrideAnimationRate() {
        return 1.0;
    }

    CheckState() {
        return {
            [ModifierState.INVULNERABLE]: true,
            [ModifierState.NO_UNIT_COLLISION]: true,
            [ModifierState.MAGIC_IMMUNE]: true
        };
    }
}

export function initBattleStage(config: GameConfig, round: number): BattleStage {
    const dummySpawnPoints = Entities.FindAllByName("dummy_target").map(entity => entity.GetAbsOrigin());
    const gemSpawnPoints = Entities.FindAllByName("orb_spawn").map(entity => entity.GetAbsOrigin());

    const dummies: Respawnable[] = dummySpawnPoints.map(spawnPoint => ({
        origin: spawnPoint,
        unit: resources.dummy.path,
        trigger: simpleTrigger(GameRules.GetGameTime() + 2.0)
    }));

    return {
        stage: Stage.battle,
        config,
        startedAt: GameRules.GetGameTime(),
        players: () => config.players,
        state: { id: "warmup", finishAt: GameRules.GetGameTime() + Constants.warmupDuration, dummies: dummies },
        round: round,
        spawnPoints: {
            dummies: dummySpawnPoints,
            gems: gemSpawnPoints
        }
    };
}

function resetEntity(entity: Entity) {
    const unit = entity.handle;

    if (!IsInToolsMode()) {
        unit.SetMana(0);
        setEnergy(unit, 0, true);
    }

    unit.SetHealth(unit.GetMaxHealth());
    entity.threshold = Constants.maxThreshold;
    refreshCooldowns(unit);
    unit.RemoveModifierByName(ModifierCasting.name);
    strongPurge(unit);
}

function createPickup(options: {
    particle: string;
    origin: Vector;
    model: string;
    effect: (unit: CDOTA_BaseNPC) => void;
    respawnRate: number;
}): Pickup {
    return {
        radius: 120,
        effect: options.effect,
        particle: options.particle,
        model: options.model,
        respawnable: {
            unit: resources.pickup.path,
            origin: options.origin,
            trigger: simpleTrigger(GameRules.GetGameTime() + options.respawnRate),
            handle: undefined
        }
    };
}

function createGem(options: { definition: GemDefinition; origin: Vector; respawnRate: number }): Gem {
    const particleId = EFX(resources.gemProgress.path, ParticleAttachment.WORLDORIGIN, undefined, {
        cp0f: Vector(0, -1, 0),
        cp0: options.origin - Vector(0, 0, 120),
        cp1: Vector(250, 0, 1),
        cp15: options.definition.color,
        cp16: Vector(1, 0, 0)
    });

    return {
        definition: options.definition,
        respawnable: {
            origin: options.origin,
            unit: options.definition.model,
            trigger: simpleTrigger(GameRules.GetGameTime() + options.respawnRate)
        },
        progressParticleId: particleId,
        lightParticleIds: [],
        startedAt: GameRules.GetGameTime()
    };
}

function spawnGem(gem: Gem) {
    const handle = CreateUnitByName(resources.gem.path, gem.respawnable.origin, false, undefined, undefined, DotaTeam.NOTEAM);

    ParticleManager.SetParticleControl(gem.progressParticleId, 1, Vector(250, 1, 0));

    EmitSoundOn("Hero_Oracle.FortunesEnd.Target", handle);
    EFX(resources.gemSpawn.path, ParticleAttachment.ABSORIGIN_FOLLOW, handle, { release: true });
    EFX(resources.gemSpawnLight.path, ParticleAttachment.ABSORIGIN_FOLLOW, handle, { release: true });
    EFX(gem.definition.particle, ParticleAttachment.ABSORIGIN_FOLLOW, handle, {
        release: true
    });

    return handle;
}

function removeGem(handle: CDOTA_BaseNPC, listenerId?: EventListenerID) {
    EmitSoundOn("Hero_Magnataur.ReversePolarity.Cast", handle);
    EFX(resources.gemExplosion.path, ParticleAttachment.WORLDORIGIN, undefined, {
        cp0: handle.GetAbsOrigin(),
        cp2: Vector(255, 80, 230),
        release: true
    });
    EFX(resources.gemExplosionNova.path, ParticleAttachment.WORLDORIGIN, undefined, {
        cp0: handle.GetAbsOrigin(),
        cp5: handle.GetAbsOrigin(),
        release: true
    });

    handle.AddNoDraw();

    if (listenerId) {
        StopListeningToGameEvent(listenerId);
    }
}

function createGemDeathListener(gemDefinition: GemDefinition, gemHandle: CDOTA_BaseNPC) {
    return ListenToGameEvent(
        "entity_killed",
        event => {
            const killed = EntIndexToHScript(event.entindex_killed);
            const killer = EntIndexToHScript(event.entindex_attacker);

            if (killer?.IsBaseNPC() && killed === gemHandle) {
                gemDefinition.effect(killer);
            }
        },
        undefined
    );
}

function removeParticles(particleIds: (ParticleID | undefined)[]) {
    for (const particleId of particleIds) {
        if (particleId) {
            ParticleManager.DestroyParticle(particleId, true);
            ParticleManager.ReleaseParticleIndex(particleId);
        }
    }
}

function updateFight(game: BattleStage) {
    function updateUnit(unit: CDOTA_BaseNPC, model: string, scale?: number) {
        unit.SetModel(model);
        unit.SetModelScale(scale ?? 1);

        const currentAngle = (GameRules.GetGameTime() % (Math.PI * 2)) * 2.0;

        fullyFaceTowards(unit, Vector(Math.cos(currentAngle), Math.sin(currentAngle)));
    }

    function scheduleLights() {
        const lights = [];
        for (let i = 0; i < 4; i++) {
            lights.push({
                trigger: simpleTrigger(GameRules.GetGameTime() + (i * Constants.gemRespawnTime) / 5),
                particleId: undefined
            });
        }

        return lights;
    }

    function spawnArrows(color: Vector, to: Vector) {
        const arrows: ParticleID[] = [];

        for (const spawnPoint of game.spawnPoints.gems) {
            if (spawnPoint == to) {
                continue;
            }

            const direction = direction2D(spawnPoint, to);
            const particleId = ParticleManager.CreateParticle(resources.gemArrow.path, ParticleAttachment.WORLDORIGIN, undefined);
            ParticleManager.SetParticleControl(particleId, 0, spawnPoint);
            ParticleManager.SetParticleControl(particleId, 2, spawnPoint.__add(direction.__mul(Vector(128, 128, 0))));
            ParticleManager.SetParticleControl(particleId, 60, color);
            ParticleManager.SetParticleControl(particleId, 61, Vector(1, 0, 0));
            arrows.push(particleId);
        }

        return arrows;
    }

    const now = GameRules.GetGameTime();

    const entities = game
        .players()
        .map(player => player.entity)
        .filter((entity): entity is Entity => entity != undefined);

    switch (game.state.id) {
        case "warmup": {
            for (const entity of entities) {
                updateEntityMovement(entity);
                updateEntityData(entity);
            }

            for (const respawnable of game.state.dummies) {
                if (triggerNow(respawnable.trigger)) {
                    respawnable.handle = CreateUnitByName(
                        respawnable.unit,
                        respawnable.origin,
                        true,
                        undefined,
                        undefined,
                        DotaTeam.NOTEAM
                    );
                }

                if (respawnable.handle && !respawnable.handle.IsAlive()) {
                    respawnable.handle = undefined;
                    respawnable.trigger = simpleTrigger(GameRules.GetGameTime() + 5.0);
                }
            }

            if (now > game.state.finishAt) {
                const radiantSpawn = Entities.FindByName(undefined, "radiant_spawn")?.GetAbsOrigin() ?? Vector(0, 0, 0);
                const direSpawn = Entities.FindByName(undefined, "dire_spawn")?.GetAbsOrigin() ?? Vector(0, 0, 0);

                for (const respawnable of game.state.dummies) {
                    respawnable.handle?.Kill(undefined, respawnable.handle);
                }

                for (const player of game.players()) {
                    if (player.entity) {
                        const hero = player.entity.handle;
                        const origin = player.alliance?.id == AllianceId.radiant ? radiantSpawn : direSpawn;

                        FindClearSpaceForUnit(hero, origin, true);
                        resetEntity(player.entity);
                        // CustomEntitiesLegacy.AutoUpgradeAbilities(hero);
                        hero.RemoveModifierByName("modifier_restricted");
                        ModifierAdrenaline.apply(hero, hero, undefined, {
                            duration: Constants.adrenalineDuration
                        });
                    }
                }

                const healthOrbs = Entities.FindAllByName("health_orb").map(entity =>
                    createPickup({
                        effect: (unit: CDOTA_BaseNPC) => {
                            const entity = findEntityByHandle(unit);

                            if (entity) {
                                const heal = 3;

                                unit.Heal(heal, undefined);
                                trueHealEntity(entity, heal);

                                EmitSoundOn("DOTA_Item.FaerieSpark.Activate", unit);
                            }
                        },
                        origin: entity.GetAbsOrigin(),
                        particle: resources.healthParticle.path,
                        model: resources.salve.path,
                        respawnRate: Constants.pickupsSpawnRate
                    })
                );

                const manaOrbs = Entities.FindAllByName("mana_orb").map(entity =>
                    createPickup({
                        effect: (unit: CDOTA_BaseNPC) => {
                            const mana = 8;
                            giveManaAndEnergy(unit, mana, true, true);
                            EmitSoundOn("DOTA_Item.ClarityPotion.Activate", unit);
                        },
                        origin: entity.GetAbsOrigin(),
                        particle: resources.manaParticle.path,
                        model: resources.clarity.path,
                        respawnRate: Constants.pickupsSpawnRate
                    })
                );

                const shieldOrbs = Entities.FindAllByName("shield_orb").map(entity =>
                    createPickup({
                        effect: (unit: CDOTA_BaseNPC) => {
                            const damageBlock = 16;
                            ModifierShield.apply(unit, unit, undefined, { duration: 6.0, damageBlock: damageBlock });
                            EmitSoundOn("Hero_Sven.GodsStrength.Attack", unit);
                            EmitSoundOn("Hero_Abaddon.AphoticShield.Cast", unit);
                        },
                        origin: entity.GetAbsOrigin(),
                        particle: resources.shieldParticle.path,
                        model: resources.shield.path,
                        respawnRate: Constants.pickupsSpawnRate
                    })
                );

                const gemDefinition = findGemDefinitionByType("amethyst");

                if (!gemDefinition) {
                    throw "Error: GEM NOT FOUND!";
                }

                const gem = createGem({
                    definition: gemDefinition,
                    origin: randomInArray(game.spawnPoints.gems),
                    respawnRate: Constants.gemSpawnTime
                });

                game.state = {
                    id: "fight",
                    healthOrbs: healthOrbs,
                    manaOrbs: manaOrbs,
                    shieldOrbs: shieldOrbs,
                    deathOrbs: [],
                    gem: gem,
                    arrowParticles: spawnArrows(gem.definition.color, gem.respawnable.origin),
                    lights: scheduleLights()
                };
            }

            break;
        }

        case "fight": {
            for (const entity of entities) {
                updateEntityMovement(entity);
                updateEntityData(entity);
            }

            for (const pickup of [...game.state.healthOrbs, ...game.state.manaOrbs, ...game.state.shieldOrbs, ...game.state.deathOrbs]) {
                if (triggerNow(pickup.respawnable.trigger)) {
                    pickup.respawnable.handle = CreateUnitByName(
                        resources.pickup.path,
                        pickup.respawnable.origin,
                        false,
                        undefined,
                        undefined,
                        DotaTeam.NOTEAM
                    );

                    ModifierPickup.apply(pickup.respawnable.handle, pickup.respawnable.handle, undefined, {});
                    ParticleManager.CreateParticle(pickup.particle, ParticleAttachment.ABSORIGIN_FOLLOW, pickup.respawnable.handle);
                }

                if (pickup.respawnable.trigger.triggered && pickup.respawnable.handle) {
                    updateUnit(pickup.respawnable.handle, pickup.model);

                    const unit = FindUnitsInRadius(
                        pickup.respawnable.handle.GetTeamNumber(),
                        pickup.respawnable.origin,
                        undefined,
                        pickup.radius,
                        UnitTargetTeam.BOTH,
                        UnitTargetType.ALL,
                        UnitTargetFlags.INVULNERABLE,
                        FindOrder.CLOSEST,
                        false
                    )
                        .filter(unit => unit != pickup.respawnable.handle)
                        .shift();
                    if (unit) {
                        pickup.effect(unit);
                        pickup.respawnable.trigger = simpleTrigger(GameRules.GetGameTime() + Constants.pickupsSpawnRate);
                        pickup.respawnable.handle.Kill(undefined, pickup.respawnable.handle);
                        pickup.respawnable.handle = undefined;
                    }
                }
            }

            const gem = game.state.gem;

            if (triggerNow(gem.respawnable.trigger)) {
                gem.respawnable.handle = spawnGem(gem);
                gem.listener = createGemDeathListener(gem.definition, gem.respawnable.handle);
            } else {
                const triggerAt = gem.respawnable.trigger.triggerAt;
                const duration = triggerAt - gem.startedAt;
                const elapsed = GameRules.GetGameTime() - gem.startedAt;
                const percentage = elapsed / duration;
                ParticleManager.SetParticleControl(gem.progressParticleId, 1, Vector(250, percentage, 0));

                for (const light of game.state.lights) {
                    if (triggerNow(light.trigger)) {
                        const current = game.state.lights.filter(light => light.trigger.triggered).length - 1;
                        const offset = gem.respawnable.origin.__add(Vector(0, -1, 0).__mul(250));
                        const rotated = RotatePoint(gem.respawnable.origin, offset, 72 * current);

                        light.particleId = EFX(gem.definition.particle, ParticleAttachment.WORLDORIGIN, undefined, {
                            cp0: GetGroundPosition(rotated, undefined),
                            release: false
                        });
                    }
                }
            }

            const gemHandle = gem.respawnable.handle;

            if (gem.respawnable.trigger.triggered && gemHandle) {
                updateUnit(gemHandle, gem.definition.model, gem.definition.scale);

                gemHandle.SetAbsOrigin(GetGroundPosition(gemHandle.GetAbsOrigin(), undefined).__add(Vector(0, 0, 128)));

                if (gemHandle && !gemHandle.IsAlive()) {
                    removeGem(gemHandle, gem.listener);

                    removeParticles(game.state.arrowParticles);
                    removeParticles([game.state.gem.progressParticleId]);
                    removeParticles(game.state.lights.map(light => light.particleId));

                    game.state.lights = scheduleLights();

                    const gemDefinition = findGemDefinitionByType(randomInArray(gems.filter(gemType => gemType != gem.definition.type)));

                    if (gemDefinition) {
                        game.state.gem = createGem({
                            definition: gemDefinition,
                            origin: randomInArray(game.spawnPoints.gems.filter(origin => origin != gem.respawnable.origin)),
                            respawnRate: Constants.gemSpawnTime
                        });
                        game.state.arrowParticles = spawnArrows(game.state.gem.definition.color, game.state.gem.respawnable.origin);
                    }
                }
            }

            break;
        }
    }

    updateAnimations();
}

export function updateBattleState(game: BattleStage) {
    updateFight(game);
}

// CreateDeathOrb(hero: CDOTA_BaseNPC): void {
//     const current_mana = hero.GetMana();
//     const origin = hero.GetAbsOrigin();
//     const mana_given = NearestValue([25, 50, 75, 100], current_mana);
//     const entity = new Pickup(PickupTypes.DEATH, hero.GetOrigin(), mana_given / 100 + 0.25);

//     this.round?.pickupWrappers.push({
//         origin,
//         type: PickupTypes.DEATH,
//         timer: -1,
//         entity: entity
//     });

//     entity.GetItem()?.SetCurrentCharges(mana_given);
//     entity.GetItem()?.SetPurchaser(hero);
// }
