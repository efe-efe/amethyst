modifier_spectre_ultimate_illusion = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_spectre_ultimate_illusion:IsHidden() return false
end

function modifier_spectre_ultimate_illusion:IsPurgable() return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_ultimate_illusion:OnCreated( kv )
    if IsServer() then
        -- references
        local parent = self:GetParent()
        local origin  = parent:GetOrigin()

        -- find enemies
        local enemies = FindUnitsInRadius( 
            parent:GetTeamNumber(), -- int, your team number
            origin, -- point, center point
            nil, -- handle, cacheUnit. (not known)
            300, -- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
            0, -- int, flag filter
            FIND_CLOSEST, -- int, order filter
            false -- bool, can grow cache
        )

        -- Attack the closests
        if enemies[1] then
            if enemies[1]:IsRealHero() then
                parent:SetForceAttackTarget(enemies[1])
            end
        end
    end
end

function modifier_spectre_ultimate_illusion:OnDestroy( kv )
    if IsServer() then
				
        self:GetCaster():SwapAbilities( 
            "spectre_ultimate",
            "spectre_ultimate_recast",
            true,
            false
        )

        if self:GetParent() ~= nil then
            self:GetParent():ForceKill( false )
        end
	end
end

-- Status Effects
function modifier_spectre_ultimate_illusion:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_PROPERTY_DISABLE_AUTOATTACK] = true,
	}

	return state
end



-- Modifier Effects
function modifier_spectre_ultimate_illusion:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
	}

	return funcs
end


function modifier_spectre_ultimate_illusion:GetModifierPreAttack_BonusDamage()
	return -7
end 

function modifier_spectre_ultimate_illusion:GetModifierBaseAttackTimeConstant()
    return 0.6
end

function modifier_spectre_ultimate_illusion:GetModifierMoveSpeed_Absolute()
    return 400
end