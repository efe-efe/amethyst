modifier_spectre_ultimate_damage = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_spectre_ultimate_damage:IsHidden() return false
end

function modifier_spectre_ultimate_damage:IsDebuff() return false
end

function modifier_spectre_ultimate_damage:IsPurgable()
	return true
end

function modifier_spectre_ultimate_damage:OnCreated( params )
	if IsServer() then
		self.aoe_origin = Vector(params.x, params.y, 0)
		self.radius = params.radius
		self:SetStackCount(0)
		self:StartIntervalThink(0.1)
	end
end

function modifier_spectre_ultimate_damage:OnDestroy()
	if IsServer() then
		self:StopEffects()
	end
end

function modifier_spectre_ultimate_damage:OnIntervalThink()
	if (self.aoe_origin - self:GetParent():GetOrigin()):Length2D() > self.radius then
		self:SetStackCount(0)
		self:StopEffects()
	else
		self:SetStackCount(3)
		self:PlayEffects()
    end
end

function modifier_spectre_ultimate_damage:PlayEffects()
	if self.effects ~= nil then return end

    local particle_cast = "particles/econ/courier/courier_roshan_darkmoon/courier_roshan_darkmoon.vpcf"
    local caster = self:GetParent()
    local origin = caster:GetOrigin()
    self.effects = ParticleManager:CreateParticle( 
        particle_cast, 
        PATTACH_CUSTOMORIGIN, 
        nil
    )

    ParticleManager:SetParticleControlEnt( 
        self.effects, 
        0, 
        caster, 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        origin, 
        true 
    )
    ParticleManager:SetParticleControlEnt( 
        self.effects, 
        1, 
        caster, 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        origin, 
        true 
    )
end

function modifier_spectre_ultimate_damage:StopEffects()
	if self.effects ~= nil then
		ParticleManager:DestroyParticle(self.effects, false)
		ParticleManager:ReleaseParticleIndex(self.effects) 
		self.effects = nil
	end
end