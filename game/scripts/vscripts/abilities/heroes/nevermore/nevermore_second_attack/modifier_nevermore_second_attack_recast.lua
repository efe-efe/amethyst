modifier_nevermore_second_attack_recast = class({})

function modifier_nevermore_second_attack_recast:OnCreated( params )
    if IsServer() then
        local parent = self:GetParent()
        local ability =  parent:FindAbilityByName("nevermore_second_attack")
        ability:EndCooldown()
    end
end

function modifier_nevermore_second_attack_recast:OnDestroy()
    if IsServer() then
        local parent = self:GetParent()
        local ability =  parent:FindAbilityByName("nevermore_second_attack")
        ability:StartCooldown(ability:GetCooldown(0))
        
		if self:GetRemainingTime() < 0.05 then
			parent:RemoveModifierByName("modifier_nevermore_second_attack")
		end
    end
end

--------------------------------------------------------------------------------
--Graphics & Animations
function modifier_nevermore_second_attack_recast:GetEffectName()
	return "particles/units/heroes/hero_invoker_kid/invoker_kid_forge_spirit_ambient_fire.vpcf"
end

function modifier_nevermore_second_attack_recast:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end


if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast( 
	modifier_nevermore_second_attack_recast,
	{ ability_name = "nevermore_second_attack", key = "M2", charges = 1, keep_order = 1}
)
