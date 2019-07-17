item_mana_orb = class({})

function item_mana_orb:OnSpellStart()
    local mana = 8
    local caster = self:GetCaster()
    caster:GiveMana(mana)
    SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, caster, mana, nil )
end