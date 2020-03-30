spectre_extra = class({})
LinkLuaModifier( "modifier_spectre_extra", "abilities/heroes/spectre/spectre_extra/modifier_spectre_extra", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function spectre_extra:OnCastPointEnd()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(caster, self, "modifier_spectre_extra", { duration = duration })
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	spectre_extra,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 0 }
)