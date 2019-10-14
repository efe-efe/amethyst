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
        parent:SetOrigin(Vector(origin.x, origin.y, origin.z + 128))
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
