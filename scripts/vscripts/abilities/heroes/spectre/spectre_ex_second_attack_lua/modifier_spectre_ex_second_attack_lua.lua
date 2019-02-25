modifier_spectre_ex_second_attack_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_spectre_ex_second_attack_lua:IsHidden()
	return false
end

function modifier_spectre_ex_second_attack_lua:IsDebuff()
	return true
end

function modifier_spectre_ex_second_attack_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_ex_second_attack_lua:OnCreated( kv )
	if IsServer() then
		self.vision_radius = self:GetAbility():GetSpecialValueFor("vision_radius")

		self:StartIntervalThink( 0.1 )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_spectre_ex_second_attack_lua:OnIntervalThink()
	AddFOWViewer(
		self:GetParent():GetTeamNumber(), 
		self:GetParent():GetOrigin(),
		self.vision_radius, 
		0.1,
		false)
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_spectre_ex_second_attack_lua:CheckState()
	local state = {
		[MODIFIER_STATE_BLIND] = true,
	}

	return state
end


--------------------------------------------------------------------------------
-- Graphics and animations
function modifier_spectre_ex_second_attack_lua:GetEffectName()
	return "particles/econ/items/bloodseeker/bloodseeker_ti7/bloodseeker_ti7_overhead_vision_model.vpcf"
end

function modifier_spectre_ex_second_attack_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
