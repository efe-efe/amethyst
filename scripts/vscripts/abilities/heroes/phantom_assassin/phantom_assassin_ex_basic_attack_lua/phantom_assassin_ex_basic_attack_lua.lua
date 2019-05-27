phantom_assassin_ex_basic_attack_lua = class({})

LinkLuaModifier("modifier_phantom_assassin_ex_basic_attack_lua", "abilities/heroes/phantom_assassin/phantom_assassin_ex_basic_attack_lua/modifier_phantom_assassin_ex_basic_attack_lua", LUA_MODIFIER_MOTION_NONE)

function phantom_assassin_ex_basic_attack_lua:OnSpellStart()
    local caster = self:GetCaster()

    caster:AddNewModifier(
        caster,
        self,
        "modifier_phantom_assassin_ex_basic_attack_lua",
        {}
    )
end