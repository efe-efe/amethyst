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
        local origin  = self:GetParent():GetOrigin()

        -- find enemies
        local enemies = FindUnitsInRadius( 
            self:GetParent():GetTeamNumber(), -- int, your team number
            origin, -- point, center point
            nil, -- handle, cacheUnit. (not known)
            300, -- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
            0, -- int, flag filter
            FIND_CLOSEST, -- int, order filter
            false -- bool, can grow cache
        )

        -- find and destroy visual modifier
        local disable_attack_modifier = self:GetParent():FindModifierByNameAndCaster( 
            "modifier_disable_right_click", self:GetParent() 
        )

        if disable_attack_modifier~=nil then
            if not disable_attack_modifier:IsNull() then
                disable_attack_modifier:Destroy()
            end
        end
        
        if enemies[1]:IsRealHero() then

            local order = 
            {
                UnitIndex = self:GetParent(),
                OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                TargetIndex = enemies[1]
            }

            ExecuteOrderFromTable(order)
            self:GetParent():SetForceAttackTarget(enemies[1])
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
	return -8
end 

function modifier_spectre_ultimate_illusion_lua:GetModifierBaseAttackTimeConstant()
    return 0.4
end

function modifier_spectre_ultimate_illusion_lua:GetModifierMoveSpeed_Absolute()
    return 1000
end