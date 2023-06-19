modifier_vengeful_mobility_illusion = class({})

function modifier_vengeful_mobility_illusion:OnCreated(params)
    if IsServer() then
        self.parent = self:GetParent()
        self.origin = self.parent:GetAbsOrigin()
        self.radius_marker_modifier = CreateTimedRadiusMarker(self.parent, self.origin, 150, self:GetDuration(), 0.2, RADIUS_SCOPE_PUBLIC):FindModifierByName('radius_marker_thinker')
    end
end

function modifier_vengeful_mobility_illusion:OnDestroy()
    if IsServer() then
        if self.radius_marker_modifier ~= nil then
            if not self.radius_marker_modifier:IsNull() then
                self.radius_marker_modifier:Destroy()
            end
        end
	end
end

function modifier_vengeful_mobility_illusion:CheckState()
    return{
		[MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
    }
end

function modifier_vengeful_mobility_illusion:GetStatusEffectName()
    return "particles/status_fx/status_effect_dark_seer_illusion.vpcf"
end