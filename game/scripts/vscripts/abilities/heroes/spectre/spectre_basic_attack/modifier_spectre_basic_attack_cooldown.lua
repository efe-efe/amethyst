modifier_spectre_basic_attack_cooldown = class({})

function modifier_spectre_basic_attack_cooldown:OnCreated(params)
    self.charged_damage = self:GetAbility():GetSpecialValueFor("charged_damage")
    if IsServer() then
	    self.attack_speed_bonus = 0.2 + self:GetCaster():GetAttackAnimationPoint()
    end
end

function modifier_spectre_basic_attack_cooldown:DeclareFunctions()
    return { 
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACK_POINT_CONSTANT,
    }
end
 
function modifier_spectre_basic_attack_cooldown:OnAbilityFullyCast(params)
    if IsServer() then
        if params.unit ~= self:GetParent() then
            return
        end

        if params.ability == self:GetAbility() then
            if self:GetRemainingTime() > 0 then
                return
            end

            self:StartCooldown()
        end
    end
end

function modifier_spectre_basic_attack_cooldown:GetModifierPreAttack_BonusDamage()
    if not self:IsCooldownReady() then return 0 end
    return self.charged_damage
end


function modifier_spectre_basic_attack_cooldown:GetModifierAttackPointConstant()
    if not self:IsCooldownReady() then return 0 end
    if IsServer() then     
        return self.attack_speed_bonus
    end
end

function modifier_spectre_basic_attack_cooldown:OnReplenish()
    self:PlayEffectsCharged()
    self:PlayEffectsWeapon()
end

function modifier_spectre_basic_attack_cooldown:OnCooldownStart()
    self:StopEffectsWeapon()
end

function modifier_spectre_basic_attack_cooldown:PlayEffectsCharged()
	local particle_cast = "particles/units/heroes/hero_wisp/wisp_death.vpcf"
	local caster = self:GetParent()
    local origin = caster:GetOrigin()

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControlEnt(
		effect_cast, 
		0, 
		caster, 
		PATTACH_POINT_FOLLOW, 
		"attach_attack1", 
		origin, 
		true 
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_spectre_basic_attack_cooldown:PlayEffectsWeapon()
    if IsServer() then
        local caster = self:GetParent()

        local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_base_attack_c.vpcf"
        local origin = caster:GetOrigin()
        self.effect_cast = ParticleManager:CreateParticle(
            particle_cast, 
            PATTACH_CUSTOMORIGIN, 
            caster
       )

        ParticleManager:SetParticleControlEnt(
            self.effect_cast, 
            0, 
            caster, 
            PATTACH_POINT_FOLLOW, 
            "attach_attack1", 
            origin, 
            true 
       )
        ParticleManager:SetParticleControlEnt(
            self.effect_cast, 
            3, 
            caster, 
            PATTACH_POINT_FOLLOW, 
            "attach_attack1", 
            origin, 
            true 
       )
    end
end

function modifier_spectre_basic_attack_cooldown:StopEffectsWeapon()
    if IsServer() then
        if self.effect_cast then
            ParticleManager:DestroyParticle(self.effect_cast, false)
            ParticleManager:ReleaseParticleIndex(self.effect_cast)
        end
    end
end

function modifier_spectre_basic_attack_cooldown:GetEffectName()
	return "particles/econ/items/dark_willow/dark_willow_ti8_immortal_head/dw_crimson_ti8_immortal_ambient_embers_b.vpcf"
end

function modifier_spectre_basic_attack_cooldown:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_spectre_basic_attack_cooldown:GetReplenishTime()
    return self:GetAbility():GetSpecialValueFor("replenish_time")
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Cooldown(modifier_spectre_basic_attack_cooldown)