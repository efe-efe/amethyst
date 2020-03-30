modifier_generic_movement = class({})

local DEBUG = false

local RADIUS_BIG = 40
local RADIUS_MINI = 5

local COLLIDE_OFFSET = 4
local COLLIDE_OFFSET_MINI = 1

local COLLIDE_SLOW_FACTOR = 1.5
local COLLIDE_SUPER_SLOW_FACTOR = 5.0

local MAX_Z_DIFF = 80
local MIN_Z_DIFF = 0

local RED = Vector(255, 0, 0)
local GREEN = Vector(0, 255, 0)
local BLUE = Vector(0, 0, 255)
local YELLOW = Vector(255, 255, 0)
local PURPLE = Vector(255, 0, 255)
local SKYBLUE = Vector(0, 255, 255)

local EAST = Vector(1, 0, 0)
local WEST = Vector(-1, 0, 0)
local NORTH = Vector(0, 1, 0)
local SOUTH = Vector(0, -1, 0)

local NORTH_EAST = Vector(1, 1, 0)
local NORTH_WEST = Vector(-1, 1, 0)
local SOUTH_EAST = Vector(1, -1, 0)
local SOUTH_WEST = Vector(-1, -1, 0)


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

	if IsServer() then
		self.previous_speed = self:GetParent():GetIdealSpeed() / 100
		self:StartIntervalThink( 0.01 )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_generic_movement:OnIntervalThink()	
	self:ItemsPickup(self.parent)
	self:Move()
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
			if hUnit:IsAlly(owner) then
				hUnit:PickupDroppedItem(drop_item)
			end
		else
			hUnit:PickupDroppedItem(drop_item)
		end
	end
end

function modifier_generic_movement:Move()
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
	if not self.parent:CanWalk() then
		if current_animation == "walking" then
			--GameRules.EndAnimation(self.parent)
		end
		return
	end

	local speed = self.parent:GetIdealSpeed() / 76.5
	local origin = self.parent:GetAbsOrigin()
	local direction = nil

	if self.parent:IsDirectionForced() then
		direction = Vector(
			self.parent.forced_direction.x,
			self.parent.forced_direction.y,
			self.parent:GetForwardVector().z
		)
	else
		direction = Vector(
			self.parent.direction.x * (self.parent:IsConfused() and -1 or 1), 
			self.parent.direction.y * (self.parent:IsConfused() and -1 or 1), 
			self.parent:GetForwardVector().z
		)
	end
	------------------------
	-- If Moving
	------------------------
	if self.parent:IsWalking() then
		-- Control diagonals
		if direction.x ~= 0 and direction.y ~= 0 then
			speed = speed * 0.75
		end

		-- Future position (if pass the z test)
		local future_position = origin + direction * speed 
		future_position.z = GetGroundPosition(future_position, self.parent).z

		local test_position_front = origin + direction * speed * COLLIDE_OFFSET
		local colliding = self:GetColliding(test_position_front, origin.z, GREEN)

		-- If not casting
		if not self.parent:HasModifier("modifier_cast_point_old") and not self.parent:HasModifier("modifier_cast_point") then --THIS CAN END BEFORE THE ACTUAL ANIMATION
			self.parent:SetForwardVector(direction)
		else
			self.frame = 0.00
		end

		if self.parent:HasModifier("modifier_spectre_special_attack_buff") then
			self.parent:SetAbsOrigin(future_position)
		else
			if --math.abs(GetGroundPosition(test_position_front, self.parent).z - origin.z) < MAX_Z_DIFF and
				not colliding[EAST] and
				not colliding[WEST] and
				not colliding[NORTH] and
				not colliding[SOUTH]
			then
				self.parent:SetAbsOrigin(future_position)
			else
				if direction == NORTH_EAST then
					self:SubMove(colliding, origin, speed, NORTH, EAST, COLLIDE_SLOW_FACTOR)
				elseif direction == NORTH_WEST then
					self:SubMove(colliding, origin, speed, NORTH, WEST, COLLIDE_SLOW_FACTOR)
				elseif direction == SOUTH_EAST then
					self:SubMove(colliding, origin, speed, SOUTH, EAST, COLLIDE_SLOW_FACTOR)
				elseif direction == SOUTH_WEST then
					self:SubMove(colliding, origin, speed, SOUTH, WEST, COLLIDE_SLOW_FACTOR)


				elseif direction == EAST or direction == WEST then
					self:SubMove(colliding, origin, speed, SOUTH, NORTH, COLLIDE_SUPER_SLOW_FACTOR)
				elseif direction == NORTH or direction == SOUTH then
					self:SubMove(colliding, origin, speed, EAST, WEST, COLLIDE_SUPER_SLOW_FACTOR)
				end
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

