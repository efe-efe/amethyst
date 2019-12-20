terrorblade_extra_recast = class({})
LinkLuaModifier( "modifier_terrorblade_extra", "abilities/heroes/terrorblade/terrorblade_extra/modifier_terrorblade_extra", LUA_MODIFIER_MOTION_NONE )

function terrorblade_extra_recast:OnCastPointEnd()
    local caster = self:GetCaster()
    local duration = 0.5--self:GetSpecialValueFor("i_frame")

    caster:AddNewModifier(caster, self, "modifier_terrorblade_extra", { duration = duration })
end


if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
    terrorblade_extra_recast,
	{ activity = ACT_DOTA_CAST_ABILITY_3, rate = 1.2 },
	{ movement_speed = 10 },
	{ modifier_name = "modifier_terrorblade_extra_recast" }
)