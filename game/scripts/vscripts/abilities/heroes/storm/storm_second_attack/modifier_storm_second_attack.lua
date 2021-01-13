modifier_storm_second_attack = class({})

function modifier_storm_second_attack:OnCreated(params)
    self.stun_duration = self:GetAbility():GetSpecialValueFor('stun_duration')
    if IsServer() then
        local interval_think = self:GetAbility():GetSpecialValueFor('interval_think')
        self:StartIntervalThink(1.0)
		self.damage_table = {
			attacker = self:GetCaster(),
			damage = self:GetAbility():GetSpecialValueFor("damage_per_tick"),
            damage_type = DAMAGE_TYPE_PURE,
            victim = self:GetParent()
		}
    end
end

function modifier_storm_second_attack:OnIntervalThink()
    ApplyDamage(self.damage_table)
    EmitSoundOn("Hero_StormSpirit.StaticRemnantExplode", self:GetParent())

    EFX('particles/econ/events/ti9/shivas_guard_ti9_impact.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), {
        release = true
    })

    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), 'modifier_generic_stunned', { duration = self.stun_duration })
end

function modifier_storm_second_attack:GetStatusLabel() return "Unstable Energy" end
function modifier_storm_second_attack:GetStatusPriority() return 4 end
function modifier_storm_second_attack:GetStatusStyle() return "Counter" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_storm_second_attack)