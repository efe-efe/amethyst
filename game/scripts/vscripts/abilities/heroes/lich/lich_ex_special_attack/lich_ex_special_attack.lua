lich_ex_special_attack = class({})


--------------------------------------------------------------------------------
-- Ability Start
function lich_ex_special_attack:OnCastPointEnd()
	-- unit identifier
	local caster = self:GetCaster()
	local point = CalcPoint(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
    local ability = caster:FindAbilityByName("lich_special_attack") 

    ability:CreateShard(point, 1)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	lich_ex_special_attack,
	{ activity = ACT_DOTA_CAST_ABILITY_2, rate = 1.0 },
	{ movement_speed = 10 }
)