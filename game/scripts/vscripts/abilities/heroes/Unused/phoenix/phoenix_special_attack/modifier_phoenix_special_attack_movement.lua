modifier_phoenix_special_attack_movement = class({})
LinkLuaModifier("modifier_phoenix_special_attack_thinker_fire", "abilities/heroes/phoenix/phoenix_special_attack/modifier_phoenix_special_attack_thinker_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_projectile_enemy_blocker", "abilities/generic/modifier_generic_projectile_enemy_blocker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_projectile_special_behavior", "abilities/generic/modifier_generic_projectile_special_behavior", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Classifications
function modifier_phoenix_special_attack_movement:IsHidden() return false
end

function modifier_phoenix_special_attack_movement:IsDebuff() return false
end

function modifier_phoenix_special_attack_movement:IsStunDebuff()
	return false
end

function modifier_phoenix_special_attack_movement:IsPurgable() return false
end

-- Status Effects
function modifier_phoenix_special_attack_movement:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
--Initializer
function modifier_phoenix_special_attack_movement:OnCreated(kv)
    self.duration = 4.0
    if IsServer() then
        -- Start Interval
        self:StartIntervalThink(0.1)
    end
end

--------------------------------------------------------------------------------
--On think
function modifier_phoenix_special_attack_movement:OnIntervalThink()
    local blocker = CreateUnitByName(
        "npc_dota_creature_phoenix_blocker", -- szUnitName
        self:GetParent():GetOrigin(), -- vLocation,
        false, -- bFindClearSpace,
        self:GetParent(), -- hNPCOwner,
        nil, -- hUnitOwner,
        self:GetParent():GetTeamNumber() -- iTeamNumber
   )
    blocker:SetHullRadius(50)
    blocker:AddNewModifier(
        self:GetParent(),
        self:GetAbility(),
        "modifier_generic_projectile_special_behavior",
        { duration = self.duration }
   )
    blocker:AddNewModifier(
        self:GetParent(),
        self:GetAbility(),
        "modifier_generic_projectile_enemy_blocker",
        { duration = self.duration }
   )

	CreateModifierThinker(
		self:GetParent(), --hCaster
		self:GetAbility(), --hAbility
		"modifier_phoenix_special_attack_thinker_fire", --modifierName
		{ duration = self.duration }, --paramTable
		self:GetParent():GetOrigin(), --vOrigin
		self:GetParent():GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
   )
    
end
