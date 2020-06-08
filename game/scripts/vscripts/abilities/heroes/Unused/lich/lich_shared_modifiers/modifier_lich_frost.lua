modifier_lich_frost = class({})

--------------------------------------------------------------------------------
-- Initializer
function modifier_lich_frost:OnCreated()
	self.frost_heal_pct = self:GetAbility():GetSpecialValueFor("frost_heal_pct")
	self.radius = 100

	if IsServer() then
		self:PlayEffectsTimer()
		self:StartIntervalThink(0.01)
	end
end

function modifier_lich_frost:OnRefresh()
	self.radius = 100
end

function modifier_lich_frost:OnDestroy()
	if IsServer() then
		self:StopEffectsTimer()
	end
end

function modifier_lich_frost:OnIntervalThink()
	self.radius = self.radius - 0.2
	self:StopEffectsTimer()
	self:PlayEffectsTimer()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_lich_frost:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}

	return funcs
end

function modifier_lich_frost:GetModifierHPRegenAmplify_Percentage(params)
	return -self.frost_heal_pct
end

--------------------------------------------------------------------------------
-- Graphics & animations
function modifier_lich_frost:PlayEffectsTimer()
    local particle_cast = "particles/dev/new_heroes/new_hero_aoe_ring_rope.vpcf"

	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius, 1,1))
	ParticleManager:SetParticleControl(self.effect_cast, 15, Vector(20, 75, 215))
end

function modifier_lich_frost:StopEffectsTimer()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
end

function modifier_lich_frost:GetTexture()
	return "lich_basic_attack"
end

