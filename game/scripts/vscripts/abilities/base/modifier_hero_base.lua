modifier_hero_base = class({})
LinkLuaModifier("modifier_hero_movement", "abilities/base/modifier_hero_movement", LUA_MODIFIER_MOTION_NONE)

local DEBUG = false

local EAST = Vector(1, 0, 0)
local WEST = Vector(-1, 0, 0)
local NORTH = Vector(0, 1, 0)
local SOUTH = Vector(0, -1, 0)

local NO_DIRECTION =  -1
local DIAGONAL_LEFT = 0
local DIAGONAL_RIGHT = 1
local HORIZONTAL = 2
local VERTICAL = 3

local NORTH_EAST = Vector(1, 1, 0):Normalized()
local NORTH_WEST = Vector(-1, 1, 0):Normalized()
local SOUTH_EAST = Vector(1, -1, 0):Normalized()
local SOUTH_WEST = Vector(-1, -1, 0):Normalized()

local DIRECTIONS = {
	EAST = EAST,
	WEST = WEST,
	NORTH = NORTH,
	SOUTH = SOUTH,
}

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

function modifier_hero_base:GetNormal(vPosition, hUnit, fScale)
    local m_scale = fScale or 1
    local nscale = -1 * m_scale
    local zl = GetGroundPosition(vPosition + Vector(nscale,0,0), hUnit).z
    local zr = GetGroundPosition(vPosition + Vector(scale,0,0), hUnit).z
    local zu = GetGroundPosition(vPosition + Vector(0,scale,0), hUnit).z
    local zd = GetGroundPosition(vPosition + Vector(0,nscale,0), hUnit).z
    return Vector(zl - zr, zd - zu, 2 * m_scale):Normalized()
end

function modifier_hero_base:OnIntervalThink()
	local direction = self.parent:GetDirection():Normalized()
	local speed = self.parent:GetIdealSpeed() / 25

	if self.parent:IsAnimating() then
		self.parent:RemoveModifierByName("modifier_hero_movement")
	end

	if (direction.x ~= 0 or direction.y ~= 0) and self.parent:CanWalk() then
		local output = self:Move(direction, speed)
		if output ~= 'SUCCESS' then
			local alternative_directions = {}
			
			if output == 'WALL' then
				alternative_directions = self:AlternativeDirectionsWalls(direction)
			else
				alternative_directions = self:AlternativeDirections(direction)
			end	

			for _,alt_direction in pairs(alternative_directions) do
				local new_output = self:Move(alt_direction, speed * 0.8)
				if new_output == 'SUCCESS' then
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

	if self.parent:IsAlive() then
		self:PickupItems()
	end

	if IsInToolsMode() and DEBUG then
		local mouse = GameRules.GameMode.players[self.parent:GetPlayerID()].cursor_position

		DebugDrawLine_vCol(self.parent:GetAbsOrigin(), self.parent:GetAbsOrigin() + self.parent:GetForwardVector() * 500, Vector(0,0,255), true, 0.03)
		DebugDrawLine_vCol(self.parent:GetAbsOrigin(), mouse, Vector(0,255,0), true, 0.03)
	end
end

function modifier_hero_base:PickupItems()
	local drop_items = Entities:FindAllByClassnameWithin("dota_item_drop", self.parent:GetAbsOrigin(), self.parent:GetHullRadius() * 2.5)
	for _,drop in pairs(drop_items) do
		
		local item = drop:GetContainedItem()
		local owner = item:GetPurchaser()
		
		--Only pickup items owned by teammates
		if owner == nil or (owner ~= nil and self.parent:IsAlly(owner) and self.parent ~= owner) then
			self.parent:AddItem(item)
			item:OnSpellStart()

			local entity = item:GetParentEntity()
			entity:OnPickedUp()
			UTIL_Remove(drop)
		end
	end
end

