modifier_phantom_counter = class({})


--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_counter:OnCreated( kv )
	if IsServer() then
		ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
			style = "Generic",
			text = "lifesteal",
			progressBarType = "duration",
			priority = 1,
		})
	end
end

function modifier_phantom_counter:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_phantom_counter:GetStatusEffectName()
	return "particles/mod_units/heroes/hero_phantom_assassin/phantom_assassin_active_blur.vpcf"
end
