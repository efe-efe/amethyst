sniper_second_attack = class({})
LinkLuaModifier( "modifier_sniper_second_attack_timer", "abilities/heroes/sniper/sniper_second_attack/modifier_sniper_second_attack_timer", LUA_MODIFIER_MOTION_NONE )

function sniper_second_attack:OnAbilityPhaseStart()
	-- play effects
	self:PlayEffects()

	return true -- if success
end

function sniper_second_attack:OnSpellStart()
    local caster = self:GetCaster()
    local attack_time = 2.0

    caster:SwapAbilities( 
        "sniper_second_attack_projectile",
        "sniper_second_attack",
        true,
        false
    )

    caster:AddNewModifier(
        caster, -- player source
		self, -- ability source
		"modifier_sniper_second_attack_timer", -- modifier name
		{ duration = attack_time } -- kv
    )

    -- Put CD on the alternate version of the ability
	local ex_version = caster:FindAbilityByName("sniper_ex_second_attack")
	ex_version:StartCooldown(self:GetCooldown(0))
end

function sniper_second_attack:PlayEffects()
    local sound_cast = "Ability.AssassinateLoad"
    EmitGlobalSound( sound_cast)
end
