modifier_lich_judgement = class({})

--------------------------------------------------------------------------------
-- Initializer
function modifier_lich_judgement:OnCreated()
	self.judgement_damage_pct = self:GetAbility():GetSpecialValueFor("judgement_damage_pct")
	self.radius = 100

	if IsServer() then
		self:PlayEffectsTimer()
		self:StartIntervalThink(0.01)
	end
end

function modifier_lich_judgement:OnRefresh()
	self.radius = 100
end

function modifier_lich_judgement:OnDestroy()
	if IsServer() then
		self:StopEffectsTimer()
	end
end

function modifier_lich_judgement:OnIntervalThink()
	self.radius = self.radius - 0.2
	self:StopEffectsTimer()
	self:PlayEffectsTimer()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_lich_judgement:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_lich_judgement:GetModifierIncomingDamage_Percentage( params )
	return self.judgement_damage_pct
end

--------------------------------------------------------------------------------
-- Graphics & animations
function modifier_lich_judgement:PlayEffectsTimer()
    local particle_cast = "particles/dev/new_heroes/new_hero_aoe_ring_rope.vpcf"

	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(self.radius, 1,1))
	ParticleManager:SetParticleControl( self.effect_cast, 15, Vector(175, 75, 175) )
end

function modifier_lich_judgement:StopEffectsTimer()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
end