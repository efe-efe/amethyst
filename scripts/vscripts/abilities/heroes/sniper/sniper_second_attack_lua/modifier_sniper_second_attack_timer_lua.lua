modifier_sniper_second_attack_timer_lua = class({})

function modifier_sniper_second_attack_timer_lua:OnCreated()
    self.parent = self:GetParent()
    self.parent:SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)
end

function modifier_sniper_second_attack_timer_lua:OnDestroy()
    if IsServer() then
        self.parent:SetMoveCapability(DOTA_UNIT_CAP_MOVE_GROUND)
        self.parent:SwapAbilities( 
            "sniper_second_attack_projectile_lua",
            "sniper_second_attack_lua",
            false,
            true
        )
    end
end

