juggernaut_ex_second_attack = class({})
LinkLuaModifier( "modifier_juggernaut_ex_second_attack", "abilities/heroes/juggernaut/juggernaut_ex_second_attack/modifier_juggernaut_ex_second_attack", LUA_MODIFIER_MOTION_NONE )

function juggernaut_ex_second_attack:OnCastPointEnd() 
    local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(
        caster,
        self,
        "modifier_juggernaut_ex_second_attack",
        { duration = duration }
    )

    if IsServer() then 
        local illusion = CreateIllusions( caster, caster, {
            duration = duration,
            outgoing_damage = -80, 
            incoming_damage = 300,
        }, 1, 0, false, true )

        
		local newOrder = {UnitIndex = illusion[1]:entindex(), 
            OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,                 
            Position = point}

        Timers:CreateTimer(0.1, function()
            ExecuteOrderFromTable(newOrder)        
        end)
    end
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	juggernaut_ex_second_attack,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 1.5 },
	{ movement_speed = 100 }
)