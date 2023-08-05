import { CustomModifier } from "./abilities/framework/custom_modifier";
import { registerModifier } from "./lib/dota_ts_adapter";
import { SimpleTrigger, simpleTrigger, triggerNow } from "./util";

@registerModifier()
class ModifierAnimation extends CustomModifier<undefined> {
    IsHidden() {
        return false;
    }

    IsDebuff() {
        return false;
    }

    IsPurgable() {
        return false;
    }

    StatusEffectPriority() {
        return 1.0;
    }

    DeclareFunctions() {
        return [
            ModifierFunction.OVERRIDE_ANIMATION,
            ModifierFunction.OVERRIDE_ANIMATION_RATE,
            ModifierFunction.OVERRIDE_ANIMATION_WEIGHT,
            ModifierFunction.TRANSLATE_ACTIVITY_MODIFIERS
        ];
    }

    GetOverrideAnimationRate() {
        return this.GetStackCount() / 10;
    }

    GetOverrideAnimationWeight() {
        return 1.0;
    }
}

@registerModifier()
class ModifierRun extends ModifierAnimation {
    GetOverrideAnimation() {
        return GameActivity.DOTA_RUN;
    }
}

@registerModifier()
class ModifierSpawn extends ModifierAnimation {
    GetOverrideAnimation() {
        return GameActivity.DOTA_SPAWN;
    }
}

@registerModifier()
class ModifierAttack extends ModifierAnimation {
    GetOverrideAnimation() {
        return GameActivity.DOTA_ATTACK;
    }
}

@registerModifier()
class ModifierAttackEvent extends ModifierAnimation {
    GetOverrideAnimation() {
        return GameActivity.DOTA_ATTACK_EVENT;
    }
}

@registerModifier()
class ModifierTeleportEnd extends ModifierAnimation {
    GetOverrideAnimation() {
        return GameActivity.DOTA_TELEPORT_END;
    }
}

@registerModifier()
class ModifierCastAbility2 extends ModifierAnimation {
    GetOverrideAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_2;
    }
}

@registerModifier()
class ModifierCastAbility3 extends ModifierAnimation {
    GetOverrideAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_3;
    }
}

@registerModifier()
class ModifierOverrideAbility1 extends ModifierAnimation {
    GetOverrideAnimation() {
        return GameActivity.DOTA_OVERRIDE_ABILITY_1;
    }
}

type AnimationPriority = "low" | "medium" | "high";

type AnimationDefinition = {
    gameActivity: GameActivity;
    priority: AnimationPriority;
    modifier: typeof ModifierAnimation;
};

type Animation = {
    definition: AnimationDefinition;
    trigger?: SimpleTrigger;
    rate: number;
};

const animationDefinitions = new Map<GameActivity, AnimationDefinition>();
const entityToAnimations = new Map<CDOTA_BaseNPC, Animation[]>();

function defineAnimation(gameActivity: GameActivity, modifier: typeof ModifierAnimation, priority: AnimationPriority = "low") {
    animationDefinitions.set(gameActivity, {
        gameActivity: gameActivity,
        priority: priority,
        modifier: modifier
    });
}

defineAnimation(GameActivity.DOTA_RUN, ModifierRun);
defineAnimation(GameActivity.DOTA_SPAWN, ModifierSpawn, "medium");
defineAnimation(GameActivity.DOTA_ATTACK, ModifierAttack, "medium");
defineAnimation(GameActivity.DOTA_ATTACK_EVENT, ModifierAttackEvent, "medium");
defineAnimation(GameActivity.DOTA_TELEPORT_END, ModifierTeleportEnd, "medium");
defineAnimation(GameActivity.DOTA_CAST_ABILITY_2, ModifierCastAbility2, "medium");
defineAnimation(GameActivity.DOTA_CAST_ABILITY_3, ModifierCastAbility3, "medium");
defineAnimation(GameActivity.DOTA_OVERRIDE_ABILITY_1, ModifierOverrideAbility1, "high");

export function removeAnimation(unit: CDOTA_BaseNPC, gameActivity: GameActivity) {
    const animationDefinition = animationDefinitions.get(gameActivity);
    if (!animationDefinition) {
        print("Animation error: Animation not found");
        return;
    }

    const currentAnimations = entityToAnimations.get(unit);

    if (currentAnimations) {
        unit.RemoveModifierByName(animationDefinition.modifier.name);
        entityToAnimations.set(unit, [...currentAnimations.filter(animation => animation.definition.gameActivity != gameActivity)]);
    }
}

export function addAnimation(
    unit: CDOTA_BaseNPC,
    gameActivity: GameActivity,
    options?: {
        duration?: number;
        rate?: number;
    }
) {
    const animationDefinition = animationDefinitions.get(gameActivity);
    if (!animationDefinition) {
        print("Animation error: Animation not found");
        return;
    }

    const currentAnimations = entityToAnimations.get(unit) ?? [];
    const existing = currentAnimations.find(current => current.definition.gameActivity == gameActivity);

    if (existing) {
        existing.trigger = options?.duration ? simpleTrigger(GameRules.GetGameTime() + options.duration) : undefined;
        return;
    }

    entityToAnimations.set(unit, [
        ...currentAnimations,
        {
            definition: animationDefinition,
            trigger: options?.duration ? simpleTrigger(GameRules.GetGameTime() + options.duration) : undefined,
            rate: options?.rate ?? 1
        }
    ]);
}

export function updateAnimations() {
    function getPriorityAnimations(animations: Animation[]) {
        const priorities = ["high", "medium", "low"];

        for (const priority of priorities) {
            const filtered = animations.filter(animation => animation.definition.priority == priority);
            if (filtered.length > 0) {
                return filtered;
            }
        }
        return animations;
    }

    for (const [unit, animations] of entityToAnimations) {
        if (!unit.IsAlive()) {
            entityToAnimations.delete(unit);
            continue;
        }

        //TODO: Stop animations being deleted

        entityToAnimations.set(
            unit,
            animations.filter(animation => (animation.trigger ? !triggerNow(animation.trigger) : true))
        );
    }

    for (const [unit, animations] of entityToAnimations) {
        const priority = getPriorityAnimations(animations);

        if (priority.length > 0) {
            const animation = priority[0];

            if (!unit.FindModifierByName(animation.definition.modifier.name)) {
                stopAnimations(unit);

                const duration = animation.trigger ? animation.trigger.triggerAt - GameRules.GetGameTime() : undefined;
                animation.definition.modifier.apply(unit, unit, undefined, { duration: duration })?.SetStackCount(animation.rate * 10);
            }
        }
    }
}

function stopAnimations(unit: CDOTA_BaseNPC) {
    function isAnimation(modifier: CDOTA_Buff) {
        // modifier instanceof ModifierAnimation will not work for some reason
        for (const [, definition] of animationDefinitions) {
            if (definition.modifier.name == modifier.GetName()) {
                return true;
            }
        }
    }
    for (const modifier of unit.FindAllModifiers().filter(isAnimation)) {
        modifier.Destroy();
    }
}
