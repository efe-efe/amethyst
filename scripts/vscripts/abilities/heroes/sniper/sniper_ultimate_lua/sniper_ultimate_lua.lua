sniper_ultimate_lua = class({})
LinkLuaModifier( "modifier_sniper_ultimate_timer_lua", "abilities/heroes/sniper/sniper_ultimate_lua/modifier_sniper_ultimate_timer_lua", LUA_MODIFIER_MOTION_NONE )

function sniper_ultimate_lua:OnAbilityPhaseStart()
	-- play effects
	self:PlayEffects_a()

	return true -- if success
end


function sniper_ultimate_lua:OnAbilityPhaseInterrupted()	
    -- stop effects 
	local sound_cast = "sniper_snip_ability_assass_02"
	StopGlobalSound( sound_cast )
	return true -- if success
end



function sniper_ultimate_lua:OnSpellStart()
    local caster = self:GetCaster()
    local attack_time = 3.5

    caster:SwapAbilities( 
        "sniper_ultimate_projectile_lua",
        "sniper_ultimate_lua",
        true,
        false
    )

    caster:AddNewModifier(
        caster, -- player source
		self, -- ability source
		"modifier_sniper_ultimate_timer_lua", -- modifier name
		{ duration = attack_time } -- kv
    )

    self:PlayEffects_b()
end

function sniper_ultimate_lua:PlayEffects_a()
    local sound_cast = "sniper_snip_ability_assass_02"
    EmitGlobalSound( sound_cast)
end


function sniper_ultimate_lua:PlayEffects_b()
    local sound_cast = "sniper_snip_laugh_08"
    EmitGlobalSound( sound_cast)
end