function modifier_generic_movement:Animate( speed, hUnit )
	--[[if speed > 5 then 
		StartAnimation(hUnit, {
			duration=100,
			translate="haste",
			activity=ACT_DOTA_RUN, 
			rate=1.3, 
			base=1
		})
	else]]
		StartAnimation(hUnit, {
			duration=100, 
			activity=ACT_DOTA_RUN, 
			rate=1.0, 
			base=1
		})
	--end
end

function modifier_generic_movement:GetColliding(test_position_front, actual_z, color)
	local test_position_east = test_position_front + RADIUS_BIG * EAST * COLLIDE_OFFSET_MINI
	local test_position_west = test_position_front + RADIUS_BIG * WEST * COLLIDE_OFFSET_MINI
	local test_position_north = test_position_front + RADIUS_BIG * NORTH * COLLIDE_OFFSET_MINI
	local test_position_south = test_position_front + RADIUS_BIG * SOUTH * COLLIDE_OFFSET_MINI

	--[[
	print("CFP:", 
		"N", GridNav:CanFindPath(test_position_north, test_position_north) and "TRUE" or "FALS",
		"S", GridNav:CanFindPath(test_position_south, test_position_south) and "TRUE" or "FALS",
		"W", GridNav:CanFindPath(test_position_west, test_position_west) and "TRUE" or "FALS",
		"E", GridNav:CanFindPath(test_position_east, test_position_east) and "TRUE" or "FALS"
	)
	print("IST:", 
		"N", GridNav:IsTraversable(test_position_north) and "TRUE" or "FALS",
		"S", GridNav:IsTraversable(test_position_south) and "TRUE" or "FALS",
		"W", GridNav:IsTraversable(test_position_west) and "TRUE" or "FALS",
		"E", GridNav:IsTraversable(test_position_east) and "TRUE" or "FALS"
	)
	print("============================================================")
	]]

	if IsInToolsMode() and DEBUG then
		local test_z = GetGroundPosition(test_position_front, self.parent).z
		local test_z_east = GetGroundPosition(test_position_east, self.parent).z
		local test_z_west = GetGroundPosition(test_position_west, self.parent).z
		local test_z_north = GetGroundPosition(test_position_north, self.parent).z
		local test_z_south = GetGroundPosition(test_position_south, self.parent).z

		test_position_east.z = test_z_east 
		test_position_west.z = test_z_west
		test_position_north.z = test_z_north
		test_position_south.z = test_z_south


		print(test_position_front.z, self.parent:GetOrigin().z)

		--DebugDrawCircle(future_position, RED, 5, RADIUS_BIG, false, 0.01)
		DebugDrawCircle(test_position_front, color, 5, RADIUS_BIG, false, 0.01)
		DebugDrawCircle(test_position_east, BLUE, 5, RADIUS_MINI, false, 0.01)
		DebugDrawCircle(test_position_west, YELLOW, 5, RADIUS_MINI, false, 0.01)
		DebugDrawCircle(test_position_north, SKYBLUE, 5, RADIUS_MINI, false, 0.01)
		DebugDrawCircle(test_position_south, PURPLE, 5, RADIUS_MINI, false, 0.01)

		DebugDrawLine_vCol(test_position_front, test_position_front, color, true, 0.01)
		DebugDrawLine_vCol(test_position_front, test_position_east, BLUE, true, 0.01)
		DebugDrawLine_vCol(test_position_front, test_position_west, YELLOW, true, 0.01)
		DebugDrawLine_vCol(test_position_front, test_position_north, SKYBLUE, true, 0.01)
		DebugDrawLine_vCol(test_position_front, test_position_south, PURPLE, true, 0.01)


		self:Aoe(RADIUS_BIG, color, 0.01, test_position_front)
		self:Aoe(RADIUS_MINI, BLUE, 0.01, test_position_east)
		self:Aoe(RADIUS_MINI, YELLOW, 0.01, test_position_west)
		self:Aoe(RADIUS_MINI, SKYBLUE, 0.01, test_position_north)
		self:Aoe(RADIUS_MINI, PURPLE, 0.01, test_position_south)
	end

	local colliding = {}
	--[[local differences = {
		east = math.abs(test_z_east - actual_z),
		west = math.abs(test_z_west - actual_z),
		north = math.abs(test_z_north - actual_z),
		south = math.abs(test_z_south - actual_z),
	}]]

	colliding[EAST] = not GridNav:IsTraversable(test_position_east) or self:GetCollidingWithObjects(test_position_east) --differences.east > MAX_Z_DIFF or self:GetCollidingWithObjects(test_position_east) == true or differences.east < MIN_Z_DIFF
	colliding[WEST] = not GridNav:IsTraversable(test_position_west) or self:GetCollidingWithObjects(test_position_west) --differences.west > MAX_Z_DIFF or self:GetCollidingWithObjects(test_position_west) == true or differences.west < MIN_Z_DIFF
	colliding[NORTH] = not GridNav:IsTraversable(test_position_north) or self:GetCollidingWithObjects(test_position_north) --differences.north > MAX_Z_DIFF or self:GetCollidingWithObjects(test_position_north) == true or differences.north < MIN_Z_DIFF
	colliding[SOUTH] = not GridNav:IsTraversable(test_position_south) or self:GetCollidingWithObjects(test_position_south) --differences.south > MAX_Z_DIFF or self:GetCollidingWithObjects(test_position_south) == true or differences.south < MIN_Z_DIFF

	return colliding
