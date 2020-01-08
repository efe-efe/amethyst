function Amethyst:Hide()
    self:GetUnit():AddNoDraw()
    self:GetUnit():AddNewModifier(self:GetUnit(), nil, "modifier_hidden", {})
    self:GetUnit():SetAbsOrigin(Vector(0, 0, 10000))
end

function Amethyst:Unhide()
    self:GetUnit():RemoveNoDraw()
    self:GetUnit():RemoveModifierByName("modifier_hidden")
    self:GetUnit():SetAbsOrigin(Vector(self.origin.x, self.origin.y, self.origin.z))
end