function modifier_hero_base:Move(vDirection, iSpeed)
	local offset = 			70
	local origin = 			self.parent:GetAbsOrigin()
	local future_origin = 	origin + (vDirection * iSpeed)
	local test_origin = 	future_origin + vDirection * offset
	future_origin.z = 		GetGroundPosition(future_origin, self.parent).z
	local normal = self:GetNormal(future_origin, self.parent)

	if IsInToolsMode() and DEBUG then
		DebugDrawLine_vCol(future_origin, test_origin, Vector(255,0,0), true, 1.0)
		DebugDrawLine_vCol(future_origin, future_origin + normal * 200, Vector(255,255,255), true, 1)
		DebugDrawCircle(future_origin, Vector(255,0,0), 5, offset, false, 0.03)
	end

	if self.parent:HasModifier("modifier_spectre_special_attack_buff") then
		self.parent:SetAbsOrigin(future_origin)
		return 'SUCCESS'
	end
	
	local trees = GridNav:GetAllTreesAroundPoint(test_origin, 5, true)
	
	if normal.z <= 0.9 then
		return 'WALL'
	end
	if #trees > 0 then
		return 'TREE'
	end

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
					return 'UNIT'
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
	return 'SUCCESS'
end

function modifier_hero_base:AlternativeDirectionsWalls(vDirection)
	local directions = {}
	local collision_direction = self.parent:GetCollisionDirection()
	local angle = VectorToAngles(vDirection).y

	if self:IsNorthEast(angle) then
		if collision_direction == DIAGONAL_LEFT then
			return directions
		end
		table.insert(directions, NORTH)
		table.insert(directions, EAST)
	end 
	if self:IsNorthWest(angle) then
		if collision_direction == DIAGONAL_RIGHT then
			return directions
		end
		if collision_direction == DIAGONAL_LEFT then
			table.insert(directions, NORTH)
			table.insert(directions, WEST)
			return directions
		end
		if collision_direction == VERTICAL then
			table.insert(directions, NORTH)
			table.insert(directions, WEST)
			return directions
		end
		table.insert(directions, NORTH)
		table.insert(directions, WEST)
	end 
	if self:IsSouthEast(angle) then
		if collision_direction == DIAGONAL_RIGHT then
			return directions
		end
		if collision_direction == DIAGONAL_LEFT then
			table.insert(directions, SOUTH)
			table.insert(directions, EAST)
		end
		if collision_direction == HORIZONTAL then
			table.insert(directions, EAST)
			table.insert(directions, SOUTH)
		end
		if collision_direction == VERTICAL then
			table.insert(directions, SOUTH)
			table.insert(directions, EAST)
		end
	end 
	if self:IsSouthWest(angle) then
		if collision_direction == HORIZONTAL then
			table.insert(directions, WEST)
			table.insert(directions, SOUTH)
		end
		if collision_direction == DIAGONAL_RIGHT then
			table.insert(directions, SOUTH_WEST)
			table.insert(directions, WEST)
			table.insert(directions, SOUTH)
		end
		if collision_direction == VERTICAL then
			table.insert(directions, SOUTH)
			table.insert(directions, WEST)
		end
 	end 
	if self:IsEast(angle) then
		if collision_direction == DIAGONAL_RIGHT then
			table.insert(directions, NORTH_EAST)
			table.insert(directions, NORTH)
		end
		if collision_direction == DIAGONAL_LEFT then
			table.insert(directions, SOUTH_EAST)
			table.insert(directions, SOUTH)
		end
	end
	if self:IsWest(angle) then
		if collision_direction == DIAGONAL_RIGHT then
			table.insert(directions, SOUTH_EAST)
			table.insert(directions, SOUTH)
		end
		if collision_direction == DIAGONAL_LEFT then
			table.insert(directions, NORTH_WEST)
			table.insert(directions, NORTH)
		end
		if collision_direction == HORIZONTAL then
			table.insert(directions, SOUTH)
			table.insert(directions, NORTH)
		end
	end 
	if self:IsNorth(angle) then
		if collision_direction == DIAGONAL_RIGHT then
			table.insert(directions, NORTH_EAST)
			table.insert(directions, EAST)
		end
		if collision_direction == HORIZONTAL then
			return directions
		end
		if collision_direction == DIAGONAL_LEFT then
			table.insert(directions, WEST)
		end
		if collision_direction == VERTICAL then
			table.insert(directions, NORTH_WEST)
			table.insert(directions, WEST)
		end
	end
	if self:IsSouth(angle) then
		if collision_direction == HORIZONTAL then
			return directions
		end
		if collision_direction == DIAGONAL_RIGHT then
			table.insert(directions, SOUTH_WEST)
			table.insert(directions, WEST)
		end
		if collision_direction == DIAGONAL_LEFT then
			table.insert(directions, SOUTH_EAST)
			table.insert(directions, EAST)
		end
		if collision_direction == VERTICAL then
			table.insert(directions, EAST)
		end
	end

	return directions
