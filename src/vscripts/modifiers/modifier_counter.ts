import { CustomAbility } from "../abilities/framework/custom_ability";
import { registerModifier } from "../lib/dota_ts_adapter";
import { ModifierCombatEvents } from "./modifier_combat_events";

@registerModifier()
export class ModifierCounter<A extends CDOTABaseAbility | undefined = CustomAbility> extends ModifierCombatEvents<A> {
    particleIds: ParticleID[] = [];

    OnCreated() {
        if (IsServer()) {
            this.particleIds = this.Visuals();
            // if self:DeactivateAbilities() then
            //     CustomEntitiesLegacy:DeactivateNonPriorityAbilities(self:GetParent())
            // end
        }
    }

    OnDestroy() {
        if (IsServer()) {
            for (const particleId of this.particleIds) {
                ParticleManager.DestroyParticle(particleId, false);
                ParticleManager.ReleaseParticleIndex(particleId);
            }
            // if self:DeactivateAbilities() then
            //     CustomEntitiesLegacy:SetAllAbilitiesActivated(self:GetParent(), true)
            // end
        }
    }

    Visuals() {
        return [
            ParticleManager.CreateParticle(
                "particles/items_fx/black_king_bar_avatar.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent
            )
        ];
    }

    GetMovementSpeedPercentage() {
        return 0;
    }

    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE, ModifierFunction.ON_ORDER];
    }

    OnOrder(event: ModifierUnitEvent) {
        if (event.unit == this.parent) {
            if (
                event.order_type == UnitOrder.STOP ||
                event.order_type == UnitOrder.HOLD_POSITION ||
                event.order_type == UnitOrder.CAST_POSITION ||
                event.order_type == UnitOrder.CAST_NO_TARGET
            ) {
                this.Destroy();
            }
        }
    }

    GetModifierMoveSpeedBonus_Percentage() {
        if (this.GetMovementSpeedPercentage() != 0) {
            return -(100 - this.GetMovementSpeedPercentage());
        }
        return 0;
    }

    CheckState() {
        return {
            [ModifierState.ROOTED]: this.GetMovementSpeedPercentage() == 0
        };
    }

    GetStatusEffectName() {
        return "particles/status_fx/status_effect_avatar.vpcf";
    }

    //     function modifier:DeactivateAbilities()
    //         if deactivateAbilities then return deactivateAbilities(self) end
    //         return true
    //     end
}
