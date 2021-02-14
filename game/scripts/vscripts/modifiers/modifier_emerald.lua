modifier_emerald = class({})

function modifier_emerald:OnCreated(params)
    if IsServer() then
        self:SetStackCount(params.heal_per_second)
        self:StartIntervalThink(1.0)
        self.efx_index = ParticleManager:CreateParticle("particles/gems/emerald_regen_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    end
end

function modifier_emerald:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.efx_index, false)
        ParticleManager:ReleaseParticleIndex(self.efx_index)
    end
end

function modifier_emerald:OnIntervalThink()
    self:GetParent():Heal(self:GetStackCount(), self:GetParent())
    
    EFX('particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_target_death_beam.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), {
        cp1 = self:GetParent():GetAbsOrigin(),
        release = true,
    })
    EFX('particles/econ/items/dazzle/dazzle_ti6_gold/dazzle_ti6_shallow_grave_gold_flash.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), {
        release = true,
    })
    EFX('particles/gems/emerald_hammers.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), {
        cp3 = {
            ent = self:GetParent(),
            point = 'attach_hitloc'
        },
        release = true,
    })
end

function modifier_emerald:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_emerald:OnTooltip()
	return self:GetStackCount()
end

function modifier_emerald:GetTexture()
	return 'modifier_emerald'
end

function modifier_emerald:GetStatusLabel() return "Emerald" end
function modifier_emerald:GetStatusPriority() return 2 end
function modifier_emerald:GetStatusStyle() return "Emerald" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_emerald)