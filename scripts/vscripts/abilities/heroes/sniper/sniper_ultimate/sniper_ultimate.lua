sniper_ultimate = class({})
LinkLuaModifier( "modifier_sniper_ultimate_timer", "abilities/heroes/sniper/sniper_ultimate/modifier_sniper_ultimate_timer", LUA_MODIFIER_MOTION_NONE )

function sniper_ultimate:OnAbilityPhaseStart()
	-- play effects
	self:PlayEffects_a()

	return true -- if success
end


function sniper_ultimate:OnAbilityPhaseInterrupted()	
    -- stop effects 
	local sound_cast = "sniper_snip_ability_assass_02"
	StopGlobalSound( sound_cast )
	return true -- if success
end

function sniper_ultimate:OnSpellStart()
    local caster = self:GetCaster()
    local attack_time = self:GetSpecialValueFor("duration")
    
    caster:AddNewModifier(
        caster, -- player source
		self, -- ability source
		"modifier_sniper_ultimate_timer", -- modifier name
		{ duration = attack_time } -- kv
    )

    self:PlayEffects_b()
end

function sniper_ultimate:PlayEffects_a()
    local sound_cast = "sniper_snip_ability_assass_02"
    EmitGlobalSound( sound_cast)
end


function sniper_ultimate:PlayEffects_b()
    local sound_cast = "sniper_snip_laugh_08"
    EmitGlobalSound( sound_cast)
end

