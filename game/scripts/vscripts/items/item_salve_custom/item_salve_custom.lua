item_salve_custom = class({})
LinkLuaModifier( "modifier_item_salve_custom", "items/item_salve_custom/modifier_item_salve_custom", LUA_MODIFIER_MOTION_NONE )

function item_salve_custom:OnSpellStart()
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_salve_custom", {duration = self:GetSpecialValueFor("duration")})
    self:PlayEffects()
end

function item_salve_custom:PlayEffects()
    EmitSoundOn( "DOTA_Item.HealingSalve.Activate", self:GetCaster()  )
end