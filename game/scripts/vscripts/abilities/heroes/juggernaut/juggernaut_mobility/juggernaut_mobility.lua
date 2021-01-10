juggernaut_mobility = class({})
LinkLuaModifier("modifier_juggernaut_mobility", "abilities/heroes/juggernaut/juggernaut_mobility/modifier_juggernaut_mobility", LUA_MODIFIER_MOTION_NONE)

function juggernaut_mobility:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

	CustomEntities:StrongPurge(caster)
	caster:RemoveModifierByName("modifier_hero_movement")
	caster:AddNewModifier(caster, self, "modifier_juggernaut_mobility", { duration = duration })

	local random_number = RandomInt(1, 9)
	if random_number > 1 then
		EmitSoundOn("juggernaut_jug_ability_bladefury_0" .. random_number, caster)
	end
end