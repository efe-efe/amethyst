modifier_generic_confuse = class({})

function modifier_generic_confuse:OnCreated(params)
    if IsServer() then
        self:GetParent():AddStatusBar({ label = "Confused", modifier = self, priority = 1, stylename="Confused" }) 
    end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_generic_confuse:GetStatusEffectName()
	return "particles/status_fx/status_effect_terrorblade_reflection.vpcf"
end


