modifier_generic_fear = class({})

function modifier_generic_fear:OnCreated(params)
    if IsServer() then
        local direction = Vector(
            params.x,
            params.y,
            self:GetParent():GetForwardVector().z
       )

        self:GetParent():ForceDirection(direction)
        self:GetParent():InterruptCastPoint()
        self:GetParent():AddNewModifier(self:GetCaster(), nil, "modifier_generic_silence", { duration = self:GetDuration() })
        self:GetParent():AddStatusBar({ label = "Fear", modifier = self, priority = 5, stylename="Fear" }) 
    end
end

function modifier_generic_fear:OnDestroy()
    if IsServer() then
        self:GetParent():UnforceDirection()
        self:GetParent():RemoveModifierByName("modifier_generic_silence")
    end
end


--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_fear:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_generic_fear:GetModifierMoveSpeedBonus_Percentage()
    return 30
end
