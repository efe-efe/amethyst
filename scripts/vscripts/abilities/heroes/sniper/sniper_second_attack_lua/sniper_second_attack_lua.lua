sniper_second_attack_lua = class({})
LinkLuaModifier( "modifier_sniper_second_attack_timer_lua", "abilities/heroes/sniper/sniper_second_attack_lua/modifier_sniper_second_attack_timer_lua", LUA_MODIFIER_MOTION_NONE )

function sniper_second_attack_lua:OnAbilityPhaseStart()
	-- play effects
	self:PlayEffects()

	return true -- if success
end

function sniper_second_attack_lua:OnSpellStart()
    local caster = self:GetCaster()
    local attack_time = 1.4

    caster:SwapAbilities( 
        "sniper_second_attack_projectile_lua",
        "sniper_second_attack_lua",
        true,
        false
    )

    caster:AddNewModifier(
        caster, -- player source
		self, -- ability source
		"modifier_sniper_second_attack_timer_lua", -- modifier name
		{ duration = attack_time } -- kv
    )

    -- Put CD on the alternate version of the ability
	local ex_version = caster:FindAbilityByName("sniper_ex_second_attack_lua")
	ex_version:StartCooldown(self:GetCooldown(0))
end

function sniper_second_attack_lua:PlayEffects()
    local sound_cast = "Ability.AssassinateLoad"
    EmitGlobalSound( sound_cast)
end
