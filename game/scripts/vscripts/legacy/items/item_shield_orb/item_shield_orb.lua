item_shield_orb = class({})

function item_shield_orb:OnSpellStart()
    local damage_block = 16
    local caster = self:GetCaster()

    caster:AddNewModifier(caster, nil, "modifier_shield", { duration = 6.0, damage_block = damage_block })

    EmitSoundOn("Hero_Sven.GodsStrength.Attack", caster)
    EmitSoundOn("Hero_Abaddon.AphoticShield.Cast", caster)
end