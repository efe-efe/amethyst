modifier_nevermore_second_attack_cooldown = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_nevermore_second_attack_cooldown:IsHidden()
	return false--CAMBIAR
end

function modifier_nevermore_second_attack_cooldown:IsDebuff()
	return false
end

function modifier_nevermore_second_attack_cooldown:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_nevermore_second_attack_cooldown:OnCreated()
    if IsServer() then
	    self:SetStackCount(1)
        -- Start Interval
    end
end

--------------------------------------------------------------------------------
-- Refresh
function modifier_nevermore_second_attack_cooldown:OnRefresh()
    if IsServer() then
	    self:IncrementStackCount()
        -- Start Interval
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_nevermore_second_attack_cooldown:OnDestroy()
	if IsServer() then
		local ability = self:GetParent():FindAbilityByName("nevermore_second_attack")
		ability:StartCooldown(ability:GetCooldown(0) + 1.0 * self:GetStackCount())
    end
end



function modifier_nevermore_second_attack_cooldown:OnStackCountChanged( old )
	if IsServer() then
		if self:GetStackCount() < 1 then
			self:Destroy()
		end
	end
end