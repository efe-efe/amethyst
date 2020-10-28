modifier_nevermore_extra = class({})

function modifier_nevermore_extra:IsAura()
	return true
end
function modifier_nevermore_extra:GetModifierAura()
	return "modifier_nevermore_extra_debuff"
end
function modifier_nevermore_extra:GetAuraRadius()
	return self.radius
end
function modifier_nevermore_extra:GetAuraDuration()
	return 0.5
end
function modifier_nevermore_extra:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end
function modifier_nevermore_extra:GetAuraEntityReject(hEntity)
    if self:GetCaster():IsAlly(hEntity) then
        return true 
    end
    return false
end
function modifier_nevermore_extra:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_nevermore_extra:OnCreated(params)
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    if IsServer() then
        self:SetStackCount(params.souls)
        local caster = self:GetCaster()
        local origin = caster:GetAbsOrigin()

        self.efx = EFX('particles/nevermore/nevermore_ex_second_attack.vpcf', PATTACH_ABSORIGIN_FOLLOW, caster, {
            cp2 = Vector(self.radius, 0, 0)
        })
    
        ParticleManager:SetParticleControlEnt(
            self.efx, 
            1, 
            caster, 
            PATTACH_POINT_FOLLOW, 
            "attach_hitloc", 
            origin, 
            true
        )
    end
end

function modifier_nevermore_extra:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.efx, false)
        ParticleManager:ReleaseParticleIndex(self.efx)
    end
end

function modifier_nevermore_extra:GetStatusLabel() return "Tornado" end
function modifier_nevermore_extra:GetStatusPriority() return 4 end
function modifier_nevermore_extra:GetStatusStyle() return "Tornado" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_nevermore_extra)