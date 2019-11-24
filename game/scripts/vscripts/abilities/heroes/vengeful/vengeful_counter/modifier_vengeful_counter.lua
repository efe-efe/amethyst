modifier_vengeful_counter = class({})

--- Misc 
function modifier_vengeful_counter:IsHidden()
    return false
end

function modifier_vengeful_counter:IsDebuff()
	return false
end

function modifier_vengeful_counter:IsPurgable()
    return false
end


--------------------------------------------------------------------------------
-- Initializations
function modifier_vengeful_counter:OnCreated( params )
    if IsServer() then
        local stacks = params.stacks
        self:SetStackCount(stacks)
        self:GetParent():AddStatusBar({
            label = "Haste", modifier = self, priority = 1, 
        }) 
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_vengeful_counter:OnDestroy( kv )
    if IsServer() then
    end
end

function modifier_vengeful_counter:OnRefresh( params )
    if IsServer() then
        local stacks = params.stacks
        self:SetStackCount( self:GetStackCount() + stacks )
    end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_vengeful_counter:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_vengeful_counter:GetModifierMoveSpeedBonus_Percentage()
    return self:GetStackCount()
end
