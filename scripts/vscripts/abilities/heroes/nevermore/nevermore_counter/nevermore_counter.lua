nevermore_counter = class({})
LinkLuaModifier( "modifier_nevermore_counter", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_counter:OnSpellStart()
	-- Initialize bariables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

    EmitSoundOn("Hero_Nevermore.PreAttack", caster)

	-- Animation and pseudo cast point
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
		duration = cast_point, 
        can_walk = 0,
        no_target = 1
	})
end

--------------------------------------------------------------------------------
function nevermore_counter:OnEndPseudoCastPoint( point )
    --load data
    local caster = self:GetCaster()
    local duration = self:GetDuration()

    StartAnimation(caster, {duration=duration, activity=ACT_DOTA_TELEPORT, rate=1.0})
    
    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_nevermore_counter", -- modifier name
        { duration = duration } -- kv
    )
end
