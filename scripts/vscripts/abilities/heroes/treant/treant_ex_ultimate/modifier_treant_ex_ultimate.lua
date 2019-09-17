modifier_treant_ex_ultimate = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_treant_ex_ultimate:IsHidden()
	return false
end

function modifier_treant_ex_ultimate:IsDebuff()
	return false
end

function modifier_treant_ex_ultimate:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_treant_ex_ultimate:OnCreated( kv )
    self.damage_bonus_pct = self:GetAbility():GetSpecialValueFor( "damage_bonus_pct" )

    if IsServer() then
        self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
        self.damage_block = self:GetAbility():GetSpecialValueFor( "damage_block" )
        self:PlayEffects()
    end
end
--------------------------------------------------------------------------
---- Destroyer
function modifier_treant_ex_ultimate:OnDestroy( kv )
    if IsServer() then
        self:StopEffects()
    end
end

function modifier_treant_ex_ultimate:GetModifierIncomingDamage_Percentage( params )
    self.damage_block =  self.damage_block - params.damage

    if self.damage_block <= 0 then
        local reduction = 100 - (100 * self.damage_block * (-1) / params.damage)
        self:Destroy()
        return -reduction
    end
    return -100
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_treant_ex_ultimate:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end


function modifier_treant_ex_ultimate:GetModifierBaseDamageOutgoing_Percentage()
    return self.damage_bonus_pct
end

--------------------------------------------------------------------------------
-- Graphics & Sounds

-- On activated
function modifier_treant_ex_ultimate:PlayEffects()
    -- Get Resources
	local particle_cast = "particles/units/heroes/hero_treant/treant_livingarmor.vpcf"
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(self.effect_cast, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(self.effect_cast, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
end

function modifier_treant_ex_ultimate:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end