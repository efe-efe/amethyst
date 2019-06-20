modifier_wisp_counter = class({})
LinkLuaModifier( "modifier_wisp_counter_buffs", "abilities/heroes/wisp/wisp_counter/modifier_wisp_counter_buffs", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Classifications
function modifier_wisp_counter:IsHidden()
	return false
end

function modifier_wisp_counter:IsDebuff()
	return false
end

function modifier_wisp_counter:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wisp_counter:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_counter:OnCreated( kv )
    if IsServer() then
        self.buff_duration = self:GetAbility():GetSpecialValueFor("buff_duration")
        -- Can't move
        self:GetParent():SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)
    end
end

--------------------------------------------------------------------------------
-- On destroy
function modifier_wisp_counter:OnDestroy( kv )
    if IsServer() then
    -- Can move again
        self:GetParent():SetMoveCapability(DOTA_UNIT_CAP_MOVE_GROUND)
    end
end

function modifier_wisp_counter:GetModifierIncomingDamage_Percentage( params )
    if IsServer() then
		local parent = self:GetParent()
        local attacker = params.attacker

        -- Pure damage doesnt trigger the counter
        if params.damage_type ~= DAMAGE_TYPE_PURE then
            parent:AddNewModifier(
                parent, -- player source
                self:GetAbility(), -- ability source
                "modifier_wisp_counter_buffs", -- modifier name
                { duration = self.buff_duration } -- kv
            )
            self:Destroy()
            return -100
        end
        return 0
	end
end

-- Status Effects
function modifier_wisp_counter:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}

	return state
end

-- Graphics & Animations
function modifier_wisp_counter:GetEffectName()
	return "particles/mod_units/heroes/hero_wisp/wisp_relocate_channel.vpcf"
end

function modifier_wisp_counter:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end