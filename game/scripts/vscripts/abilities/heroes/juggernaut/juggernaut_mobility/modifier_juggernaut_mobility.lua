modifier_juggernaut_mobility = class({})

function modifier_juggernaut_mobility:IsHidden()                return false    end
function modifier_juggernaut_mobility:IsDebuff()	            return false    end
function modifier_juggernaut_mobility:IsPurgable()              return true     end
function modifier_juggernaut_mobility:StatusEffectPriority()    return 2.0      end

function modifier_juggernaut_mobility:OnCreated(kv)
    self.speed_buff_pct = self:GetAbility():GetSpecialValueFor("speed_buff_pct")
    self.parent = self:GetParent()

    if IsServer() then
        self.damage_table = {
            attacker = self:GetCaster(),
            damage = self:GetAbility():GetSpecialValueFor("damage_per_second"),
            damage_type = DAMAGE_TYPE_PURE,
        }

        local think_interval = self:GetAbility():GetSpecialValueFor("think_interval")
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self:StartIntervalThink(think_interval)
        self:PlayEffects()
    end
end

function modifier_juggernaut_mobility:OnIntervalThink()
    local enemies = CustomEntitiesLegacy:FindUnitsInRadius(
        self.parent,
        self.parent:GetOrigin(), 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
        FIND_ANY_ORDER
   )

    for _,enemy in pairs(enemies) do
        if self:GetCaster():HasModifier("modifier_upgrade_juggernaut_fury_attack") then
            CustomEntitiesLegacy:SingleAttack(self:GetCaster(), {
                bIsBasicAttack = true,
                hTarget = enemy,
                Callback = function(hTarget)
                    self.damage_table.victim = hTarget
                    ApplyDamage(self.damage_table)
                    self:PlayEffectsOnImpact(hTarget)
                end
            })
        else
            self.damage_table.victim = enemy
            ApplyDamage(self.damage_table)
            self:PlayEffectsOnImpact(enemy)
        end
    end
end

function modifier_juggernaut_mobility:OnDestroy(kv)
    if IsServer() then
        self:StopEffects()
        EmitSoundOn("Hero_Juggernaut.BladeFuryStop", self.parent)
    end
end

function modifier_juggernaut_mobility:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_EVENT_ON_ORDER,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_WEIGHT,
	}
end

function modifier_juggernaut_mobility:OnOrder(params)
	if params.unit==self.parent then
		if params.order_type == DOTA_UNIT_ORDER_STOP or params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION then
			self:Destroy()
		end
	end
end

function modifier_juggernaut_mobility:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff_pct
end

function modifier_juggernaut_mobility:GetOverrideAnimation(params)          return ACT_DOTA_OVERRIDE_ABILITY_1      end
function modifier_juggernaut_mobility:GetOverrideAnimationRate(params)      return 1.0                              end
function modifier_juggernaut_mobility:GetOverrideAnimationWeight(params)    return 2.0                              end

function modifier_juggernaut_mobility:CheckState()
	return { 
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_SILENCED] = true
    }
end

function modifier_juggernaut_mobility:PlayEffectsOnImpact(hTarget)
    EmitSoundOn("Hero_Juggernaut.Attack", hTarget)
    EmitSoundOn("Hero_Juggernaut.BladeFury.Impact", hTarget)
    EFX('particles/juggernaut/juggernaut_mobility_impact.vpcf', PATTACH_ABSORIGIN, enemy, {
        release = true
    })
end

function modifier_juggernaut_mobility:PlayEffects()
	EmitSoundOn("Hero_Juggernaut.BladeFuryStart", self.parent)

    local particle_cast = "particles/units/heroes/hero_juggernaut/juggernaut_blade_fury.vpcf"
    
    if self:ShouldReflect() then
        particle_cast = 'particles/econ/items/juggernaut/jugg_sword_jade/juggernaut_blade_fury_jade.vpcf'
    end

	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(self.effect_cast, 5, Vector(self.radius, 1, 1))
    ParticleManager:SetParticleControl(self.effect_cast, 2, self.parent:GetOrigin())
end

function modifier_juggernaut_mobility:ShouldReflect()
    return self:GetAbility():GetLevel() >= 2 or self:GetCaster():HasModifier("modifier_upgrade_juggernaut_fury_reflects")
end

function modifier_juggernaut_mobility:StopEffects()
    StopSoundOn("Hero_Juggernaut.BladeFuryStart", self.parent)

    ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast)

    
    local particle_cast = "particles/econ/items/axe/axe_ti9_immortal/axe_ti9_beserkers_call_owner_aoe_dome.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_juggernaut_mobility:GetEffectName()
	return "particles/econ/events/ti9/phase_boots_ti9.vpcf"
end

function modifier_juggernaut_mobility:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_juggernaut_mobility:OnHit(params)
    if IsServer() then
        if params.iType == PROJECTILE_HIT then
            if not self:ShouldReflect() then
                return true
            end

            local projectile = params.hProjectile

            if projectile.bIsReflectable == true then
                projectile:SetVelocity(projectile:GetVelocity() * -1.2, projectile:GetPosition())
                projectile:SetSource(self:GetParent())
                projectile:SetVisionTeam(self:GetParent():GetTeam())
                projectile:ResetDistanceTraveled()
                projectile:ResetRehit()
                EmitSoundOn("Hero_Juggernaut.Attack", self:GetParent())
            end

            return false
        end
        return true
	end
end

function modifier_juggernaut_mobility:GetStatusLabel() return "Blade Fury" end
function modifier_juggernaut_mobility:GetStatusPriority() return 4 end
function modifier_juggernaut_mobility:GetStatusStyle() return "BladeFury" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Animation(modifier_juggernaut_mobility)
Modifiers.Status(modifier_juggernaut_mobility)
Modifiers.OnHit(modifier_juggernaut_mobility)
