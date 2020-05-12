modifier_spectre_basic_attack = class({})

function modifier_spectre_basic_attack:IsHidden()           return  false    end
function modifier_spectre_basic_attack:IsDebuff()           return  false    end
function modifier_spectre_basic_attack:IsPurgable()         return  true     end
function modifier_spectre_basic_attack:DestroyOnExpire()    return  false    end

function modifier_spectre_basic_attack:OnCreated( kv )
    self.damage_bonus_charged = self:GetAbility():GetSpecialValueFor("damage_bonus_charged")
    self.charge_cooldown = self:GetAbility():GetSpecialValueFor("charge_cooldown")
    self.max_charges = 1

    if IsServer() then
	    self.attack_speed_bonus = 0.2 + self:GetCaster():GetAttackAnimationPoint()--self:GetAbility():GetSpecialValueFor("attack_speed_bonus")

        if self:GetParent():IsRealHero() then
            self:GetParent():AddCooldownVisual({ modifier = self })
            self:SetStackCount( self.max_charges )
            self:CalculateCharge()
        end
    end
end

function modifier_spectre_basic_attack:OnIntervalThink()
	self:IncrementStackCount()
	self:StartIntervalThink(-1)
	self:CalculateCharge()
end

function modifier_spectre_basic_attack:CalculateCharge()
    if self:GetStackCount() == self.max_charges then
		-- stop charging
		self:SetDuration( -1, true )
		self:StartIntervalThink( -1 )
        self:PlayEffectsCharged()
        self:PlayEffectsWeapon()
    elseif self:GetStackCount() > self.max_charges then
		-- stop charging
		self:SetStackCount( self.max_charges )
		self:SetDuration( -1, false )
		self:StartIntervalThink( -1 )
	else
		-- if not charging
		if self:GetRemainingTime() <= 0.05 then
			-- start charging
			local charge_time = self.charge_cooldown
			self:StartIntervalThink( charge_time )
			self:SetDuration( charge_time, true )
            self:StopEffectsWeapon()
		end
	end
end

function modifier_spectre_basic_attack:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACK_POINT_CONSTANT,
	}
end

function modifier_spectre_basic_attack:GetModifierAttackPointConstant()
    if self:GetStackCount() == 0 then return 0 end
    if IsServer() then     
        return self.attack_speed_bonus
    end
end

function modifier_spectre_basic_attack:GetModifierPreAttack_BonusDamage()
    if self:GetStackCount() == 0 then return 0 end
    return self.damage_bonus_charged
end

function modifier_spectre_basic_attack:PlayEffectsCharged()
	local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_death.vpcf"
	local caster = self:GetParent()
    local origin = caster:GetOrigin()

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, caster )
	ParticleManager:SetParticleControlEnt( 
		effect_cast, 
		0, 
		caster, 
		PATTACH_POINT_FOLLOW, 
		"attach_attack1", 
		origin, 
		true 
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_spectre_basic_attack:PlayEffectsWeapon()
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

function modifier_spectre_basic_attack:StopEffectsWeapon()
    if IsServer() then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
end

function modifier_spectre_basic_attack:GetEffectName()
	return "particles/econ/items/dark_willow/dark_willow_ti8_immortal_head/dw_crimson_ti8_immortal_ambient_embers_b.vpcf"
end

function modifier_spectre_basic_attack:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
