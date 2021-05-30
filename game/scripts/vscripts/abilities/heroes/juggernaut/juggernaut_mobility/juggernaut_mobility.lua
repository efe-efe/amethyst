juggernaut_mobility = class({})
LinkLuaModifier("modifier_juggernaut_mobility", "abilities/heroes/juggernaut/juggernaut_mobility/modifier_juggernaut_mobility", LUA_MODIFIER_MOTION_NONE)

function juggernaut_mobility:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()
    local duration = self:GetSpecialValueFor("duration")

	CustomEntitiesLegacy:StrongPurge(caster)
	caster:RemoveModifierByName("modifier_hero_movement")
	caster:AddNewModifier(caster, self, "modifier_juggernaut_mobility", { duration = duration })

	local random_number = RandomInt(1, 9)
	if random_number > 1 then
		EmitSoundOn("juggernaut_jug_ability_bladefury_0" .. random_number, caster)
	end

	if caster:HasModifier("modifier_upgrade_juggernaut_spinning_ward") then
		ApplyCallbackForUnitsInArea(caster, origin, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, function(unit)
			if unit:GetUnitName() == 'npc_dota_creature_juggernaut_healing_totem' then
				if unit:GetPlayerOwnerID() == caster:GetPlayerOwnerID() then
					unit:AddNewModifier(caster, self, "modifier_juggernaut_mobility", { duration = duration })
				end
			end
		end)
	end
end