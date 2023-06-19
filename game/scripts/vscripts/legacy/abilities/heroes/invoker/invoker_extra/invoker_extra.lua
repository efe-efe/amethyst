invoker_extra = class({})

--[[
    amounts = {
        wex = x, R
        quas = y, Q
        exort = z, E
    }
]]

local invoker_abilities = {
    ['120'] = "invoker_walk_custom",
	['012'] = "invoker_spirit_custom",
	['021'] = "invoker_wall_custom",
    ['003'] = "invoker_sun_custom",
	['030'] = "invoker_snap_custom",
	['300'] = "invoker_emp_custom",
	['111'] = "invoker_blast_custom",
	['201'] = "invoker_alacrity_custom",
    ['210'] = "invoker_tornado_custom",
    ['102'] = "invoker_meteor_custom",
}

function invoker_extra:OnSpellStart()
    local caster = self:GetCaster()
    local orb_amounts = caster:FindModifierByName("modifier_invoker_helper"):GetOrbAmounts()
    local ability_code = tostring(orb_amounts['wex'] .. orb_amounts['quas'] .. orb_amounts['exort'])

    if invoker_abilities[ability_code] then
        local incoming_ability_name = invoker_abilities[ability_code]
        local incoming_ability = caster:FindAbilityByName(incoming_ability_name)
        local first_ability = caster:GetAbilityByIndex(7)
        local second_ability = caster:GetAbilityByIndex(8)
        local outcoming_ability = nil
        local enable_outcoming_ability = false

        if first_ability == incoming_ability then
            outcoming_ability = second_ability
            enable_outcoming_ability = true
        elseif second_ability == incoming_ability then
            outcoming_ability = first_ability
            enable_outcoming_ability = true
        elseif first_ability:GetName() == "invoker_empty1" or first_ability:GetName() == "invoker_empty2" then
            outcoming_ability = first_ability
        elseif second_ability:GetName() == "invoker_empty1" or second_ability:GetName() == "invoker_empty2" then
            outcoming_ability = second_ability
        else
            caster:SwapAbilities(
                first_ability:GetName(), 
                second_ability:GetName(), 
                true,
                true
            )
            outcoming_ability = caster:GetAbilityByIndex(7)
        end

        caster:SwapAbilities(
            incoming_ability_name, 
            outcoming_ability:GetName(), 
            true,
            enable_outcoming_ability
        )
        EmitSoundOn("Hero_Invoker.Invoke", caster)
    end
end
