modifier_spectre_ultimate_thinker = class({})

function modifier_spectre_ultimate_thinker:IsAura()
	return self:IsInitialized()
end
function modifier_spectre_ultimate_thinker:GetModifierAura()
	return "modifier_spectre_ultimate"
end
function modifier_spectre_ultimate_thinker:GetAuraRadius()
	return self.radius
end
function modifier_spectre_ultimate_thinker:GetAuraDuration()
	return 0.0
end
function modifier_spectre_ultimate_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end
function modifier_spectre_ultimate_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_spectre_ultimate_thinker:OnCreated()
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_spectre_ultimate_thinker:OnDelayEnds()
    if IsServer() then
        self:GetCaster():FindAbilityByName("spectre_mobility"):EndCooldown()

        local particle_cast = "particles/fv_chronosphere_aeons.vpcf"

        self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetParent():GetOrigin())
        ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius, self.radius, 1))
    end
end

function modifier_spectre_ultimate_thinker:OnDestroy()
    if IsServer() then
        local enemies = self:GetCaster():FindUnitsInRadius(
			self:GetParent():GetOrigin(), 
			self.radius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER
		)

        for _,enemy in pairs(enemies) do
            if enemy:HasModifier("modifier_spectre_ultimate") then
                enemy:FindModifierByName("modifier_spectre_ultimate"):SetStackCount(3)
            end
        end
        
        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)
    end
end

function modifier_spectre_ultimate_thinker:GetDelayTime()
    return self:GetAbility():GetSpecialValueFor("delay_time")
end

function modifier_spectre_ultimate_thinker:GetAOERadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_spectre_ultimate_thinker:GetFollowTarget()
    if self:IsInitialized() then
        return self:GetParent()
    else
        return self:GetCaster()
    end
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Thinker(modifier_spectre_ultimate_thinker)