modifier_nevermore_ultimate_thinker = class({})

function modifier_nevermore_ultimate_thinker:OnCreated(params)
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    if IsServer() then
        self.caster = self:GetCaster()
        self.origin = self.caster:GetAbsOrigin()
        print(self:GetDuration())
        self.radius_marker_modifier = CreateTimedRadiusMarker(self.caster, self.origin, self.radius, self:GetDuration(), 0.2, RADIUS_SCOPE_PUBLIC):FindModifierByName('radius_marker_thinker')

        self:PlayEffects()
        self:StartIntervalThink(0.03)
    end
end

function modifier_nevermore_ultimate_thinker:OnDestroy()
    if IsServer() then
        
        if self.radius_marker_modifier ~= nil then
            if not self.radius_marker_modifier:IsNull() then
                self.radius_marker_modifier:Destroy()
            end
        end
        
        self:StopEffects()

        UTIL_Remove(self:GetParent())
    end
end

function modifier_nevermore_ultimate_thinker:PlayEffects()
    local particle_cast = "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf"
	self.effect_cast_aoe = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.effect_cast_aoe, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(self.effect_cast_aoe, 1, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(self.effect_cast_aoe, 2, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(self.effect_cast_aoe, 3, Vector(self.radius, 0, 0))
end

function modifier_nevermore_ultimate_thinker:StopEffects()
    ParticleManager:DestroyParticle(self.effect_cast_aoe, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast_aoe)
end


function modifier_nevermore_ultimate_thinker:OnIntervalThink()
    if IsServer() then
        local enemies = self:GetCaster():FindUnitsInRadius(
            self.origin, 
            self.radius, 
            DOTA_UNIT_TARGET_TEAM_ENEMY, 
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER
       )
        for _,enemy in pairs(enemies) do
            local direction = (self.origin - enemy:GetOrigin()):Normalized()
            local point = enemy:GetAbsOrigin() + direction * 8
            enemy:SetAbsOrigin(point)
            FindClearSpaceForUnit(enemy, enemy:GetAbsOrigin(), true)
        end
    end
end