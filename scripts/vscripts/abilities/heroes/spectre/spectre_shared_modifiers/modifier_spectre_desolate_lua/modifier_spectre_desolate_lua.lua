modifier_spectre_desolate_lua = class({})

--------------------------------------------------------------------------------
function modifier_spectre_desolate_lua:IsDebuff()
	return true
end

function modifier_spectre_desolate_lua:IsHidden()
	return false
end

function modifier_spectre_desolate_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_desolate_lua:OnCreated( kv )
	if IsServer() then
		self:SetDuration( 2.0, true )
	end
end

-- Graphics & Animations
function modifier_spectre_desolate_lua:GetEffectName()
	return "particles/units/heroes/hero_spectre/spectre_desolate_debuff.vpcf"
end

function modifier_spectre_desolate_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end