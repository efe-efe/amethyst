import { ModifierEmerald } from "../modifiers/gems/modifier_emerald";
import { ModifierRuby } from "../modifiers/gems/modifier_ruby";
import { ModifierSapphire } from "../modifiers/gems/modifier_sapphire";
import { ModifierGem } from "../modifiers/modifier_gem";
import BreakableBounty from "./breakable_bounty";

export enum GemTypes {
    NO_TYPE = 0,
    AMETHYST,
    SAPPHIRE,
    RUBY,
    EMERALD,
    DIAMOND
}

const GEM_LIGHT_PARTICLE = {
    [GemTypes.NO_TYPE]: "",
    [GemTypes.AMETHYST]: "particles/generic_gameplay/rune_arcane.vpcf",
    [GemTypes.SAPPHIRE]: "particles/generic_gameplay/rune_doubledamage.vpcf",
    [GemTypes.RUBY]: "particles/generic_gameplay/rune_haste.vpcf",
    [GemTypes.EMERALD]: "particles/generic_gameplay/rune_regeneration.vpcf",
    [GemTypes.DIAMOND]: "particles/generic_gameplay/rune_regeneration.vpcf"
};

const GEM_COLOR = {
    [GemTypes.NO_TYPE]: Vector(0, 0, 0),
    [GemTypes.AMETHYST]: Vector(255, 26, 243),
    [GemTypes.SAPPHIRE]: Vector(0, 101, 255),
    [GemTypes.RUBY]: Vector(255, 26, 0),
    [GemTypes.EMERALD]: Vector(26, 255, 0),
    [GemTypes.DIAMOND]: Vector(26, 255, 0)
};

class Gem extends BreakableBounty {
    type = GemTypes.NO_TYPE;

    constructor(origin: Vector, particle: string, model: string, scale = 1.0) {
        super(origin, { particle, model, scale, health: 100 });

        ModifierGem.apply(this.GetUnit(), this.GetUnit(), undefined, {});
    }

    Update(): void {
        const currentAngle = (GameRules.GetGameTime() % (math.pi * 2)) * 2.0;

        if (!CustomEntitiesLegacy.IsBanished(this.GetUnit())) {
            CustomEntitiesLegacy.FullyFaceTowards(this.GetUnit(), Vector(math.cos(currentAngle), math.sin(currentAngle)));
            this.GetUnit().SetModel(this.model);
            this.GetUnit().SetModelScale(this.scale);
        }
    }

    BeforeRemoving(killer: CDOTA_BaseNPC): void {
        super.BeforeRemoving(killer);
        CustomEntitiesLegacy.GetAlliance(killer).AddAmethsyt();
    }

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    Effect(killer: CDOTA_BaseNPC): void {
        //override this method
    }

    GetUnits(searcher: CDOTA_BaseNPC, iTeamFlags: UnitTargetTeam) {
        return CustomEntitiesLegacy.FindUnitsInRadius(
            searcher,
            this.GetUnit().GetAbsOrigin(),
            FIND_UNITS_EVERYWHERE,
            iTeamFlags,
            UnitTargetType.HERO,
            UnitTargetFlags.PLAYER_CONTROLLED + UnitTargetFlags.INVULNERABLE + UnitTargetFlags.OUT_OF_WORLD,
            FindOrder.ANY
        );
    }

    GetAllies(searcher: CDOTA_BaseNPC) {
        return this.GetUnits(searcher, UnitTargetTeam.FRIENDLY);
    }

    GetHeroes() {
        return this.GetUnits(this.GetUnit(), UnitTargetTeam.BOTH);
    }

    ProcessValue(allies: CDOTA_BaseNPC[], heroes: CDOTA_BaseNPC[], value: number): number {
        return math.ceil((heroes.length * value) / allies.length);
    }

