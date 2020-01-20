modifier_nevermore_ex_mobility_thinker = class({})

function modifier_nevermore_ex_mobility_thinker:OnCreated()
    if IsServer() then
        local delay_time = self:GetAbility():GetSpecialValueFor("delay_time")

        self.origin = self:GetParent():GetOrigin()
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.duration = self:GetAbility():GetSpecialValueFor("duration")
        self:StartIntervalThink( delay_time )
        self:PlayEffects()
    end
end

function modifier_nevermore_ex_mobility_thinker:OnDestroy()
    if IsServer() then
        self:StopEffects()
        UTIL_Remove( self:GetParent() )
        EmitSoundOn("Hero_Nevermore.ROS_Flames", self:GetCaster() )

        local particle_cast = "particles/econ/events/ti4/blink_dagger_end_ti4.vpcf"
        local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
        ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
        
        particle_cast = "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
        effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )	
        ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
        ParticleManager:SetParticleControl( effect_cast, 60, Vector(157, 0, 243) )
        ParticleManager:SetParticleControl( effect_cast, 61, Vector(1, 0, 0) )
        ParticleManager:ReleaseParticleIndex( effect_cast )
    end
end

function modifier_nevermore_ex_mobility_thinker:OnIntervalThink()
    StartAnimation(self:GetCaster(), { 
        duration = 0.3, 
        activity = ACT_DOTA_RAZE_2, 
        rate = 1.0
    })

    FindClearSpaceForUnit( self:GetCaster(), self.origin , true )

    local enemies = self:GetCaster():FindUnitsInRadius(
        self.origin, 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )
    
    for _,enemy in pairs(enemies) do
        local x =  - (self.origin - enemy:GetOrigin()):Normalized().x
        local y =  - (self.origin - enemy:GetOrigin()):Normalized().y

        enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_fear", { 
            duration = self.duration, 
            x = x,
            y = y
        })
    end
    
	self:GetCaster():RemoveNoDraw()
	self:GetCaster():RemoveModifierByName("modifier_banish")
	self:Destroy()
end

function modifier_nevermore_ex_mobility_thinker:PlayEffects()

    local particle_cast = "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf"
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( self.effect_cast, 0, self.origin )
    ParticleManager:SetParticleControl( self.effect_cast, 1, self.origin )
    ParticleManager:SetParticleControl( self.effect_cast, 2, self.origin )
    ParticleManager:SetParticleControl( self.effect_cast, 3, Vector(self.radius, 0, 0) )
end

function modifier_nevermore_ex_mobility_thinker:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )    
end