modifier_spectre_ultimate_illusion = class({})

function modifier_spectre_ultimate_illusion:OnCreated( params )
    if IsServer() then
		self.aoe_origin = Vector(params.x, params.y, 0)
        self.radius = params.radius
        self.enemy = params.enemy
        
        self:PlayEffects()
		self:StartIntervalThink(0.5)
	end
end

function modifier_spectre_ultimate_illusion:OnDestroy()
    if IsServer() then
        self:StopEffects()
        UTIL_Remove(self:GetParent())
    end
end

function modifier_spectre_ultimate_illusion:OnIntervalThink()
    if (self.aoe_origin - self:GetParent():GetOrigin()):Length2D() > self.radius then
        self:Destroy()
    end

    ExecuteOrderFromTable({
		UnitIndex = self:GetParent():entindex(),
		OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
		TargetIndex = self.enemy,
	})
end

function modifier_spectre_ultimate_illusion:PlayEffects()
    local particle_cast = "particles/econ/courier/courier_roshan_darkmoon/courier_roshan_darkmoon.vpcf"
    local caster = self:GetParent()
    local origin = caster:GetOrigin()
    self.effects = ParticleManager:CreateParticle( 
        particle_cast, 
        PATTACH_CUSTOMORIGIN, 
        nil
    )

    ParticleManager:SetParticleControlEnt( 
        self.effects, 
        0, 
        caster, 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        origin, 
        true 
    )
    ParticleManager:SetParticleControlEnt( 
        self.effects, 
        1, 
        caster, 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        origin, 
        true 
    )
end

function modifier_spectre_ultimate_illusion:StopEffects()
    ParticleManager:DestroyParticle(self.effects, false)
    ParticleManager:ReleaseParticleIndex(self.effects) 
end

function modifier_spectre_ultimate_illusion:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_BONUS_VISION_PERCENTAGE,
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
    }
    return funcs
end


function modifier_spectre_ultimate_illusion:GetModifierMoveSpeed_Absolute()
    return 550
end


function modifier_spectre_ultimate_illusion:GetBonusVisionPercentage()
    return -50
end

function modifier_spectre_ultimate_illusion:CheckState()
	local state = {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
	}

	return state
end