modifier_nevermore_special_attack_stacks = class({})

function modifier_nevermore_special_attack_stacks:OnCreated(params)
    if IsServer() then
        self.max_stacks = self:GetAbility():GetSpecialValueFor('max_stacks')
        self:SetStackCount(1)
    end
end

function modifier_nevermore_special_attack_stacks:OnRefresh(params)
    if IsServer() then
        self:IncrementStackCount()
    end
end

function modifier_nevermore_special_attack_stacks:OnStackCountChanged(iStackCount)
    if IsServer() then
        if self:GetStackCount() > self.max_stacks then
            self:SetStackCount(self.max_stacks)
            return
        end

        if self:GetStackCount() == 0 then
            self:Destroy()
        end
    end
end

function modifier_nevermore_special_attack_stacks:GetEffectName()
	return "particles/units/heroes/hero_nevermore/nevermore_shadowraze_debuff.vpcf"
end


function modifier_nevermore_special_attack_stacks:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_nevermore_special_attack_stacks:GetStatusLabel() return "Raze" end
function modifier_nevermore_special_attack_stacks:GetStatusPriority() return 4 end
function modifier_nevermore_special_attack_stacks:GetStatusStyle() return "Raze" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_nevermore_special_attack_stacks)