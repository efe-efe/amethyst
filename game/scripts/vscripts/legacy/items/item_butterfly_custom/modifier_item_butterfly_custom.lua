modifier_item_butterfly_custom = class({})

function modifier_item_butterfly_custom:OnCreated()
	self.ms_pct = self:GetAbility():GetSpecialValueFor("ms_pct")
	self.aspd = self:GetAbility():GetSpecialValueFor("aspd")
	self.banish_duration = self:GetAbility():GetSpecialValueFor("banish_duration")
	local think_duration = self:GetAbility():GetSpecialValueFor("think_duration")
	
	if IsServer() then
		self:OnIntervalThink()
		self:StartIntervalThink(think_duration)
	end
end

function modifier_item_butterfly_custom:OnIntervalThink()
	local caster = self:GetCaster()

	caster:AddNewModifier(caster, self:GetAbility(), "modifier_item_butterfly_custom_banish", { duration = self.banish_duration })
	caster:AddNewModifier(caster, self:GetAbility(), "modifier_hide_bar", { duration = self.banish_duration })
	self:PlayEffectsOnBanish()
end

function modifier_item_butterfly_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}

	return funcs
end

function modifier_item_butterfly_custom:GetModifierAttackSpeedBonus_Constant()
	return self.aspd
end

function modifier_item_butterfly_custom:GetModifierMoveSpeedBonus_Percentage()
    return self.ms_pct
end

function modifier_item_butterfly_custom:GetEffectName()
	return "particles/items2_fx/butterfly_buff.vpcf"
end

function modifier_item_butterfly_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_butterfly_custom:PlayEffectsOnBanish()
    EmitSoundOn("DOTA_Item.Butterfly", self:GetCaster() )

	local particle_cast = "particles/butterfly_effect/pa_arcana_event_glitch.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_item_butterfly_custom:GetStatusLabel() return "Flutter" end
function modifier_item_butterfly_custom:GetStatusPriority() return 4 end
function modifier_item_butterfly_custom:GetStatusStyle() return "Flutter" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_item_butterfly_custom)