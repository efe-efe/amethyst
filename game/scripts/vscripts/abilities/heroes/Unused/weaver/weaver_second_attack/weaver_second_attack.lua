weaver_second_attack = class({})
LinkLuaModifier("modifier_weaver_second_attack_thinker", "abilities/heroes/weaver/weaver_second_attack/modifier_weaver_second_attack_thinker", LUA_MODIFIER_MOTION_NONE)

function weaver_second_attack:OnCastPointEnd()
    local caster = self:GetCaster()
    local modifier = caster:FindModifierByName("modifier_weaver_ultimate")
    local location = nil
    local origin = caster:GetOrigin()

    if 
        modifier.origins == nil or
        modifier.counter == nil or 
        modifier.origins[modifier.counter] == nil 
    then
        location = origin
    else
        location = modifier.origins[modifier.counter]
    end

    local radius = 350
    local delay_time = 0.5
    local thinker_duration = 5.0

    CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_weaver_second_attack_thinker",
			show_all = 1,
			radius = radius,
			delay_time = delay_time,
			thinker_duration = thinker_duration + delay_time,
			draw_clock = 1
		}, --paramTable
		location, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	weaver_second_attack,
	{ activity = ACT_DOTA_ATTACK, rate = 1.8 },
	{ movement_speed = 80 }
)