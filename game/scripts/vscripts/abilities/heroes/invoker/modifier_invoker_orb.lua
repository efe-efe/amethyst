modifier_invoker_orb = class({})

function modifier_invoker_orb:IsDebuff()        return	false	end
function modifier_invoker_orb:IsPurgable() 		return	false	end
function modifier_invoker_orb:RemoveOnDeath() 	return	false	end

function modifier_invoker_orb:OnCreated(table)
    if IsServer() then
        local parent = self:GetParent()
        self.efx = EFX(self:GetParticleName(), PATTACH_OVERHEAD_FOLLOW, parent, {})
        parent:FindModifierByName("modifier_invoker_helper"):AddOrb(self)
    end
end

function modifier_invoker_orb:GetParticleName()
    return ""
end

function modifier_invoker_orb:GetEfx()
    return self.efx
end

function modifier_invoker_orb:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.efx, false)
        ParticleManager:ReleaseParticleIndex(self.efx)
    end
end

function modifier_invoker_orb:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

modifier_invoker_orb_quas = class(modifier_invoker_orb)
modifier_invoker_orb_exort = class(modifier_invoker_orb)
modifier_invoker_orb_wex = class(modifier_invoker_orb)

function modifier_invoker_orb_quas:GetParticleName()
    return "particles/units/heroes/hero_invoker/invoker_quas_orb.vpcf"
end

function modifier_invoker_orb_quas:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_invoker_orb_quas:GetModifierMoveSpeedBonus_Percentage()
    return 3
end

function modifier_invoker_orb_exort:GetParticleName()
    return "particles/units/heroes/hero_invoker/invoker_exort_orb.vpcf"
end

function modifier_invoker_orb_exort:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_invoker_orb_exort:GetModifierPreAttack_BonusDamage()
    return 1
end

function modifier_invoker_orb_wex:OnCreated(params)
    modifier_invoker_orb.OnCreated(self, params)

    if IsServer() then
        self:StartIntervalThink(3.0)
    end
end

function modifier_invoker_orb_wex:OnIntervalThink()
    CustomEntities:GiveManaCustom(self:GetParent(), 1, true, true)
end

function modifier_invoker_orb_wex:GetParticleName()
    return "particles/units/heroes/hero_invoker/invoker_wex_orb.vpcf"
end
