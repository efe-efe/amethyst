modifier_item_diffusal_custom= class({})

function modifier_item_diffusal_custom:OnCreated()
	self.mana_per_tick = self:GetAbility():GetSpecialValueFor("mana_per_tick")
	EmitSoundOn("DOTA_Item.DiffusalBlade.Target", self:GetCaster())
end

function modifier_item_diffusal_custom:OnDestroy()
	StopSoundOn("DOTA_Item.DiffusalBlade.Target", self:GetCaster())
end

function modifier_item_diffusal_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_item_diffusal_custom:GetModifierIncomingDamage_Percentage(params)
	if IsServer() then
		self:GetParent():ReduceMana(self.mana_per_tick)
		self:PlayEffectsOnImpact(self:GetParent())	
        return 0
	end
end

function modifier_item_diffusal_custom:GetModifierMoveSpeedBonus_Percentage()
    return -self:GetAbility():GetSpecialValueFor("ms_pct")
end

function modifier_item_diffusal_custom:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_item_diffusal_custom:PlayEffectsOnImpact(hTarget)
	EmitSoundOn("DOTA_Item.DiffusalBlade.Target", hTarget)

	local particle_cast = "particles/generic_gameplay/generic_manaburn.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_item_diffusal_custom:GetEffectName()
	return "particles/items_fx/diffusal_slow.vpcf"
end

function modifier_item_diffusal_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_diffusal_custom:GetStatusLabel() return "Inhibit" end
function modifier_item_diffusal_custom:GetStatusPriority() return 4 end
function modifier_item_diffusal_custom:GetStatusStyle() return "Inhibit" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_item_diffusal_custom)