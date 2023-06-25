export enum Translate {
    "odachi" = 1,
    "sharp_blade" = 2,
    "aggressive" = 3,
    "attack_close_range" = 4,
    "ti10_taunt" = 5,
    "overload" = 6,
    "ti8" = 7,
    "overkilled" = 8,
    "loadout" = 9
}

const translateKeys = Object.keys(Translate) as (keyof typeof Translate)[];

import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";
import { fullyFaceTowards, getCursorPosition } from "../util";

@registerModifier({ customNameForI18n: "modifier_casting" })
export class ModifierCasting extends CustomModifier {
    movementSpeed?: number;

    IsHidden() {
        return true;
    }

    OnCreated(params: { movementSpeed?: number; translate?: Translate }) {
        if (IsServer()) {
            this.movementSpeed = params.movementSpeed;
            // self.ignore_activation_cycle = params.ignore_activation_cycle

            if (params.translate) {
                this.SetStackCount(params.translate);
            }

            // if not self.ignore_activation_cycle then
            // 	for i = 0, 10 do
            // 		local ability = self.parent:GetAbilityByIndex(i)
            // 		if ability and ability ~= self:GetAbility() then
            // 			ability:SetActivated(false)
            // 		end
            // 	end
            // end

            this.StartIntervalThink(0.03);
        }
    }

    OnDestroy() {
        if (IsServer()) {
            // if not self.ignore_activation_cycle then
            //     for i = 0, 10 do
            //         local ability = self.parent:GetAbilityByIndex(i)
            //         if ability and ability ~= self:GetAbility() then
            //             ability:SetActivated(true)
            //         }
            //     }
            // }

            if (this.GetRemainingTime() > 0.05) {
                // if not self:GetAbility():IsBasicAttack() then
                //     self:GetAbility():StartCooldown(0.5)
                // }
            }
        }
    }

    OnIntervalThink() {
        if (!this.parent.IsAlive()) {
            this.Destroy();
        }

        if (this.parent.GetPlayerOwnerID() != -1) {
            // TODO: @Refactor refactor GetCursorPosition
            const mouse = getCursorPosition(this.caster);
            const direction = mouse.__sub(this.parent.GetAbsOrigin()).Normalized();

            fullyFaceTowards(this.parent, Vector(direction.x, direction.y, this.parent.GetForwardVector().z));
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.TRANSLATE_ACTIVITY_MODIFIERS, ModifierFunction.MOVESPEED_BONUS_PERCENTAGE];
    }

    GetActivityTranslationModifiers() {
        for (const key of translateKeys) {
            const value = Translate[key];
            if (this.GetStackCount() == value) {
                return key;
            }
        }

        return "";
    }

    GetModifierMoveSpeedBonus_Percentage() {
        if (this.movementSpeed && this.movementSpeed != 0) {
            return -(100 - this.movementSpeed);
        }
        return 0;
    }

    CheckState() {
        if (this.movementSpeed == 0) {
            return { [ModifierState.ROOTED]: true };
        }

        return {};
    }

    // function modifier_casting:GetStatusEnabled()
    // 	if self:GetAbility():GetAbilityType() == 1 then
    // 		return true
    // 	end
    // end
}
