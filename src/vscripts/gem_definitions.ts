import { findEntityByHandle, trueHealEntity } from "./entities";
import { ModifierEmerald } from "./modifiers/gems/modifier_emerald";
import { ModifierRuby } from "./modifiers/gems/modifier_ruby";
import { ModifierSapphire } from "./modifiers/gems/modifier_sapphire";
import { precache, resource } from "./precache";
import { areUnitsAllied, findUnitsInRadius, giveEnergy, giveMana, refreshCooldowns } from "./util";

type GemType = "emerald" | "ruby" | "amethyst" | "sapphire";

const resources = precache({
    amethyst: resource.model("models/heroes/oracle/crystal_ball.vmdl"),
    amethystParticle: resource.fx("particles/generic_gameplay/rune_arcane.vpcf"),
    amethystEfx1: resource.fx("particles/items_fx/arcane_boots_recipient.vpcf"),
    amethystEfx2: resource.fx("particles/gems/amethyst.vpcf"),
    amethystEfx3: resource.fx("particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/cm_arcana_pup_lvlup_godray.vpcf"),
    sapphireParticle: resource.fx("particles/generic_gameplay/rune_doubledamage.vpcf"),
    sapphire: resource.model("models/items/disruptor/disruptor_ti8_immortal_weapon/disruptor_ti8_immortal_sphere.vmdl"),
    rubyParticle: resource.fx("particles/generic_gameplay/rune_haste.vpcf"),
    ruby: resource.model("models/items/furion/dark_staff/bulb.vmdl"),
    emeraldParticle: resource.fx("particles/generic_gameplay/rune_regeneration.vpcf"),
    emerald: resource.model("models/items/rubick/rubick_arcana/rubick_arcana_cube.vmdl"),
    emeraldEfx: resource.fx("particles/gems/emerald.vpcf")
});

export type GemDefinition = {
    type: GemType;
    color: Vector;
    particle: string;
    model: string;
    scale: number;
    effect: (unit: CDOTA_BaseNPC) => void;
};

export type GemDefinitionOptions = {
    type: GemType;
    color: Vector;
    particle: string;
    model: string;
    scale?: number;
    effect: (unit: CDOTA_BaseNPC) => void;
};

export const gemDefinitions: GemDefinition[] = [];

function getAllHeroes(reference: CDOTA_BaseNPC) {
    return findUnitsInRadius(
        reference,
        Vector(0, 0, 0),
        FIND_UNITS_EVERYWHERE,
        UnitTargetTeam.BOTH,
        UnitTargetType.HERO,
        UnitTargetFlags.PLAYER_CONTROLLED + UnitTargetFlags.INVULNERABLE + UnitTargetFlags.OUT_OF_WORLD,
        FindOrder.ANY
    );
}

// The less players are alive in the round, the smaller the buffs are
function getValue(allies: CDOTA_BaseNPC[], heroes: CDOTA_BaseNPC[], value: number): number {
    return Math.ceil((heroes.length * value) / allies.length);
}

function defineGem(options: GemDefinitionOptions) {
    const definition: GemDefinition = {
        type: options.type,
        color: options.color,
        particle: options.particle,
        model: options.model,
        scale: options.scale ?? 1,
        effect: options.effect
    };

    gemDefinitions.push(definition);
}

defineGem({
    type: "amethyst",
    color: Vector(255, 26, 243),
    particle: resources.amethystParticle.path,
    model: resources.amethyst.path,
    scale: 3,
    effect: (killer: CDOTA_BaseNPC) => {
        const allHeroes = getAllHeroes(killer);
        const allies = allHeroes.filter(hero => areUnitsAllied(killer, hero));

        const manaPerHero = getValue(allies, allHeroes, 25);
        const healPerHero = getValue(allies, allHeroes, 5);

        for (const ally of allies.filter(ally => ally.IsRealHero())) {
            const entity = findEntityByHandle(ally);

            if (!entity) {
                continue;
            }

            refreshCooldowns(ally);
            trueHealEntity(entity, manaPerHero);
            giveMana(ally, healPerHero, true, true);

            EmitSoundOn("DOTA_Item.Refresher.Activate", ally);
            EFX(resources.amethystEfx1.path, ParticleAttachment.ABSORIGIN_FOLLOW, ally, {
                release: true
            });
            EFX(resources.amethystEfx2.path, ParticleAttachment.CUSTOMORIGIN, ally, {
                cp0: {
                    ent: ally,
                    point: AttachLocation.hitloc
                },
                release: true
            });
            EFX(resources.amethystEfx3.path, ParticleAttachment.ABSORIGIN_FOLLOW, ally, {
                cp1: ally.GetAbsOrigin(),
                cp3: ally.GetAbsOrigin(),
                release: true
            });
        }
    }
});
defineGem({
    type: "sapphire",
    color: Vector(0, 101, 255),
    particle: resources.sapphireParticle.path,
    model: resources.sapphire.path,
    scale: 4,
    effect: (killer: CDOTA_BaseNPC) => {
        const allHeroes = getAllHeroes(killer);
        const allies = allHeroes.filter(hero => areUnitsAllied(killer, hero));
        const shieldPerAlly = getValue(allies, allHeroes, 20);

        for (const ally of allies.filter(ally => ally.IsRealHero())) {
            ModifierSapphire.apply(ally, ally, undefined, {
                duration: 10,
                damageBlock: shieldPerAlly
            });
        }
    }
});
defineGem({
    type: "ruby",
    color: Vector(255, 26, 0),
    particle: resources.rubyParticle.path,
    model: resources.ruby.path,
    scale: 0.5,
    effect: (killer: CDOTA_BaseNPC) => {
        const allHeroes = getAllHeroes(killer);
        const allies = allHeroes.filter(hero => areUnitsAllied(killer, hero));
        const damagePerAlly = getValue(allies, allHeroes, 3);
        const energyPerAlly = getValue(allies, allHeroes, 25);

        for (const ally of allies.filter(ally => ally.IsRealHero())) {
            ModifierRuby.apply(ally, ally, undefined, {
                duration: 10,
                damage: damagePerAlly
            });
            giveEnergy(ally, energyPerAlly, true, true);
        }
    }
});
defineGem({
    type: "emerald",
    color: Vector(26, 255, 0),
    particle: resources.emeraldParticle.path,
    model: resources.emerald.path,
    scale: 0.45,
    effect: (killer: CDOTA_BaseNPC) => {
        const allHeroes = getAllHeroes(killer);
        const allies = allHeroes.filter(hero => areUnitsAllied(killer, hero));

        const trueHealPerAlly = getValue(allies, allHeroes, 10);
        const healPerSecondPerAlly = getValue(allies, allHeroes, 2);

        for (const ally of allies.filter(ally => ally.IsRealHero())) {
            const entity = findEntityByHandle(ally);

            if (!entity) {
                continue;
            }

            trueHealEntity(entity, trueHealPerAlly);

            ModifierEmerald.apply(ally, ally, undefined, {
                duration: 8,
                healPerSecond: healPerSecondPerAlly
            });

            EFX(resources.emeraldEfx.path, ParticleAttachment.ABSORIGIN_FOLLOW, ally, {
                cp3: {
                    ent: ally,
                    point: AttachLocation.hitloc
                },
                release: true
            });
        }
    }
});

export function findGemDefinitionByType(type: GemType) {
    return gemDefinitions.find(gem => gem.type == type);
}
