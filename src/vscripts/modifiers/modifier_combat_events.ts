import { CustomAbility } from "../abilities/framework/custom_ability";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { ProjectileHandler } from "../projectiles";

export type OnHitEvent =
    | { source: CDOTA_BaseNPC; triggerCounters: boolean; attackCategory: "meele" | "aoe" | "single" }
    | { source: CDOTA_BaseNPC; triggerCounters: boolean; attackCategory: "projectile"; projectile: ProjectileHandler };

export class ModifierCombatEvents<A extends CDOTABaseAbility | undefined = CustomAbility> extends CustomModifier<A> {
    OnBasicAttackStarted() {}

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    OnBasicAttackLanded(event: { target: CDOTA_BaseNPC }) {}

    OnBasicAttackEnded() {}

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    OnHit(event: OnHitEvent) {
        return true;
    }

    AfterHit() {}

    IsHidden() {
        return true;
    }
}
