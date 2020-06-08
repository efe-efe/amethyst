modifier_nevermore_ex_basic_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_nevermore_ex_basic_attack:IsHidden() return false
end

function modifier_nevermore_ex_basic_attack:IsDebuff() return false
end

function modifier_nevermore_ex_basic_attack:IsStunDebuff()
	return false
end

function modifier_nevermore_ex_basic_attack:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_nevermore_ex_basic_attack:OnCreated(params)
    self.damage_per_soul = self:GetAbility():GetSpecialValueFor("damage_per_soul")

    if IsServer() then
        self:SetStackCount(params.stacks)
        self:GetParent():AddStatusBar({
            label = "Desolation", modifier = self, priority = 2, stylename="Desolation"
        }) 
        self:PlayEffectsOnCast()
	end
end

function modifier_nevermore_ex_basic_attack:OnDestroy(kv)
    if IsServer() then
        local particle_cast = "particles/econ/events/ti6/blink_dagger_end_ti6.vpcf"
        local origin = self:GetParent():GetOrigin()
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

function modifier_nevermore_ex_basic_attack:PlayEffectsOnCast()
    local particle_cast = "particles/econ/courier/courier_axolotl_ambient/courier_axolotl_ambient_lvl3.vpcf"
    local origin = self:GetParent():GetOrigin()

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

function modifier_nevermore_ex_basic_attack:StopEffects()
    if self.effect_cast_sparks ~= nil then
        ParticleManager:DestroyParticle(self.effect_cast_sparks, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast_sparks)
    end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_nevermore_ex_basic_attack:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end

function modifier_nevermore_ex_basic_attack:GetModifierPreAttack_BonusDamage()
    return self:GetStackCount() * self.damage_per_soul
end
