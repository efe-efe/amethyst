modifier_storm_ex_basic_attack = class({})

function modifier_storm_ex_basic_attack:IsHidden() return true end

function modifier_storm_ex_basic_attack:OnCreated(params)
    if IsServer() then
        if self:GetAbility():GetLevel() >= 2 then
            self:SetStackCount(21)
        else
            self:SetStackCount(11)
        end

        self.efx = EFX('particles/storm/storm_ex_basic_attack.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), {})

    end
end

function modifier_storm_ex_basic_attack:OnDestroy()
    if IsServer() then
        DEFX(self.efx, false)
    end
end

function modifier_storm_ex_basic_attack:OnStackCountChanged(iStackCount)
    if self:GetStackCount() <= 2 then
        self:Destroy()
    end    
end

function modifier_storm_ex_basic_attack:OnRefresh(params)
    if IsServer() then
        DEFX(self.efx, false)
        self.efx = EFX('particles/storm/storm_ex_basic_attack_level_two.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), {})
        
        if self:GetAbility():GetLevel() >= 2 then
            if self:GetStackCount() < 22 then
                self:SetStackCount(22)
            end
        else
            if self:GetStackCount() < 12 then
                self:IncrementStackCount()
            end
        end
    end
end

function modifier_storm_ex_basic_attack:GetLevel()
    return self:GetStackCount() % 10
end

