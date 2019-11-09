modifier_disable_right_click = class ({})

--- Misc 
function modifier_disable_right_click:IsHidden()
    return true
end

function modifier_disable_right_click:DestroyOnExpire()
    return false
end

function modifier_disable_right_click:IsPurgable()
    return false
end

function modifier_disable_right_click:RemoveOnDeath()
    return false
end


function modifier_disable_right_click:OnCreated( kv )
end
--------------------------------------------------------------------------------
-- Modifier Effects
-- Status Effects
function modifier_disable_right_click:CheckState()
	local state = {
		[MODIFIER_STATE_DISARMED] = true,
	}

	return state
end

function modifier_disable_right_click:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
    }
    return funcs
end


function modifier_disable_right_click:GetDisableAutoAttack()
    return true
end
