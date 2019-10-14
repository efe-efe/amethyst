modifier_generic_movement = class({})
local DEBUG = true
local DEBUG_RADIUS = 40
local DEBUG_RADIUS_MINI = 10
local RED = Vector(255, 0, 0)
local GREEN = Vector(0, 255, 0)
local BLUE = Vector(0, 0, 255)

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
	-- Initialize variables (to not be generated on every think)
	self.frame = 0.00
	self.parent = self:GetParent()
	self.max_diff_z = 70

	if IsServer() then
		self.previous_speed = self:GetParent():GetIdealSpeed() / 100
		self:StartIntervalThink( 0.01 )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_generic_movement:OnIntervalThink()
    CustomGameEventManager:Send_ServerToAllClients("getMousePosition", {})
	
	------------------------
	-- Pickup items
	------------------------
	self:ItemsPickup(self.parent)

	local current_animation_modifier = self.parent:FindModifierByName("modifier_animation")
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
	if 	self.parent:IsStunned() or 
		self.parent:IsCommandRestricted() or 
		not self.parent:IsAlive() or 
		self.parent:IsRooted() or
		self.parent:IsNightmared()
	then
		if current_animation == "walking" then
			GameRules.EndAnimation(self.parent)
		end
		return
	end

	local speed = self.parent:GetIdealSpeed() / 100
	local origin = self.parent:GetAbsOrigin()
	local direction = Vector(
		self.parent.direction.x, 
		self.parent.direction.y, 
		self.parent:GetForwardVector().z
	)
	------------------------
	-- If Moving
	------------------------
	if self.parent.direction.x ~= 0 or self.parent.direction.y ~= 0 then
		-- Control diagonals
		if self.parent.direction.x ~= 0 and self.parent.direction.y ~= 0 then
			speed = speed * 0.75
		end

		-- Future position (if pass the z test)
		local future_position = origin + direction * speed 
		local facing_point = origin + direction * 1000 

		local future_z = GetGroundPosition(future_position, self.parent).z	-- To detect height differences
		future_position.z = future_z
	
		-- Test position, where to test the z
		local test_position = origin + direction * speed * 7 
		local test_z = GetGroundPosition(test_position, self.parent).z
		--test_position.z = test_z

		-- Test position, where to test the z
		local test_position_a = test_position + DEBUG_RADIUS * Vector(1, 0, 0)
		local test_z_a = GetGroundPosition(test_position_a, self.parent).z
		

		local test_position_b = test_position + DEBUG_RADIUS * Vector(-1, 0, 0)
		local test_z_b = GetGroundPosition(test_position_b, self.parent).z

		local test_position_c = test_position + DEBUG_RADIUS * Vector(0, 1, 0)
		local test_z_c = GetGroundPosition(test_position_c, self.parent).z

		local test_position_d = test_position + DEBUG_RADIUS * Vector(0, -1, 0)
		local test_z_d = GetGroundPosition(test_position_d, self.parent).z

		if DEBUG then 
			test_position_a.z = test_z_a 
			test_position_b.z = test_z_b
			test_position_c.z = test_z_c
			test_position_d.z = test_z_d

			DebugDrawCircle(future_position, RED, 5, DEBUG_RADIUS, false, 0.01)
			DebugDrawCircle(test_position, GREEN, 5, DEBUG_RADIUS, false, 0.01)
			DebugDrawCircle(test_position_a, BLUE, 5, DEBUG_RADIUS_MINI, false, 0.01)
			DebugDrawCircle(test_position_b, BLUE, 5, DEBUG_RADIUS_MINI, false, 0.01)
			DebugDrawCircle(test_position_c, BLUE, 5, DEBUG_RADIUS_MINI, false, 0.01)
			DebugDrawCircle(test_position_d, BLUE, 5, DEBUG_RADIUS_MINI, false, 0.01)

			local units = FindUnitsInRadius( 
				self.parent:GetTeamNumber(), -- int, your team number
				test_position, -- point, center point
				nil, -- handle, cacheUnit. (not known)
				DEBUG_RADIUS, -- float, radius. or use FIND_UNITS_EVERYWHERE
				DOTA_UNIT_TARGET_TEAM_BOTH, -- int, team filter
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
				0, -- int, flag filter
				0, -- int, order filter
				false -- bool, can grow cache
			)

			for _,unit in pairs(units) do
				if unit ~= self.parent then
					print(unit:GetName())
					unit.direction.x = unit.direction.x + 1
				end
			end
		end

		-- If not casting
		if not self.parent:HasModifier("modifier_cast_point") and not self.parent:HasModifier("modifier_cast_point_new") then --THIS CAN END BEFORE THE ACTUAL ANIMATION
			--self.parent:FaceTowards(facing_point)
			self.parent:SetForwardVector(direction)
		else
			self.frame = 0.00
		end

		if self.parent:HasModifier("modifier_spectre_special_attack_buff") then
			self.parent:SetAbsOrigin(future_position)
		else
			if 	math.abs(test_z - origin.z) < self.max_diff_z and
				math.abs(test_z_a - origin.z) < self.max_diff_z and
				math.abs(test_z_b - origin.z) < self.max_diff_z and
				math.abs(test_z_c - origin.z) < self.max_diff_z and
				math.abs(test_z_d - origin.z) < self.max_diff_z
			then
				self.parent:SetAbsOrigin(future_position)
			end
		end


		-- If not animating
		if current_animation_modifier == nil then
			self.frame = self.frame + 0.01
			if self.frame >= 0.1 then
				self:Animate( speed, self.parent )
			end
		elseif current_animation_modifier == "walking" then
			-- Check for running annimation
			if self.previous_speed ~= speed then
				self:Animate( speed, self.parent )
				self.previous_speed = speed
			end
		end
	------------------------
	-- If NOT moving
	------------------------
	else
		-- If not animating an spell
		if current_animation == "walking" then
			GameRules.EndAnimation(self.parent)
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

function modifier_generic_movement:Animate( speed, hUnit )
	if speed > 5 then 
		StartAnimation(hUnit, {
			duration=100,
			translate="haste",
			activity=ACT_DOTA_RUN, 
			rate=1.3, 
			base=1
		})
	else
		StartAnimation(hUnit, {
			duration=100, 
			activity=ACT_DOTA_RUN, 
			rate=1.0, 
			base=1
		})
	end
end