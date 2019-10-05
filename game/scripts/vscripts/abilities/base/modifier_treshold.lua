modifier_treshold = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_treshold:IsHidden()
	return false
end

function modifier_treshold:IsDebuff()
	return false
end

function modifier_treshold:IsStunDebuff()
	return false
end

function modifier_treshold:IsPurgable()
	return false
end

function modifier_treshold:RemoveOnDeath()
    return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_treshold:OnCreated( kv )
    self.max_stack = kv.max_treshold

	-- references
	if IsServer() then
        ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
            style = "Treshold",
            progressBarType = "stacks",
            ignorePriority = 1,
            maxStacks = self.max_stack,
            reversedProgress = true,
            persistOnDeath = true,
        })
	end
end

function modifier_treshold:OnStackCountChanged( old )
    if IsServer() then
		if self:GetStackCount() < 0 then
			self:SetStackCount(0)
        end

        if self:GetStackCount() > self.max_stack then
			self:SetStackCount(self.max_stacks)
        end
	end
end