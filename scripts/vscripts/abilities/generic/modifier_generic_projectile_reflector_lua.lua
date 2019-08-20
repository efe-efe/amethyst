modifier_generic_projectile_reflector_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_projectile_reflector_lua:IsHidden()
	return false
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_generic_projectile_reflector_lua:OnCreated()
end


function modifier_generic_projectile_reflector_lua:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_REFLECT_SPELL, --Lotus Orb trigger.
    }
    return funcs
end

-- TODO
function modifier_generic_projectile_reflector_lua:GetReflectSpell(kv)
    if self.stored ~= nil then
        self.stored:RemoveSelf() --we make sure to remove previous spell.
    end
    local hCaster = self:GetParent()
    local hAbility = hCaster:AddAbility(kv.ability:GetAbilityName())
    hAbility:SetStolen(true) --just to be safe with some interactions.
    hAbility:SetHidden(true) --hide the ability.
    hAbility:SetLevel(kv.ability:GetLevel()) --same level of ability as the origin.
    hCaster:SetCursorCastTarget(kv.ability:GetCaster()) --lets send this spell back.
    hAbility:OnSpellStart() --cast the spell.
    self.stored = hAbility --store the spell reference for future use.
end
