modifier_casting = class({})

local translate = {
	["odachi"] = 1,
	["sharp_blade"] = 2,
	["aggressive"] = 3,
	["attack_close_range"] = 4,
	["ti10_taunt"] = 5,
	["overload"] = 6,
	["ti8"] = 7
}

function modifier_casting:IsHidden() return true end	

function modifier_casting:OnCreated(params)
    if IsServer() then
		self.movement_speed = params.movement_speed
		self.ignore_activation_cycle = params.ignore_activation_cycle
		
		self.parent = self:GetParent()
		self:StartIntervalThink(0.03)

		if params.translate then
			self:SetStackCount(translate[params.translate])
		end

		if not self.ignore_activation_cycle then
			for i = 0, 10 do
				local ability = self.parent:GetAbilityByIndex(i)
				if ability and ability ~= self:GetAbility() then
					ability:SetActivated(false)
				end
			end
		end
	end
end

function modifier_casting:OnDestroy()
	if IsServer() then
		if not self.ignore_activation_cycle then
			for i = 0, 10 do
				local ability = self.parent:GetAbilityByIndex(i)
				if ability and ability ~= self:GetAbility() then
					ability:SetActivated(true)
				end
			end
		end

		if self:GetRemainingTime() > 0.05 then
			if not self:GetAbility():IsBasicAttack() then
				self:GetAbility():StartCooldown(0.5)
			end
		end
	end
end

function modifier_casting:OnIntervalThink()
	if not self.parent:IsAlive() then
		self:Destroy()
	end
		
    local mouse = self:GetAbility():GetCursorPosition()
	local direction = (mouse - self.parent:GetAbsOrigin()):Normalized()

	self.parent:FaceTowardsCustom(Vector(direction.x, direction.y, self.parent:GetForwardVector().z))
end

function modifier_casting:DeclareFunctions()
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS, MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_casting:GetActivityTranslationModifiers(params)
	for k,v in pairs(translate) do
		if self:GetStackCount() == v then
			return k
		end
	end
end

function modifier_casting:GetModifierMoveSpeedBonus_Percentage()
	if self.movement_speed ~= nil and self.movement_speed ~= 0 then
		return - (100 - self.movement_speed)
	end
end

function modifier_casting:CheckState()
	if self.movement_speed == 0 then
		return { [MODIFIER_STATE_ROOTED] = true }
	else
		return {}
	end
end

function modifier_casting:GetStatusEnabled() 
	if self:GetAbility():GetAbilityType() == 1 then
		return true
	end 
end
function modifier_casting:GetStatusLabel() return "Ultimate" end
function modifier_casting:GetStatusPriority() return 5 end
function modifier_casting:GetStatusStyle() return "Ultimate" end
function modifier_casting:GetStatusContentType() return STATUS_CONTENT_FILLUP end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_casting)