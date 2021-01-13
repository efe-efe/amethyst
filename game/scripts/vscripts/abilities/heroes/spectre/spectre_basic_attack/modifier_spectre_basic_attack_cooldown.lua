modifier_spectre_basic_attack_cooldown = class({})

function modifier_spectre_basic_attack_cooldown:OnCreated(params)
    self.damage_bonus_desolate = self:GetAbility():GetSpecialValueFor("damage_bonus_desolate")
    self.heal_desolate = self:GetAbility():GetSpecialValueFor("heal_desolate")
	self.heal_charged = self:GetAbility():GetSpecialValueFor("heal_charged")
	self.desolate_duration = self:GetAbility():GetSpecialValueFor("desolate_duration")
    self.silence_duration = self:GetAbility():GetSpecialValueFor("silence_duration")
    self.mana_gain_pct = self:GetAbility():GetSpecialValueFor("mana_gain_pct")
    
    self.parent = self:GetParent()

    if IsServer() then
	    self.attack_speed_bonus = 0.2 + self:GetCaster():GetAttackAnimationPoint()
    end
end

function modifier_spectre_basic_attack_cooldown:DeclareFunctions()
    return { 
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_ATTACK_POINT_CONSTANT,
        MODIFIER_EVENT_ON_ATTACK_LANDED,
    }
end
 
function modifier_spectre_basic_attack_cooldown:OnAttack(params)
    if params.attacker ~= self:GetParent() then
        return
    end
    if self:GetRemainingTime() > 0 then
        return
    end

    self:StartCooldown()
end

function modifier_spectre_basic_attack_cooldown:GetModifierPreAttack_BonusDamage(event)
    if event.attacker ~= self:GetParent() then
        return
    end
    
    local extra_damage = 0
    
    if event.target and event.target ~= self.parent then
        local enemy = event.target
        if enemy:HasModifier("modifier_spectre_desolate_custom") then
            extra_damage = self.damage_bonus_desolate
        end

        if CustomEntities:ProvidesMana(enemy) then
            CustomEntities:GiveManaAndEnergyPercent(self.parent, self.mana_gain_pct, true)
        end
        self:PlayEffectsOnImpact(enemy, enemy:GetAbsOrigin(), is_charged)

        if self:IsCooldownReady() then
            enemy:AddNewModifier(self.parent, self:GetAbility(), "modifier_generic_silence", { duration = self.silence_duration })
            
            if CustomEntities:ProvidesMana(enemy) then
                enemy:AddNewModifier(self.parent, self:GetAbility(), "modifier_spectre_desolate_custom", { duration = self.desolate_duration })
            end
            
            if not CustomEntities:IsObstacle(enemy) and not CustomEntities:IsCountering(enemy) then
                self.parent:Heal(self.heal_charged, self.parent)
            end
        end
    end
    
    if not self:IsCooldownReady() then 
        return extra_damage 
    end
    return self:GetAbility():GetSpecialValueFor("charged_damage") + extra_damage
end

function modifier_spectre_basic_attack_cooldown:OnAttackLanded(event)
    if event.attacker ~= self:GetParent() then
        return
    end
    if event.target:HasModifier("modifier_spectre_desolate_custom") then
        if not CustomEntities:IsObstacle(event.target) then
            self.parent:Heal(self.heal_desolate, self.parent)
            self:PlayEffectsLifeSteal()
        end
    end
end

function modifier_spectre_basic_attack_cooldown:GetModifierAttackPointConstant()
    if not self:IsCooldownReady() then return 0 end
    if IsServer() then     
        return self.attack_speed_bonus
    end
end

function modifier_spectre_basic_attack_cooldown:OnReplenish()
	ReplenishEFX(self.parent)
    self:PlayEffectsWeapon()
end

function modifier_spectre_basic_attack_cooldown:OnCooldownStart()
    self:StopEffectsWeapon()
end

function modifier_spectre_basic_attack_cooldown:PlayEffectsLifeSteal()
	local particle_cast = "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_heal_eztzhok.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_spectre_basic_attack_cooldown:PlayEffectsWeapon()
    if IsServer() then
        local caster = self.parent

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

function modifier_spectre_basic_attack_cooldown:PlayEffectsOnImpact(hTarget, vPosition, bCharged)
	if bCharged then
		EmitSoundOn("Hero_BountyHunter.Jinada", hTarget)
		
		local particle_cast = "particles/econ/items/slark/slark_ti6_blade/slark_ti6_blade_essence_shift.vpcf"
		local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, hTarget)
		ParticleManager:ReleaseParticleIndex(effect_cast)
	else
		EmitSoundOn("Hero_Spectre.Attack", hTarget)
		
		EFX('particles/phantom/phantom_basic_attack.vpcf', PATTACH_ABSORIGIN, hTarget, {
			release = true
		})

		local caster = self:GetCaster()
		local offset = 50
		local new_position = caster:GetOrigin() + (vPosition - caster:GetOrigin()):Normalized() * offset
	
		local particle_cast = "particles/units/heroes/hero_spectre/spectre_desolate.vpcf"
		local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, caster)
		ParticleManager:SetParticleControl(effect_cast, 0, vPosition)
		ParticleManager:SetParticleControlForward(effect_cast, 0, (vPosition - caster:GetOrigin()):Normalized())
		ParticleManager:ReleaseParticleIndex(effect_cast)
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