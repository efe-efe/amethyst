modifier_item_orchid_custom = class({})

function modifier_item_orchid_custom:OnCreated()
    self:SetStackCount(0)
    self.effect_cast = ParticleManager:CreateParticle("particles/items2_fx/orchid.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
end

function modifier_item_orchid_custom:OnDestroy()
    if IsServer() then
        local damage_table = {
            victim = self:GetParent(),
            attacker = self:GetCaster(),
            damage = self:GetStackCount(),
            damage_type = DAMAGE_TYPE_PURE
        }
        ApplyDamage(damage_table)
        self:PlayEffectsOnDestroy()

        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)
    end
end


function modifier_item_orchid_custom:DeclareFunctions()
	return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_item_orchid_custom:GetModifierIncomingDamage_Percentage(params)
    self:SetStackCount(self:GetStackCount() + params.damage)
    return 0
end

function modifier_item_orchid_custom:CheckState()
	return { 
        [MODIFIER_STATE_SILENCED] = true
    }
end

function modifier_item_orchid_custom:PlayEffectsOnDestroy()
	local particle_cast = "particles/items2_fx/orchid_pop.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self:GetParent())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self:GetStackCount() * 100))
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_item_orchid_custom:GetEffectName()
	return "particles/generic_gameplay/generic_silenced.vpcf"
end
function modifier_item_orchid_custom:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_item_orchid_custom:GetStatusLabel() return "Soul Burn" end
function modifier_item_orchid_custom:GetStatusPriority() return 5 end
function modifier_item_orchid_custom:GetStatusStyle() return "Silence" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_item_orchid_custom)