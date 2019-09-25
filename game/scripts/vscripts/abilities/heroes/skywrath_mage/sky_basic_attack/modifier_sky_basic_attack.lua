modifier_sky_basic_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sky_basic_attack:IsHidden()
	return false
end

function modifier_sky_basic_attack:IsDebuff()
	return false
end

function modifier_sky_basic_attack:IsPurgable()
	return true
end

function modifier_sky_basic_attack:DestroyOnExpire()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sky_basic_attack:OnCreated( kv )
    -- load data
    self.damage_bonus = self:GetAbility():GetSpecialValueFor("damage_bonus")
    self.charge_cooldown = self:GetAbility():GetSpecialValueFor("charge_cooldown")

    self.max_charges = 1

    if IsServer() then
		self:SetStackCount( self.max_charges )
		self:CalculateCharge()
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_sky_basic_attack:OnIntervalThink()
	self:IncrementStackCount()
	self:StartIntervalThink(-1)
	self:CalculateCharge()
end

--------------------------------------------------------------------------------
-- Helpers
function modifier_sky_basic_attack:CalculateCharge()
	if self:GetStackCount() == self.max_charges then
		-- stop charging
		self:SetDuration( -1, false )
		self:StartIntervalThink( -1 )
        self:PlayEffects_a()
        self:PlayEffects_b()
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
            self:StopEffects_b()
		end
	end
end


--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sky_basic_attack:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}

	return funcs
end

function modifier_sky_basic_attack:OnAbilityFullyCast( params )
	if IsServer() then
		if params.unit ~= self:GetParent() then
			return
        end
        if params.ability == self:GetParent():FindAbilityByName("sky_mobility") or
            params.ability == self:GetParent():FindAbilityByName("sky_ex_basic_attack")
        then
            self:IncrementStackCount()
	        self:StartIntervalThink(-1)
            self:CalculateCharge()
            return
        end
	end
end

function modifier_sky_basic_attack:GetModifierPreAttack_BonusDamage()
    if self:GetStackCount() == 0 then return 0 end
    return self.damage_bonus
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_sky_basic_attack:PlayEffects_a()
	-- Get Resources
	local sound_cast = "Hero_Wisp.Spirits.Destroy"
	local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_death.vpcf"
    local origin = self:GetCaster():GetOrigin()

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster()  )

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_sky_basic_attack:PlayEffects_b()
    if IsServer() then
        -- Get Resources
        local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_overcharge_c.vpcf"
        local origin = self:GetParent():GetOrigin()
        
        self.effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_CUSTOMORIGIN, 
            self:GetParent()
        )

        ParticleManager:SetParticleControlEnt( 
            self.effect_cast, 
            0, 
            self:GetParent(), 
            PATTACH_POINT_FOLLOW, 
            "attach_attack1", 
            origin + Vector( 0, 0, 96 ), 
            true 
        )
    end
end

function modifier_sky_basic_attack:StopEffects_b()
    if IsServer() then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
end

function modifier_sky_basic_attack:GetEffectName()
	return "particles/econ/items/dark_willow/dark_willow_ti8_immortal_head/dw_crimson_ti8_immortal_ambient_embers_b.vpcf"
end

function modifier_sky_basic_attack:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end