import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

// local translate = {
// 	["bulwark"] = 1,
// }

@registerModifier("modifier_hero_movement")
export class ModifierHeroMovement extends CustomModifier<undefined> {
    IsHidden() {
        return true;
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

    OnCreated() {
        // if IsServer() then
        //     local translate_modifiers = CustomEntitiesLegacy:GetAllModifiersWithType(self:GetParent(), MODIFIER_TYPES.TRANSLATE)
        //     if translate_modifiers then
        //         local translate_modifier = nil
        //         for _,modifier in pairs(translate_modifiers) do
        //             local modifier_handle = self:GetParent():FindModifierByName(modifier)
        //             if translate_modifier == nil then
        //                 translate_modifier = modifier_handle
        //             else
        //                 if modifier_handle:GetWeight() > translate_modifier:GetWeight() then
        //                     translate_modifier = modifier_handle
        //                 end
        //             end
        //         end
        //         if translate_modifier ~= nil then
        //             self:SetStackCount(translate[translate_modifier:GetTranslation()])
        //         end
        //     end
        // end
    }

    DeclareFunctions() {
        return [
            ModifierFunction.OVERRIDE_ANIMATION,
            ModifierFunction.OVERRIDE_ANIMATION_RATE,
            ModifierFunction.OVERRIDE_ANIMATION_WEIGHT
            // ModifierFunction.TRANSLATE_ACTIVITY_MODIFIERS
        ];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_RUN;
    }

    GetOverrideAnimationRate() {
        return 1.0;
    }

    GetOverrideAnimationWeight() {
        return 1.0;
    }

    // GetActivityTranslationModifiers() {
    // 	for k,v in pairs(translate) do
    //         if self:GetStackCount() == v then
    // 			return k
    // 		end
    // 	end
    // }
}
