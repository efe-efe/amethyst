modifier_item_orchid_custom = class({})

function modifier_item_orchid_custom:OnCreated()
    self:SetStackCount(0)
end

function modifier_item_orchid_custom:OnDestroy()
    if IsServer() then
        local damage_table = {
            victim = self:GetParent(),
            attacker = self:GetCaster(),
            damage = self:GetStackCount(),
            damage_type = DAMAGE_TYPE_PURE
        }
        ApplyDamage( damage_table )
        self:PlayEffectsOnDestroy()
    end
end


function modifier_item_orchid_custom:DeclareFunctions()
	return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_item_orchid_custom:GetModifierIncomingDamage_Percentage( params )
    self:SetStackCount( self:GetStackCount() + params.damage )
    return 0
end

function modifier_item_orchid_custom:PlayEffectsOnDestroy()
	local particle_cast = "particles/items2_fx/orchid_pop.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(self:GetStackCount() * 100) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_item_orchid_custom:GetEffectName()
    return "particles/items2_fx/orchid.vpcf"
end

function modifier_item_orchid_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

