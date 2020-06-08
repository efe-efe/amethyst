phantom_extra = class({})
LinkLuaModifier("modifier_phantom_extra", "abilities/heroes/phantom/phantom_extra/modifier_phantom_extra", LUA_MODIFIER_MOTION_HORIZONTAL)

--------------------------------------------------------------------------------
-- Ability Start
function phantom_extra:OnCastPointEnd()
    local caster = self:GetCaster()
    
    caster:AddNewModifier(caster, self, "modifier_phantom_extra", {})

    caster:SwapAbilities(
        "phantom_extra",
        "phantom_extra_mobility",
        false,
        true
   )

    self:PlayEffectsOnCast()
end

function phantom_extra:PlayEffectsOnCast()
    EmitSoundOn("Hero_PhantomAssassin.Blur", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	phantom_extra,
	{ activity = ACT_DOTA_CAST_ABILITY_3, rate = 1.0 },
	{ movement_speed = 0 }
)