modifier_pudge_ultimate_thinker = class({})

function modifier_pudge_ultimate_thinker:OnCreated()
    if IsServer() then
        local delay_time = self:GetAbility():GetSpecialValueFor("delay_time")

        self.origin = self:GetParent():GetOrigin()
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.interval = self:GetAbility():GetSpecialValueFor("interval")
        self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")
        self.damage = self:GetAbility():GetSpecialValueFor("ability_damage")
        self.counter = 0
        self.effects_cast = {}
        self.initialized = false
        self:StartIntervalThink(delay_time)

        self.damage = 10
    end
end

function modifier_pudge_ultimate_thinker:OnDestroy()
	if IsServer() then
		self:StopEffects()
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_pudge_ultimate_thinker:OnIntervalThink()
    local enemies = self:GetCaster():FindUnitsInRadius(
        self.origin, 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )

    for _,enemy in pairs(enemies) do
        local damage_table = {
            victim = enemy,
            attacker = self:GetCaster(),
            damage = self.damage,
            damage_type = DAMAGE_TYPE_PURE,
        }
        ApplyDamage( damage_table )

        enemy:InterruptMotionControllers( true )
        enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_stunned", { duration = self.stun_duration })
    end
    
    
    self:PlayEffects(self.counter)
    self.counter = self.counter + 1
    self:PlayEffectsAoe()

    if self.initialized == false then
        self.initialized = true
        self:StartIntervalThink(self.interval)
    end 
end

function modifier_pudge_ultimate_thinker:PlayEffects( index )
    EmitSoundOnLocationWithCaster( self.origin, "Hero_Pudge.Dismember", self:GetCaster())
    EmitSoundOnLocationWithCaster( self.origin, "Hero_Pudge.DismemberSwings", self:GetCaster())

    
    local particle_cast = "particles/econ/items/pudge/pudge_arcana/pudge_arcana_dismember_default.vpcf"
    self.effects_cast[self.counter] = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( self.effects_cast[self.counter], 0, self.origin )
    
    if index == 0 then
        particle_cast = "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf"
        self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
        ParticleManager:SetParticleControl( self.effect_cast, 0, self.origin )
        ParticleManager:SetParticleControl( self.effect_cast, 1, self.origin )
        ParticleManager:SetParticleControl( self.effect_cast, 2, self.origin )
        ParticleManager:SetParticleControl( self.effect_cast, 3, Vector(self.radius, 0, 0) )
    end
end

function modifier_pudge_ultimate_thinker:PlayEffectsAoe()
    local particle_cast = "particles/aoe_marker.vpcf"

    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self.origin)
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 2, Vector( 255, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 3, Vector(0.1, 0, 0) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_pudge_ultimate_thinker:StopEffects()
    for _,effect_cast in pairs(self.effects_cast) do
        ParticleManager:DestroyParticle( effect_cast, false )
        ParticleManager:ReleaseParticleIndex( effect_cast )    
    end

    ParticleManager:DestroyParticle( self.effect_cast, false )
    ParticleManager:ReleaseParticleIndex( self.effect_cast )    
    
end