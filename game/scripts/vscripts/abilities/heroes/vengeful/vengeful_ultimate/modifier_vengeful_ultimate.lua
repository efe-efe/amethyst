modifier_vengeful_ultimate = class({})

function modifier_vengeful_ultimate:DeclareFunctions()
	return {
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}
end

function modifier_vengeful_ultimate:OnAbilityFullyCast(params)
    if IsServer() then
        if params.unit ~= self:GetParent() then return end
        
        local ability = params.ability
        if self:ShouldMimic(ability) then
            if self.ability then
                self:RemoveAbility()
            end
            self:SetAbility(ability)
        end
	end
end

function modifier_vengeful_ultimate:ShouldMimic(hAbility)
    return self.ability ~= hAbility and hAbility.IsMimicable and hAbility:IsMimicable() and not self:AlreadyCopied(hAbility)
end

function modifier_vengeful_ultimate:AlreadyCopied(hAbility)
    return self.ability and self.ability:GetName() == hAbility:GetName() .. "_ultimate"
end

function modifier_vengeful_ultimate:SetAbility(hAbility)
    local name = hAbility:GetName()
    local copy_name = name .. "_ultimate"
    self.ability = self:GetParent():AddAbility(copy_name)
    self.ability:SetLevel(hAbility:GetLevel())

    if self.ability:GetAssociatedPrimaryAbilities() then
        local associated = self:GetParent():AddAbility(self.ability:GetAssociatedPrimaryAbilities())
        associated:SetLevel(self.ability:GetLevel())
    end

    self:GetParent():SwapAbilities(
        copy_name, 
        "vengeful_ultimate", 
        true, 
        false
    )
end

function modifier_vengeful_ultimate:RemoveAbility()
    local name = self.ability:GetAbilityName()

    if self.ability.BeforeRemoved then
        self.ability:BeforeRemoved()
    end

    self:GetParent():SwapAbilities(
        "vengeful_ultimate",
        name, 
        true, 
        false 
    )

    if self.ability:GetAssociatedPrimaryAbilities() then
        self:GetParent():RemoveAbility(self.ability:GetAssociatedPrimaryAbilities())
    end
    
    self:GetParent():RemoveAbility(name)

    self.abilities = nil
end