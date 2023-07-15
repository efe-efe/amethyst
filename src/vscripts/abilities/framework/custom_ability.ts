import { addAnimation } from "../../animation";
import { BaseAbility, BaseItem } from "../../lib/dota_ts_adapter";
import { ModifierCasting, Translate } from "../../modifiers/modifier_casting";
import { ModifierCombatEvents } from "../../modifiers/modifier_combat_events";
import { ProjectileHandler, ProjectileOptions, createProjectile } from "../../projectiles";
import { callEntityFuncSafe, findUnitsInCone, findUnitsInRadius } from "../../util";

function triggerBasicAttackStarted(unit: CDOTA_BaseNPC) {
    for (const modifier of unit.FindAllModifiers()) {
        if (modifier instanceof ModifierCombatEvents) {
            callEntityFuncSafe(modifier, "OnBasicAttackStarted");
        }
    }
}

function triggerBasicAttackEnded(unit: CDOTA_BaseNPC) {
    for (const modifier of unit.FindAllModifiers()) {
        if (modifier instanceof ModifierCombatEvents) {
            callEntityFuncSafe(modifier, "OnBasicAttackEnded");
        }
    }
}

function triggerBasicAttackLanded(unit: CDOTA_BaseNPC, target: CDOTA_BaseNPC) {
    for (const modifier of unit.FindAllModifiers()) {
        if (modifier instanceof ModifierCombatEvents) {
            // TODO: @Refactor Find a way to use this method with params
            // callEntityFuncSafe(modifier, "OnBasicAttackLanded");
            modifier.OnBasicAttackLanded({ target: target });
        }
    }
}

function triggerOnHit(unit: CDOTA_BaseNPC, attackCategory: AttackCategory, triggerCounters: boolean, projectile?: ProjectileHandler) {
    let bypass = false;
    for (const modifier of unit.FindAllModifiers()) {
        if (modifier instanceof ModifierCombatEvents) {
            // TODO: @Refactor Find a way to use this method with params
            // callEntityFuncSafe(modifier, "OnHit");

            if (attackCategory == "projectile") {
                if (projectile) {
                    bypass = !modifier.OnHit({
                        source: unit,
                        triggerCounters: triggerCounters,
                        attackCategory: attackCategory,
                        projectile
                    });
                }
            } else {
                bypass = !modifier.OnHit({ source: unit, triggerCounters: triggerCounters, attackCategory: attackCategory });
            }

            modifier.AfterHit();
        }
    }
    return bypass;
}

function findOne<T extends typeof BaseAbility>(this: T, target: CDOTA_BaseNPC): InstanceType<T> | undefined {
    // eslint-disable-next-line no-restricted-syntax
    return target.FindAbilityByName(this.name) as InstanceType<T>;
}

type AttackType = "basic" | "other";
export type AttackCategory = "projectile" | "meele" | "aoe" | "single";

export class CustomAbility extends BaseAbility {
    caster = this.GetCaster();

    public static findOne = findOne;

    GetCastingCrawl(): number | undefined {
        //TODO: @Refactor should be the opposite, return the slowed amount pct
        return;
    }

    GetAnimation(): GameActivity | undefined {
        return undefined;
    }

    GetAnimationTranslate(): Translate | undefined {
        return undefined;
    }

    OnAbilityPhaseStart() {
        ModifierCasting.apply(this.caster, this.caster, this, {
            duration: this.GetCastPoint(),
            movementSpeed: this.GetCastingCrawl(),
            translate: this.GetAnimationTranslate()
            // ignore_activation_cycle: this.GetIgnoreActivationCycle()
        });

        const animation = this.GetAnimation();
        if (animation) {
            addAnimation(this.caster, animation, { duration: this.GetCastPoint() + 0.15, rate: this.GetPlaybackRateOverride() });
        }

        return true;
    }

