modifier_phoenix_ex_ultimate = class({})
--------------------------------------------------------------------------------
-- Classifications
function modifier_phoenix_ex_ultimate:IsDebuff()
	return false
end

function modifier_phoenix_ex_ultimate:IsStunDebuff()
	return false
end

function modifier_phoenix_ex_ultimate:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_phoenix_ex_ultimate:OnCreated()
    self.range = self:GetAbility():GetSpecialValueFor("range")
    self.movement_speed = self:GetAbility():GetSpecialValueFor("movement_speed")
    self.radius = 120
    self.heal_per_think = self:GetAbility():GetSpecialValueFor("heal_per_think")
    self.self_heal_per_think = self:GetAbility():GetSpecialValueFor("self_heal_per_think")
    self.damage_per_think = self:GetAbility():GetSpecialValueFor("damage_per_think")
    local think_interval = self:GetAbility():GetSpecialValueFor("think_interval")

    if IsServer() then
        self:StartIntervalThink(think_interval)
    end
end


function modifier_phoenix_ex_ultimate:OnDestroy()
    if IsServer() then
    end
end

function modifier_phoenix_ex_ultimate:OnIntervalThink()
    local target = self:GetParent():GetOrigin() + self:GetParent():GetForwardVector():Normalized() * self.range 

    local units = FindUnitsInLine(
		self:GetParent():GetTeamNumber(),
		self:GetParent():GetOrigin(),
		target,
		nil,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0
    )

    for _,unit in pairs(units) do
        if unit:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
            if unit == self:GetCaster() then
                unit:Heal(self.self_heal_per_think, unit)
            else
                unit:Heal(self.heal_per_think, unit)
            end
        else
            local damage = {
                victim = unit,
                attacker = self:GetCaster(),
                damage = self.damage_per_think,
                damage_type = DAMAGE_TYPE_PURE,
            }
    
            ApplyDamage( damage )
        end
    end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_phoenix_ex_ultimate:CheckState()
	local state = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING] = true,
		[MODIFIER_STATE_SILENCED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phoenix_ex_ultimate:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
        MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE,
	}

	return funcs
end

function modifier_phoenix_ex_ultimate:GetModifierMoveSpeed_Absolute()
    return self.movement_speed
end

function modifier_phoenix_ex_ultimate:GetModifierTurnRate_Percentage()
    return -300
end