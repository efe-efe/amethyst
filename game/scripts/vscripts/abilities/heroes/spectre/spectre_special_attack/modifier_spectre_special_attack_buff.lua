modifier_spectre_special_attack_buff = class({})

function modifier_spectre_special_attack_buff:IsDebuff() return false end
function modifier_spectre_special_attack_buff:IsHidden() return false end
function modifier_spectre_special_attack_buff:IsPurgable() return false end

function modifier_spectre_special_attack_buff:OnCreated(kv)
	self.speed_buff_pct = self:GetAbility():GetSpecialValueFor("speed_buff_pct")

	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_spectre_special_attack_buff:OnDestroy()
	if IsServer() then
		EFX('particles/units/heroes/hero_spectre/spectre_death.vpcf', PATTACH_WORLDORIGIN, self:GetParent(), {
			cp0 = self:GetParent():GetAbsOrigin(),
			cp3 = self:GetParent():GetAbsOrigin(),
			release = true,
		})
		self:StopEffects()
	end
end

function modifier_spectre_special_attack_buff:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = self:GetAbility():GetLevel() >=2 and not self:GetParent():FindModifierByName('modifier_casting'),
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true
	}

	return state
end

function modifier_spectre_special_attack_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end


function modifier_spectre_special_attack_buff:GetModifierInvisibilityLevel()
	if IsServer() then
		if self:GetAbility():GetLevel() >=2 and not self:GetParent():FindModifierByName('modifier_casting') then
			return 2
		end

		return 0
	end
end


function modifier_spectre_special_attack_buff:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff_pct
end

function modifier_spectre_special_attack_buff:PlayEffects()
	local particle_cast = "particles/econ/items/lifestealer/lifestealer_immortal_backbone/lifestealer_immortal_backbone_rage_swirl.vpcf"
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_CUSTOMORIGIN, self:GetParent())
    ParticleManager:SetParticleControlEnt(
        self.effect_cast, 
        2, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        self:GetParent():GetOrigin(), 
        true 
   )
end

function modifier_spectre_special_attack_buff:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
end
