modifier_lich_corruption = class({})

--------------------------------------------------------------------------------
-- Initializer
function modifier_lich_corruption:OnCreated()
	self.corruption_heal_pct = self:GetAbility():GetSpecialValueFor("corruption_heal_pct")
	self.radius = 100

	if IsServer() then
		self:PlayEffectsTimer()
		self:StartIntervalThink(0.01)
	end
end

function modifier_lich_corruption:OnRefresh()
	self.radius = 100
end

function modifier_lich_corruption:OnDestroy()
	if IsServer() then
		self:StopEffectsTimer()
	end
end

function modifier_lich_corruption:OnIntervalThink()
	self.radius = self.radius - 0.2
	self:StopEffectsTimer()
	self:PlayEffectsTimer()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_lich_corruption:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}

	return funcs
end

function modifier_lich_corruption:GetModifierHPRegenAmplify_Percentage( params )
	return -self.corruption_heal_pct
end

--------------------------------------------------------------------------------
-- Graphics & animations
function modifier_lich_corruption:PlayEffectsTimer()
    local particle_cast = "particles/dev/new_heroes/new_hero_aoe_ring_rope.vpcf"

	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(self.radius, 1,1))
	ParticleManager:SetParticleControl( self.effect_cast, 15, Vector(20, 75, 215))
end

function modifier_lich_corruption:StopEffectsTimer()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
end