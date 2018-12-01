modifier_health_buffer = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_health_buffer:IsHidden()
	return false
end

function modifier_health_buffer:IsDebuff()
	return false
end

function modifier_health_buffer:IsPurgable()
	return false
end

function modifier_health_buffer:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_health_buffer:DeclareFunctions()
	local funcs = {
        -- MODIFIER_EVENT_ON_HEAL_RECEIVED,
        MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_health_buffer:OnCreated( kv )
    if IsServer() then
        -- references
        self.maxHealthBuffer = 40
        self.minHealthBuffer = 0
        self.actualHealthBuffer = 40
    end
end

--------------------------------------------------------------------------------3

function modifier_health_buffer:OnTakeDamage( params )
    if IsServer() then

        local parent = self:GetParent()

        if params.unit == parent then

            local damage = params.damage
            self.actualHealthBuffer = self.actualHealthBuffer - damage

            if self.actualHealthBuffer < self.minHealthBuffer then
                local maxHealth = parent:GetMaxHealth()
                local newMaxHealth = maxHealth + self.actualHealthBuffer
                
                parent:SetMaxHealth(newMaxHealth)
                parent:SetBaseMaxHealth(newMaxHealth)

                self.actualHealthBuffer = 0
            end
        end
    end
end

--[[
function modifier_health_buffer:OnHealReceived( params )
    if IsServer() then
        if params.unit == self:GetParent() then     
            DebugPrint("-----------------------Heal received")
            local heal = params.gain
            local parent = self:GetParent()
            local newHealthBuffer = self.actualHealthBuffer + heal

            DebugPrint("heal " .. heal)
            DebugPrint("healthBuffer " .. self.actualHealthBuffer)
            DebugPrint("newHealthBuffer " .. newHealthBuffer)

            if newHealthBuffer > self.maxHealthBuffer then
                newHealthBuffer = self.maxHealthBuffer
            end
            self.actualHealthBuffer = newHealthBuffer
        end
    end
end
]]--