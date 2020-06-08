pudge_ex_counter = class({})
LinkLuaModifier("modifier_ex_pudge_counter", "abilities/heroes/pudge/pudge_ex_counter/modifier_ex_pudge_counter", LUA_MODIFIER_MOTION_NONE)

function pudge_ex_counter:OnCastPointEnd()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	caster:AddNewModifier(caster, self, "modifier_ex_pudge_counter", { duration = duration })
	
	local ability = caster:FindAbilityByName("pudge_counter")
	if ability:GetToggleState() then
		ability:ToggleAbility()
	end
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	pudge_ex_counter,
	{ activity = ACT_DOTA_CAST_ABILITY_ROT, rate = 0.7 },
	{ movement_speed = 10 }
)