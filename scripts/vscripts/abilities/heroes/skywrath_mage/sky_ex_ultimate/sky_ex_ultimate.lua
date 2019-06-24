sky_ex_ultimate = class({})
LinkLuaModifier( "modifier_sky_ex_ultimate", "abilities/heroes/skywrath_mage/sky_ex_ultimate/modifier_sky_ex_ultimate", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function sky_ex_ultimate:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor( "duration" )
    local target = self:GetCursorTarget()
    
    target:AddNewModifier(
        caster,
        self,
        "modifier_sky_ex_ultimate",
        { duration = duration }
    )
end