modifier_hero_base = class({})
LinkLuaModifier("modifier_hero_movement", "abilities/base/modifier_hero_movement", LUA_MODIFIER_MOTION_NONE)

local DEBUG = false

local EAST = Vector(1, 0, 0)
local WEST = Vector(-1, 0, 0)
local NORTH = Vector(0, 1, 0)
local SOUTH = Vector(0, -1, 0)

local NORTH_EAST = Vector(1, 1, 0)
local NORTH_WEST = Vector(-1, 1, 0)
local SOUTH_EAST = Vector(1, -1, 0)
local SOUTH_WEST = Vector(-1, -1, 0)

function modifier_hero_base:IsHidden() 			return	true	end
function modifier_hero_base:IsDebuff() 			return	false	end
function modifier_hero_base:IsPurgable() 		return	false	end
function modifier_hero_base:RemoveOnDeath() 	return	false	end

function modifier_hero_base:OnCreated()
	if IsServer() then
		self.parent = self:GetParent()
		self:StartIntervalThink(0.03)
	end
end

function modifier_hero_base:OnIntervalThink()
	local direction = self.parent:GetDirection()
	local speed = self.parent:GetIdealSpeed() / 25

	if direction.x ~= 0 and direction.y ~= 0 then
		speed = speed * 0.75
	end

	if self.parent:IsAnimating() then
		self.parent:RemoveModifierByName("modifier_hero_movement")
	end

	if (direction.x ~= 0 or direction.y ~= 0) and self.parent:CanWalk() then
		if not self:Move(direction, speed) then
			local alternative_directions = self:AlternatieDirections(direction)
			
			for _,alt_direction in pairs(alternative_directions) do
				if self:Move(alt_direction, speed/2) then
					break
				end
			end
		end

		if 	not self.parent:HasModifier("modifier_casting") and 
			not self.parent:HasModifier("modifier_mars_counter_countering") and 
			not self.parent:HasModifier("modifier_spectre_counter_countering")
		then 
			self.parent:FaceTowardsCustom(direction)
		end
	else
		self.parent:RemoveModifierByName("modifier_hero_movement")
	end

	self:PickupItems()

	if IsInToolsMode() and DEBUG then
		local mouse = GameRules.GameMode.players[self.parent:GetPlayerID()].cursor_position

		DebugDrawLine_vCol(self.parent:GetAbsOrigin(), self.parent:GetAbsOrigin() + self.parent:GetForwardVector() * 500, Vector(0,0,255), true, 0.03)
		DebugDrawLine_vCol(self.parent:GetAbsOrigin(), mouse, Vector(0,255,0), true, 0.03)
	end
end

function modifier_hero_base:PickupItems()
	local drop_items = Entities:FindAllByClassnameWithin("dota_item_drop", self.parent:GetAbsOrigin(), self.parent:GetHullRadius() * 2.5)
	for _,drop_item in pairs(drop_items) do
		
		local item = drop_item:GetContainedItem()
		local owner = item:GetPurchaser()
		
		--Only pickup items owned by teammates
		if owner ~= nil then
			if self.parent:IsAlly(owner) then
				self.parent:PickupDroppedItem(drop_item)
			end
		else
			self.parent:PickupDroppedItem(drop_item)
		end
	end
end

function modifier_hero_base:Move(vDirection, iSpeed)
	local offset = 			70
	local origin = 			self.parent:GetAbsOrigin()
	local future_origin = 	origin + (vDirection * iSpeed)
	local test_origin = 	future_origin + vDirection * offset
	future_origin.z = 		GetGroundPosition(future_origin, self.parent).z
	
	if IsInToolsMode() and DEBUG then
		DebugDrawLine_vCol(future_origin, test_origin, Vector(255,0,0), true, 0.03)
		DebugDrawCircle(future_origin, Vector(255,0,0), 5, offset, false, 0.03)
	end

	if self.parent:HasModifier("modifier_spectre_special_attack_buff") then
		self.parent:SetAbsOrigin(future_origin)
		return true
	end

	if GridNav:IsTraversable(test_origin) then
		if not self.parent:IsPhased() then
			local units = FindUnitsInRadius(
				self.parent:GetTeamNumber(), -- int, your team number
				test_origin, -- point, center point
				nil, -- handle, cacheUnit. (not known)
				5, -- float, radius. or use FIND_UNITS_EVERYWHERE
				DOTA_UNIT_TARGET_TEAM_BOTH, -- int, team filter
				DOTA_UNIT_TARGET_ALL,	-- int, type filter
				DOTA_UNIT_TARGET_FLAG_NONE, -- int, flag filter
				FIND_ANY_ORDER, -- int, order filter
				false -- bool, can grow cache
			)
		
			for _,unit in pairs(units) do
				if unit ~= self.parent then
					if not unit:IsPhased() then
						return false
					end
				end
			end
		end

		if not self.parent:IsAnimating() then
			if not self.parent:HasModifier("modifier_hero_movement") then
				self.parent:AddNewModifier(self.parent, nil, "modifier_hero_movement", {})
			end
		end
		self.parent:SetAbsOrigin(future_origin)
		return true
	else
		return false
	end
end

function modifier_hero_base:AlternatieDirections(vDirection)
	local directions = {}
	if vDirection == NORTH_EAST then
		table.insert(directions, NORTH)
		table.insert(directions, EAST)
	end 
	if vDirection == NORTH_WEST then
		table.insert(directions, NORTH)
		table.insert(directions, WEST)
	end 
	if vDirection == SOUTH_EAST then
		table.insert(directions, SOUTH)
		table.insert(directions, EAST)
	end 
	if vDirection == SOUTH_WEST then
		table.insert(directions, SOUTH)
		table.insert(directions, WEST)
 	end 
	if vDirection == EAST or vDirection == WEST then
		if self.parent:GetAbsOrigin().y < 0 then
			table.insert(directions, SOUTH)
		end
		
		if self.parent:GetAbsOrigin().y > 0 then
			table.insert(directions, NORTH)
		end
	end 
	if vDirection == NORTH or vDirection == SOUTH then
		if self.parent:GetAbsOrigin().x < 0 then
			table.insert(directions, WEST)
		end
		if self.parent:GetAbsOrigin().x > 0 then
			table.insert(directions, EAST)
		end
	end

	return directions
end

function modifier_hero_base:CheckState() 		
	return { 
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true 
	} 
end

function modifier_hero_base:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
    }
end

function modifier_hero_base:GetDisableAutoAttack()						return true	end
function modifier_hero_base:GetModifierIgnoreMovespeedLimit(params)		return 1	end

