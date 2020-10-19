modifier_mars_basic_attack_stacks = class({})

function modifier_mars_basic_attack_stacks:IsHidden() return false end
function modifier_mars_basic_attack_stacks:IsDebuff() return false end
function modifier_mars_basic_attack_stacks:IsStunDebuff() return false end
function modifier_mars_basic_attack_stacks:IsPurgable() return true end

function modifier_mars_basic_attack_stacks:OnCreated(kv)
	if IsServer() then
		self.effects_cast_weapon = {}
		self:SetStackCount(1)
	end
end

function modifier_mars_basic_attack_stacks:OnRefresh(kv)
	local max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks")

	if IsServer() then
		if self:GetStackCount() < max_stacks then
			self.effects_cast_weapon = {}
			self:IncrementStackCount()

			if self:GetStackCount() == max_stacks then
				self:PlayEffectsCharged()
			end
		end
	end
end

function modifier_mars_basic_attack_stacks:OnDestroy(kv)
	if IsServer() then
		self:StopEffects()
	end
end

function modifier_mars_basic_attack_stacks:PlayEffectsCharged()
	local particle_cast = "particles/units/heroes/hero_wisp/wisp_death.vpcf"
	local caster = self:GetParent()
    local origin = caster:GetOrigin()

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControlEnt(
		effect_cast, 
		0, 
		caster, 
		PATTACH_POINT_FOLLOW, 
		"attach_attack1", 
		origin, 
		true 
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	
	self:CreateGlow(0)
	self:CreateGlow(1)
	self:CreateGlow(2)
	self:CreateGlow(3)
	self:CreateGlow(4)
	self:CreateGlow(5)
end

function modifier_mars_basic_attack_stacks:CreateGlow(index)
	local particle_cast = "particles/units/heroes/hero_invoker_kid/invoker_kid_forge_spirit_ambient_fire.vpcf"
	local caster = self:GetParent()
	local origin = caster:GetOrigin()
	self.effects_cast_weapon[index] = ParticleManager:CreateParticle(
		particle_cast, 
		PATTACH_ABSORIGIN_FOLLOW, 
		caster
	)
end

function modifier_mars_basic_attack_stacks:StopEffects()
	for _,efx in pairs(self.effects_cast_weapon) do
		if efx ~= nil then
			ParticleManager:DestroyParticle(efx, false)
			ParticleManager:ReleaseParticleIndex(efx)
		end
	end
end