    OnAbilityPhaseInterrupted() {
        const animation = this.GetAnimation();

        if (animation) {
            this.caster.FadeGesture(animation);
        }
        this.GetCaster().RemoveModifierByName(ModifierCasting.name);
    }

    OnSpellStart() {
        // if self.GetCastAnimationCustom then
        //     if self:GetFadeGestureOnCast() then
        //         self:GetCaster():FadeGesture(self:GetCastAnimationCustom())
        //     end
        // end
        // if onSpellStart then onSpellStart(self) end

        //TODO: @Refactor Idk why I did this
        this.caster.Stop();
    }

    MeeleAttack(options: {
        direction: Vector;
        origin: Vector;
        radius: number;
        triggerCounters?: boolean;
        teamFilter?: UnitTargetTeam;
        typeFilter?: UnitTargetType;
        flagFilter?: UnitTargetFlags;
        orderFilter?: FindOrder;
        maxTargets?: number;
        attackType?: AttackType;
        effect: (target: CDOTA_BaseNPC) => void;
        baseSound?: string;
    }) {
        const triggerCounters = options.triggerCounters ?? true;
        const teamFilter = options.teamFilter ?? UnitTargetTeam.ENEMY;
        const typeFilter = options.typeFilter ?? UnitTargetType.HERO + UnitTargetType.BASIC;
        const flagFilter = options.flagFilter ?? UnitTargetFlags.NONE;
        const orderFilter = options.orderFilter ?? FindOrder.CLOSEST;
        const attackType = options.attackType ?? "other";

        // const shakeOnHeroes = (options.shakeOnHeroes == undefined && options.isBasicAttack) && true || options.shakeOnHeroes
        // const shouldShake = false

        if (attackType == "basic") {
            triggerBasicAttackStarted(this.caster);
        }

        // const callback = options.Callback
        // options.Callback = function(hTarget)
        //     if( shakeOnHeroes && hTarget:IsRealHero() ){
        //         shouldShake = true
        //     }
        //     callback(hTarget)
        // }

        const units = findUnitsInCone(
            this.caster,
            options.direction,
            0,
            options.origin,
            options.radius,
            teamFilter,
            typeFilter,
            flagFilter,
            orderFilter
        );

        let hitTargets = 0;

        for (const unit of units) {
            const bypass = triggerOnHit(unit, "meele", triggerCounters);

            if (!bypass) {
                options.effect(unit);
                if (attackType == "basic") {
                    triggerBasicAttackLanded(this.caster, unit);
                }
            }

            hitTargets++;

            if (options.maxTargets == hitTargets) {
                break;
            }
        }

        // if( shouldShake ){
        //     ScreenShake(options.vOrigin, 100, 100, 0.45, 1000, 0, true)
        // }

        if (attackType == "basic") {
            triggerBasicAttackEnded(this.caster);
        }

        if (options.baseSound) {
            EmitSoundOn(options.baseSound, this.caster);
        }

        return units;
    }

    AoeAttack(options: {
        origin: Vector;
        radius: number;
        triggerCounters?: boolean;
        teamFilter?: UnitTargetTeam;
        typeFilter?: UnitTargetType;
        flagFilter?: UnitTargetFlags;
        orderFilter?: FindOrder;
        maxTargets?: number;
        attackType?: AttackType;
        effect: (target: CDOTA_BaseNPC) => void;
        baseSound?: string;
    }) {
        const triggerCounters = options.triggerCounters ?? false;
        const teamFilter = options.teamFilter ?? UnitTargetTeam.ENEMY;
        const typeFilter = options.typeFilter ?? UnitTargetType.HERO + UnitTargetType.BASIC;
        const flagFilter = options.flagFilter ?? UnitTargetFlags.NONE;
        const orderFilter = options.orderFilter ?? FindOrder.CLOSEST;
        const attackType = options.attackType ?? "other";

        if (options.attackType == "basic") {
            triggerBasicAttackStarted(this.caster);
        }

        const units = findUnitsInRadius(this.caster, options.origin, options.radius, teamFilter, typeFilter, flagFilter, orderFilter);

        let hitTargets = 0;

        for (const unit of units) {
            const bypass = triggerOnHit(unit, "aoe", triggerCounters);

            if (!bypass) {
                options.effect(unit);
                if (attackType == "basic") {
                    triggerBasicAttackLanded(this.caster, unit);
                }
            }

            hitTargets++;

            if (options.maxTargets == hitTargets) {
                break;
            }
        }

        if (attackType == "basic") {
            triggerBasicAttackEnded(this.caster);
        }

        return units;
    }

