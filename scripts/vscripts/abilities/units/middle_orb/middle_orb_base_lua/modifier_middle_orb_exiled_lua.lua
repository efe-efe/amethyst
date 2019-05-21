modifier_middle_orb_exiled_lua = class ({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_middle_orb_exiled_lua:IsHidden()
	return false
end

function modifier_middle_orb_exiled_lua:IsDebuff()
	return false
end

function modifier_middle_orb_exiled_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_middle_orb_exiled_lua:OnCreated( kv )
    if IsServer() then
        local wait = kv.wait
        self:GetParent():AddNoDraw()
        self:StartIntervalThink( wait )
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_middle_orb_exiled_lua:OnDestroy( kv )
	if IsServer() then
        local parent = self:GetParent()
        local origin = parent:GetOrigin()

        parent:RemoveNoDraw()
        parent:SetOrigin(Vector(origin.x, origin.y, 256))

	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_middle_orb_exiled_lua:CheckState()
	local state = {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
    }
	return state
end


--------------------------------------------------------------------------------
-- Interval Effects
function modifier_middle_orb_exiled_lua:OnIntervalThink()
    self:Destroy()
end