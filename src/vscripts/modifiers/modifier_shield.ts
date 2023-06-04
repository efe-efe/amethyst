import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";
import { sendOverheadShieldMessage } from "../util";

@registerModifier()
export class ModifierShield extends CustomModifier<undefined> {
    OnCreated(params: { damageBlock: number }) {
        if (IsServer()) {
            sendOverheadShieldMessage(this.parent, params.damageBlock);
            this.SetStackCount(params.damageBlock);
        }
    }

    //     function modifier:OnRefresh(params)
    //         if IsServer() then
    //             if self:GetStackeable() then
    //                 self:SetStackCount(self:GetStackCount() + params.damageBlock)
    //             else
    //                 self:SetStackCount(params.damageBlock)
    //             end
    //             SendOverheadShieldMessage(self:GetParent(), params.damageBlock)
    //         end
    //     end
    //     function modifier:OnDestroy()
    //         if IsServer() then
    //             self:InformClient()
    //         end
    //         if onDestroy then onDestroy(self) end
    //     end
    //     function modifier:OnStackCountChanged(old)
    //         if IsServer() then
    //             self:InformClient()
    //             if self:GetStackCount() < 0 then
    //                 self:Destroy()
    //             end
    //         end
    //     end
    //     function modifier:DeclareFunctions()
    //         local funcs = {}
    //         if declareFunctions then
    //             for _,func in pairs(declareFunctions()) do
    //                 table.insert(funcs, func)
    //             end
    //         end
    //         table.insert(funcs, MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE)
    //         return funcs
    //     end
    //     function modifier:GetModifierIncomingDamage_Percentage(params)
    //         for key, value in pairs(CustomEntitiesLegacy:GetAllModifiersWithType(self:GetParent(), MODIFIER_TYPES.SHIELD)) do
    //             if value == self:GetName() then
    //                 CustomEntitiesLegacy:SetBeenHurt(self:GetParent(), true)
    //                 local shield_points = self:GetStackCount() - params.damage
    //                 if shield_points <= 0 then
    //                     local reduction = 100 - (100 * shield_points * (-1) / params.damage)
    //                     self:Destroy()
    //                     return -reduction
    //                 end
    //                 self:SetStackCount(shield_points)
    //                 return -100
    //             end
    //             return 0
    //         end
    //     end
    //     function modifier:InformClient()
    //         CustomEntitiesLegacy:SendDataToClient(self:GetParent())
    //         local alliance = CustomEntitiesLegacy:GetAlliance(self:GetParent())
    //         if alliance then
    //             alliance:SendDataToClient()
    //         end
    //     end
    //     function modifier:GetStackeable()
    //         if getStackeable then return getStackeable(self) end
    //         return false
    //     end
    //     Modifiers.StartTracking(modifier, MODIFIER_TYPES.SHIELD)
}
