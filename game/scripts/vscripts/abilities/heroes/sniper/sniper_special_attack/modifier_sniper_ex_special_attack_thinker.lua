modifier_sniper_ex_special_attack_thinker = class({})

function modifier_sniper_ex_special_attack_thinker:IsAura()
	return self:IsInitialized()
end
function modifier_sniper_ex_special_attack_thinker:GetModifierAura()
	return "modifier_sniper_ex_special_attack_debuff"
end
function modifier_sniper_ex_special_attack_thinker:GetAuraRadius()
	return self.radius
end
function modifier_sniper_ex_special_attack_thinker:GetAuraDuration()
	return self.debuff_linger
end
function modifier_sniper_ex_special_attack_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end
function modifier_sniper_ex_special_attack_thinker:GetAuraEntityReject(hEntity)
    if self:GetCaster():IsAlly(hEntity) then
        return true 
    end
    return false
end
function modifier_sniper_ex_special_attack_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_sniper_ex_special_attack_thinker:OnDelayEnds()
    if IsServer() then
        self.duration = self:GetAbility():GetSpecialValueFor("duration")
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.debuff_linger = self:GetAbility():GetSpecialValueFor("debuff_linger")
        self.initial_damage = self:GetAbility():GetSpecialValueFor("initial_damage")
        self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")

        local enemies = self:GetCaster():FindUnitsInRadius(
            self:GetParent():GetAbsOrigin(), 
            self.radius, 
            DOTA_UNIT_TARGET_TEAM_ENEMY, 
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
            DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
            FIND_ANY_ORDER
        )

        for _,enemy in pairs(enemies) do
            local damage = {
                victim = enemy,
                attacker = self.parent,
                damage = self.initial_damage,
                damage_type = DAMAGE_TYPE_PURE,
            }

            enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), 'modifier_generic_stunned', { duration = self.stun_duration })
            
            ApplyDamage(damage)
        end
        
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self.radius, self.duration, false)
        self:PlayEffectsOnCreated()
        self:PlayEffectsAoe()
    end
end

function modifier_sniper_ex_special_attack_thinker:OnDestroy()
    if IsServer() then
        self:StopEffects()
		UTIL_Remove(self:GetParent())
	end
end

function modifier_sniper_ex_special_attack_thinker:PlayEffectsOnCreated()
    local particle_cast = "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(effect_cast, 1, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(effect_cast, 2, self:GetParent():GetAbsOrigin())

    
    particle_cast = "particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf"
    effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(effect_cast, 1, self:GetParent():GetAbsOrigin() + Vector(0, 0, 1000))
    ParticleManager:SetParticleControl(effect_cast, 2, self:GetParent():GetAbsOrigin())
end

function modifier_sniper_ex_special_attack_thinker:PlayEffectsAoe()
    EmitSoundOn("Hero_Sniper.MKG_ShrapnelShatter", self:GetParent())

    local particle_cast = "particles/sniper/sniper_ex_special_attack.vpcf"
    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius,0,0))
end

function modifier_sniper_ex_special_attack_thinker:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)

	StopSoundOn("Hero_Sniper.MKG_ShrapnelShatter", self:GetParent())
end

function modifier_sniper_ex_special_attack_thinker:GetDelayTime()
    return self:GetAbility():GetSpecialValueFor("delay_time")
end

function modifier_sniper_ex_special_attack_thinker:GetAOERadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Thinker(modifier_sniper_ex_special_attack_thinker)