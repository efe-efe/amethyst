modifier_nevermore_second_attack_recasts_counter = class({})

function modifier_nevermore_second_attack_recasts_counter:IsHidden()     return true end
function modifier_nevermore_second_attack_recasts_counter:IsPurgable()   return false end

function modifier_nevermore_second_attack_recasts_counter:OnCreated(params)
    self.recast_duration = self:GetAbility():GetSpecialValueFor("recast_duration")

    if IsServer() then
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_nevermore_second_attack_recast", { duration = self.recast_duration })
        self:SetStackCount(self:GetAbility():GetSpecialValueFor("recasts"))
    end
end

function modifier_nevermore_second_attack_recasts_counter:OnDestroy()
    if IsServer() then
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_nevermore_second_attack_block_recast", { duration = 2.0 })
    end
end

function modifier_nevermore_second_attack_recasts_counter:OnStackCountChanged(iStackCount)
    if IsServer() then
        if self:GetStackCount() > 0 then
            self:SetDuration(self.recast_duration, true)
            self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_nevermore_second_attack_recast", { duration = self.recast_duration })
        else
            self:Destroy()
        end
    end
end

