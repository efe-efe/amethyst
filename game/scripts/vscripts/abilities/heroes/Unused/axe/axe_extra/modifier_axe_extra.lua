modifier_axe_extra = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_extra:IsHidden() return false
end

function modifier_axe_extra:IsDebuff() return false
end

function modifier_axe_extra:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_axe_extra:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_axe_extra:OnCreated(kv)
    if IsServer() then
        self.damage_reduction = -self:GetAbility():GetSpecialValueFor("damage_reduction")
        self:PlayEffects()

        ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
			style = "Generic",
			text = "Armor",
			progressBarType = "duration",
			priority = 2,
		})
    end
end

--------------------------------------------------------------------------------
-- Destructor
function modifier_axe_extra:OnDestroy(kv)
    if IsServer() then
        self:StopEffects()
    end
end

function modifier_axe_extra:GetModifierIncomingDamage_Percentage(params)
	return self.damage_reduction
end

function modifier_axe_extra:PlayEffects()
    local caster = self:GetParent()
    -- Create Particle
    local particle_cast = "particles/units/heroes/hero_medusa/medusa_mana_shield.vpcf"
    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControl(self.effect_cast, 0 , caster:GetOrigin())
    ParticleManager:SetParticleControl(self.effect_cast, 1 , caster:GetOrigin())
end

function modifier_axe_extra:StopEffects()
    ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast)
end

-- Graphics & Animations
function modifier_axe_extra:GetStatusEffectName()
	return "particles/status_fx/status_effect_pangolier_shield.vpcf"
end

