import { BaseAbility } from "../../lib/dota_ts_adapter";
import { ModifierCasting, Translate } from "../../modifiers/modifier_casting";
import { ModifierCombatEvents } from "../../modifiers/modifier_combat_events";
import { ProjectileOptions, createProjectile } from "../../projectiles";
import { callEntityFuncSafe } from "../../util";

//minProjection is a value from -1 to 1, 1 when the unit is aligned with direction, -1 is the vector opposite to direction
function findUnitsInCone(
    source: CDOTA_BaseNPC, //TODO: @Refactor Change this for team
    direction: Vector,
    minProjection: number,
    center: Vector,
    radius: number,
    teamFilter: UnitTargetTeam,
    typeFilter: UnitTargetType,
    flagFilter: UnitTargetFlags,
    orderFilter: FindOrder
) {
    //TODO: @Refactor Change this for a TS finder
    const units = CustomEntitiesLegacy.FindUnitsInRadius(source, center, radius, teamFilter, typeFilter, flagFilter, orderFilter);

    const targets = [];

    for (const unit of units) {
        const directionToUnit = unit.GetAbsOrigin().__sub(center).Normalized();
        const projection = directionToUnit.x * direction.x + directionToUnit.y * direction.y;

        if (projection >= minProjection) {
            targets.push(unit);
        }
    }

    return targets;
}

type AttackType = "basic" | "other";

export class CustomAbility extends BaseAbility {
    caster = this.GetCaster();

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
            this.caster.StartGestureWithPlaybackRate(animation, this.GetPlaybackRateOverride());
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
            for (const modifier of this.caster.FindAllModifiers()) {
                if (modifier instanceof ModifierCombatEvents) {
                    callEntityFuncSafe(modifier, "OnBasicAttackStarted");
                }
            }
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
            // const tOnHitModifiers = CustomEntitiesLegacy:GetAllModifiersWithType(unit, MODIFIER_TYPES.ON_HIT)

            // if( #tOnHitModifiers > 0 ){
            //     for _,sModifierName in pairs(tOnHitModifiers) do
            //         const hModifier = unit:FindModifierByName(sModifierName)
            //         const bProcessEffect = hModifier:OnHit({
            //             hSource = this.caster,
            //             triggerCounters = triggerCounters,
            //             Callback = options.Callback,
            //             iType = MEELE_HIT
            //         })

            //         if( bProcessEffect ){
            //             options.Callback(unit)
            //             if( options.isBasicAttack ){
            //                 CustomEntitiesLegacy:EmitModifierEvent(this.caster, {
            //                     iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED,
            //                     hTarget = unit,
            //                 })
            //             }
            //         }
            //     }
            // else
            options.effect(unit);
            if (attackType == "basic") {
                for (const modifier of this.caster.FindAllModifiers()) {
                    if (modifier instanceof ModifierCombatEvents) {
                        // TODO: @Refactor Find a way to use this method with params
                        // callEntityFuncSafe(modifier, "OnBasicAttackLanded");
                        modifier.OnBasicAttackLanded({ target: unit });
                    }
                }
            }
            // }

            hitTargets++;

