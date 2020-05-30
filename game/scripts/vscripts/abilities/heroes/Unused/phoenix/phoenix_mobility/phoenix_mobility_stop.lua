phoenix_mobility_stop = class({})

function phoenix_mobility_stop:OnSpellStart()
    local caster = self:GetCaster()

    SafeDestroyModifier("modifier_phoenix_mobility_movement", caster, caster)
end