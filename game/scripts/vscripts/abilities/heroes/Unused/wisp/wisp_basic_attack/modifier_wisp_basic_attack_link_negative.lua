modifier_wisp_basic_attack_link_negative = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_wisp_basic_attack_link_negative:IsHidden()
	return true
end

function modifier_wisp_basic_attack_link_negative:IsDebuff() return false
end

function modifier_wisp_basic_attack_link_negative:IsPurgable() return false
end

function modifier_wisp_basic_attack_link_negative:RemoveOnDeath()
    return true
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_wisp_basic_attack_link_negative:OnCreated()
    self.max_range = self:GetAbility():GetSpecialValueFor("projectile_range")
    self.damage_return = self:GetAbility():GetSpecialValueFor("damage_return")
    
    self:PlayEffects(self:GetParent())
    self:StartIntervalThink(0.1)
end

function modifier_wisp_basic_attack_link_negative:OnRefresh()
    self:OnDestroy()

    self:PlayEffects(self:GetParent())
    self:StartIntervalThink(0.1)
end

--------------------------------------------------------------------------------
-- Destructor
function modifier_wisp_basic_attack_link_negative:OnDestroy()
    self:StopEffects()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wisp_basic_attack_link_negative:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
	return funcs
end

function modifier_wisp_basic_attack_link_negative:GetModifierIncomingDamage_Percentage(params)
    if IsServer() then

        local damage = params.damage * self.damage_return/100
        if params.damage_flags == DOTA_DAMAGE_FLAG_REFLECTION then return end
        
        local damage = {
			victim = self:GetCaster(),
			attacker = self:GetParent(),
			damage = damage,
            damage_type = DAMAGE_TYPE_PURE,
            damage_flags = DOTA_DAMAGE_FLAG_REFLECTION,
		}

        ApplyDamage(damage)
        
        return 0
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_wisp_basic_attack_link_negative:OnIntervalThink()
    if IsServer() then
        local target_origin = self:GetCaster():GetOrigin()
        local caster_origin = self:GetParent():GetOrigin()
        local direction = (caster_origin - target_origin)
        local distance = direction:Length2D()

        if distance > self.max_range then
            self:Destroy()
        end
    end
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
function modifier_wisp_basic_attack_link_negative:PlayEffects(hTarget)
    -- Get Resources
    if IsServer() then
        -- Get Resources
        local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_tether.vpcf"

        self.effect_cast = ParticleManager:CreateParticle(
            particle_cast,
            PATTACH_CUSTOMORIGIN, 
            nil
       )

        local origin = self:GetCaster():GetOrigin()

        ParticleManager:SetParticleControlEnt(
            self.effect_cast, 
            0, 
            self:GetCaster(), 
            PATTACH_POINT_FOLLOW, 
            "attach_hitloc", 
            self:GetCaster():GetOrigin() + Vector(0, 0, 96), 
            true 
       );
        ParticleManager:SetParticleControlEnt(
            self.effect_cast, 
            1, 
            hTarget, 
            PATTACH_POINT_FOLLOW, 
            "attach_attack1", 
            hTarget:GetOrigin(), 
            true 
       );

    end
end

function modifier_wisp_basic_attack_link_negative:StopEffects()
    if IsServer() then
        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)
    end
end