phoenix_ex_ultimate = class({})
LinkLuaModifier("modifier_phoenix_ex_ultimate", "abilities/heroes/phoenix/phoenix_ex_ultimate/modifier_phoenix_ex_ultimate", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_ex_ultimate_visuals", "abilities/heroes/phoenix/phoenix_ex_ultimate/modifier_phoenix_ex_ultimate_visuals", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Ability Start
function phoenix_ex_ultimate:OnSpellStart()
    --load data
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    
    caster:AddNewModifier(
        caster,
        self,
        "modifier_phoenix_ex_ultimate",
        { duration = duration }
   )
        
    caster:AddNewModifier(
        caster,
        self,
        "modifier_phoenix_ex_ultimate_visuals",
        { duration = duration }
   )

    EmitSoundOn("Hero_Phoenix.SunRay.Cast", caster)
end


