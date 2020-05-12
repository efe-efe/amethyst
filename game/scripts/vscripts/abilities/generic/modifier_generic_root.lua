modifier_generic_root = class({})

function modifier_generic_root:IsDebuff() return true end
function modifier_generic_root:IsStunDebuff() return true end

function modifier_generic_root:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true,
	}
end

function modifier_generic_root:GetEffectName()
	return "particles/econ/items/oracle/oracle_fortune_ti7/oracle_fortune_ti7_purge_root_pnt.vpcf"
end

function modifier_generic_root:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_generic_root:GetStatusLabel() return "Root" end
function modifier_generic_root:GetStatusPriority() return 4 end
function modifier_generic_root:GetStatusStyle() return "Root" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_generic_root)