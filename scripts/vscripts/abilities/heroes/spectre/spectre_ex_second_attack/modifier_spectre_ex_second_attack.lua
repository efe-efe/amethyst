modifier_spectre_ex_second_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_spectre_ex_second_attack:IsHidden()
	return false
end

function modifier_spectre_ex_second_attack:IsDebuff()
	return true
end

function modifier_spectre_ex_second_attack:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_ex_second_attack:OnCreated( kv )
	if IsServer() then
		self.vision_radius = self:GetAbility():GetSpecialValueFor("vision_radius")

		self:StartIntervalThink( 0.1 )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_spectre_ex_second_attack:OnIntervalThink()
	AddFOWViewer(
		self:GetParent():GetTeamNumber(), 
		self:GetParent():GetOrigin(),
		self.vision_radius, 
		0.1,
		false)
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_spectre_ex_second_attack:CheckState()
	local state = {
		[MODIFIER_STATE_BLIND] = true,
	}

	return state
end


--------------------------------------------------------------------------------
-- Graphics and animations
function modifier_spectre_ex_second_attack:GetEffectName()
	return "particles/econ/items/bloodseeker/bloodseeker_ti7/bloodseeker_ti7_overhead_vision_model.vpcf"
end

function modifier_spectre_ex_second_attack:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
