modifier_puck_ultimate_thinker = class({})

function modifier_puck_ultimate_thinker:IsAura()
	return true
end
function modifier_puck_ultimate_thinker:GetModifierAura()
	return "modifier_puck_ultimate_area_check"
end
function modifier_puck_ultimate_thinker:GetAuraRadius()
	return self.radius
end
function modifier_puck_ultimate_thinker:GetAuraDuration()
	return 0.0
end
function modifier_puck_ultimate_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end
function modifier_puck_ultimate_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_puck_ultimate_thinker:OnCreated(params)
    if IsServer() then
        local initial_stun_duration = self:GetAbility():GetSpecialValueFor("initial_stun_duration")
        local tether_duration =  self:GetAbility():GetSpecialValueFor("duration")

        self.radius = self:GetAbility():GetSpecialValueFor("radius")

        local enemies = CustomEntities:FindUnitsInRadius(
			self:GetCaster(),
			self:GetParent():GetOrigin(), 
			self.radius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER
		)

		for _,enemy in pairs(enemies) do
			enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_puck_ultimate_debuff", { 
                duration = tether_duration,
                x = self:GetParent():GetAbsOrigin().x,
                y = self:GetParent():GetAbsOrigin().y,
                z = self:GetParent():GetAbsOrigin().z,
            })
			enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_stunned", { duration = initial_stun_duration })
        end

        local particle_cast = "particles/econ/items/puck/puck_alliance_set/puck_dreamcoil_aproset.vpcf"
        self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    end
end

function modifier_puck_ultimate_thinker:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)
    end
end

function modifier_puck_ultimate_thinker:DeclareFunctions()
    return { 
        MODIFIER_EVENT_ON_ABILITY_EXECUTED,
    }
end

function modifier_puck_ultimate_thinker:OnAbilityExecuted(params)
    if IsServer() then
        if params.unit ~= self:GetCaster() then
            return
        end

        local basic_attack = self:GetCaster():FindAbilityByName("puck_basic_attack")
        local counter = self:GetCaster():FindAbilityByName("puck_counter")
        local basic_attack_related = self:GetCaster():FindAbilityByName("puck_basic_attack_related")

        if  params.ability == counter or
            params.ability == basic_attack_related or
            params.ability == basic_attack
        then
            basic_attack:LaunchProjectile(self:GetParent():GetOrigin(), self:GetAbility():GetCursorPosition())
        end
    end
end

function modifier_puck_ultimate_thinker:GetDelayTime()
    return self:GetAbility():GetSpecialValueFor("duration")
end

function modifier_puck_ultimate_thinker:GetAOERadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Thinker(modifier_puck_ultimate_thinker)