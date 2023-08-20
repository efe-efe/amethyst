import { CustomModifier } from "./abilities/framework/custom_modifier";
import { updateAnimations } from "./animation";
import { updateEntityData, updateEntityMovement } from "./common";
import { Entity, findEntityByHandle, trueHealEntity } from "./entities";
import { FindStage, Game } from "./game";
import { registerModifier } from "./lib/dota_ts_adapter";
import { ModifierAdrenaline } from "./modifiers/modifier_adrenaline";
import { ModifierCasting } from "./modifiers/modifier_casting";
import { ModifierShield } from "./modifiers/modifier_shield";
import { precache, resource } from "./precache";
import {
    SimpleTrigger,
    fullyFaceTowards,
    giveManaAndEnergy,
    refreshCooldowns,
    setEnergy,
    simpleTrigger,
    strongPurge,
    triggerNow
} from "./util";

type Respawnable = {
    origin: Vector;
    path: string;
    trigger: SimpleTrigger;
    handle?: CDOTA_BaseNPC;
};

type Pickup = {
    model: string;
    radius: number;
    effect: (unit: CDOTA_BaseNPC) => void;
    particle: string;
    trigger: SimpleTrigger;
    origin: Vector;
    handle?: CDOTA_BaseNPC;
};

declare global {
    interface AddStage {
        [Stage.battle]: BaseStage & {
            startedAt: number;
            round: number;
            state:
                | { id: "afterFightPreview"; finishAt: number }
                | {
                      id: "warmup";
                      finishAt: number;
                      respawnables: Respawnable[];
                  }
                | {
                      id: "fight";
                      healthOrbs: Pickup[];
                      manaOrbs: Pickup[];
                      shieldOrbs: Pickup[];
                      deathOrbs: Pickup[];
                  };
        };
    }
}

const resources = precache({
    dummy: resource.unit("npc_dota_creature_dummy_target"),
    pickup: resource.unit("npc_dota_pickup"),
    clarity: resource.model("models/props_gameplay/clarity.vmdl"),
    salve: resource.model("models/props_gameplay/salve.vmdl"),
    shield: resource.model("models/props_gameplay/stout_shield.vmdl"),
    death: resource.model("models/props_items/bloodstone.vmdl"),
    healthParticle: resource.fx("particles/generic_gameplay/rune_regeneration.vpcf"),
    manaParticle: resource.fx("particles/generic_gameplay/rune_doubledamage.vpcf"),
    shieldParticle: resource.fx("particles/generic_gameplay/rune_bounty.vpcf"),
    deathParticle: resource.fx("particles/generic_gameplay/rune_haste.vpcf")
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
    const dummyTargets: Respawnable[] = Entities.FindAllByName("dummy_target").map(entity => ({
        origin: entity.GetAbsOrigin(),
        path: resources.dummy.path,
        trigger: simpleTrigger(GameRules.GetGameTime() + 2.0)
    }));

    return {
        stage: Stage.battle,
        config,
        startedAt: GameRules.GetGameTime(),
        players: () => config.players,
        state: { id: "warmup", finishAt: GameRules.GetGameTime() + Constants.warmupDuration, respawnables: dummyTargets },
        round: round
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

function pickup(options: {
    particle: string;
    origin: Vector;
    model: string;
    effect: (unit: CDOTA_BaseNPC) => void;
    respawnRate: number;
}): Pickup {
    return {
        model: options.model,
        radius: 150,
        effect: options.effect,
        particle: options.particle,
        trigger: simpleTrigger(GameRules.GetGameTime() + options.respawnRate),
        origin: options.origin,
        handle: undefined
    };
}

function updateFight(game: BattleStage) {
    const now = GameRules.GetGameTime();

    switch (game.state.id) {
        case "warmup": {
            const entities = game
                .players()
                .map(player => player.entity)
                .filter((entity): entity is Entity => entity != undefined);

            for (const entity of entities) {
                updateEntityMovement(entity);
                updateEntityData(entity);
            }

            for (const respawnable of game.state.respawnables) {
                if (triggerNow(respawnable.trigger)) {
                    respawnable.handle = CreateUnitByName(
                        respawnable.path,
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

                for (const respawnable of game.state.respawnables) {
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
                    pickup({
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
                    pickup({
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
                    pickup({
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

                game.state = {
                    id: "fight",
                    healthOrbs: healthOrbs,
                    manaOrbs: manaOrbs,
                    shieldOrbs: shieldOrbs,
                    deathOrbs: []
                };
            }

            break;
        }

        case "fight": {
            const entities = game
                .players()
                .map(player => player.entity)
                .filter((entity): entity is Entity => entity != undefined);

            for (const entity of entities) {
                updateEntityMovement(entity);
            }

            for (const pickup of [...game.state.healthOrbs, ...game.state.manaOrbs, ...game.state.shieldOrbs, ...game.state.deathOrbs]) {
                if (triggerNow(pickup.trigger)) {
                    pickup.handle = CreateUnitByName(resources.pickup.path, pickup.origin, false, undefined, undefined, DotaTeam.NOTEAM);
                    pickup.handle.SetModel(pickup.model);
                    pickup.handle.SetModelScale(1);
                    ModifierPickup.apply(pickup.handle, pickup.handle, undefined, {});
                    ParticleManager.CreateParticle(pickup.particle, ParticleAttachment.ABSORIGIN_FOLLOW, pickup.handle);
                }

                if (pickup.trigger.triggered && pickup.handle) {
                    const currentAngle = (GameRules.GetGameTime() % (Math.PI * 2)) * 2.0;

                    fullyFaceTowards(pickup.handle, Vector(Math.cos(currentAngle), Math.sin(currentAngle)));

                    const unit = FindUnitsInRadius(
                        pickup.handle.GetTeamNumber(),
                        pickup.origin,
                        undefined,
                        pickup.radius,
                        UnitTargetTeam.BOTH,
                        UnitTargetType.ALL,
                        UnitTargetFlags.INVULNERABLE,
                        FindOrder.CLOSEST,
                        false
                    )
                        .filter(unit => unit != pickup.handle)
                        .shift();
                    if (unit) {
                        pickup.effect(unit);
                        pickup.trigger = simpleTrigger(GameRules.GetGameTime() + Constants.pickupsSpawnRate);
                        pickup.handle.Kill(undefined, pickup.handle);
                        pickup.handle = undefined;
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