    SingleAttack(options: {
        target: CDOTA_BaseNPC;
        triggerCounters?: boolean;
        teamFilter?: UnitTargetTeam;
        typeFilter?: UnitTargetType;
        flagFilter?: UnitTargetFlags;
        orderFilter?: FindOrder;
        attackType?: AttackType;
        effect: (target: CDOTA_BaseNPC) => void;
        baseSound?: string;
    }) {
        const triggerCounters = options.triggerCounters ?? true;
        const teamFilter = options.teamFilter ?? UnitTargetTeam.ENEMY;
        const typeFilter = options.typeFilter ?? UnitTargetType.HERO + UnitTargetType.BASIC;
        const flagFilter = options.flagFilter ?? UnitTargetFlags.NONE;
        const orderFilter = options.orderFilter ?? FindOrder.CLOSEST;
        const attackType = options.attackType ?? "other";

        if (options.attackType == "basic") {
            triggerBasicAttackStarted(this.caster);
        }

        const bypass = triggerOnHit(options.target, "single", triggerCounters);

        if (!bypass) {
            options.effect(options.target);
            if (attackType == "basic") {
                triggerBasicAttackLanded(this.caster, options.target);
            }
        }

        if (attackType == "basic") {
            triggerBasicAttackEnded(this.caster);
        }

        return options.target;
    }

    ProjectileAttack(
        options: ProjectileOptions & {
            triggerCounters?: boolean;
            attackType?: AttackType;
        }
    ) {
        const triggerCounters = options.triggerCounters ?? true;
        const attackType = options.attackType ?? "other";
        const valueDistance = this.GetSpecialValueFor("projectile_distance");
        const distance = options.distance
            ? options.distance
            : valueDistance != 0
            ? valueDistance
            : this.GetCastRange(Vector(0, 0, 0), undefined);

        const startRadius = options.startRadius ?? this.GetSpecialValueFor("hitbox");

        const onUnitHit = (unit: CDOTA_BaseNPC, projectile: ProjectileHandler) => {
            const bypass = triggerOnHit(unit, "projectile", triggerCounters, projectile);

            if (!bypass) {
                options.onUnitHit?.(unit, projectile);
                if (attackType == "basic") {
                    triggerBasicAttackLanded(this.caster, unit);
                }
            }

            return bypass;
        };

        const onFinish = (projectile: ProjectileHandler) => {
            options.onFinish?.(projectile);

            if (attackType == "basic") {
                triggerBasicAttackEnded(this.caster);
            }
        };

        if (options.attackType == "basic") {
            triggerBasicAttackStarted(this.caster);
        }

        const projectile = createProjectile({
            ...options,
            distance,
            startRadius,
            onUnitHit,
            onFinish
        });

        return projectile;
    }
}

// @Refactor this is so repeated
export class CustomItem extends BaseItem {
    public static findOne = findOne;

    GetCastingCrawl(): number | undefined {
        //TODO: @Refactor should be the opposite, return the slowed amount pct
        return;
    }

    GetAnimation(): GameActivity | undefined {
        return undefined;
    }

    GetAnimationTranslate(): Translate | undefined {
        return undefined;
    }

