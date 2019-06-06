modifier_spectre_ultimate_illusion_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_spectre_ultimate_illusion_lua:IsHidden()
	return false
end

function modifier_spectre_ultimate_illusion_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_ultimate_illusion_lua:OnCreated( kv )
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

        -- Destroy the disable attack modifier
        SafeDestroyModifier("modifier_disable_right_click", parent, parent)
        
        -- Attack the closests
        if enemies[1]:IsRealHero() then
            parent:SetForceAttackTarget(enemies[1])
        end
    end
end

function modifier_spectre_ultimate_illusion_lua:OnDestroy( kv )
    if IsServer() then
        if self:GetParent() ~= nil then
            self:GetParent():ForceKill( false )
        end
	end
end

-- Status Effects
function modifier_spectre_ultimate_illusion_lua:CheckState()
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
function modifier_spectre_ultimate_illusion_lua:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
	}

	return funcs
end


function modifier_spectre_ultimate_illusion_lua:GetModifierPreAttack_BonusDamage()
	return -7
end 

function modifier_spectre_ultimate_illusion_lua:GetModifierBaseAttackTimeConstant()
    return 0.6
end

function modifier_spectre_ultimate_illusion_lua:GetModifierMoveSpeed_Absolute()
    return 1000
end