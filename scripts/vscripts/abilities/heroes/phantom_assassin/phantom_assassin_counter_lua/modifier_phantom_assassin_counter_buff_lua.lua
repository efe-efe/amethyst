modifier_phantom_assassin_counter_buff_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phantom_assassin_counter_buff_lua:IsHidden()
	return false
end

function modifier_phantom_assassin_counter_buff_lua:IsDebuff()
	return false
end

function modifier_phantom_assassin_counter_buff_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_assassin_counter_buff_lua:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_assassin_counter_buff_lua:OnCreated( kv )
    if IsServer() then
		self.movement_speed = self:GetAbility():GetSpecialValueFor( "movement_speed" )
    end
end

function modifier_phantom_assassin_counter_buff_lua:GetModifierMoveSpeed_Absolute()
    return self.movement_speed
end

--Graphics & Animations
function modifier_phantom_assassin_counter_buff_lua:GetEffectName()
	return "particles/items3_fx/silver_edge_slow.vpcf"
end

function modifier_phantom_assassin_counter_buff_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end