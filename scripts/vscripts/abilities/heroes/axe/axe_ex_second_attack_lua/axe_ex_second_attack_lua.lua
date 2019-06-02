
axe_ex_second_attack_lua = class({})
LinkLuaModifier( "modifier_axe_ex_second_attack_lua", "abilities/heroes/axe/axe_ex_second_attack_lua/modifier_axe_ex_second_attack_lua", LUA_MODIFIER_MOTION_NONE )

function axe_ex_second_attack_lua:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(
        caster,
        self,
        "modifier_axe_ex_second_attack_lua",
        { duration = duration }
    )

    self:PlayEffects()
end

function axe_ex_second_attack_lua:PlayEffects()
    local caster = self:GetCaster()

    -- Create Sound
    local sound_cast = "Hero_Sven.GreatCleave.ti7"
    EmitSoundOn(sound_cast, caster)
    
end


