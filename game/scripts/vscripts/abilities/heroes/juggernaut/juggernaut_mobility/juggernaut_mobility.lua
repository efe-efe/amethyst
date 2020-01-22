juggernaut_mobility = class({})
LinkLuaModifier( "modifier_juggernaut_mobility", "abilities/heroes/juggernaut/juggernaut_mobility/modifier_juggernaut_mobility", LUA_MODIFIER_MOTION_NONE )

function juggernaut_mobility:OnCastPointEnd()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

	caster:StrongPurge()
	caster:AddNewModifier(caster, self, "modifier_juggernaut_mobility", { duration = duration })
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
    juggernaut_mobility,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 50, hide_indicator = 1 }
)