    PlayEffectsOnSpawn(): void {
        const unit = this.GetUnit();
        EmitSoundOn("Hero_Oracle.FortunesEnd.Target", unit);
        EFX("particles/units/heroes/hero_chen/chen_hand_of_god.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, unit, { release: true });
        EFX("particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, unit, { release: true });

        if (this.particle) {
            EFX(this.particle, ParticleAttachment.ABSORIGIN_FOLLOW, unit, {
                release: true
            });
        }
    }
}
export class Diamond extends Gem {
    type = GemTypes.DIAMOND;

    constructor(origin: Vector) {
        super(origin, "particles/generic_gameplay/rune_doubledamage.vpcf", "models/heroes/oracle/weapon.vmdl", 3.0);
    }

    Effect(killer: CDOTA_BaseNPC): void {
        const allies = this.GetAllies(killer);

        allies.forEach(ally => {
            if (ally.IsRealHero()) {
                ally.SetAbilityPoints(ally.GetAbilityPoints() + 1);
            }
        });
    }

    PlayEffectsOnTarget(target: CDOTA_BaseNPC): void {
        EmitSoundOn("DOTA_Item.Refresher.Activate", target);
        EFX("particles/items_fx/arcane_boots_recipient.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, target, {
            release: true
        });
        EFX("particles/gems/amethyst.vpcf", ParticleAttachment.CUSTOMORIGIN, target, {
            cp0: {
                ent: target,
                point: "attach_hitloc"
            },
            release: true
        });
        EFX(
            "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/cm_arcana_pup_lvlup_godray.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            target,
            {
                cp1: target.GetAbsOrigin(),
                cp3: target.GetAbsOrigin(),
                release: true
            }
        );
    }
}
class Sapphire extends Gem {
    shield = 20;
    duration = 10.0;
    type = GemTypes.SAPPHIRE;

    constructor(origin: Vector) {
        super(
            origin,
            "particles/generic_gameplay/rune_doubledamage.vpcf",
            "models/items/disruptor/disruptor_ti8_immortal_weapon/disruptor_ti8_immortal_sphere.vmdl",
            4.0
        );
    }

    Effect(killer: CDOTA_BaseNPC) {
        const allies = this.GetAllies(killer);
        const heroes = this.GetHeroes();
        const final_shield = this.ProcessValue(allies, heroes, this.shield);

        allies.forEach(ally => {
            if (ally.IsRealHero()) {
                ModifierSapphire.apply(ally, ally, undefined, {
                    duration: this.duration,
                    damageBlock: final_shield
                });
            }
        });
    }
}

class Amethyst extends Gem {
    mana_bounty = 25;
    heal_bounty = 5;
    type = GemTypes.AMETHYST;

    constructor(origin: Vector) {
        super(origin, "particles/generic_gameplay/rune_arcane.vpcf", "models/heroes/oracle/crystal_ball.vmdl", 3.0);
    }

    Effect(killer: CDOTA_BaseNPC): void {
        const allies = this.GetAllies(killer);
        const heroes = this.GetHeroes();

        const final_mana = this.ProcessValue(allies, heroes, this.mana_bounty);
        const final_heal = this.ProcessValue(allies, heroes, this.heal_bounty);

        allies.forEach(ally => {
            if (ally.IsRealHero()) {
                CustomEntitiesLegacy.RefreshCooldowns(ally);
                CustomEntitiesLegacy.TrueHeal(ally, final_heal);
                CustomEntitiesLegacy.GiveManaCustom(ally, final_mana, true, true);
                this.PlayEffectsOnTarget(ally);
            }
        });

        //ModifierAmethyst.apply(killer, killer, undefined, { duration: 5 })
    }

    PlayEffectsOnTarget(target: CDOTA_BaseNPC): void {
        EmitSoundOn("DOTA_Item.Refresher.Activate", target);
        EFX("particles/items_fx/arcane_boots_recipient.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, target, {
            release: true
        });
        EFX("particles/gems/amethyst.vpcf", ParticleAttachment.CUSTOMORIGIN, target, {
            cp0: {
                ent: target,
                point: "attach_hitloc"
            },
            release: true
        });
        EFX(
            "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/cm_arcana_pup_lvlup_godray.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            target,
            {
                cp1: target.GetAbsOrigin(),
                cp3: target.GetAbsOrigin(),
                release: true
            }
        );
    }
}

class Emerald extends Gem {
    heal_per_second = 2;
    true_heal = 10;
    duration = 8.0;
    type = GemTypes.EMERALD;

    constructor(origin: Vector) {
        super(
            origin.__add(Vector(0, 0, 64)),
            "particles/generic_gameplay/rune_regeneration.vpcf",
            "models/items/rubick/rubick_arcana/rubick_arcana_cube.vmdl",
            0.45
        );
    }

    Effect(killer: CDOTA_BaseNPC) {
        const allies = this.GetAllies(killer);
        const heroes = this.GetHeroes();
        const final_true_heal = this.ProcessValue(allies, heroes, this.true_heal);
        const final_heal_per_second = this.ProcessValue(allies, heroes, this.heal_per_second);

        allies.forEach(ally => {
            if (ally.IsRealHero()) {
                CustomEntitiesLegacy.TrueHeal(ally, final_true_heal);

                ModifierEmerald.apply(ally, ally, undefined, {
                    duration: this.duration,
                    healPerSecond: final_heal_per_second
                });

                EFX("particles/gems/emerald.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, ally, {
                    cp3: {
                        ent: ally,
                        point: "attach_hitloc"
                    },
                    release: true
                });
            }
        });
    }
}

