modifier_generic_projectile_enemy_blocker_lua = class({})


function modifier_generic_projectile_enemy_blocker_lua:OnDestroy( kv )
    if IsServer() then
		if self:GetParent() ~= nil then
            self:GetParent():ForceKill( false )
        end
	end
end


--------------------------------------------------------------------------------
-- Status Effects
function modifier_generic_projectile_enemy_blocker_lua:CheckState()
	local state = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}

	return state
end