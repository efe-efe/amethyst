skywrath_mage_ex_ultimate_lua = class({})
LinkLuaModifier( "modifier_skywrath_mage_ex_ultimate_lua", "abilities/heroes/skywrath_mage/skywrath_mage_ex_ultimate_lua/modifier_skywrath_mage_ex_ultimate_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function skywrath_mage_ex_ultimate_lua:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor( "duration" )
    local target = self:GetCursorTarget()
    
    target:AddNewModifier(
        caster,
        self,
        "modifier_skywrath_mage_ex_ultimate_lua",
        { duration = duration }
    )
end