phoenix_ultimate = class({})
LinkLuaModifier( "modifier_phoenix_ultimate", "abilities/heroes/phoenix/phoenix_ultimate/modifier_phoenix_ultimate", LUA_MODIFIER_MOTION_NONE )

function phoenix_ultimate:OnSpellStart()
    local caster = self:GetCaster()
    local base_health = caster:GetHealth()
    local duration = self:GetSpecialValueFor("duration")

    SafeDestroyModifier("modifier_phoenix_mobility_movement", caster, caster)
    caster:AddNewModifier(
        caster,
        self,
        "modifier_phoenix_ultimate",
        { 
            duration = duration,
            base_health = base_health
        }
    )
end