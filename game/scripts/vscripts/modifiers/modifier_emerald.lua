modifier_emerald = class({})

function modifier_emerald:OnCreated(params)
    if IsServer() then
        self.health_per_second = 4
        self:StartIntervalThink(1.0)
        self.efx_index = ParticleManager:CreateParticle("particles/generic_gameplay/rune_regen_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    end
end

function modifier_emerald:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.efx_index, false)
        ParticleManager:ReleaseParticleIndex(self.efx_index)
    end
end

function modifier_emerald:OnIntervalThink()
    self:GetParent():Heal(self.health_per_second, self:GetParent())
end

function modifier_emerald:GetStatusLabel() return "Emerald" end
function modifier_emerald:GetStatusPriority() return 2 end
function modifier_emerald:GetStatusStyle() return "Emerald" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_emerald)