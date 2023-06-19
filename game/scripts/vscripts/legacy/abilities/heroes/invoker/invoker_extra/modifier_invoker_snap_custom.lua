modifier_invoker_snap_custom = class({})

function modifier_invoker_snap_custom:OnCreated(params)
    if IsServer() then
        self.cooldown_ready = true
        self.off_time = self:GetAbility():GetSpecialValueFor("off_time")
        self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")
        EmitSoundOn("Hero_Invoker.ColdSnap", self:GetParent())
    end
end

function modifier_invoker_snap_custom:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_invoker_snap_custom:OnIntervalThink()
    self.cooldown_ready = true
    self:StartIntervalThink(-1)
end

function modifier_invoker_snap_custom:OnTakeDamage(params)
    if IsServer() then
		if params.unit ~= self:GetParent() then return end
        if not self.cooldown_ready then return end
        
        self.cooldown_ready = false
        self:StartIntervalThink(self.off_time)

        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_stunned", {
            duration = self.stun_duration
        })
        self:PlayEffects(params.attacker)
    end
end


function modifier_invoker_snap_custom:PlayEffects(attacker)
	local direction = self:GetParent():GetAbsOrigin() - attacker:GetAbsOrigin()

    local efx = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_cold_snap.vpcf", PATTACH_POINT_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(
		efx,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0),
		true
	)
	ParticleManager:SetParticleControl(efx, 1,  self:GetParent():GetAbsOrigin() + direction)
	ParticleManager:ReleaseParticleIndex(efx)

	EmitSoundOn("Hero_Invoker.ColdSnap.Freeze", self:GetParent())
end

function modifier_invoker_snap_custom:GetEffectName()
	return "particles/units/heroes/hero_invoker/invoker_cold_snap_status.vpcf"
end

function modifier_invoker_snap_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_invoker_snap_custom:GetStatusLabel() return "Cold Snap" end
function modifier_invoker_snap_custom:GetStatusPriority() return 2 end
function modifier_invoker_snap_custom:GetStatusStyle() return "ColdSnap" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_invoker_snap_custom)