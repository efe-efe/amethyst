item_shield_orb = class({})

function item_shield_orb:OnSpellStart()
    local damage_block = 8
    local caster = self:GetCaster()

    caster:AddNewModifier(caster, nil, "modifier_shield", { duration = 5.0, damage_block = damage_block })

    EmitSoundOn("DOTA_Item.ClarityPotion.Activate", caster)
end