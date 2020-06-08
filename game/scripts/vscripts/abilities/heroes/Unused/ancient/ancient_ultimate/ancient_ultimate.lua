ancient_ultimate = class({})
LinkLuaModifier("modifier_ancient_ultimate_recast", "abilities/heroes/ancient/ancient_ultimate/modifier_ancient_ultimate_recast", LUA_MODIFIER_MOTION_NONE)

function ancient_ultimate:OnSpellStart()
    EmitGlobalSound("ancient_apparition_appa_ability_iceblast_01")
end

function ancient_ultimate:OnCastPointEnd()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    caster:AddNewModifier(caster, self, "modifier_ancient_ultimate_recast", { duration = duration })
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	ancient_ultimate,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 1.3 },
	{ movement_speed = 0 }
)
