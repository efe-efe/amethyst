healthBufferModifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function healthBufferModifier:IsHidden()
	return false
end

function healthBufferModifier:IsDebuff()
	return false
end

function healthBufferModifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Modifier Effects
function healthBufferModifier:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_EVENT_ON_HEAL_RECEIVED,
		-- MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function healthBufferModifier:OnCreated( kv )
	-- references
	self.maxHealthBuffer = 40
	self.minHealthBuffer = 0
    self.healthBuffer = 40
end

--------------------------------------------------------------------------------3

function healthBufferModifier:GetModifierIncomingDamage_Percentage( params )
    if IsServer() then
        DebugPrint("-----------------------Damage received")
        local damage = params.damage
		local parent = self:GetParent()
        local newHealthBuffer = self.healthBuffer - damage

        DebugPrint("attacker " .. params.attacker:GetUnitName())
        DebugPrint("parent " .. parent:GetUnitName())
        DebugPrint("damage " .. damage)
        DebugPrint("healthBuffer " .. self.healthBuffer)
        DebugPrint("newHealthBuffer " .. newHealthBuffer)

        if newHealthBuffer < self.minHealthBuffer then
            local maxHealth = parent:GetMaxHealth()
            local newMaxHealth = maxHealth + newHealthBuffer

            DebugPrint("maxHealth " .. maxHealth)
            DebugPrint("newMaxHealth " .. newMaxHealth)

            parent:SetMaxHealth(newMaxHealth)
            newHealthBuffer = 0
        end
        self.healthBuffer = newHealthBuffer
    end
end

function healthBufferModifier:OnHealReceived( params )
    if IsServer() then
        DebugPrint("-----------------------Heal received")
        local heal = params.gain
		local parent = self:GetParent()
        local newHealthBuffer = self.healthBuffer + heal

        DebugPrint("parent " .. parent:GetUnitName())
        DebugPrint("heal " .. heal)
        DebugPrint("healthBuffer " .. self.healthBuffer)
        DebugPrint("newHealthBuffer " .. newHealthBuffer)

        if newHealthBuffer > self.maxHealthBuffer then
            newHealthBuffer = self.maxHealthBuffer
        end
        self.healthBuffer = newHealthBuffer
    end
end