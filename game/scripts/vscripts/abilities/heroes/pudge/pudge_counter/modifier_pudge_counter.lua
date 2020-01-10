modifier_pudge_counter = class({})

function modifier_pudge_counter:OnCreated()
    if IsServer() then
        self.caster = self:GetCaster()
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.damage_per_second = self:GetAbility():GetSpecialValueFor("damage_per_second")
        self:StartIntervalThink(1.0)

        self:PlayEffectsOnCreated()
    end
end

function modifier_pudge_counter:OnDestroy()
    if IsServer() then
        self:StopEffectsOnCreated()
    end
end

function modifier_pudge_counter:OnIntervalThink()
    local enemies = self.caster:FindUnitsInRadius( 
        self.caster:GetOrigin(), 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )


    for _,enemy in pairs(enemies) do
        local damage = {
            victim = enemy,
            attacker = self.caster,
            damage = self.damage_per_second,
            damage_type = DAMAGE_TYPE_PURE,
        }

        ApplyDamage( damage )
    end
end

function modifier_pudge_counter:PlayEffectsOnCreated()
    local particle_cast = "particles/units/heroes/hero_pudge/pudge_rot.vpcf"
    self.effect_cast_self = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControl( self.effect_cast_self, 1, Vector(self.radius, 0,0) )
end

function modifier_pudge_counter:StopEffectsOnCreated()
    ParticleManager:DestroyParticle(self.effect_cast_self, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast_self)
end