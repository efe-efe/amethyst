modifier_phantom_ex_basic_attack = class({})

function modifier_phantom_ex_basic_attack:IsHidden() return false end
function modifier_phantom_ex_basic_attack:IsDebuff() return false end
function modifier_phantom_ex_basic_attack:IsStunDebuff() return false end
function modifier_phantom_ex_basic_attack:IsPurgable() return true end

function modifier_phantom_ex_basic_attack:OnCreated(kv)
    if IsServer() then
        self:GetParent():SwapAbilities(
            "phantom_basic_attack", 
            "phantom_basic_attack_related", 
            false, 
            true
       )
        
        self:PlayEffectsOnCast()
	end
end

function modifier_phantom_ex_basic_attack:OnDestroy(kv)
    if IsServer() then
        self:GetParent():SwapAbilities(
            "phantom_basic_attack", 
            "phantom_basic_attack_related", 
            true,
            false
       )

        local particle_cast = "particles/econ/events/ti5/blink_dagger_end_sparkles_end_lvl2_ti5.vpcf"
        local origin = self:GetParent():GetAbsOrigin()
        local effect_cast = ParticleManager:CreateParticle(
            particle_cast, 
            PATTACH_CUSTOMORIGIN, 
            self:GetParent()
       )
    
        ParticleManager:SetParticleControlEnt(
            effect_cast, 
            0, 
            self:GetParent(), 
            PATTACH_POINT_FOLLOW, 
            "attach_hitloc", 
            origin, 
            true 
       )
        ParticleManager:SetParticleControlEnt(
            effect_cast, 
            1, 
            self:GetParent(), 
            PATTACH_POINT_FOLLOW, 
            "attach_hitloc", 
            origin, 
            true 
       )
       
        self:StopEffects()
	end
end


function modifier_phantom_ex_basic_attack:DeclareFunctions()
    return { 
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
end

function modifier_phantom_ex_basic_attack:GetModifierPreAttack_BonusDamage(event)
    return -1
end

function modifier_phantom_ex_basic_attack:PlayEffectsOnCast()
    local particle_cast = "particles/econ/courier/courier_axolotl_ambient/courier_axolotl_ambient_lvl4_trail_steam.vpcf"
    local origin = self:GetParent():GetAbsOrigin()

    self.effect_cast_sparks = ParticleManager:CreateParticle(
        particle_cast, 
        PATTACH_CUSTOMORIGIN, 
        self:GetParent()
   )

    ParticleManager:SetParticleControlEnt(
        self.effect_cast_sparks, 
        0, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        origin, 
        true 
   )
end

function modifier_phantom_ex_basic_attack:StopEffects()
    if self.effect_cast_sparks ~= nil then
        ParticleManager:DestroyParticle(self.effect_cast_sparks, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast_sparks)
    end
end

function modifier_phantom_ex_basic_attack:GetStatusLabel() return "Dancing Blades" end
function modifier_phantom_ex_basic_attack:GetStatusPriority() return 2 end
function modifier_phantom_ex_basic_attack:GetStatusStyle() return "DancingBlades" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_phantom_ex_basic_attack)