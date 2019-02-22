modifier_wisp_counter_lua = class({})
LinkLuaModifier( "modifier_wisp_counter_buffs_lua", "abilities/heroes/wisp/wisp_counter_lua/modifier_wisp_counter_buffs_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Classifications
function modifier_wisp_counter_lua:IsHidden()
	return false
end

function modifier_wisp_counter_lua:IsDebuff()
	return false
end

function modifier_wisp_counter_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wisp_counter_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_counter_lua:OnCreated( kv )
    if IsServer() then
        self.buff_duration = self:GetAbility():GetSpecialValueFor("buff_duration")
        self:GetParent():SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)
    end
end

--------------------------------------------------------------------------------
-- On destroy
function modifier_wisp_counter_lua:OnDestroy( kv )
    if IsServer() then
        self:GetParent():SetMoveCapability(DOTA_UNIT_CAP_MOVE_GROUND)
    end
end

function modifier_wisp_counter_lua:GetModifierIncomingDamage_Percentage( params )
    if IsServer() then
		local parent = self:GetParent()
        local attacker = params.attacker
        
        if params.damage_type ~= DAMAGE_TYPE_PURE then
            parent:AddNewModifier(
                parent, -- player source
                self:GetAbility(), -- ability source
                "modifier_wisp_counter_buffs_lua", -- modifier name
                { duration = self.buff_duration } -- kv
            )
            self:Destroy()
            return -100
        end
        return 0
	end
end

-- Status Effects
function modifier_wisp_counter_lua:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}

	return state
end

-- Graphics & Animations
function modifier_wisp_counter_lua:GetEffectName()
	return "particles/mod_units/heroes/hero_wisp/wisp_relocate_channel.vpcf"
end

function modifier_wisp_counter_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end