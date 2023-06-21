import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierCombatEvents, OnHitEvent } from "../../../modifiers/modifier_combat_events";
import { ModifierDisplacement } from "../../../modifiers/modifier_displacement";
import { ModifierRecast } from "../../../modifiers/modifier_recast";
import { ModifierRoot } from "../../../modifiers/modifier_root";
import { ModifierStun } from "../../../modifiers/modifier_stunned";
import { clampPosition, direction2D, fullyFaceTowards, interpolate } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { ModifierMarsSpecialAttack } from "./mars_special_attack";

@registerAbility("mars_extra")
class MarsExtra extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_GENERIC_CHANNEL_1;
    }

    GetPlaybackRateOverride() {
        return 2.0;
    }

    GetCastingCrawl() {
        return 10;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, {
            maxRange: this.GetCastRange(Vector(0, 0, 0), undefined)
        });
        const direction = direction2D(point, origin);
        const duration = this.GetSpecialValueFor("duration");
        const radius = this.GetSpecialValueFor("radius");
        const spawnPoint = point.__add(direction.__mul((radius / 2) * -1));
        const unit = CreateUnitByName(
            "npc_dota_mars_ultimate_soldier",
            spawnPoint,
            false,
            this.caster,
            this.caster,
            this.caster.GetTeamNumber()
        );

        fullyFaceTowards(unit, direction);
        unit.SetNeverMoveToClearSpace(true);

        ModifierMarsSoldierDuration.apply(unit, this.caster, this, { duration: duration });

        ModifierMarsSoldier.apply(unit, this.caster, this, {
            duration: duration,
            visibility: "visible",
            behavior: "notFade",
            x: direction.x,
            y: direction.y,
            radius: radius
        });

        unit.SetModelScale(1.3);

        EFX("particles/mars/mars_extra.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, unit, {
            cp1: unit.GetAbsOrigin(),
            release: true
        });

        EFX("particles/units/heroes/hero_invoker_kid/invoker_kid_forge_spirit_ambient.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, unit, {
            release: true
        });

        EFX("particles/items_fx/aegis_respawn_aegis_trail.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, unit, {
            release: true
        });

        unit.StartGesture(GameActivity.DOTA_SPAWN);
        EmitSoundOn("Hero_Mars.Spear.Root", unit);

        if (this.GetLevel() == 2) {
            ModifierRecast.apply(this.caster, this.caster, this, { duration: 3, abilityLeft: MarsExtra.name });
        }
    }
}

@registerModifier({ customNameForI18n: "modifier_mars_extra_recast" })
class ModifierMarsExtraRecast extends ModifierRecast {}

@registerModifier({ customNameForI18n: "modifier_mars_soldier" })
export class ModifierMarsSoldier extends ModifierCombatEvents {
    behavior!: "fade" | "notFade";
    visibility!: "visible" | "notVisible";
    origin!: Vector;
    searchOrigin!: Vector;
    radius!: number;

    IsHidden() {
        return true;
    }

    IsPurgable() {
        return false;
    }

    OnCreated(params: { behavior: "fade" | "notFade"; visibility: "visible" | "notVisible"; x: number; y: number; radius: number }) {
        if (IsServer()) {
            this.behavior = params.behavior;
            this.visibility = params.visibility;
            this.origin = this.parent.GetAbsOrigin();
            this.radius = params.radius;
            this.searchOrigin = this.origin.__add(Vector(params.x, params.y, 0).__mul(this.radius));

            this.parent.SetHullRadius(60);

            if (this.visibility == "visible") {
                this.parent.SetOriginalModel("models/heroes/mars/mars_soldier.vmdl");
            }

            if (this.behavior == "fade") {
                this.parent.SetRenderAlpha(0);
            }

            this.StartIntervalThink(0.03);
        }
    }

    OnDestroy() {
        if (IsServer()) {
            this.parent.Kill(undefined, this.parent);
        }
    }

    OnIntervalThink() {
        const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
            this.caster,
            this.origin,
            this.radius,
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE,
            FindOrder.ANY
        );

        if (this.behavior == "fade") {
            this.parent.SetRenderAlpha(this.GetAlphaValue());
        }