            if (options.maxTargets == hitTargets) {
                break;
            }
        }

        // if( hitTargets == 0 ){
        //     if( options.isBasicAttack ){
        //         CustomEntitiesLegacy:EmitModifierEvent(this.caster, { iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_MISSED })
        //     }
        // }

        // if( shouldShake ){
        //     ScreenShake(options.vOrigin, 100, 100, 0.45, 1000, 0, true)
        // }

        if (attackType == "basic") {
            for (const modifier of this.caster.FindAllModifiers()) {
                if (modifier instanceof ModifierCombatEvents) {
                    callEntityFuncSafe(modifier, "OnBasicAttackEnded");
                }
            }
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
            for (const modifier of this.caster.FindAllModifiers()) {
                if (modifier instanceof ModifierCombatEvents) {
                    callEntityFuncSafe(modifier, "OnBasicAttackStarted");
                }
            }
        }

        const units = CustomEntitiesLegacy.FindUnitsInRadius(
            this.caster,
            options.origin,
            options.radius,
            teamFilter,
            typeFilter,
            flagFilter,
            orderFilter
        );

        let hitTargets = 0;

        for (const unit of units) {
            // const tOnHitModifiers = CustomEntitiesLegacy:GetAllModifiersWithType(unit, MODIFIER_TYPES.ON_HIT)

            // if #tOnHitModifiers > 0 then
            //     for _,sModifierName in pairs(tOnHitModifiers) do
            //         const hModifier = unit:FindModifierByName(sModifierName)
            //         const bProcessEffect = hModifier:OnHit({
            //             hSource = hEntity,
            //             triggerCounters = triggerCounters,
            //             Callback = tData.Callback,
            //             iType = AOE_HIT
            //         })

            //         if bProcessEffect then
            //             tData.Callback(unit)
            //             if tData.bIsBasicAttack then
            //                 CustomEntitiesLegacy:EmitModifierEvent(hEntity, {
            //                     iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED,
            //                     hTarget = unit,
            //                 })
            //             end
            //         end
            //     end
            // else
            options.effect(unit);
            if (attackType == "basic") {
                for (const modifier of this.caster.FindAllModifiers()) {
                    if (modifier instanceof ModifierCombatEvents) {
                        // TODO: @Refactor Find a way to use this method with params
                        // callEntityFuncSafe(modifier, "OnBasicAttackLanded");
                        modifier.OnBasicAttackLanded({ target: unit });
                    }
                }
            }
            // end

            hitTargets++;

            if (options.maxTargets == hitTargets) {
                break;
            }
        }

        if (hitTargets == 0) {
            // if tData.bIsBasicAttack then
            //     CustomEntitiesLegacy:EmitModifierEvent(hEntity, { iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_MISSED })
            // end
        }

        if (attackType == "basic") {
            for (const modifier of this.caster.FindAllModifiers()) {
                if (modifier instanceof ModifierCombatEvents) {
                    callEntityFuncSafe(modifier, "OnBasicAttackEnded");
                }
            }
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
            for (const modifier of this.caster.FindAllModifiers()) {
                if (modifier instanceof ModifierCombatEvents) {
                    callEntityFuncSafe(modifier, "OnBasicAttackStarted");
                }
            }
        }

        // const tOnHitModifiers = CustomEntitiesLegacy:GetAllModifiersWithType(tData.hTarget, MODIFIER_TYPES.ON_HIT)

        // if #tOnHitModifiers > 0 then
        // 	for _,sModifierName in pairs(tOnHitModifiers) do
        // 		const hModifier = tData.hTarget:FindModifierByName(sModifierName)
        // 		const bProcessEffect = hModifier:OnHit({
        // 			hSource = hEntity,
        // 			triggerCounters = triggerCounters,
        // 			Callback = tData.Callback,
        // 			iType = SINGLE_HIT
        // 		})

        // 		if bProcessEffect then
        // 			tData.Callback(tData.hTarget)
        // 			if tData.bIsBasicAttack then
        // 				CustomEntitiesLegacy:EmitModifierEvent(hEntity, {
        // 					iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED,
        // 					hTarget = tData.hTarget,
        // 				})
        // 			end
        // 		end
        // 	end
        // else
        options.effect(options.target);
        if (attackType == "basic") {
            for (const modifier of this.caster.FindAllModifiers()) {
                if (modifier instanceof ModifierCombatEvents) {
                    // TODO: @Refactor Find a way to use this method with params
                    // callEntityFuncSafe(modifier, "OnBasicAttackLanded");
                    modifier.OnBasicAttackLanded({ target: options.target });
                }
            }
        }
        // end

        if (attackType == "basic") {
            for (const modifier of this.caster.FindAllModifiers()) {
                if (modifier instanceof ModifierCombatEvents) {
                    callEntityFuncSafe(modifier, "OnBasicAttackEnded");
                }
            }
        }

        return options.target;
    }

    ProjectileAttack(options: { triggerCounters?: boolean; attackType?: AttackType } & ProjectileOptions) {
        const triggerCounters = options.triggerCounters ?? true;
        const attackType = options.attackType ?? "other";
        const valueDistance = this.GetSpecialValueFor("projectile_distance");
        const distance = options.distance ?? valueDistance != 0 ? valueDistance : this.GetCastRange(Vector(0, 0, 0), undefined);
        const startRadius = options.startRadius ?? this.GetSpecialValueFor("hitbox");

        const onUnitHit = (unit: CDOTA_BaseNPC, projectile: { source: CDOTA_BaseNPC }) => {
            //     tData.tProjectile.OnUnitHit = function(hProjectile, hTarget)
            //         const tOnHitModifiers = CustomEntitiesLegacy:GetAllModifiersWithType(hTarget, MODIFIER_TYPES.ON_HIT)

            //         if #tOnHitModifiers > 0 then
            //             for _,sModifierName in pairs(tOnHitModifiers) do
            //                 const hModifier = hTarget:FindModifierByName(sModifierName)
            //                 const bProcessEffect = hModifier:OnHit({
            //                     hProjectile = hProjectile,
            //                     bTriggerCounters = bTriggerCounters,
            //                     iType = PROJECTILE_HIT,
            //                 })

            //                 if bProcessEffect then
            //                     onUnitHit(hProjectile, hTarget)
            //                     if tData.bIsBasicAttack then
            //                         CustomEntitiesLegacy:EmitModifierEvent(hEntity, {
            //                             iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED,
            //                             hTarget = hTarget,
            //                         })
            //                     end
            //                 else
            //                     hProjectile:IgnoreNextUnitBehavior()
            //                 end
            //             end
            //         else
            options.onUnitHit?.(unit, projectile);
            if (attackType == "basic") {
                for (const modifier of this.caster.FindAllModifiers()) {
                    if (modifier instanceof ModifierCombatEvents) {
                        // TODO: @Refactor Find a way to use this method with params
                        // callEntityFuncSafe(modifier, "OnBasicAttackLanded");
                        modifier.OnBasicAttackLanded({ target: unit });
                    }
                }
            }
            //         end
            //     end
        };

        const onFinish = (position: Vector) => {
            options.onFinish?.(position);

            //     tData.tProjectile.OnFinish = function(hProjectile, vPosition)
            //         if next(hProjectile.tHitLog) == nil then
            //             if tData.bIsBasicAttack then
            //                 CustomEntitiesLegacy:EmitModifierEvent(hEntity, { iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_MISSED })
            //             end
            //         end

            if (attackType == "basic") {
                for (const modifier of this.caster.FindAllModifiers()) {
                    if (modifier instanceof ModifierCombatEvents) {
                        callEntityFuncSafe(modifier, "OnBasicAttackEnded");
                    }
                }
            }
            //     end
        };

        if (options.attackType == "basic") {
            for (const modifier of this.caster.FindAllModifiers()) {
                if (modifier instanceof ModifierCombatEvents) {
                    callEntityFuncSafe(modifier, "OnBasicAttackStarted");
                }
            }
        }

        const projectile = createProjectile({
            ...options,
            distance,
            startRadius,
            onUnitHit,
            onFinish
        });

        //     if tData.OnProjectileCreated then
        //         tData.OnProjectileCreated(hProjectile)
        //     end

        return projectile;
    }
}
