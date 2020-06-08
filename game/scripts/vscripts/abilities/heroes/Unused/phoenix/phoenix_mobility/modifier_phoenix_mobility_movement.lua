modifier_phoenix_mobility_movement = class({})
LinkLuaModifier("modifier_phoenix_mobility_debuff", "abilities/heroes/phoenix/phoenix_mobility/modifier_phoenix_mobility_debuff", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Classifications
function modifier_phoenix_mobility_movement:IsHidden() return false
end

function modifier_phoenix_mobility_movement:IsDebuff() return false
end

function modifier_phoenix_mobility_movement:IsStunDebuff()
	return false
end

function modifier_phoenix_mobility_movement:IsPurgable() return false
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_phoenix_mobility_movement:OnCreated()
    self.fire_radius = self:GetAbility():GetSpecialValueFor("fire_radius")
    self.fire_duration = self:GetAbility():GetSpecialValueFor("fire_duration")
	if IsServer() then
        self:StartIntervalThink(0.1)
    end
end


function modifier_phoenix_mobility_movement:OnDestroy()
	if IsServer() then
		-- Swap abilities back to normality
		self:GetParent():SwapAbilities(
			"phoenix_mobility",
			"phoenix_mobility_stop",
			true,
			false
		)
		
        self:StartIntervalThink(0.3)
	end
end

-- Status Effects
function modifier_phoenix_mobility_movement:CheckState()
	local state = {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end


function modifier_phoenix_mobility_movement:OnIntervalThink()
	local enemies = FindUnitsInRadius(
        self:GetParent():GetTeamNumber(), -- int, your team number
        self:GetParent():GetOrigin(), -- point, center point
        nil, -- handle, cacheUnit. (not known)
        self.fire_radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        0, -- int, flag filter
        0, -- int, order filter
        false -- bool, can grow cache
   )

    for _,enemy in pairs(enemies) do
        if not enemy:HasModifier("modifier_phoenix_mobility_debuff") then
            enemy:AddNewModifier(
                self:GetParent(),
                self:GetAbility(),
                "modifier_phoenix_mobility_debuff",
                { duration = self.fire_duration }
           )
        end
	end
end