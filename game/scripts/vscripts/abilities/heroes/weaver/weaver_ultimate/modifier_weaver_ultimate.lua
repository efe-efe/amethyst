modifier_weaver_ultimate = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_weaver_ultimate:IsHidden()
	return false
end

function modifier_weaver_ultimate:IsDebuff()
	return false
end

function modifier_weaver_ultimate:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_weaver_ultimate:OnCreated( kv )
	if IsServer() then
		self.counter = 0
		self.origins = {}
		self.initialized = false

		self:StartIntervalThink(0.1)
	end
end

function modifier_weaver_ultimate:OnDestroy( kv )
end

function modifier_weaver_ultimate:OnIntervalThink()
	if self.counter > 40 then
		self.counter = 0
		self.initialized = true
	end

	if self.initialized then
		self:PlayEffects(self.origins[self.counter])
	end

	self.origins[self.counter] = self:GetParent():GetOrigin()
	self.counter = self.counter + 1
end

function modifier_weaver_ultimate:PlayEffects( pos )
	local particle_cast = "particles/econ/items/puck/puck_alliance_set/puck_phase_shift_c_aproset.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_weaver_ultimate:DeclareFunctions()
	local funcs = {
	}

	return funcs
end
