modifier_nevermore_special_attack_thinker = class({})

function modifier_nevermore_special_attack_thinker:OnCreated(params)
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.mana_gain_pct = self:GetAbility():GetSpecialValueFor("mana_gain_pct")
    self.lift_duration = self:GetAbility():GetSpecialValueFor("lift_duration")
    self.damage_table = {
        attacker = self:GetCaster(),
        damage = self:GetAbility():GetSpecialValueFor("ability_damage"),
        damage_type = DAMAGE_TYPE_PURE,
    }
    
    if IsServer() then
        local particle_cast = "particles/nevermore/nevermore_special_attack.vpcf"
        local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:ReleaseParticleIndex(effect_cast)

        
        particle_cast = "particles/nevermore/nevermore_special_attack_glow.vpcf"
        effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:ReleaseParticleIndex(effect_cast)
    end
end

function modifier_nevermore_special_attack_thinker:OnDelayEnds(params)
    if IsServer() then
        local enemies = self:GetCaster():FindUnitsInRadius(
            self:GetParent():GetOrigin(), 
            self.radius, 
            DOTA_UNIT_TARGET_TEAM_ENEMY, 
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER
        )

        local give_mana = false
        for _,enemy in pairs(enemies) do
            self.damage_table.victim = enemy
            ApplyDamage(self.damage_table)

            enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_nevermore_special_attack_displacement", {
                x = 1,
                y = 1,
                r = 1,
                speed = (1/self.lift_duration),
                peak = 400,
            })

            if not enemy:IsObstacle() then
                give_mana = true
            end
        end

        if give_mana then
            self:GetCaster():GiveManaPercent(self.mana_gain_pct)    
        end
        
        local particle_cast = "particles/econ/items/monkey_king/arcana/fire/monkey_king_spring_arcana_fire.vpcf"
        local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 1, 1))
        ParticleManager:ReleaseParticleIndex(effect_cast)

        EmitSoundOn("Hero_Nevermore.Shadowraze", self:GetCaster())
        EmitSoundOn("Hero_Nevermore.Raze_Flames", self:GetCaster())
    end
end

function modifier_nevermore_special_attack_thinker:GetDelayTime()
    return self:GetAbility():GetSpecialValueFor("delay_time")
end

function modifier_nevermore_special_attack_thinker:GetAOERadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Thinker(modifier_nevermore_special_attack_thinker)