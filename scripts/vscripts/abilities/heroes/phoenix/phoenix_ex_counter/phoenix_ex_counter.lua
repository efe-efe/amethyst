phoenix_ex_counter = class({})
LinkLuaModifier( "modifier_phoenix_ex_counter", "abilities/heroes/phoenix/phoenix_ex_counter/modifier_phoenix_ex_counter", LUA_MODIFIER_MOTION_NONE )

function phoenix_ex_counter:OnSpellStart()
    local caster = self:GetCaster()

    caster:AddNewModifier(
        caster,
        self,
        "modifier_phoenix_ex_counter",
        {}
    )
    
    -- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("phoenix_counter")
	alternate_version:StartCooldown(self:GetCooldown(0))
end