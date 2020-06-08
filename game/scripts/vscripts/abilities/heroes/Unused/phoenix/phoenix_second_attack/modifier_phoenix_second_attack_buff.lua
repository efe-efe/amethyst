modifier_phoenix_second_attack_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phoenix_second_attack_buff:IsHidden() return false
end

function modifier_phoenix_second_attack_buff:IsDebuff() return false
end

function modifier_phoenix_second_attack_buff:IsStunDebuff()
	return false
end

function modifier_phoenix_second_attack_buff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initialization
function modifier_phoenix_second_attack_buff:OnCreated()
    self.hp_per_second = self:GetAbility():GetSpecialValueFor("hp_per_second")
    self.stack_bonus = self:GetAbility():GetSpecialValueFor("stack_bonus")

	if IsServer() then
		self:SetStackCount(1)
		self:StartIntervalThink(1.0)
		self:OnIntervalThink()
		self:PlayEffects(self:GetParent())
	end
end

--------------------------------------------------------------------------------
-- Initialization
function modifier_phoenix_second_attack_buff:OnRefresh()

    self.hp_per_second = self:GetAbility():GetSpecialValueFor("hp_per_second")
    self.stack_bonus = self:GetAbility():GetSpecialValueFor("stack_bonus")
	
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink(1.0)
		self:OnIntervalThink()
	end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_phoenix_second_attack_buff:OnDestroy()
	if IsServer() then
		self:StopEffects()
	end
end


-- On Think
--------------------------------------------------------------------------------
function modifier_phoenix_second_attack_buff:OnIntervalThink()
	if IsServer() then
		self:GetParent():Heal(self.hp_per_second + self.stack_bonus * self:GetStackCount() - 1, self:GetCaster())
	end
end

function modifier_phoenix_second_attack_buff:PlayEffects(hTarget)
	-- get resources
	local particle_cast = "particles/units/heroes/hero_warlock/warlock_shadow_word_buff.vpcf"

	-- create particle
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)
	ParticleManager:SetParticleControl(self.effect_cast, 0, hTarget:GetOrigin())
end


function modifier_phoenix_second_attack_buff:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
end

--------------------------------------------------------------------------------
--Graphics
function modifier_phoenix_second_attack_buff:GetTexture()
	return "modifier_phoenix_second_attack"
end
