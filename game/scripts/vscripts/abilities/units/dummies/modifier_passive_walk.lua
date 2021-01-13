modifier_passive_walk = class({})

function modifier_passive_walk:OnCreated(params)
    if IsServer() then
        self.direction = Vector(1, 0, 0)
        self:StartIntervalThink(3.0)
    end
end

function modifier_passive_walk:OnIntervalThink()
    local new_origin = self:GetParent():GetAbsOrigin() + self.direction * 500 
    self:GetParent():MoveToPosition(new_origin)
    self.direction = Vector(self.direction.x * -1, self.direction.y, self.direction.z)
end