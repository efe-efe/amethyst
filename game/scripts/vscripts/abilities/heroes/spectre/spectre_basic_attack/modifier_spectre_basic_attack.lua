modifier_spectre_basic_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_spectre_basic_attack:IsHidden()
	return false
end

function modifier_spectre_basic_attack:IsDebuff()
	return false
end

function modifier_spectre_basic_attack:IsPurgable()
	return true
end

function modifier_spectre_basic_attack:DestroyOnExpire()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_basic_attack:OnCreated( kv )
    -- load data
    self.damage_bonus_desolate = self:GetAbility():GetSpecialValueFor("damage_bonus_desolate")
    self.damage_bonus_charged = self:GetAbility():GetSpecialValueFor("damage_bonus_charged")
    self.heal_desolate = self:GetAbility():GetSpecialValueFor("heal_desolate")
    self.charge_cooldown = self:GetAbility():GetSpecialValueFor("charge_cooldown")
    self.max_charges = 1

    if IsServer() then
	    self.attack_speed_bonus = 0.2 + self:GetCaster():GetAttackAnimationPoint()--self:GetAbility():GetSpecialValueFor("attack_speed_bonus")

        GameMode:InitializeCooldown( self:GetParent(), self:GetName() )
		self:SetStackCount( self.max_charges )
		self:CalculateCharge()
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
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

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spectre_basic_attack:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_ATTACK_POINT_CONSTANT,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spectre_basic_attack:GetModifierAttackPointConstant()
    if self:GetStackCount() == 0 then return 0 end
    if IsServer() then     
        return self.attack_speed_bonus
    end
end

--------------------------------------------------------------------------------

function modifier_spectre_basic_attack:GetModifierPreAttack_BonusDamage()
    if self:GetStackCount() == 0 then return 0 end
    return self.damage_bonus_charged
end

function modifier_spectre_basic_attack:OnAttackLanded( params )
	if IsServer() then
		if params.attacker ~= self:GetParent() then return end
        if params.attacker:GetTeamNumber() == params.target:GetTeamNumber() then return end
        
        local desolate = params.target:FindModifierByNameAndCaster( "modifier_spectre_desolate_lua", params.attacker )
		
        -- If have the debuff, adds extra attack and extends debuff duration
        if desolate ~= nil then 
            local damage = {
                victim = params.target,
                attacker = params.attacker,
                damage = self.damage_bonus_desolate,
                damage_type = DAMAGE_TYPE_PHYSICAL,
            }
    
            ApplyDamage( damage )

            if not params.target:IsObstacle() then
                params.attacker:Heal( self.heal_desolate, params.attacker )
            end
            
            self:PlayEffectsLifeSteal()
        end
	end
end



--------------------------------------------------------------------------------
-- Graphics & Animations
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
        -- Get Resources
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

function modifier_spectre_basic_attack:PlayEffectsLifeSteal( )
	-- Create Particles
	local particle_cast = "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_heal_eztzhok.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	
	ParticleManager:ReleaseParticleIndex( effect_cast )
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
