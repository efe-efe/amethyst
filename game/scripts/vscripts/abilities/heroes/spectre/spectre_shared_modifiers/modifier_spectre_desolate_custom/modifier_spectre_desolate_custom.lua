modifier_spectre_desolate_custom = class({})

function modifier_spectre_desolate_custom:IsDebuff() return true end
function modifier_spectre_desolate_custom:IsHidden() return false end
function modifier_spectre_desolate_custom:IsPurgable() return true end

function modifier_spectre_desolate_custom:GetEffectName()
	return "particles/units/heroes/hero_spectre/spectre_desolate_debuff.vpcf"
end

function modifier_spectre_desolate_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_spectre_desolate_custom:GetTexture()
	return "spectre_desolate_modifier"
end

function modifier_spectre_desolate_custom:GetStatusLabel() return "Desolate" end
function modifier_spectre_desolate_custom:GetStatusPriority() return 6 end
function modifier_spectre_desolate_custom:GetStatusStyle() return "Desolate" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_spectre_desolate_custom)