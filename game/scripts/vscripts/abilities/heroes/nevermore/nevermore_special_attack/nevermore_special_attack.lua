nevermore_special_attack = class({})
LinkLuaModifier( "modifier_nevermore_special_attack_thinker", "abilities/heroes/nevermore/nevermore_special_attack/modifier_nevermore_special_attack_thinker", LUA_MODIFIER_MOTION_NONE )

function nevermore_special_attack:GetRadius()
	local radius = self:GetSpecialValueFor("radius")
	local radius_per_stack = self:GetSpecialValueFor("radius_per_stack")

    return radius + 2 * radius_per_stack
end
--[[
function nevermore_special_attack:GetCastRange( vLocation, hTarget )
	if IsServer() then
		local stacks = 0
		local range_per_stack = self:GetSpecialValueFor("range_per_stack")
			
		local modifier = self:GetCaster():FindModifierByNameAndCaster( "modifier_nevermore_souls", self:GetCaster() )
		if modifier~=nil then
			stacks = stacks + modifier:GetStackCount()
		end

		return self.BaseClass.GetCastRange(self, vLocation, hTarget) + stacks * range_per_stack
	end
end

]]

function nevermore_special_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")
	local radius = self:GetSpecialValueFor("radius")
	local delay_time = self:GetSpecialValueFor("delay_time")

	local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")
	local radius_per_stack = self:GetSpecialValueFor("radius_per_stack")
	local point = CalcPoint(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

	local direction = (point - origin):Normalized()
	local distance = self:GetCastRange(Vector(0,0,0), nil)
	local points = {}
	local offset = 128

	points[0] = origin + Vector(direction.x * offset , direction.y * offset, 0 )
	points[1] = origin + Vector(direction.x * (distance/2 + offset), direction.y * (distance/2 + offset), 0 )
	points[2] = origin + Vector(direction.x * (distance + offset), direction.y * (distance + offset), 0 )

	for i = 0, 2 do
		CreateModifierThinker(
			caster, --hCaster
			self, --hAbility
			"modifier_nevermore_special_attack_thinker", --modifierName
			{ 
				radius = radius + (radius_per_stack * i),
				delay_time = (delay_time * i),
				damage = damage + (damage_per_stack * i)
			}, --paramTable
			points[i], --vOrigin
			caster:GetTeamNumber(), --nTeamNumber
			false --bPhantomBlocker
		)
	end
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	nevermore_special_attack,
	{ activity = ACT_DOTA_RAZE_3, rate = 1.3 },
	{ movement_speed = 10, fixed_range = 1}
)