modifier_wisp_extra = class({})

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wisp_extra:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_extra:OnCreated( kv )
    self.damage_reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
    self.speed_buff_pct = self:GetAbility():GetSpecialValueFor("speed_buff_pct")
    
    if IsServer() then
        -- effects
        local sound_cast = "Hero_Wisp.Overcharge"

        EmitSoundOn( sound_cast, self:GetParent() )

        ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
            style = "Overcharge",
            text = "overcharge",
            progressBarType = "duration",
            priority = 1,
        })
        self:PlayEffects()
    end
end

--------------------------------------------------------------------------------
-- Destructor
function modifier_wisp_extra:OnDestroy( kv )
    if IsServer() then
        -- load data

        local sound_cast = "Hero_Wisp.Overcharge"
        StopSoundOn( sound_cast, self:GetParent() )
        self:StopEffects()
    end
end


function modifier_wisp_extra:GetModifierIncomingDamage_Percentage( params )
    return -self.damage_reduction
end

function modifier_wisp_extra:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff_pct
end

function modifier_wisp_extra:GetModifierIgnoreMovespeedLimit( params )
    return 1
end


--------------------------------------------------------------------------------
-- Visuals
function modifier_wisp_extra:PlayEffects()
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

function modifier_wisp_extra:StopEffects()
    if IsServer() then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
end

