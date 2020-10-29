mars_extra = class({})
mars_extra_recast = class({})
LinkLuaModifier("modifier_mars_extra_recast", "abilities/heroes/mars/mars_extra/modifier_mars_extra_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_soldier", "abilities/heroes/mars/modifier_mars_soldier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_soldier_debuff", "abilities/heroes/mars/modifier_mars_soldier_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_soldier_displacement", "abilities/heroes/mars/modifier_mars_soldier_displacement", LUA_MODIFIER_MOTION_BOTH)

function mars_extra:GetCastAnimationCustom()		return ACT_DOTA_GENERIC_CHANNEL_1 end
function mars_extra:GetPlaybackRateOverride()    return 2.0 end
function mars_extra:GetCastPointSpeed() 			return 10 end

function mars_extra:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
    local point = Clamp(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local direction = (origin - point):Normalized()
	local duration = 5.0
	local radius = self:GetSpecialValueFor('radius')

	local spawnPoint = point + (direction * radius * -1)

	local callback = function(unit)
		unit:FaceTowardsCustom(direction)
		unit:SetNeverMoveToClearSpace(true)
		unit:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_mars_soldier", -- modifier name
			{
				duration = duration,
				model = 1,
				fade = 0,
				marker = 1,
				x = direction.x,
				y = direction.y,
				radius = radius,
			} -- kv
		)
		
		unit:SetModelScale(1.3)
		EFX("particles/units/heroes/hero_invoker_kid/invoker_kid_forge_spirit_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit, {
			release = true
		})

		EFX("particles/items_fx/aegis_respawn_aegis_trail.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit, {
			release = true
		})
		
		unit:StartGesture(ACT_DOTA_SPAWN)
		EmitSoundOn('Hero_Mars.Spear.Root', unit)
	end

	local unit = CreateUnitByNameAsync(
		"npc_dota_mars_ultimate_soldier",
		spawnPoint,
		false,
		caster,
		nil,
		caster:GetTeamNumber(),
		callback
	)

	if self:GetName() == 'mars_extra' then
		if self:GetLevel() == 2 then
			caster:AddNewModifier(caster, self, "modifier_mars_extra_recast", { duration = 1.5 })
		end
	end
end

mars_extra_recast.GetCastAnimationCustom =	mars_extra.GetCastAnimationCustom
mars_extra_recast.GetPlaybackRateOverride = mars_extra.GetPlaybackRateOverride
mars_extra_recast.GetCastPointSpeed = mars_extra.GetCastPointSpeed
mars_extra_recast.OnSpellStart = mars_extra.OnSpellStart

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(mars_extra)
Abilities.Castpoint(mars_extra_recast)