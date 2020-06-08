modifier_lich_decay = class({})

--------------------------------------------------------------------------------
-- Initializer
function modifier_lich_decay:OnCreated()
	self.decay_damage_pct = self:GetAbility():GetSpecialValueFor("decay_damage_pct")
	self.radius = 100

	if IsServer() then
		self:PlayEffectsTimer()
		self:StartIntervalThink(0.01)
	end
end

function modifier_lich_decay:OnRefresh()
	self.radius = 100
end

function modifier_lich_decay:OnDestroy()
	if IsServer() then
		self:StopEffectsTimer()
	end
end

function modifier_lich_decay:OnIntervalThink()
	self.radius = self.radius - 0.2
	self:StopEffectsTimer()
	self:PlayEffectsTimer()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_lich_decay:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_lich_decay:GetModifierIncomingDamage_Percentage(params)
	return self.decay_damage_pct
end

--------------------------------------------------------------------------------
-- Graphics & animations
function modifier_lich_decay:PlayEffectsTimer()
    local particle_cast = "particles/dev/new_heroes/new_hero_aoe_ring_rope.vpcf"

	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius, 1,1))
	ParticleManager:SetParticleControl(self.effect_cast, 15, Vector(175, 75, 175))
end

function modifier_lich_decay:StopEffectsTimer()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
end


function modifier_lich_decay:GetTexture()
	return "lich_second_attack"
end