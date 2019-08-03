modifier_generic_movement = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_movement:IsHidden()
	return false
end

function modifier_generic_movement:IsDebuff()
	return false
end

function modifier_generic_movement:IsStunDebuff()
	return false
end

function modifier_generic_movement:IsPurgable()
	return false
end

function modifier_generic_movement:RemoveOnDeath()
    return false
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_generic_movement:OnCreated(params)
	self.frame = 0.00
	if IsServer() then
		self:StartIntervalThink( 0.01 )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_generic_movement:OnIntervalThink()
	local parent = self:GetParent()

	------------------------
	-- Items pickup
	------------------------
	local items = Entities:FindAllByClassnameWithin("dota_item_drop", parent:GetOrigin(), parent:GetHullRadius() * 2.5)

	for _,item in pairs(items) do
		parent:PickupDroppedItem(item)
	end

	local current_animation_modifier = parent:FindModifierByName("modifier_animation")
	local current_animation = "not_walking"

	if current_animation_modifier ~= nil then
		if current_animation_modifier.keys.base ~= nil then
			if current_animation_modifier.keys.base == 1 then
				current_animation = "walking"
			end
		end
	end

	------------------------
	-- Disable conditions
	------------------------
	if parent:IsStunned() or parent:IsCommandRestricted() or not parent:IsAlive() then
		if current_animation == "walking" then
			GameRules.EndAnimation(parent)
		end
		return
	end

	local speed = parent:GetIdealSpeed() / 100
	local origin = parent:GetAbsOrigin()
	local direction = Vector(parent.direction.x, parent.direction.y, parent:GetForwardVector().z)
	local future_position = origin + direction * speed 
	local future_z = GetGroundPosition(future_position, parent).z

	local test_position = origin + direction * 70 
	local future_z_test = GetGroundPosition(test_position, parent).z

	------------------------
	-- If Moving
	------------------------
	if parent.direction.x ~= 0 or parent.direction.y ~= 0 then
		-- Control diagonals
		if parent.direction.x ~= 0 and parent.direction.y ~= 0 then
			speed = speed * 0.75
		end

		local target = origin + direction * speed
		target.z = future_z

		if math.abs(future_z_test - origin.z) < 50 then
			parent:SetAbsOrigin(target)
		end

		-- If not casting
		if not parent:HasModifier("modifier_generic_pseudo_cast_point") then --THIS CAN END BEFORE THE ACTUAL ANIMATION
			parent:SetForwardVector(direction)
		else
			self.frame = 0.00
		end

		-- If not animating
		if current_animation_modifier == nil then
			self.frame = self.frame + 0.01
			if self.frame >= 0.1 then
				StartAnimation(parent, {duration=100, activity=ACT_DOTA_RUN, rate=1.0, base=1})
			end
		end
	------------------------
	-- If NOT moving
	------------------------
	else
		-- If not animating an spell
		if current_animation == "walking" then
			GameRules.EndAnimation(parent)
			self.frame = 0.00
		end
	end
end
