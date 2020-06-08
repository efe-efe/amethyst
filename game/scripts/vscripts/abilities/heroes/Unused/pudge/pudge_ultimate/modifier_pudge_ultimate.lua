modifier_pudge_ultimate = class({})

function modifier_pudge_ultimate:OnCreated()
    if IsServer() then
        self.parent = self:GetParent()
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.interval = self:GetAbility():GetSpecialValueFor("interval")
        self.fading_slow_duration = self:GetAbility():GetSpecialValueFor("fading_slow_duration")
        self.fading_slow_pct = self:GetAbility():GetSpecialValueFor("fading_slow_pct")
        self.damage = self:GetAbility():GetSpecialValueFor("ability_damage")
        self.heal = self:GetAbility():GetSpecialValueFor("heal")
        self.counter = 0
        self.effects_cast = {}
        self:OnIntervalThink()
        self:StartIntervalThink(self.interval)

        if IsServer() then 
            self:GetParent():AddStatusBar({
                label = "Ultimate", modifier = self, priority = 6, stylename="Ultimate"
            })
        end
    end
end


function modifier_pudge_ultimate:OnDestroy()
	if IsServer() then
		self:StopEffects()
	end
end

function modifier_pudge_ultimate:OnIntervalThink()
    local origin = self.parent:GetOrigin()
    local enemies = self.parent:FindUnitsInRadius(
        origin, 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
   )

    for _,enemy in pairs(enemies) do
        local damage_table = {
            victim = enemy,
            attacker = self.parent,
            damage = self.damage,
            damage_type = DAMAGE_TYPE_PURE,
        }
        ApplyDamage(damage_table)

        enemy:AddNewModifier(self.parent, self:GetAbility(), "modifier_generic_fading_slow_new", { 
            duration = self.fading_slow_duration,
            max_slow_pct = self.fading_slow_pct
        })
        self.parent:Heal(self.heal, self.parent)
    end
    

    self:PlayEffects(self.counter, origin)
    self:PlayEffectsAoe(self.counter + 1, origin)
    self.counter = self.counter + 2
end

function modifier_pudge_ultimate:PlayEffects(index, origin)
    EmitSoundOnLocationWithCaster(origin, "Hero_Pudge.Dismember", self:GetCaster())
    EmitSoundOnLocationWithCaster(origin, "Hero_Pudge.DismemberSwings", self:GetCaster())

    
    local particle_cast = "particles/econ/items/pudge/pudge_arcana/pudge_arcana_dismember_default.vpcf"
    self.effects_cast[index] = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.effects_cast[index], 0, origin)
end

function modifier_pudge_ultimate:PlayEffectsAoe(index, origin)
    local effect_cast = ParticleManager:CreateParticle("particles/aoe_marker.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, origin)
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 1, 1))
    ParticleManager:SetParticleControl(effect_cast, 2, Vector(255, 1, 1))
    ParticleManager:SetParticleControl(effect_cast, 3, Vector(0.1, 0, 0))
    ParticleManager:ReleaseParticleIndex(effect_cast)

    self.effects_cast[index] = ParticleManager:CreateParticle("particles/grimstroke_ink_swell_aoe.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.effects_cast[index], 0, origin)
    ParticleManager:SetParticleControl(self.effects_cast[index], 1, Vector(self.radius, self.radius, self.radius))
end

function modifier_pudge_ultimate:StopEffects()
    for _,effect_cast in pairs(self.effects_cast) do
        ParticleManager:DestroyParticle(effect_cast, false)
        ParticleManager:ReleaseParticleIndex(effect_cast)    
    end
end