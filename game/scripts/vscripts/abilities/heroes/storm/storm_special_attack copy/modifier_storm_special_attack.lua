modifier_storm_special_attack = class({})

function modifier_storm_special_attack:OnCreated(params)
    if IsServer() then
        self.caster = self:GetAbility():GetCaster()
        self.radius = self:GetAbility():GetSpecialValueFor('radius')
        self:OnIntervalThink()
        self:StartIntervalThink(0.5)
    end
end

function modifier_storm_special_attack:OnIntervalThink()
    CreateRadiusMarker(self.caster, self:GetParent():GetAbsOrigin(), self.radius, RADIUS_SCOPE_PUBLIC, 0.1)
end

function modifier_storm_special_attack:GetStatusLabel() return "Electric Vortex" end
function modifier_storm_special_attack:GetStatusPriority() return 1 end
function modifier_storm_special_attack:GetStatusStyle() return "StormUnleashed" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_storm_special_attack)