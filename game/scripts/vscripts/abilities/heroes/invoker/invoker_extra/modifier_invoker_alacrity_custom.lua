modifier_invoker_alacrity_custom = class({})

function modifier_invoker_alacrity_custom:OnCreated(params)
	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_invoker_alacrity_custom:PlayEffects()
	local efx = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_alacrity.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	self:AddParticle(
		efx,
		false,
		false,
		-1,
		false,
		false
	)

	EmitSoundOn("Hero_Invoker.Alacrity", self:GetParent())
end

function modifier_invoker_alacrity_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_invoker_alacrity_custom:GetModifierAttackSpeedBonus_Constant()
	return 50
end

function modifier_invoker_alacrity_custom:GetModifierPreAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("extra_damage")
end

function modifier_invoker_alacrity_custom:GetEffectName()
	return "particles/units/heroes/hero_invoker/invoker_alacrity_buff.vpcf"
end

function modifier_invoker_alacrity_custom:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_invoker_alacrity_custom:GetStatusLabel() return "Alacrity" end
function modifier_invoker_alacrity_custom:GetStatusPriority() return 1 end
function modifier_invoker_alacrity_custom:GetStatusStyle() return "Alacrity" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_invoker_alacrity_custom)