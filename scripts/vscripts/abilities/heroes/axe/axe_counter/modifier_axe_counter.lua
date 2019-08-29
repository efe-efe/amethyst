modifier_axe_counter = class({})
LinkLuaModifier( "modifier_axe_counter_buff", "abilities/heroes/axe/axe_counter/modifier_axe_counter_buff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_counter:IsHidden()
	return false
end

function modifier_axe_counter:IsDebuff()
	return false
end

function modifier_axe_counter:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_axe_counter:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_axe_counter:OnCreated( kv )
    if IsServer() then
        self.buff_duration = self:GetAbility():GetSpecialValueFor("buff_duration")
        -- Can't move
        self:GetParent():SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)
    end
end

--------------------------------------------------------------------------------
-- On destroy
function modifier_axe_counter:OnDestroy( kv )
    if IsServer() then
    -- Can move again
        self:GetParent():SetMoveCapability(DOTA_UNIT_CAP_MOVE_GROUND)
    end
end

function modifier_axe_counter:GetModifierIncomingDamage_Percentage( params )
    if IsServer() then
		local parent = self:GetParent()
        local attacker = params.attacker

        PrintTable(params)

        -- Pure damage doesnt trigger the counter
        if params.damage_type ~= DAMAGE_TYPE_PURE then
            parent:AddNewModifier(
                parent, -- player source
                self:GetAbility(), -- ability source
                "modifier_axe_counter_buff", -- modifier name
                { duration = self.buff_duration } -- kv
            )
            self:Destroy()
            return -100
        end
        return 0
	end
end

-- Status Effects
function modifier_axe_counter:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}

	return state
end

-- Graphics & Animations
function modifier_axe_counter:GetStatusEffectName()
	return "particles/status_fx/status_effect_guardian_angel.vpcf"
end