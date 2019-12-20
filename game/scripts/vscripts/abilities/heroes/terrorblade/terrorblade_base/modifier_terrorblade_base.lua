modifier_terrorblade_base = class({})
LinkLuaModifier( "modifier_terrorblade_normal", "abilities/heroes/terrorblade/terrorblade_base/modifier_terrorblade_normal", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_terrorblade_demon", "abilities/heroes/terrorblade/terrorblade_base/modifier_terrorblade_demon", LUA_MODIFIER_MOTION_NONE )

function modifier_terrorblade_base:OnCreated()
    self.state = "NORMAL" --demon

    if IsServer() then
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_terrorblade_normal", { first_time = 1 })
    end
end

function modifier_terrorblade_base:GetState()
    return self.state
end

function modifier_terrorblade_base:SwapState()
    if self.state == "DEMON" then
        if IsServer() then
            self:GetParent():RemoveModifierByName("modifier_terrorblade_demon")
            self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_terrorblade_normal", {})
        end
        self.state = "NORMAL"
    elseif self.state == "NORMAL" then
        if IsServer() then
            self:GetParent():RemoveModifierByName("modifier_terrorblade_normal")
            self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_terrorblade_demon", {})
        end
        self.state = "DEMON"
    end
end