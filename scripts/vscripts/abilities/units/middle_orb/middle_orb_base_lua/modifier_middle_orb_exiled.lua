modifier_middle_orb_exiled = class ({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_middle_orb_exiled:IsHidden()
	return false
end

function modifier_middle_orb_exiled:IsDebuff()
	return false
end

function modifier_middle_orb_exiled:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_middle_orb_exiled:OnCreated( kv )
    if IsServer() then
        self:GetParent():AddNoDraw()
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_middle_orb_exiled:OnDestroy( kv )
	if IsServer() then
        local parent = self:GetParent()
        local origin = parent:GetOrigin()

        --self:StopEffects()
        parent:SetOrigin(Vector(origin.x, origin.y, 256))
        parent:RemoveNoDraw()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_middle_orb_exiled:CheckState()
	local state = {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
    }
	return state
end

function modifier_middle_orb_exiled:PlayEffects()
    -- Create particles
    
    local position = self:GetParent():GetOrigin()
    local new_position = Vector(position.x, position.y, position.z + 128)

    local particle_cast = "particles/neutral_fx/roshan_death_timer_arc.vpcf"
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )

    ParticleManager:SetParticleControl( self.effect_cast, 0, new_position )
    ParticleManager:SetParticleControl( self.effect_cast, 3, new_position )
end

function modifier_middle_orb_exiled:StopEffects()
    ParticleManager:DestroyParticle( self.effect_cast, false )
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
end