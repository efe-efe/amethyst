juggernaut_counter = class({})
LinkLuaModifier( "modifier_juggernaut_counter", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_counter", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_juggernaut_counter_buff", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_counter_buff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function juggernaut_counter:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	caster:AddNewModifier(
        caster, 
        self,
        "modifier_generic_pseudo_cast_point", 
        {
            duration = cast_point,
        }
    )
end

--------------------------------------------------------------------------------
-- Ability Start
function juggernaut_counter:OnEndPseudoCastPoint( point )
    --load data
    local caster = self:GetCaster()
    local duration = 0.8--self:GetDuration()
    
    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_juggernaut_counter", -- modifier name
		{ 
            duration = duration, 
            movement_speed = 20
        } -- kv
    )
end


--ACT_DOTA_ATTACK_EVENT+favor