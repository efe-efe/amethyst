modifier_wisp_ex_ultimate = class({})

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wisp_ex_ultimate:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_ex_ultimate:OnCreated( kv )
    self.damage_reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
    self.damage_bonus = self:GetAbility():GetSpecialValueFor("damage_bonus")
    
    if IsServer() then
        -- effects
        local sound_cast = "Hero_Wisp.Overcharge"

        EmitSoundOn( sound_cast, self:GetParent() )

        self:PlayEffects()
    end
end

--------------------------------------------------------------------------------
-- Destructor
function modifier_wisp_ex_ultimate:OnDestroy( kv )
    if IsServer() then
        -- load data

        local sound_cast = "Hero_Wisp.Overcharge"
        StopSoundOn( sound_cast, self:GetParent() )
        self:StopEffects()
    end
end


function modifier_wisp_ex_ultimate:GetModifierIncomingDamage_Percentage( params )
    return -self.damage_reduction
end

function modifier_wisp_ex_ultimate:GetModifierPreAttack_BonusDamage()
    return self.damage_bonus
end

--------------------------------------------------------------------------------
-- Visuals
function modifier_wisp_ex_ultimate:PlayEffects()
    if IsServer() then
        -- Get Resources
        local particle_cast = "particles/econ/items/wisp/wisp_overcharge_ti7.vpcf"
        local origin = self:GetParent():GetOrigin()
        
        self.effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_CUSTOMORIGIN, 
            nil
        )

        ParticleManager:SetParticleControlEnt( 
            self.effect_cast, 
            0, 
            self:GetParent(), 
            PATTACH_POINT_FOLLOW, 
            "attach_attack1", 
            origin + Vector( 0, 0, 96 ), 
            true 
        )
    end
end

function modifier_wisp_ex_ultimate:StopEffects()
    if IsServer() then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
end