        if (enemies.some(enemy => !ModifierMarsSoldierMark.findOne(enemy))) {
            this.parent.FadeGesture(GameActivity.DOTA_ATTACK);
            this.parent.StartGesture(GameActivity.DOTA_ATTACK);
        }

        for (const enemy of enemies) {
            if (!ModifierMarsSoldierMark.findOne(enemy)) {
                ApplyDamage({
                    victim: enemy,
                    attacker: this.caster,
                    damage: this.Value("damage"),
                    damage_type: DamageTypes.PURE
                });

                const direction = direction2D(this.origin, enemy.GetAbsOrigin());

                if (!ModifierStun.findOne(enemy) && !ModifierRoot.findOne(enemy) && !ModifierMarsSpecialAttack.findOne(enemy)) {
                    ModifierMarsSoldierDisplacement.apply(enemy, this.caster, this.ability, {
                        x: direction.x,
                        y: direction.y,
                        distance: this.Value("knockback_distance"),
                        speed: this.Value("knockback_distance") / 0.3,
                        peak: 50
                    });
                }

                ModifierMarsSoldierMark.apply(enemy, this.caster, this.ability, { duration: 1 });
                this.PlayEffects(direction, enemy);
            }
        }
    }

    GetAlphaValue() {
        const enemy = CustomEntitiesLegacy.FindUnitsInRadius(
            this.caster,
            this.origin,
            this.radius,
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.INVULNERABLE + UnitTargetFlags.MAGIC_IMMUNE_ENEMIES,
            FindOrder.CLOSEST
        ).shift();

        if (enemy) {
            const fadeMin = 350;
            const fadeMax = 450;
            const fadeRange = fadeMax - fadeMin;
            const range = Math.max(this.parent.GetRangeToUnit(enemy), fadeMin);
            const parsedRange = Math.min(range, fadeMax) - fadeMin;

            return interpolate(parsedRange / fadeRange, 255, 0);
        }
        return 0;
    }

    CheckState() {
        return {
            [ModifierState.NOT_ON_MINIMAP]: true,
            [ModifierState.NO_HEALTH_BAR]: true,
            [ModifierState.NO_TEAM_MOVE_TO]: true,
            [ModifierState.NO_TEAM_SELECT]: true,
            [ModifierState.STUNNED]: true,
            [ModifierState.UNSELECTABLE]: true,
            [ModifierState.UNTARGETABLE]: true
        };
    }

    PlayEffects(direction: Vector, target: CDOTA_BaseNPC) {
        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_mars/mars_arena_of_blood_spear.vpcf",
            ParticleAttachment.WORLDORIGIN,
            target
        );
        ParticleManager.SetParticleControl(particleId, 0, target.GetAbsOrigin());
        ParticleManager.SetParticleControlForward(particleId, 0, direction);
        ParticleManager.ReleaseParticleIndex(particleId);
        EmitSoundOnLocationWithCaster(target.GetAbsOrigin(), "Hero_Mars.Phalanx.Attack", this.caster);
        EmitSoundOn("Hero_Mars.Phalanx.Target", target);
    }

    OnHit(event: OnHitEvent) {
        if (IsServer() && event.attackCategory == "projectile" && event.projectile.getIsDestructible()) {
            event.projectile.scheduleDestroy();
            return false;
        }

        return true;
    }
}

@registerModifier({ customNameForI18n: "modifier_mars_soldier_displacement" })
class ModifierMarsSoldierDisplacement extends ModifierDisplacement {
    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_FLAIL;
    }
    GetOverrideAnimationRate() {
        return 1.0;
    }

    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.NO_HEALTH_BAR]: true,
            [ModifierState.NO_UNIT_COLLISION]: true
        };
    }
}

@registerModifier({ customNameForI18n: "modifier_mars_soldier_duration" })
class ModifierMarsSoldierDuration extends CustomModifier {
    IsPermanent() {
        return true;
    }

    IsHidden() {
        return true;
    }
}

@registerModifier({ customNameForI18n: "modifier_mars_soldier_debuff" })
class ModifierMarsSoldierMark extends CustomModifier {
    IsPermanent() {
        return true;
    }

    IsHidden() {
        return true;
    }
}
