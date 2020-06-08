ancient_ex_special_attack = class({})

LinkLuaModifier("modifier_ancient_ex_special_attack_charges", "abilities/heroes/ancient/ancient_ex_special_attack/modifier_ancient_ex_special_attack_charges", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ancient_ex_special_attack_thinker", "abilities/heroes/ancient/ancient_ex_special_attack/modifier_ancient_ex_special_attack_thinker", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Passive Modifier
function ancient_ex_special_attack:GetIntrinsicModifierName()
	return "modifier_ancient_ex_special_attack_charges"
end

function ancient_ex_special_attack:HasCharges()
	return true
end

function ancient_ex_special_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = Clamp(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
    local origin = caster:GetOrigin()
	local duration = self:GetSpecialValueFor("duration")
	local offset = 250--self:GetCastRange(Vector(0,0,0), nil)
	local direction = (point - origin):Normalized() 
	local angle = 0.6

	local distance = (point - origin):Length2D() - offset
	if distance < 0 then distance = 0 end

	local new_origin = origin + direction * distance

	for i = 0, 2 do
		local target_points = {}

		if i == 0 then
			target_points[0] = new_origin + Vector(direction.x, direction.y, 0) * offset
		else 
			local a_x = ((direction.x * math.cos(angle * i)) - (direction.y * math.sin(angle * i)))
			local a_y = ((direction.x * math.sin(angle * i)) + (direction.y * math.cos(angle * i)))
			local b_x = ((direction.x * math.cos(-angle * i)) - (direction.y * math.sin(-angle * i)))
			local b_y = ((direction.x * math.sin(-angle * i)) + (direction.y * math.cos(-angle * i))) 

			target_points[0] = new_origin + Vector(a_x, a_y, 0) * offset
			target_points[1] = new_origin + Vector(b_x, b_y, 0) * offset
		end
		
		for _,target_point in pairs(target_points) do
			CreateModifierThinker(
				caster, --hCaster
				self, --hAbility
				"modifier_ancient_ex_special_attack_thinker", --modifierName
				{ 
					duration = duration,
					draw = 1 
				}, --paramTable
				target_point, --vOrigin
				caster:GetTeamNumber(), --nTeamNumber
				false --bPhantomBlocker
			)
		end
	end

	self:PlayEffectsOnCast()
end

function ancient_ex_special_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_Ancient_Apparition.ChillingTouch.Cast", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	ancient_ex_special_attack,
	{ activity = ACT_DOTA_ICE_VORTEX, rate = 0.8 },
	{ movement_speed = 80 }
)


-- PERPENDICULAR WALL
--[[

local caster = self:GetCaster()
	local point = Clamp(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
    local origin = caster:GetOrigin()
	local duration = self:GetSpecialValueFor("duration")
	local offset = 100
	local direction = (point - origin):Normalized() 
	local angle = 0.6

    DebugDrawLine_vCol(origin, point, Vector(254, 255, 234), false, 10)
    DebugDrawLine_vCol(point, point + Vector(direction.y , -direction.x , 0) * 200, Vector(254, 255, 234), false, 10)
    DebugDrawLine_vCol(point, point - Vector(direction.y , -direction.x , 0) * 200, Vector(254, 255, 234), false, 10)


	for i = 0, 2 do
		local target_points = {}

		if i == 0 then
			target_points[0] = point
		else 
			target_points[0] = point + Vector(direction.y , -direction.x , 0) * offset * i
			target_points[1] = point - Vector(direction.y , -direction.x , 0) * offset * i
		end
		
		for _,target_point in pairs(target_points) do
			CreateModifierThinker(
				caster, --hCaster
				self, --hAbility
				"modifier_ancient_ex_special_attack_thinker", --modifierName
				{ 
					duration = duration,
					draw = 1 
				}, --paramTable
				target_point, --vOrigin
				caster:GetTeamNumber(), --nTeamNumber
				false --bPhantomBlocker
			)
		end
	end
]]