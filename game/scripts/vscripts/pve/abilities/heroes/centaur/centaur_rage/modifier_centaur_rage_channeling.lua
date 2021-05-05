modifier_centaur_rage_channeling = class({})

function modifier_centaur_rage_channeling:OnCreated(params)
    if IsServer() then
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.team = self.caster:GetTeamNumber()
        self.radius = self.ability:GetSpecialValueFor("radius")
        self.count = 7
        self.angle_diff = 360/self.count
        self:OnIntervalThink()
        self:StartIntervalThink(1.0)
    end
end

function modifier_centaur_rage_channeling:OnIntervalThink()
    self.caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.5)
    local origin = self.caster:GetAbsOrigin()

    for i = 0, self.count - 1 do
        local direction = RotatePosition(Vector(0,0,0), QAngle(0, 200 + self.angle_diff * i, 0), Vector(1,0,0))
        local previous_range = 0

        for j = 0,1 do
            local range = previous_range + RandomInt(self.radius * 2, 1000)
            local point = RotatePosition(origin, QAngle(0, self.angle_diff * i, 0), origin + Vector(range, 0, 0))

            CreateModifierThinker(
                self.caster, --hCaster
                self.ability, --hAbility
                "modifier_centaur_rage_thinker", --modifierName
                { sound = j },
                point, --vOrigin
                self.team, --nTeamNumber
                false --bPhantomBlocker
            )

            previous_range = range
        end
    end
end

function modifier_centaur_rage_channeling:OnDestroy()
    if IsServer() then
        self.ability:StartCooldown(self.ability:GetCooldown(0))
        self.caster:FadeGesture(ACT_DOTA_CAST_ABILITY_1)
    end
end

function modifier_centaur_rage_channeling:GetStatusLabel() return "Ultimate" end
function modifier_centaur_rage_channeling:GetStatusPriority() return 5 end
function modifier_centaur_rage_channeling:GetStatusStyle() return "Ultimate" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Channeling(modifier_centaur_rage_channeling)
Modifiers.Status(modifier_centaur_rage_channeling)
