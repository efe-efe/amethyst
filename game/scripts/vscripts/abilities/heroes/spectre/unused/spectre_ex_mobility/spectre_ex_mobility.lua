spectre_ex_mobility = class({})
LinkLuaModifier("modifier_spectre_ex_mobility", "abilities/heroes/spectre/spectre_ex_mobility/modifier_spectre_ex_mobility", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Ability Start
function spectre_ex_mobility:OnCastPointEnd()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(caster, self, "modifier_spectre_ex_mobility", { duration = duration })
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	spectre_ex_mobility,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 0 }
)