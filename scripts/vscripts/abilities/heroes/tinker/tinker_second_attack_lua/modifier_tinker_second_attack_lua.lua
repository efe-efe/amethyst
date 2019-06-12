modifier_tinker_second_attack_lua = class({})

-------------------------------------------------------------------------------
-- Initializations
function modifier_tinker_second_attack_lua:OnCreated( kv )
	-- references
	if IsServer() then
		self:SetStackCount( 1 )	
	end
end

function modifier_tinker_second_attack_lua:OnRefresh( kv )
    local max_stacks = self:GetAbility():GetSpecialValueFor( "max_stacks" )
    
	if IsServer() then
        -- increase stack
        if self:GetStackCount() == max_stacks then
            return
        end
		self:IncrementStackCount()
	end		
end

function modifier_tinker_second_attack_lua:OnStackCountChanged( old )
	if IsServer() then
		if self:GetStackCount()<1 then
			self:Destroy()
		end
	end
end