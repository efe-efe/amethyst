modifier_juggernaut_ultimate_slashing = class({})

function modifier_juggernaut_ultimate_slashing:IsHidden()   return false end
function modifier_juggernaut_ultimate_slashing:IsDebuff()   return false end
function modifier_juggernaut_ultimate_slashing:IsPurgable() return false end

function modifier_juggernaut_ultimate_slashing:OnCreated(params)
    self.radius = self:GetAbility():GetSpecialValueFor("find_radius")

    if IsServer() then
        self.damage_per_second = self:GetParent():GetAttackDamage()
        self.current_position = self:GetParent():GetOrigin()
        self.previous_position = self:GetParent():GetOrigin()

        self:SetStackCount(params.aspd_buff)

        local attacks_per_second = self:GetParent():GetAttacksPerSecond()
        local attack_speed = math.abs(1 / attacks_per_second)
        
        self:OnIntervalThink()
        self:StartIntervalThink(attack_speed)
        self:GetCaster():HideHealthBar()
    end
end

function modifier_juggernaut_ultimate_slashing:OnDestroy()
    if IsServer() then
        self:GetCaster():UnhideHealthBar()
        self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_juggernaut_spin_animation", {duration = 0.3})
    end
end

function modifier_juggernaut_ultimate_slashing:OnIntervalThink()
    local enemies = self:GetParent():FindUnitsInRadius(
        self:GetParent():GetOrigin(), 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
        FIND_ANY_ORDER
   )

    local filtered_enemies = {}
    local counter = 0

    for _,enemy in pairs(enemies) do
        if  (not enemy:IsObstacle()) and 
            (not (enemy:Attribute_GetIntValue("dummy", 0) == 1)) 
        then
            counter = counter + 1
            filtered_enemies[counter] = enemy
        end
    end

    if counter > 0 then
        local enemy_index = RandomInt(1, counter)
        local target = filtered_enemies[enemy_index]

        local damage_table = {
            victim = target,
            attacker = self:GetParent(),
            damage = self.damage_per_second,
            damage_type = DAMAGE_TYPE_PURE,
        }
        ApplyDamage(damage_table)

        FindClearSpaceForUnit(self:GetParent(), target:GetAbsOrigin() + RandomVector(128), false)

        local direction = target:GetOrigin() - self:GetParent():GetOrigin()
        direction.z = self:GetParent():GetForwardVector().z
        self:GetParent():SetForwardVector(direction:Normalized())

        self.current_position = self:GetParent():GetOrigin()

        self:PlayEffects(target)
        self:PlayEffects_b()

        CreateRadiusMarker(self:GetParent(), self:GetParent():GetAbsOrigin(), self.radius, RADIUS_SCOPE_PUBLIC, 0.1)
		ScreenShake(self:GetParent():GetAbsOrigin(), 100, 300, 0.45, 1000, 0, true)

        self.previous_position = self.current_position

    else
        self:Destroy()
    end
end

function modifier_juggernaut_ultimate_slashing:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_juggernaut_ultimate_slashing:GetModifierAttackSpeedBonus_Constant()
	return self:GetStackCount()
end

function modifier_juggernaut_ultimate_slashing:GetOverrideAnimation(params)          return ACT_DOTA_OVERRIDE_ABILITY_4      end
function modifier_juggernaut_ultimate_slashing:GetOverrideAnimationRate(params)      return 1.5                              end

function modifier_juggernaut_ultimate_slashing:CheckState()
	return {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_juggernaut_ultimate_slashing:PlayEffects(hTarget)
	EFX('particles/juggernaut/juggernaut_basic_attack_impact.vpcf', PATTACH_ABSORIGIN, hTarget, {
		release = true
    })
    
    local particle_cast = "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_tgt.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)
    ParticleManager:ReleaseParticleIndex(effect_cast)
    EmitSoundOn("Hero_Juggernaut.OmniSlash.Damage", hTarget)
end

function modifier_juggernaut_ultimate_slashing:PlayEffects_b()
    local trail_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(trail_pfx, 0, self.previous_position)
    ParticleManager:SetParticleControl(trail_pfx, 1, self.current_position)
    ParticleManager:ReleaseParticleIndex(trail_pfx)
end

function modifier_juggernaut_ultimate_slashing:GetEffectName()
	return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Animation(modifier_juggernaut_ultimate_slashing)