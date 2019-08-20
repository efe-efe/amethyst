modifier_generic_movement = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_movement:IsHidden()
	return true
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
	local max_diff_z = 60
	local debug_radius = 40
	local debug_radius_mini = 10
	
	------------------------
	-- Pickup items
	------------------------
	self:ItemsPickup(parent)

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
	if 	parent:IsStunned() or 
		parent:IsCommandRestricted() or 
		not parent:IsAlive() or 
		parent:IsRooted() or
		parent:IsNightmared()
	then
		if current_animation == "walking" then
			GameRules.EndAnimation(parent)
		end
		return
	end

	local speed = parent:GetIdealSpeed() / 100
	local origin = parent:GetAbsOrigin()
	local direction = Vector(
		parent.direction.x, 
		parent.direction.y, 
		parent:GetForwardVector().z
	)
	------------------------
	-- If Moving
	------------------------
	if parent.direction.x ~= 0 or parent.direction.y ~= 0 then
		-- Control diagonals
		if parent.direction.x ~= 0 and parent.direction.y ~= 0 then
			speed = speed * 0.75
		end

		-- Future position (if pass the z test)
		local future_position = origin + direction * speed 
		local future_z = GetGroundPosition(future_position, parent).z	-- To detect height differences
		future_position.z = future_z
	
		-- Test position, where to test the z
		local test_position = origin + direction * speed * 7 
		local test_z = GetGroundPosition(test_position, parent).z
		--test_position.z = test_z

		-- Test position, where to test the z
		local test_position_a = test_position + debug_radius * Vector(1, 0, 0)
		local test_z_a = GetGroundPosition(test_position_a, parent).z
		--test_position_a.z = test_z_a -- Not necesary, only for debug

		local test_position_b = test_position + debug_radius * Vector(-1, 0, 0)
		local test_z_b = GetGroundPosition(test_position_b, parent).z
		--test_position_b.z = test_z_b -- Not necesary, only for debug

		local test_position_c = test_position + debug_radius * Vector(0, 1, 0)
		local test_z_c = GetGroundPosition(test_position_c, parent).z
		--test_position_c.z = test_z_c -- Not necesary, only for debug

		local test_position_d = test_position + debug_radius * Vector(0, -1, 0)
		local test_z_d = GetGroundPosition(test_position_d, parent).z
		--test_position_d.z = test_z_d -- Not necesary, only for debug

		--DebugDrawCircle(future_position, Vector(255,0,0), 5, debug_radius, false, 0.01)
		--DebugDrawCircle(test_position, Vector(0,255,0), 5, debug_radius, false, 0.01)
		--DebugDrawCircle(test_position_a, Vector(0,0,255), 5, debug_radius_mini, false, 0.01)
		--DebugDrawCircle(test_position_b, Vector(0,0,250), 5, debug_radius_mini, false, 0.01)
		--DebugDrawCircle(test_position_c, Vector(0,0,250), 5, debug_radius_mini, false, 0.01)
		--DebugDrawCircle(test_position_d, Vector(0,0,250), 5, debug_radius_mini, false, 0.01)

		if parent:HasModifier("modifier_spectre_special_attack_buff") then
			parent:SetAbsOrigin(future_position)
		else
			if 	math.abs(test_z - origin.z) < max_diff_z and
				math.abs(test_z_a - origin.z) < max_diff_z and
				math.abs(test_z_b - origin.z) < max_diff_z and
				math.abs(test_z_c - origin.z) < max_diff_z and
				math.abs(test_z_d - origin.z) < max_diff_z
			then
				parent:SetAbsOrigin(future_position)
			end
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
				if speed > 5 then 
					StartAnimation(parent, {
						duration=100,
						translate="haste",
						activity=ACT_DOTA_RUN, 
						rate=1.3, 
						base=1}
					)
				else
					StartAnimation(parent, {
						duration=100, 
						activity=ACT_DOTA_RUN, 
						rate=1.0, 
						base=1}
					)
				end
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

--------------------------------------------------------------------------------
-- Helpers


function modifier_generic_movement:ItemsPickup( hUnit )
	local drop_items = Entities:FindAllByClassnameWithin("dota_item_drop", hUnit:GetOrigin(), hUnit:GetHullRadius() * 2.5)
	for _,drop_item in pairs(drop_items) do
		
		local item = drop_item:GetContainedItem()
		local owner = item:GetPurchaser()
		
		--Only pickup items owned by teammates
		if owner ~= nil then
			if owner:GetTeam() == hUnit:GetTeam() then
				hUnit:PickupDroppedItem(drop_item)
			end
		else
			hUnit:PickupDroppedItem(drop_item)
		end
	end
end

