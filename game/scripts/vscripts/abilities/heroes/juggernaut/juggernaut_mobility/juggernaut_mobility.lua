juggernaut_mobility = class({})
LinkLuaModifier( "modifier_juggernaut_mobility", "abilities/heroes/juggernaut/juggernaut_mobility/modifier_juggernaut_mobility", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function juggernaut_mobility:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=cast_point + 0.1, activity=ACT_DOTA_ATTACK, rate=1.0})
	caster:AddNewModifier(caster, self , "modifier_cast_point", { 
		duration = cast_point, 
		movement_speed = 50,
		no_target = 1
	})

	-- Strong Dispel
	self:GetCaster():Purge( false, true, false, true, false )
end

--------------------------------------------------------------------------------
function juggernaut_mobility:OnCastPointEnd()

    local caster = self:GetCaster()
    local duration = self:GetDuration()

	caster:AddNewModifier(caster, self, "modifier_juggernaut_mobility", { duration = duration })
end