    OnAbilityPhaseStart() {
        ModifierCasting.apply(this.GetCaster(), this.GetCaster(), this, {
            duration: this.GetCastPoint(),
            movementSpeed: this.GetCastingCrawl(),
            translate: this.GetAnimationTranslate()
            // ignore_activation_cycle: this.GetIgnoreActivationCycle()
        });

        const animation = this.GetAnimation();
        if (animation) {
            this.GetCaster().StartGestureWithPlaybackRate(animation, this.GetPlaybackRateOverride());
        }

        return true;
    }

    OnAbilityPhaseInterrupted() {
        const animation = this.GetAnimation();

        if (animation) {
            this.GetCaster().FadeGesture(animation);
        }
        this.GetCaster().RemoveModifierByName(ModifierCasting.name);
    }

    OnSpellStart() {
        // if self.GetCastAnimationCustom then
        //     if self:GetFadeGestureOnCast() then
        //         self:GetCaster():FadeGesture(self:GetCastAnimationCustom())
        //     end
        // end
        // if onSpellStart then onSpellStart(self) end

        //TODO: @Refactor Idk why I did this
        this.GetCaster().Stop();
    }

    MeeleAttack(options: {
        direction: Vector;
        origin: Vector;
        radius: number;
        triggerCounters?: boolean;
        teamFilter?: UnitTargetTeam;
        typeFilter?: UnitTargetType;
        flagFilter?: UnitTargetFlags;
        orderFilter?: FindOrder;
        maxTargets?: number;
        attackType?: AttackType;
        effect: (target: CDOTA_BaseNPC) => void;
        baseSound?: string;
    }) {
        const triggerCounters = options.triggerCounters ?? true;
        const teamFilter = options.teamFilter ?? UnitTargetTeam.ENEMY;
        const typeFilter = options.typeFilter ?? UnitTargetType.HERO + UnitTargetType.BASIC;
        const flagFilter = options.flagFilter ?? UnitTargetFlags.NONE;
        const orderFilter = options.orderFilter ?? FindOrder.CLOSEST;
        const attackType = options.attackType ?? "other";

        // const shakeOnHeroes = (options.shakeOnHeroes == undefined && options.isBasicAttack) && true || options.shakeOnHeroes
        // const shouldShake = false

        if (attackType == "basic") {
            triggerBasicAttackStarted(this.GetCaster());
        }

        // const callback = options.Callback
        // options.Callback = function(hTarget)
        //     if( shakeOnHeroes && hTarget:IsRealHero() ){
        //         shouldShake = true
        //     }
        //     callback(hTarget)
        // }

        const units = findUnitsInCone(
            this.GetCaster(),
            options.direction,
            0,
            options.origin,
            options.radius,
            teamFilter,
            typeFilter,
            flagFilter,
            orderFilter
        );

        let hitTargets = 0;

        for (const unit of units) {
            const bypass = triggerOnHit(unit, "meele", triggerCounters);

            if (!bypass) {
                options.effect(unit);
                if (attackType == "basic") {
                    triggerBasicAttackLanded(this.GetCaster(), unit);
                }
            }

            hitTargets++;

            if (options.maxTargets == hitTargets) {
                break;
            }
        }

        // if( shouldShake ){
        //     ScreenShake(options.vOrigin, 100, 100, 0.45, 1000, 0, true)
        // }

        if (attackType == "basic") {
            triggerBasicAttackEnded(this.GetCaster());
        }

        if (options.baseSound) {
            EmitSoundOn(options.baseSound, this.GetCaster());
        }

        return units;
    }

