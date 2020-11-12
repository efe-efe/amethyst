modifier_storm_ultimate = class({})

function modifier_storm_ultimate:OnCreated(params)
    self.mana_regen = self:GetAbility():GetSpecialValueFor("mana_regen")
    if IsServer() then
        self:PlayEffectsOnCast()
    end
end


function modifier_storm_ultimate:OnDestroy()
    if IsServer() then
        self:GetParent():SetManaCustom(0.0)
        EFX('particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), { 
            release = true 
        })
    end
end

function modifier_storm_ultimate:PlayEffectsOnCast()
    EFX("particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = self:GetParent():GetAbsOrigin(),
        cp1 = self:GetParent():GetAbsOrigin() + Vector(0, 0, 1000),
        cp2 = self:GetParent():GetAbsOrigin(),
        release = true
    })
end

function modifier_storm_ultimate:GetEffectName()
    return "particles/storm/storm_ultimate.vpcf"
end

function modifier_storm_ultimate:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	}
end

function modifier_storm_ultimate:GetModifierConstantManaRegen()
    return self.mana_regen
end

function modifier_storm_ultimate:GetStatusLabel() return "Storm Unleashed" end
function modifier_storm_ultimate:GetStatusPriority() return 1 end
function modifier_storm_ultimate:GetStatusStyle() return "StormUnleashed" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_storm_ultimate)