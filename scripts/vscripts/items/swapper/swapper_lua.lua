if item_swapper == nil then
    item_swapper = class({})
end

function item_swapper:OnToggle()

    local caster = self:GetCaster()

    if self:GetToggleState() then
        
        local abilities = {}

        for i = 0, 23 do
            local ability = caster:GetAbilityByIndex(i)
            if ability then
                if ability:GetSpecialValueFor("ex_ability") == 1 then -- Normal abilities with ex version
                    if abilities[ability] == nil then
                        abilities[ability] = ability:GetAbilityName()
                        if ability:GetAbilityName() ~= ability:GetRelatedName() then
                            caster:SwapAbilities( 
                                ability:GetAbilityName(),
                                ability:GetRelatedName(),
                                false,
                                true
                            )
                        end
                    end
                end
            end
        end
    else
               
        local abilities = {}

        for i = 0, 23 do
            local ability = caster:GetAbilityByIndex(i)
            if ability then
                if ability:GetSpecialValueFor("ex_ability") == 2 then -- Normal abilities with ex version
                    if abilities[ability] == nil then
                        abilities[ability] = ability:GetAbilityName()
                        if ability:GetAbilityName() ~= ability:GetRelatedName() then
                            caster:SwapAbilities( 
                                ability:GetAbilityName(),
                                ability:GetRelatedName(),
                                false,
                                true
                            )
                        end
                    end
                end
            end
        end
	end
end
 