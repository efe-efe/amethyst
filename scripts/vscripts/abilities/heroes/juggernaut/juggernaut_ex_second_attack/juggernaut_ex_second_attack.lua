juggernaut_ex_second_attack = class({})
LinkLuaModifier( 
    "modifier_juggernaut_ex_second_attack", 
    "abilities/heroes/juggernaut/juggernaut_ex_second_attack/modifier_juggernaut_ex_second_attack", LUA_MODIFIER_MOTION_NONE 
)

function juggernaut_ex_second_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("juggernaut_second_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function juggernaut_ex_second_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	
	-- Animation and pseudo cast point
	StartAnimation(caster, { duration=cast_point, activity=ACT_DOTA_CAST_ABILITY_1, rate=1.5 })
    caster:AddNewModifier(caster, self , "modifier_cast_point", 
        { duration = cast_point })
end


--------------------------------------------------------------------------------
function juggernaut_ex_second_attack:OnCastPointEnd( point ) 
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    self:PlayEffects()

    caster:AddNewModifier(
        caster,
        self,
        "modifier_juggernaut_ex_second_attack",
        {duration = duration}
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
    
    -- Put CD on the alternate of the ability
    local alternate_version = caster:FindAbilityByName("juggernaut_second_attack")
    alternate_version:StartCooldown(self:GetCooldown(0))
end

function juggernaut_ex_second_attack:PlayEffects()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()

    -- Cast Sound
    --local sound_cast = "DOTA_Item.SmokeOfDeceit.Activate"
    --EmitSoundOn( sound_cast , caster )
end
