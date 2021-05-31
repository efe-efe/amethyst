modifier_combine_util = class({})

function modifier_combine_util:OnCreated()
    if IsServer() then
        self.efx = EFX('particles/items5_fx/repair_kit_overhead.vpcf', PATTACH_OVERHEAD_FOLLOW, self:GetParent(), {
            cp2 = {
                ent = self:GetParent(),
                attach = PATTACH_OVERHEAD_FOLLOW,
            },
            release = false,
        })
    end
end

function modifier_combine_util:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.efx, false)
        ParticleManager:ReleaseParticleIndex(self.efx)
    end
end