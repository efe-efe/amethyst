modifier_amethyst = class({})

function modifier_amethyst:OnCreated(params)
    if IsServer() then
        self:SetStackCount(params.mana)
        self.efx_index = ParticleManager:CreateParticle("particles/generic_gameplay/rune_arcane_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        CustomEntitiesLegacy:SendDataToClient(self:GetParent())
    end
end

function modifier_amethyst:OnRefresh(params)
    if IsServer() then
        self:SetStackCount(self:GetStackCount() + params.mana)
        CustomEntitiesLegacy:SendDataToClient(self:GetParent())
    end
end

function modifier_amethyst:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.efx_index, false)
        ParticleManager:ReleaseParticleIndex(self.efx_index)
    end
end

function modifier_amethyst:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_EXTRA_MANA_BONUS,
	}
end

function modifier_amethyst:GetModifierExtraManaBonus()
	return self:GetStackCount()
end