end

function modifier_hero_base:AlternativeDirections(vDirection)
	local directions = {}
	local angle = VectorToAngles(vDirection).y

	if self:IsNorthEast(angle) then
		table.insert(directions, NORTH)
		table.insert(directions, EAST)
	end 
	if self:IsNorthWest(angle) then
		table.insert(directions, NORTH)
		table.insert(directions, WEST)
	end 
	if self:IsSouthEast(angle) then
		table.insert(directions, SOUTH)
		table.insert(directions, EAST)
	end 
	if self:IsSouthWest(angle) then
		table.insert(directions, SOUTH)
		table.insert(directions, WEST)
 	end 
	if self:IsEast(angle) or self:IsWest(angle) then
		if self.parent:GetAbsOrigin().y < 0 then
			table.insert(directions, SOUTH)
			table.insert(directions, NORTH)
		end
		
		if self.parent:GetAbsOrigin().y > 0 then
			table.insert(directions, NORTH)
			table.insert(directions, SOUTH)
		end
	end 
	if self:IsNorth(angle) or self:IsSouth(angle) then
		if self.parent:GetAbsOrigin().x < 0 then
			table.insert(directions, WEST)
		end
		if self.parent:GetAbsOrigin().x > 0 then
			table.insert(directions, EAST)
		end
	end
	return directions
end



function modifier_hero_base:IsEast(iAngle)
	return iAngle > 345 or iAngle <= 15
end

function modifier_hero_base:IsNorthEast(iAngle)
	return iAngle > 15 and iAngle <= 75
end

function modifier_hero_base:IsNorth(iAngle)
	return iAngle > 75 and iAngle <= 105
end

function modifier_hero_base:IsNorthWest(iAngle)
	return iAngle > 105 and iAngle <= 165
end

function modifier_hero_base:IsWest(iAngle)
	return iAngle > 165 and iAngle <= 195
end

function modifier_hero_base:IsSouthWest(iAngle)
	return iAngle > 195 and iAngle <= 255
end

function modifier_hero_base:IsSouth(iAngle)
	return iAngle > 255 and iAngle <= 285
end

function modifier_hero_base:IsSouthEast(iAngle)
	return iAngle > 285 and iAngle <= 345
end

function modifier_hero_base:CheckState() 		
	return { 
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true 
	} 
end

function modifier_hero_base:DeclareFunctions()
    return {
		MODIFIER_EVENT_ON_SPENT_MANA,
		MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
    }
end

function modifier_hero_base:OnSpentMana(event)
	self:GetParent():SendDataToClient()
end

function modifier_hero_base:OnAbilityFullyCast(params)
	if IsServer() then
		if params.unit ~= self:GetParent() then
			return
		end

		params.unit:GiveEnergy(-params.ability:GetEnergyCost())
	end
end




function modifier_hero_base:GetDisableAutoAttack()						return true	end
function modifier_hero_base:GetModifierIgnoreMovespeedLimit(params)		return 1	end

