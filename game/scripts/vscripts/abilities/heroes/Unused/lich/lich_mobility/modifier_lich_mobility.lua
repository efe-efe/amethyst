modifier_lich_mobility = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_lich_mobility:IsHidden() return false
end

function modifier_lich_mobility:IsDebuff() return false
end

function modifier_lich_mobility:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_lich_mobility:OnCreated( kv )
    if IsServer() then
        self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
        self.damage_block = self:GetAbility():GetSpecialValueFor( "damage_block" )

        if IsServer() then
            ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
                style = "Generic",
                text = "shield",
                progressBarType = "duration",
                priority = 1,
            })
        end
        self:PlayEffects()
    end
end

function modifier_lich_mobility:OnDestroy()
    if IsServer() then
        self:StopEffects()
    end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_lich_mobility:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_lich_mobility:GetModifierIncomingDamage_Percentage( params )
    self.damage_block =  self.damage_block - params.damage

    if self.damage_block <= 0 then
        local reduction = 100 - (100 * self.damage_block * (-1) / params.damage)
        self:Destroy()
        return -reduction
    end
    return -100
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_lich_mobility:GetEffectName()
	return "particles/units/heroes/hero_lich/lich_frost_armor.vpcf"
end

function modifier_lich_mobility:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end


-- On activated
function modifier_lich_mobility:PlayEffects()
    -- Create Particles
    self.effect_cast = ParticleManager:CreateParticle( 
        "particles/units/heroes/hero_lich/lich_ice_age.vpcf", 
        PATTACH_CUSTOMORIGIN, 
        self:GetParent()
    )

    ParticleManager:SetParticleControlEnt( 
        self.effect_cast, 
        1, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_origin", 
        self:GetParent():GetOrigin(), 
        true 
    )
    ParticleManager:SetParticleControl( self.effect_cast, 2, Vector(250, 250, 250) )
end

function modifier_lich_mobility:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end