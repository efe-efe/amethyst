nevermore_counter = class({})
LinkLuaModifier( "modifier_nevermore_counter", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_counter:OnSpellStart()
    --load data
    local caster = self:GetCaster()
    local duration = self:GetDuration()

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_nevermore_counter", -- modifier name
        { duration = duration } -- kv
    )

end