    AoeAttack(options: {
        origin: Vector;
        radius: number;
        triggerCounters?: boolean;
        teamFilter?: UnitTargetTeam;
        typeFilter?: UnitTargetType;
        flagFilter?: UnitTargetFlags;
        orderFilter?: FindOrder;
        maxTargets?: number;
        attackType?: AttackType;
        effect: (target: CDOTA_BaseNPC) => void;
        baseSound?: string;
    }) {
        const triggerCounters = options.triggerCounters ?? false;
        const teamFilter = options.teamFilter ?? UnitTargetTeam.ENEMY;
        const typeFilter = options.typeFilter ?? UnitTargetType.HERO + UnitTargetType.BASIC;
        const flagFilter = options.flagFilter ?? UnitTargetFlags.NONE;
        const orderFilter = options.orderFilter ?? FindOrder.CLOSEST;
        const attackType = options.attackType ?? "other";

        if (options.attackType == "basic") {
            triggerBasicAttackStarted(this.GetCaster());
        }

        const units = findUnitsInRadius(this.GetCaster(), options.origin, options.radius, teamFilter, typeFilter, flagFilter, orderFilter);

        let hitTargets = 0;

        for (const unit of units) {
            const bypass = triggerOnHit(unit, "aoe", triggerCounters);

            if (!bypass) {
                options.effect(unit);
                if (attackType == "basic") {
                    triggerBasicAttackLanded(this.GetCaster(), unit);
                }
            }

            hitTargets++;

            if (options.maxTargets == hitTargets) {
                break;
            }
        }

        if (attackType == "basic") {
            triggerBasicAttackEnded(this.GetCaster());
        }

        return units;
    }

    SingleAttack(options: {
        target: CDOTA_BaseNPC;
        triggerCounters?: boolean;
        teamFilter?: UnitTargetTeam;
        typeFilter?: UnitTargetType;
        flagFilter?: UnitTargetFlags;
        orderFilter?: FindOrder;
        attackType?: AttackType;
        effect: (target: CDOTA_BaseNPC) => void;
        baseSound?: string;
    }) {
        const triggerCounters = options.triggerCounters ?? true;
        const teamFilter = options.teamFilter ?? UnitTargetTeam.ENEMY;
        const typeFilter = options.typeFilter ?? UnitTargetType.HERO + UnitTargetType.BASIC;
        const flagFilter = options.flagFilter ?? UnitTargetFlags.NONE;
        const orderFilter = options.orderFilter ?? FindOrder.CLOSEST;
        const attackType = options.attackType ?? "other";

        if (options.attackType == "basic") {
            triggerBasicAttackStarted(this.GetCaster());
        }

        const bypass = triggerOnHit(options.target, "single", triggerCounters);

        if (!bypass) {
            options.effect(options.target);
            if (attackType == "basic") {
                triggerBasicAttackLanded(this.GetCaster(), options.target);
            }
        }

        if (attackType == "basic") {
            triggerBasicAttackEnded(this.GetCaster());
        }

        return options.target;
    }

    ProjectileAttack(
        options: ProjectileOptions & {
            triggerCounters?: boolean;
            attackType?: AttackType;
        }
    ) {
        const triggerCounters = options.triggerCounters ?? true;
        const attackType = options.attackType ?? "other";
        const valueDistance = this.GetSpecialValueFor("projectile_distance");
        const distance = options.distance
            ? options.distance
            : valueDistance != 0
            ? valueDistance
            : this.GetCastRange(Vector(0, 0, 0), undefined);

        const startRadius = options.startRadius ?? this.GetSpecialValueFor("hitbox");

        const onUnitHit = (unit: CDOTA_BaseNPC, projectile: ProjectileHandler) => {
            const bypass = triggerOnHit(unit, "projectile", triggerCounters, projectile);

            if (!bypass) {
                options.onUnitHit?.(unit, projectile);
                if (attackType == "basic") {
                    triggerBasicAttackLanded(this.GetCaster(), unit);
                }
            }

            return bypass;
        };

        const onFinish = (projectile: ProjectileHandler) => {
            options.onFinish?.(projectile);

            if (attackType == "basic") {
                triggerBasicAttackEnded(this.GetCaster());
            }
        };

        if (options.attackType == "basic") {
            triggerBasicAttackStarted(this.GetCaster());
        }

        const projectile = createProjectile({
            ...options,
            distance,
            startRadius,
            onUnitHit,
            onFinish
        });

        return projectile;
    }
}