end

function modifier_generic_movement:GetCollidingWithObjects(test_position)
	if self.parent:IsPhased() then
		return false
	end

	local units = FindUnitsInRadius( 
		self.parent:GetTeamNumber(), -- int, your team number
		test_position, -- point, center point
		nil, -- handle, cacheUnit. (not known)
		RADIUS_MINI, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_BOTH, -- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0, -- int, flag filter
		0, -- int, order filter
		false -- bool, can grow cache
	)

	for _,unit in pairs(units) do
		if unit ~= self.parent then
			if not unit:IsPhased() then
				return true
			end
		end
	end

	return false
end

function modifier_generic_movement:SubMove(colliding, origin, speed, direction_a, direction_b, slow)
	if colliding[direction_a] then
		local future_position = origin + direction_b * speed / slow
		local test_position_front = origin + direction_b * speed * COLLIDE_OFFSET
		local sub_colliding = self:GetColliding(test_position_front, origin.z, RED)
		
		if not sub_colliding[direction_b] then
			self.parent:SetAbsOrigin(future_position)
		end
	else
		local future_position = origin + direction_a * speed / slow
		local test_position_front = origin + direction_a * speed * COLLIDE_OFFSET
		local sub_colliding = self:GetColliding(test_position_front, origin.z, RED)
		
		if not sub_colliding[direction_a] then
			self.parent:SetAbsOrigin(future_position)
		end
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_movement:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_MANA_GAINED,
		MODIFIER_EVENT_ON_SPENT_MANA,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
	}

	return funcs
end

function modifier_generic_movement:GetModifierIgnoreMovespeedLimit( params )
    return 1
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_generic_movement:CheckState()
	local state = {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}

	return state
end

function modifier_generic_movement:Aoe(radius, color, duration, origin)
    local particle_cast = "particles/aoe_marker.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, origin )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 2, color )
    ParticleManager:SetParticleControl( effect_cast, 3, Vector(duration, 0, 0) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end