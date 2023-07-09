import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";
import { sendOverheadShieldMessage } from "../util";

export function getUnitShieldPoints(unit: CDOTA_BaseNPC) {
    return unit
        .FindAllModifiers()
        .filter(modifier => modifier instanceof ModifierShield)
        .reduce((a, b) => a + b.GetStackCount(), 0);
}

@registerModifier()
export class ModifierShield extends CustomModifier<undefined> {
    OnCreated(params: { damageBlock: number }) {
        if (IsServer()) {
            sendOverheadShieldMessage(this.parent, params.damageBlock);
            this.SetStackCount(params.damageBlock);
        }
    }

    OnRefresh(params: { damageBlock: number }) {
        if (IsServer()) {
            if (this.GetStackeable()) {
                this.SetStackCount(this.GetStackCount() + params.damageBlock);
            } else {
                this.SetStackCount(params.damageBlock);
            }
            // SendOverheadShieldMessage(self:GetParent(), params.damageBlock)
        }
    }

    // function modifier:OnDestroy()
    //     if IsServer() then
    //         self:InformClient()
    //     end
    //     if onDestroy then onDestroy(self) end
    // end

    OnStackCountChanged() {
        if (IsServer()) {
            // self:InformClient()
            if (this.GetStackCount() <= 0) {
                this.Destroy();
            }
        }
    }

    //     function modifier:InformClient()
    //         CustomEntitiesLegacy:SendDataToClient(self:GetParent())
    //         local alliance = CustomEntitiesLegacy:GetAlliance(self:GetParent())
    //         if alliance then
    //             alliance:SendDataToClient()
    //         end
    //     end

    GetStackeable() {
        return false;
    }
}
