modifier_wisp_debuff_lua = class({})

--------------------------------------------------------------------------------

function modifier_wisp_debuff_lua:IsDebuff()
	return true
end

function modifier_wisp_debuff_lua:IsHidden()
	return false
end

function modifier_wisp_debuff_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_debuff_lua:OnCreated( kv )
	if IsServer() then
		self:SetDuration( 2.0, true )
	end
end

--------------------------------------------------------------------------------

function modifier_wisp_debuff_lua:GetEffectName()
	return "particles/econ/items/antimage/antimage_weapon_tustakuri/antimage_blade_tustakuri_generic_a.vpcf"
end

function modifier_wisp_debuff_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

--------------------------------------------------------------------------------
