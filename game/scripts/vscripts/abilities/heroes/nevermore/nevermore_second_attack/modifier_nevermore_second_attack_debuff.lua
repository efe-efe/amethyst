modifier_nevermore_second_attack_debuff = class({})

function modifier_nevermore_second_attack_debuff:OnCreated(params)
    if IsServer() then
        self:SetStackCount(1)

        self:GetParent():AddStatusBar({
			label = "Raze", modifier = self, priority = 4, stylename="Raze"
		}) 
    end
end

function modifier_nevermore_second_attack_debuff:OnRefresh(table)
    if IsServer() then
        self:IncrementStackCount()
    end
end

function modifier_nevermore_second_attack_debuff:GetEffectName()
	return "particles/units/heroes/hero_nevermore/nevermore_shadowraze_debuff.vpcf"
end

function modifier_nevermore_second_attack_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end