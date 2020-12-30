modifier_invoker_helper = class({})

function modifier_invoker_helper:OnCreated(params)
    if IsServer() then
        self.orbs = {}
        self:GetParent():FindAbilityByName("invoker_extra"):SetHidden(false)
        self:GetParent():FindAbilityByName("invoker_ultimate"):SetHidden(false)
        self:GetParent():FindAbilityByName("invoker_empty1"):SetHidden(false)
        self:GetParent():FindAbilityByName("invoker_empty2"):SetHidden(false)
        self:SetStackCount(3)
    end
end

function modifier_invoker_helper:GetMaxCharges()
	return 3--self:GetAbility():GetSpecialValueFor("max_charges")
end

function modifier_invoker_helper:GetReplenishType() return CHARGES_TYPE_SYNC end
function modifier_invoker_helper:GetReplenishTime()
    return 1.0
end

function modifier_invoker_helper:AddOrb(hOrbModifier)
    if #self.orbs == 3 then
        self:RemoveFirstOrb()
    end
    table.insert(self.orbs, hOrbModifier)
    self:UpdateEffects()
end

function modifier_invoker_helper:UpdateEffects()
    for _,orb in pairs(self.orbs) do
        local efx = orb:GetEfx()
        local parent = orb:GetParent()
        ParticleManager:SetParticleControlEnt(efx, 1, parent, PATTACH_POINT_FOLLOW, "attach_orb" .. _, parent:GetAbsOrigin(), false)
    end
end

function modifier_invoker_helper:RemoveFirstOrb()
    self.orbs[1]:Destroy()
    table.remove(self.orbs, 1)
end

function modifier_invoker_helper:GetOrbAmounts()
    local amounts = {
        wex = 0,
        quas = 0,
        exort = 0
    }

    for _,orb in pairs(self.orbs) do
        local name = orb:GetName()

        for key, value in pairs(amounts) do
            if name == 'modifier_invoker_orb_' .. key then
                amounts[key] = value + 1
                break
            end
        end
    end
    
    return amounts
end

function modifier_invoker_helper:Print()
    for _,orb in pairs(self.orbs) do
        print('self.orbs[', _, ']: ', orb:GetName())
    end
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Charges(modifier_invoker_helper)
