item_clarity_custom = class({})
LinkLuaModifier( "modifier_item_clarity_custom", "items/item_clarity_custom/modifier_item_clarity_custom", LUA_MODIFIER_MOTION_NONE )

function item_clarity_custom:OnSpellStart()
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_clarity_custom", {duration = self:GetSpecialValueFor("duration")})
    self:PlayEffects()
end

function item_clarity_custom:PlayEffects()
    EmitSoundOn( "DOTA_Item.ClarityPotion.Activate", self:GetCaster()  )
end