import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier()
export class ModifierRecast extends CustomModifier<undefined> {
    OnCreated() {
        if (IsServer()) {
            // if self:GetRecastCharges() then
            //     self:SetStackCount(self:GetRecastCharges())
            // end
            // if self:GetAbility() == self:GetRecastAbility() then
            //     self:GetAbility():EndCooldown()
            // else
            //     self:GetParent():SwapAbilities(
            //         self:GetAbility():GetName(),
            //         self:GetRecastAbility():GetName(),
            //         false,
            //         true
            //     )
            // end
            // CustomEntitiesLegacy:SendDataToClient(self:GetParent())
        }
    }

    // function modifier:GetRecastData()
    //     return {
    //         key = self:GetRecastKey(),
    //         modifier_name = self:GetName(),
    //         ability_name = self:GetRecastAbility():GetName(),
    //     }
    // end

    // function modifier:OnDestroy()
    //     if IsServer() then
    //         if self:GetAbility() == self:GetRecastAbility() then
    //             self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(self:GetAbility():GetLevel()))
    //         else
    //             self:GetParent():SwapAbilities(
    //                 self:GetAbility():GetName(),
    //                 self:GetRecastAbility():GetName(),
    //                 true,
    //                 false
    //            )
    //         end
    //         CustomEntitiesLegacy:SendDataToClient(self:GetParent())
    //     end
    //     if onDestroy then onDestroy(self) end
    // end

    // function modifier:OnRefresh()
    //     self:IncrementStackCount()
    //     if onRefresh then onRefresh(self) end
    // end

    // function modifier:OnStackCountChanged(old)
    //     if IsServer() then
    //         if self:GetStackCount() <= 0 then
    //             self:Destroy()
    //         end
    //     end
    // end

    // function modifier:DeclareFunctions()
    //     local funcs = {}

    //     if declareFunctions then
    //         for _,func in pairs(declareFunctions()) do
    //             table.insert(funcs, func)
    //         end
    //     end

    //     table.insert(funcs, MODIFIER_EVENT_ON_ABILITY_EXECUTED)

    //     return funcs
    // end

    // function modifier:OnAbilityExecuted(params)
    //     if IsServer() then
    //         if params.unit ~= self:GetParent() then
    //             return
    //         end

    //         if params.ability == self:GetRecastAbility() then
    //             if self:GetRecastCharges() then
    //                 self:DecrementStackCount()
    //             end
    //         end
    //     end
    // end

    // function modifier:GetRecastCharges()
    //     if getRecastCharges then return getRecastCharges(self) end
    //     return nil
    // end

    // function modifier:GetRecastAbility()
    //     if getRecastAbility then return getRecastAbility(self) end
    //     return self:GetAbility()
    // end

    // function modifier:GetRecastKey()
    //     if getRecastKey then return getRecastKey(self) end
    //     return "NO KEY"
    // end

    // function modifier:GetStatusLabel() return "Recast" end
    // function modifier:GetStatusPriority() return 10 end
    // function modifier:GetStatusStyle() return "Recast" end
    // function modifier:GetStatusScope() return STATUS_SCOPE_LOCAL end
}

//     if IsClient() then require("wrappers/modifiers") end
//     Modifiers.Status(modifier)
//     Modifiers.StartTracking(modifier, MODIFIER_TYPES.RECAST)