class Ruby extends Gem {
    duration = 10.0;
    energy_bounty = 25;
    damage = 3;
    type = GemTypes.RUBY;

    constructor(origin: Vector) {
        super(origin, "particles/generic_gameplay/rune_haste.vpcf", "models/items/furion/dark_staff/bulb.vmdl", 0.5);
    }

    Effect(killer: CDOTA_BaseNPC): void {
        const allies = this.GetAllies(killer);
        const heroes = this.GetHeroes();
        const final_damage = this.ProcessValue(allies, heroes, this.damage);
        const final_energy = this.ProcessValue(allies, heroes, this.energy_bounty);

        allies.forEach(ally => {
            if (ally.IsRealHero()) {
                ModifierRuby.apply(ally, ally, undefined, {
                    duration: this.duration,
                    damage: final_damage
                });
                CustomEntitiesLegacy.GiveEnergy(ally, final_energy, true, true);
            }
        });
    }

    PlaySpecificEffectsOnDeath(): void {
        EFX("particles/econ/items/monkey_king/arcana/fire/monkey_king_spring_arcana_fire.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: GetGroundPosition(this.origin, undefined),
            release: true
        });
    }
}

export default class GemWrapper {
    delay_time: number;
    current_time: number;
    light_delay_time: number;
    type: GemTypes;
    origin: Vector;
    progress_circle: ParticleID;
    entity: Gem | undefined;
    destroyed = false;
    lights: ParticleID[] = [];

    constructor(delay: number, origin: Vector, type?: GemTypes) {
        this.delay_time = delay * 30;
        this.current_time = delay * 30;
        this.light_delay_time = this.delay_time / 5;

        if (!type) {
            this.type = RandomInt(GemTypes.AMETHYST, GemTypes.EMERALD);
        } else {
            this.type = type;
        }

        this.origin = origin;
        this.CreateLight();
        this.progress_circle = this.CreateProgressCircle();
    }

    Alive(): boolean {
        return !this.destroyed;
    }

    Update(): void {
        this.current_time = this.current_time - 1;

        if (this.current_time === 0) {
            if (this.type == GemTypes.AMETHYST) {
                this.entity = new Amethyst(this.origin);
            }
            if (this.type == GemTypes.SAPPHIRE) {
                this.entity = new Sapphire(this.origin);
            }
            if (this.type == GemTypes.RUBY) {
                this.entity = new Ruby(this.origin);
            }
            if (this.type == GemTypes.EMERALD) {
                this.entity = new Emerald(this.origin);
            }
        }

        const percentage = (this.delay_time - this.current_time) / this.delay_time;
        if (percentage <= 1.0) {
            ParticleManager.SetParticleControl(this.progress_circle, 1, Vector(250, percentage, 0));
        }

        if (math.fmod(this.current_time, this.light_delay_time) === 0 && this.lights.length < 5) {
            this.CreateLight();
        }

        if (this.entity) {
            if (!this.entity.Alive()) {
                this.entity = undefined;
                this.destroyed = true;
                this.DestroyProgressCircle();
                this.CleanLights();
            } else {
                this.entity.Update();
            }
        }
    }

    CreateLight(): void {
        let origin = this.origin.__add(Vector(0, -1, 0).__mul(250));
        origin = RotatePoint(this.origin, origin, 72 * this.lights.length);

        const efx = EFX(GEM_LIGHT_PARTICLE[this.type], ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: GetGroundPosition(origin, undefined),
            release: false
        });

        this.lights.push(efx);
    }

    CleanLights(): void {
        this.lights.forEach(light => {
            ParticleManager.DestroyParticle(light, false);
            ParticleManager.ReleaseParticleIndex(light);
        });
        this.lights = [];
    }

    CreateProgressCircle(): ParticleID {
        return EFX("particles/progress_circle/generic_progress_circle.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0f: Vector(0, -1, 0),
            cp0: this.origin - Vector(0, 0, 120),
            cp1: Vector(250, 0, 1),
            cp15: GEM_COLOR[this.type],
            cp16: Vector(1, 0, 0)
        });
    }

    Destroy(remove: boolean): void {
        if (this.entity) {
            this.entity.Destroy(remove);
        }
        this.DestroyProgressCircle();
        this.CleanLights();
    }

    DestroyProgressCircle(): void {
        ParticleManager.DestroyParticle(this.progress_circle, false);
        ParticleManager.ReleaseParticleIndex(this.progress_circle);
    }

    GetColor(): Vector {
        return GEM_COLOR[this.type];
    }
}
