time_lapse_lua = class ({})
--LinkLuaModifier( "modifier_weaver_basic_attack", "abilities/weaver/weaver_basic_attack/modifier_weaver_basic_attack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function time_lapse_lua:OnSpellStart()
    local caster = self:GetCaster()
	local wrapped_ability = caster:FindAbilityByName("weaver_time_lapse")
    local mana_cost = self:GetManaCost(-1)

    if wrapped_ability:IsFullyCastable() then
        caster:CastAbilityImmediately(wrapped_ability, caster:GetPlayerOwnerID())
        Timers:CreateTimer(0.001, function()
            self:PayManaCost()
        end)
    end
end