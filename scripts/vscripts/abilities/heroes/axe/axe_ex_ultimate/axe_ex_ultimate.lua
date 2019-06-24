axe_ex_ultimate = class({})
LinkLuaModifier( "modifier_axe_ex_ultimate", "abilities/heroes/axe/axe_ex_ultimate/modifier_axe_ex_ultimate", LUA_MODIFIER_MOTION_NONE )

function axe_ex_ultimate:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(
        caster,
        self,
        "modifier_axe_ex_ultimate",
        { duration = duration }
    )

    self:PlayEffects()
end

function axe_ex_ultimate:PlayEffects()
    local caster = self:GetCaster()

    -- Create Sound
    local sound_cast = "Hero_Sven.GreatCleave.ti7"
    EmitSoundOn(sound_cast, caster)
    
end