import { CustomModifier } from "../abilities/framework/custom_modifier";

export class ModifierCombatEvents extends CustomModifier<undefined> {
    OnBasicAttackStarted() {}

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    OnBasicAttackLanded(event: { target: CDOTA_BaseNPC }) {}

    OnBasicAttackEnded() {}

    IsHidden() {
        return true;
    }
}
