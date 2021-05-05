modifier_queen_dodge = class({})

function modifier_queen_dodge:OnCreated(params)
    if IsServer() then
        self.origin = self:GetParent():GetAbsOrigin()
        self.blink = self:GetParent():FindAbilityByName("queen_blink")
        self.radius = 700
        self.aoe_radius = 250
        self.count = 0
        self.jumps = params.jumps
        self.angle_diff = 360/self.jumps
        self.delay_time = 0.7
        self.next_target = 0

        self:OnIntervalThink()
        self:StartIntervalThink(self.delay_time)

        self.radius_marker_modifier = CreateTimedRadiusMarker(self:GetCaster(), self.origin, self.radius, 1.0 * self.jumps, 0.2, RADIUS_SCOPE_PUBLIC):FindModifierByName('radius_marker_thinker')        
        local particle_cast = "particles/queen/queen_dodge.vpcf"
        self.effect_cast_aoe = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(self.effect_cast_aoe, 0, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(self.effect_cast_aoe, 1, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(self.effect_cast_aoe, 2, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(self.effect_cast_aoe, 3, Vector(self.radius, 0, 0))
    end
end

function modifier_queen_dodge:OnDestroy()
    if IsServer() then
        if self.count == self.jumps then
            self.blink:Blink(self.origin)
        end
        ParticleManager:DestroyParticle(self.effect_cast_aoe, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast_aoe)
        
        if self.radius_marker_modifier ~= nil then
            if not self.radius_marker_modifier:IsNull() then
                self.radius_marker_modifier:Destroy()
            end
        end

        self:GetAbility():StartCooldown(self:GetAbility():GetLevel())
    end
end

function modifier_queen_dodge:OnIntervalThink()
    if self.count == self.jumps then
        self:Destroy()
        return
    end

    self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1.5)
    
    if self.count ~= 0 then
        local vPoint = RotatePosition(self.origin, QAngle(0, self.angle_diff * self.next_target, 0), self.origin + Vector(self.radius, 0, 0))
        self.blink:Blink(vPoint)
    end 
    self.count = self.count + 1

    local newPoint = self.origin
    if self.count ~= self.jumps then
        self.next_target = RandomIntWithExeption(0, self.jumps, self.next_target)
        newPoint = RotatePosition(self.origin, QAngle(0, self.angle_diff * self.next_target - 1, 0), self.origin + Vector(self.radius, 0, 0))
    end
    CreateTimedRadiusMarker(self:GetCaster(), newPoint, self.aoe_radius, self.delay_time, 0.2, RADIUS_SCOPE_PUBLIC):FindModifierByName('radius_marker_thinker')
end

function modifier_queen_dodge:OnHit(params)
	if IsServer() then
        self:Destroy()
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_generic_stunned", { duration = 2.5 })
		return true
	end
end

function modifier_queen_dodge:CheckState()
	return {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.OnHit(modifier_queen_dodge)