modifier_sky_basic_attack_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sky_basic_attack_debuff:IsDebuff()
	return true
end

function modifier_sky_basic_attack_debuff:IsStunDebuff()
	return false
end

function modifier_sky_basic_attack_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_sky_basic_attack_debuff:OnCreated()
    self.magic_res_debuff_pct = -50

    if IsServer() then
        local particle_cast = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_ancient_seal_debuff.vpcf"
        self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_sky_basic_attack_debuff:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)
    end
end


--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sky_basic_attack_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}

	return funcs
end

function modifier_sky_basic_attack_debuff:GetModifierMagicalResistanceBonus()
	return self.magic_res_debuff_pct
end
