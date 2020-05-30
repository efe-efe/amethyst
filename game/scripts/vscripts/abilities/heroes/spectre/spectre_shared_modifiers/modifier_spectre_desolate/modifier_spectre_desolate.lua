modifier_spectre_desolate = class({})

function modifier_spectre_desolate:IsDebuff() return true end
function modifier_spectre_desolate:IsHidden() return false end
function modifier_spectre_desolate:IsPurgable() return true end

function modifier_spectre_desolate:GetEffectName()
	return "particles/units/heroes/hero_spectre/spectre_desolate_debuff.vpcf"
end

function modifier_spectre_desolate:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_spectre_desolate:GetTexture()
	return "spectre_desolate_modifier"
end

function modifier_spectre_desolate:GetStatusLabel() return "Desolate" end
function modifier_spectre_desolate:GetStatusPriority() return 2 end
function modifier_spectre_desolate:GetStatusStyle() return "Desolate" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_spectre_desolate)