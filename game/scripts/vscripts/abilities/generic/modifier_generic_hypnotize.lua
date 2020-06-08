modifier_generic_hypnotize = class({})

function modifier_generic_hypnotize:OnCreated(params)
    if IsServer() then
        self.caster = self:GetCaster()
        self.parent = self:GetParent()

        self:StartIntervalThink(0.1)

        self.parent:AddNewModifier(self:GetCaster(), nil, "modifier_generic_silence", { duration = self:GetDuration() })
        self:GetParent():AddStatusBar({ label = "Hypnotize", modifier = self, priority = 5, stylename="Fear" }) 
    end
end

function modifier_generic_hypnotize:OnDestroy()
    if IsServer() then
        self:GetParent():UnforceDirection()
        self.parent:RemoveModifierByName("modifier_generic_silence")
    end
end

function modifier_generic_hypnotize:OnIntervalThink()
    local x =  (self.caster:GetOrigin() - self.parent:GetOrigin()):Normalized().x
    local y =  (self.caster:GetOrigin() - self.parent:GetOrigin()):Normalized().y
    
    local direction = Vector(
        x,
        y,
        self.parent:GetForwardVector().z
   )

    self.parent:ForceDirection(direction)
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_hypnotize:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_generic_hypnotize:GetModifierMoveSpeedBonus_Percentage()
    return 30
end
