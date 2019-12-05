modifier_shield = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_shield:IsHidden()
	return false
end

function modifier_shield:IsDebuff()
	return false
end

function modifier_shield:IsStunDebuff()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_shield:OnCreated( params )
    if IsServer() then
        self.sound_cast = params.sound_cast

        self:SetStackCount(params.damage_block)
        self:PlayEffects( self:GetDuration() )
        GameMode:UpdateHeroHealthBar( self:GetParent() )
        self:GetParent():AddStatusBar({
			label = "Shield", modifier = self, priority = 2, stylename="Shield"
		}) 
	end
end

function modifier_shield:OnRefresh( params )
    if IsServer() then
        self:SetStackCount( self:GetStackCount() + params.damage_block )

        local new_duration = self:GetRemainingTime()
        if self:GetRemainingTime() < params.duration then
            new_duration = params.duration
        end

        self:SetDuration(new_duration, true)
        self:StopEffects()
        self:PlayEffects(new_duration)
        GameMode:UpdateHeroHealthBar( self:GetParent() )
    end
end

function modifier_shield:OnDestroy( kv )
    if IsServer() then
        self:StopEffects()
        GameMode:UpdateHeroHealthBar( self:GetParent() )
    end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_shield:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_shield:GetModifierIncomingDamage_Percentage( params )
    local shield_points = self:GetStackCount() - params.damage
    
    -- If shield is over
    if shield_points <= 0 then
        local reduction = 100 - (100 * shield_points * (-1) / params.damage)
        self:Destroy()
        return -reduction
    end

    self:SetStackCount(shield_points)
    return -100
end

function modifier_shield:OnStackCountChanged( old )
    if IsServer() then
		if self:GetStackCount() < 0 then
			self:Destroy()
        end
	end
end


--------------------------------------------------------------------------------
-- Graphics & Sounds
function modifier_shield:PlayEffects( duration )
    local particle_cast = "particles/items_fx/courier_shield.vpcf"
    if self.sound_cast ~= nil then
        EmitSoundOn(self.sound_cast, self:GetCaster())
    end
    
    local origin = self:GetParent():GetOrigin()

    -- Create Particles
    self.effect_cast = ParticleManager:CreateParticle( 
        particle_cast, 
        PATTACH_CUSTOMORIGIN, 
        self:GetParent()
    )

    ParticleManager:SetParticleControlEnt( 
        self.effect_cast, 
        0, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        origin, 
        true 
    )
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(duration, 0,0) )
end

function modifier_shield:StopEffects()
    if self.effect_cast then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
end