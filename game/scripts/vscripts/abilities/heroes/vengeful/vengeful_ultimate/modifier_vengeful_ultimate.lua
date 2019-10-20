modifier_vengeful_ultimate = class({})

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_vengeful_ultimate:DeclareFunctions()
	local funcs = {
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}

	return funcs
end

function modifier_vengeful_ultimate:OnAbilityFullyCast( params )
    if IsServer() then
        local parent = self:GetParent()
        
		if params.unit ~= parent then
			return
        end
        
        local name = params.ability:GetName() 
        local ability = self:GetAbility()

		if 	name == "item_death_orb" or
            name == "item_mana_orb" or
            name == "item_health_orb" or
            params.ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE) 
		then
			return
        end

        if ability.current_ability then
            if  ability.current_ability == params.ability or
                ability.current_ability:GetAbilityName() == name .. "_ultimate"
            then
                return
            end

            self:ForgetSpell()
        end

        ability.current_ability = parent:AddAbility( name .. "_ultimate" )
        ability.current_ability:SetLevel( 1 )
        ability.current_ability:SetStolen(true)	
        
        parent:SwapAbilities(
            ability.current_ability:GetAbilityName(), 
            "vengeful_ultimate", 
            true, 
            false
        )

        if ability.current_ability.OnAdded then
            ability.current_ability:OnAdded()
        end
	end
end

-- Remove currently stolen spell
function modifier_vengeful_ultimate:ForgetSpell()
    local ability = self:GetAbility()
    local parent = self:GetParent()


    if ability.current_ability ~= nil then
        if ability.current_ability.OnRemoved then
            ability.current_ability:OnRemoved()
        end

        parent:SwapAbilities( 
            "vengeful_ultimate",
            ability.current_ability:GetAbilityName(), 
            true, 
            false 
        )

		parent:RemoveAbility( ability.current_ability:GetAbilityName() )
		ability.current_ability = nil
	end
end

--[[
]]