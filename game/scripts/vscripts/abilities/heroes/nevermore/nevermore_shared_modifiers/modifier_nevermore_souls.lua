modifier_nevermore_souls = class({})

function modifier_nevermore_souls:IsHidden() return false end
function modifier_nevermore_souls:IsDebuff() return false end
function modifier_nevermore_souls:IsPurgable() return true end
function modifier_nevermore_souls:RemoveOnDeath() return false end

function modifier_nevermore_souls:OnCreated()
    self.damage_per_stack = self:GetAbility():GetSpecialValueFor("damage_per_stack")
	self.max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks")
	self.effects_cast_weapon = {}

	if IsServer() then
	    self:SetStackCount(0)
    end
end

function modifier_nevermore_souls:OnStackCountChanged(iStackCount)
	if IsServer() then
		if self:GetStackCount() > self.max_stacks then
			self:SetStackCount(self.max_stacks)
			return
		end

		if self:GetStackCount() <= 0 then
			self:StopEffects()
			return
		end

		if self:GetStackCount() == self.max_stacks then
			self:StopEffects()
			self:PlayEffectsCharged()
		end
	end
end

function modifier_nevermore_souls:PlayEffectsCharged()
	self:CreateGlow(0)
	self:CreateGlow(1)
	self:CreateGlow(2)
end

function modifier_nevermore_souls:CreateGlow(index)
	local particle_cast = "particles/nevermore/nevermore_basic_attack_aura.vpcf"
	self.effects_cast_weapon[index] = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())

	if index == 0 then
		particle_cast = "particles/econ/items/lycan/ti9_immortal/lycan_ti9_immortal_howl_buff.vpcf"
		self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	end
end

function modifier_nevermore_souls:StopEffects()
	for _,efx in pairs(self.effects_cast_weapon) do
		if efx ~= nil then
			ParticleManager:DestroyParticle(efx, false)
			ParticleManager:ReleaseParticleIndex(efx)
		end
	end

	if self.effect_cast then
		ParticleManager:DestroyParticle(self.effect_cast, false)
		ParticleManager:ReleaseParticleIndex(self.effect_cast)
	end

	self.effects_cast_weapon = {}
end

function modifier_nevermore_souls:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
end

function modifier_nevermore_souls:GetModifierPreAttack_BonusDamage()
    return self.damage_per_stack * self:GetStackCount()
end
