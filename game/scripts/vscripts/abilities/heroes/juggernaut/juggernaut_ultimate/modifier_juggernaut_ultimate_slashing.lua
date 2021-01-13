modifier_juggernaut_ultimate_slashing = class({})

function modifier_juggernaut_ultimate_slashing:IsHidden()   return false end
function modifier_juggernaut_ultimate_slashing:IsDebuff()   return false end
function modifier_juggernaut_ultimate_slashing:IsPurgable() return false end

function modifier_juggernaut_ultimate_slashing:OnCreated(params)
    self.radius = self:GetAbility():GetSpecialValueFor("find_radius")

    if IsServer() then
        self.parent = self:GetParent()
        self.damage_per_second = self.parent:GetAttackDamage()
        self.current_position = self.parent:GetOrigin()
        self.previous_position = self.current_position
        self.current_target = nil
        self.damage_table = {
            attacker = self.parent,
            damage = self.damage_per_second,
            damage_type = DAMAGE_TYPE_PURE,
        }
        self:SetStackCount(params.aspd_buff)

        local attacks_per_second = self.parent:GetAttacksPerSecond()
        self.attack_speed = math.abs(1 / attacks_per_second)
        self:OnIntervalThink()
        self:StartIntervalThink(self.attack_speed)
        self.parent:HideHealthBar()
    end
end

function modifier_juggernaut_ultimate_slashing:OnDestroy()
    if IsServer() then
        self.parent:UnhideHealthBar()
        self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_juggernaut_spin_animation", {duration = 0.3})
    end
end

function modifier_juggernaut_ultimate_slashing:OnIntervalThink()
    local enemies = self:FindTargets()
    if #enemies > 0 then
        local enemy_index = RandomInt(1, #enemies)
        self.current_target = enemies[enemy_index]
        self:OnEnemyHit()
    else
        self.current_target = nil
        self:OnMiss()
    end
end

function modifier_juggernaut_ultimate_slashing:OnEnemyHit(hEnemy)
    self.damage_table.victim = self.current_target
    ApplyDamage(self.damage_table)
    FindClearSpaceForUnit(self.parent, self.current_target:GetAbsOrigin() + RandomVector(128), false)

    local direction = self.current_target:GetOrigin() - self.parent:GetOrigin()
    direction.z = self.parent:GetForwardVector().z
    self.parent:SetForwardVector(direction:Normalized())
    self.current_position = self.parent:GetOrigin()

    self:PlayEffectsTarget(self.current_target)
    self:PlayEffectsTrail(self.previous_position, self.current_position)

    ScreenShake(self.current_target:GetAbsOrigin(), 100, 300, 0.45, 1000, 0, true)
    self.previous_position = self.current_position
end

function modifier_juggernaut_ultimate_slashing:OnMiss()
    local efx_origin = self.parent:GetAbsOrigin() + RandomVector(RandomInt(self.radius/2, self.radius))
    EmitSoundOn("Hero_Juggernaut.ArcanaHaste.Anim", self.parent)

    EFX("particles/juggernaut/juggernaut_ultimate_glitch.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = efx_origin,
        cp1 = efx_origin,
        release = true
    })
    self.parent:AddNewModifier(self.parent, self:GetAbility(), 'modifier_juggernaut_ultimate_banish', { duration = self.attack_speed })
end

function modifier_juggernaut_ultimate_slashing:FindTargets()
    local find_origin = self.current_target and self.current_target:GetAbsOrigin() or self.parent:GetAbsOrigin()

    local enemies = CustomEntities:FindUnitsInRadius(
        self.parent,
        find_origin, 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
        FIND_ANY_ORDER
    )

    CreateRadiusMarker(self.parent, find_origin, self.radius, RADIUS_SCOPE_PUBLIC, 0.1)

    local filtered_enemies = {}

    for _,enemy in pairs(enemies) do
        if  (not CustomEntities:IsObstacle(enemy)) and 
            (not (enemy:Attribute_GetIntValue("dummy", 0) == 1)) 
        then
            table.insert(filtered_enemies, enemy)
        end
    end

    return filtered_enemies
end

function modifier_juggernaut_ultimate_slashing:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_juggernaut_ultimate_slashing:GetModifierAttackSpeedBonus_Constant()
	return -50 + self:GetStackCount()
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

function modifier_juggernaut_ultimate_slashing:PlayEffectsTarget(hTarget)
	EFX('particles/juggernaut/juggernaut_basic_attack_impact.vpcf', PATTACH_ABSORIGIN, hTarget, {
		release = true
    })
    
    local particle_cast = "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_tgt.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)
    ParticleManager:ReleaseParticleIndex(effect_cast)
    EmitSoundOn("Hero_Juggernaut.OmniSlash.Damage", hTarget)
end

function modifier_juggernaut_ultimate_slashing:PlayEffectsTrail(vPreviousPosition, vCurrentPosition)
    local efx = ParticleManager:CreateParticle("particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf", PATTACH_ABSORIGIN, self.parent)
    ParticleManager:SetParticleControl(efx, 0, vPreviousPosition)
    ParticleManager:SetParticleControl(efx, 1, vCurrentPosition)
    ParticleManager:ReleaseParticleIndex(efx)
end

function modifier_juggernaut_ultimate_slashing:GetEffectName()
	return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Animation(modifier_juggernaut_ultimate_slashing)