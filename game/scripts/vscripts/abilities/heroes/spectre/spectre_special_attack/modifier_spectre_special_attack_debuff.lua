modifier_spectre_special_attack_debuff = class({})
LinkLuaModifier( "modifier_spectre_special_attack_thinker", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_special_attack_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_special_attack_debuff:OnCreated( kv )
	if IsServer() then
		self:StartIntervalThink(0.2)
	end
end

function modifier_spectre_special_attack_debuff:OnIntervalThink()
	local origin = self:GetParent():GetOrigin()

	CreateModifierThinker(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_spectre_special_attack_thinker", -- modifier name
		{ 
			duration = self:GetRemainingTime(),
			x = origin.x,
			y = origin.y,
			z = origin.z,
			draw = 1,
			spiral = 1,

		 }, -- kv
		origin,
		self:GetCaster():GetTeamNumber(),
		false --bPhantomBlocker
	)
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_spectre_special_attack_debuff:GetEffectName()
	return "particles/econ/items/spectre/spectre_transversant_soul/spectre_transversant_spectral_dagger_path_owner.vpcf"
end

function modifier_spectre_special_attack_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
