terrorblade_extra = class({})
LinkLuaModifier( "modifier_terrorblade_extra_recast", "abilities/heroes/terrorblade/terrorblade_extra/modifier_terrorblade_extra_recast", LUA_MODIFIER_MOTION_NONE )

function terrorblade_extra:OnCastPointEnd()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(caster, self, "modifier_terrorblade_extra_recast", { duration = duration })
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
    terrorblade_extra,
	nil,
	{ movement_speed = 100 },
	{ modifier_name = "modifier_terrorblade_extra_recast" }
)
