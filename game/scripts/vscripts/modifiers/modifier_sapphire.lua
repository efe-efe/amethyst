modifier_sapphire = class({})

function modifier_sapphire:OnCreated()
    if IsServer() then
        self.efx_index = ParticleManager:CreateParticle("particles/generic_gameplay/rune_doubledamage_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    end
end

function modifier_sapphire:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.efx_index, false)
        ParticleManager:ReleaseParticleIndex(self.efx_index)
    end
end

function modifier_sapphire:GetStatusLabel() return "Sapphire" end
function modifier_sapphire:GetStatusPriority() return 2 end
function modifier_sapphire:GetStatusStyle() return "Sapphire" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_sapphire)
Modifiers.Shield(modifier_sapphire)