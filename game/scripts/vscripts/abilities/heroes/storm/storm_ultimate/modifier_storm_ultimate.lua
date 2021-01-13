modifier_storm_ultimate = class({})

function modifier_storm_ultimate:OnCreated(params)
    self.mana_multiplier = self:GetAbility():GetSpecialValueFor("mana_multiplier")
end


function modifier_storm_ultimate:OnDestroy()
    if IsServer() then
        EFX('particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), { 
            release = true 
        })
    end
end

function modifier_storm_ultimate:GetManaMultiplier()
    return self.mana_multiplier
end

function modifier_storm_ultimate:GetEffectName()
    return "particles/storm/storm_ultimate.vpcf"
end

function modifier_storm_ultimate:GetStatusLabel() return "Storm Unleashed" end
function modifier_storm_ultimate:GetStatusPriority() return 1 end
function modifier_storm_ultimate:GetStatusStyle() return "StormUnleashed" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_storm_ultimate)