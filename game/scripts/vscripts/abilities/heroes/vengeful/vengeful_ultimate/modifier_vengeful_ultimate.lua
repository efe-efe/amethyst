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
        if params.unit ~= parent then return end
        
        local ultimate = self:GetAbility()
        local incoming_ability = params.ability
        local incoming_ability_name = incoming_ability:GetName() 

		if 	incoming_ability_name == "item_death_orb" or
            incoming_ability_name == "item_mana_orb" or
            incoming_ability_name == "item_health_orb" or
            incoming_ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE) 
		then
			return
        end

        if ultimate.current_ability then
            if  ultimate.current_ability == incoming_ability or
                ultimate.current_ability:GetAbilityName() == incoming_ability_name .. "_ultimate"
            then
                return
            end

            self:ForgetSpell()
        end

        print(incoming_ability_name)

        ultimate.current_ability = parent:AddAbility( incoming_ability_name .. "_ultimate" )
        ultimate.current_ability:SetLevel( 1 )
        if ultimate.current_ability.OnAdded then
            ultimate.current_ability:OnAdded()
        end

        parent:SwapAbilities(
            ultimate.current_ability:GetAbilityName(), 
            "vengeful_ultimate", 
            true, 
            false
        )
	end
end

-- Remove currently stolen spell
function modifier_vengeful_ultimate:ForgetSpell()
    local ultimate = self:GetAbility()
    local parent = self:GetParent()

    if ultimate.current_ability ~= nil then
        if ultimate.current_ability.OnRemoved then
            ultimate.current_ability:OnRemoved()
        end

        parent:SwapAbilities( 
            "vengeful_ultimate",
            ultimate.current_ability:GetAbilityName(), 
            true, 
            false 
        )

		parent:RemoveAbility( ultimate.current_ability:GetAbilityName() )
		ultimate.current_ability = nil
	end
end