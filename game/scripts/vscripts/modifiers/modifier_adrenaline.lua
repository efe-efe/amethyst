modifier_adrenaline = class({})

function modifier_adrenaline:IsHidden() return false end
function modifier_adrenaline:IsDebuff() return false end
function modifier_adrenaline:IsPurgable() return true end

function modifier_adrenaline:OnCreated(params)
	self.speed_buff_pct = 20
	self.slow_duration = 2.0
end

function modifier_adrenaline:OnDestroy()
	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_adrenaline:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	}
end

function modifier_adrenaline:OnTakeDamage(params)
	if IsServer() then
        if params.unit ~= self:GetCaster() then return end

		params.unit:AddNewModifier(params.unit, nil, "modifier_generic_fading_slow", { duration = self.slow_duration, max_slow_pct = 100 })
		self:Destroy()
	end
end

function modifier_adrenaline:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff_pct
end

function modifier_adrenaline:OnAbilityExecuted(params)
	if IsServer() then
		if params.unit ~= self:GetParent() then return end
		if 	params.ability:GetName() == "item_death_orb" or
			params.ability:GetName() == "item_mana_orb" or
			params.ability:GetName() == "item_health_orb" or
			params.ability:GetName() == "item_shield_orb"
		then
			return
		end
		self:Destroy()
	end
end

function modifier_adrenaline:GetEffectName()
	return "particles/adrenaline/adrenaline_owner.vpcf"
end

function modifier_adrenaline:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_adrenaline:GetTexture()
	return "modifier_adrenaline"
end

function modifier_adrenaline:PlayEffects()
    EmitSoundOn("DOTA_Item.Sheepstick.Activate", self:GetParent())
	local particle_cast = "particles/units/heroes/hero_lion/lion_spell_voodoo.vpcf"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self:GetParent())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_adrenaline:GetStatusEffectName()
	return "particles/status_fx/status_effect_void_spirit_aether_remnant.vpcf"
end

function modifier_adrenaline:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

function modifier_adrenaline:GetStatusLabel() return "Adrenaline" end
function modifier_adrenaline:GetStatusPriority() return 3 end
function modifier_adrenaline:GetStatusStyle() return "Adrenaline" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_adrenaline)