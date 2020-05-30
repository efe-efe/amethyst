modifier_puck_ultimate_debuff = class({})

function modifier_puck_ultimate_debuff:OnCreated(params)
    if IsServer() then
        self.origin = Vector(params.x, params.y, params.z)
        self:PlayEffects()
    end
end

function modifier_puck_ultimate_debuff:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_puck/puck_dreamcoil_tether.vpcf", PATTACH_ABSORIGIN, self:GetParent())
	ParticleManager:SetParticleControl(effect_cast, 0, self.origin)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)

    self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		false
	)
end