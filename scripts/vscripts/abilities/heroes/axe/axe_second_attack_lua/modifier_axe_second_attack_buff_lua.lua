modifier_axe_second_attack_buff_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_second_attack_buff_lua:IsHidden()
	return false
end

function modifier_axe_second_attack_buff_lua:IsDebuff()
	return false
end

function modifier_axe_second_attack_buff_lua:IsPurgable()
	return false
end

-------------------------------------------------------------------------------
-- Initializations
function modifier_axe_second_attack_buff_lua:OnCreated( kv )
	-- references
	self.bonus = self:GetAbility():GetSpecialValueFor( "speed_bonus" )

	if IsServer() then
		self:SetStackCount( 1 )	
	end
end

function modifier_axe_second_attack_buff_lua:OnRefresh( kv )
	-- references
	self.bonus = self:GetAbility():GetSpecialValueFor( "speed_bonus" )

	if IsServer() then
		-- increase stack
		self:IncrementStackCount()
	end		
end

function modifier_axe_second_attack_buff_lua:OnDestroy( kv )

end

function modifier_axe_second_attack_buff_lua:OnStackCountChanged( old )
	if IsServer() then
		if self:GetStackCount()<1 then
			self:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_axe_second_attack_buff_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_axe_second_attack_buff_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus * self:GetStackCount()
end

--Graphics & Animations
function modifier_axe_second_attack_buff_lua:GetEffectName()
	return "particles/econ/items/axe/ti9_jungle_axe/ti9_jungle_axe_culling_blade_sprint_creep.vpcf"
end

function modifier_axe_second_attack_buff_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end