modifier_invoker_ice_wall_custom_thinker = class({})

function modifier_invoker_ice_wall_custom_thinker:OnCreated(params)
    if IsServer() then
        local direction = Vector(params.x, params.y)
        local origin = self:GetParent():GetAbsOrigin()
        local offset = 150
        local length = 1500
        local point = origin + (direction * length)/2
        local z_offset = 90

        self.point_a = self:Rotate(origin, point, -90) + direction * offset + Vector(0, 0, z_offset)
        self.point_b = self:Rotate(origin, point, 90) + direction * offset + Vector(0, 0, z_offset)

        self.efx_wall = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_ice_wall.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
        ParticleManager:SetParticleControl(self.efx_wall, 0, self.point_a)
        ParticleManager:SetParticleControl(self.efx_wall, 1, self.point_b)
        self.efx_spikes = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_ice_wall_b.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
        ParticleManager:SetParticleControl(self.efx_spikes, 0, self.point_a)
        ParticleManager:SetParticleControl(self.efx_spikes, 1, self.point_b)
        self:StartIntervalThink(0.03)
    end
end

function modifier_invoker_ice_wall_custom_thinker:OnIntervalThink()
	local enemies = CustomEntities:FindUnitsInLine(
        self:GetCaster(),
		self.point_a, 
		self.point_b, 
		100, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE
    )

    for _,enemy in pairs(enemies) do
        if not enemy:HasModifier("modifier_invoker_ice_wall_custom") then
            enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_invoker_ice_wall_custom", { duration = 0.5 })
        end
    end
end

function modifier_invoker_ice_wall_custom_thinker:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.efx_spikes, false)
        ParticleManager:DestroyParticle(self.efx_wall, true)
        ParticleManager:ReleaseParticleIndex(self.efx_wall)
        ParticleManager:ReleaseParticleIndex(self.efx_spikes)
        UTIL_Remove(self:GetParent())
    end
end

function modifier_invoker_ice_wall_custom_thinker:Rotate(vOrigin, vPoint, fAngle)
    local radians = (math.pi / 180) * fAngle
    local cos = math.cos(radians)
    local sin = math.sin(radians)
    local nx = (cos * (vPoint.x - vOrigin.x)) + (sin * (vPoint.y - vOrigin.y)) + vOrigin.x
    local ny = (cos * (vPoint.y - vOrigin.y)) - (sin * (vPoint.x - vOrigin.x)) + vOrigin.y
    
    return Vector(nx, ny)
end