import { BaseAbility } from "../../lib/dota_ts_adapter";
import { ModifierCasting, Translate } from "../../modifiers/modifier_casting";
import { ModifierCombatEvents } from "../../modifiers/modifier_combat_events";
import { callEntityFuncSafe } from "../../util";

//minProjection is a value from -1 to 1, 1 when the unit is aligned with direction, -1 is the vector opposite to direction
function findUnitsInCone(
    team: DotaTeam,
    direction: Vector,
    minProjection: number,
    center: Vector,
    radius: number,
    teamFilter: UnitTargetTeam,
    typeFilter: UnitTargetType,
    flagFilter: UnitTargetFlags,
    orderFilter: FindOrder
) {
    //TODO: @Refactor @Important Change this for custom finder, to use alliances!
    const units = FindUnitsInRadius(team, center, undefined, radius, teamFilter, typeFilter, flagFilter, orderFilter, false);

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

        // if onAbilityPhaseStart then return onAbilityPhaseStart(self) end
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
            this.caster.GetTeam(),
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

        // if( iTargets == 0 ){
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
}
