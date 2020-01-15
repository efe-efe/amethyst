modifier_nevermore_ultimate_attract = class({})

function modifier_nevermore_ultimate_attract:OnCreated()
    if IsServer() then 
        local interval = 0.01
        self.distance = 5
        self.caster = self:GetCaster()
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.speed = self.distance/interval
        self.initialized = false

        self:StartIntervalThink(interval)
    end
end

function modifier_nevermore_ultimate_attract:OnIntervalThink()
    
    if self.initialized == false then
        self:PlayEffectsAoe()
        self.initialized = true
    end

    local origin = self.caster:GetOrigin()

    local enemies = self.caster:FindUnitsInRadius(
		origin, 
		self.radius, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER
	)

	for _,enemy in pairs(enemies) do
        local direction = (origin - enemy:GetOrigin()):Normalized()
        
        if not enemy:HasModifier("modifier_generic_displacement") then
            enemy:AddNewModifier(
                self.caster, -- player source
                self:GetAbility(), -- ability source
                "modifier_generic_displacement", -- modifier name
                {
                    x = direction.x,
                    y = direction.y,
                    r = self.distance,
                    speed = self.speed,
                    peak = 0,
                    activity = 0,
                    restricted = 0,
                    interrupt = 0,
                } -- kv
            )
        end
    end
end


function modifier_nevermore_ultimate_attract:PlayEffectsAoe()
    local particle_cast = "particles/aoe_marker.vpcf"

    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin())
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 2, Vector( 255, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 3, Vector(self:GetDuration(), 0, 0) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end
