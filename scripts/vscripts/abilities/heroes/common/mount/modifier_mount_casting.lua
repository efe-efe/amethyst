modifier_mount_casting = class({})

function modifier_mount_casting:OnCreated()
    if IsServer() then
        self:PlayEffects()
    end
    
end

function modifier_mount_casting:OnDestroy()
    if IsServer() then
        self:StopEffects()

        self:GetCaster():AddNewModifier(
            self:GetCaster(),
            self:GetAbility(),
            "modifier_mount",
            { }
        )
    end
end

function modifier_mount_casting:PlayEffects()
    local particle_cast = "particles/econ/items/silencer/silencer_ti6/silencer_last_word_status_ti6_ring_ember.vpcf"
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )

    --ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() ) 
end

function modifier_mount_casting:StopEffects()
    ParticleManager:DestroyParticle( self.effect_cast, false )
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_mount_casting:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_mount_casting:OnTakeDamage( params )
	if IsServer() then
        if params.unit~=self:GetCaster() then return end
        --Quits the animation
        local order = 
        {
            OrderType = DOTA_UNIT_ORDER_STOP,
            UnitIndex = self:GetParent():entindex()
        }
        ExecuteOrderFromTable(order)
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_mount_casting:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end