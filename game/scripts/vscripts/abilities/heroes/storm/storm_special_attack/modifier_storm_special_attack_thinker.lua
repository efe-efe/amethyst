modifier_storm_special_attack_thinker = class({})

function modifier_storm_special_attack_thinker:IsAura()
	return not self.isProvidedByAura
end
function modifier_storm_special_attack_thinker:GetModifierAura()
	return "modifier_storm_special_attack_thinker"
end
function modifier_storm_special_attack_thinker:GetAuraRadius()
	return self.radius
end
function modifier_storm_special_attack_thinker:GetAuraDuration()
	return 0.0
end
function modifier_storm_special_attack_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end
function modifier_storm_special_attack_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_storm_special_attack_thinker:OnCreated(params)
    if IsServer() then
        self.caster = self:GetCaster()
        self.origin = self:GetParent():GetAbsOrigin()
        self.radius = 300;
        self.isProvidedByAura = params.isProvidedByAura

        if not self.isProvidedByAura then
            CreateRadiusMarker(self.caster, self.origin, self.radius, RADIUS_SCOPE_PUBLIC, 0.1)
            CreateTimedRadiusMarker(self.caster, self.origin, self.radius, self:GetDuration(), 0.2, RADIUS_SCOPE_PUBLIC)
        end
    end
end