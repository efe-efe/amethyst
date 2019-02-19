modifier_spectre_basic_attack_charged_timer = class({})
LinkLuaModifier( "modifier_spectre_basic_attack_charged_visuals", "abilities/heroes/spectre/spectre_basic_attack_lua/modifier_spectre_basic_attack_charged_visuals", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function modifier_spectre_basic_attack_charged_timer:IsDebuff()
	return false
end

function modifier_spectre_basic_attack_charged_timer:IsHidden()
	return false
end

function modifier_spectre_basic_attack_charged_timer:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
---- Destroyer
function modifier_spectre_basic_attack_charged_timer:OnDestroy( kv )
    if IsServer() then
        self:GetParent():AddNewModifier(
            self:GetParent(),
            self:GetAbility(), 
            "modifier_spectre_basic_attack_charged_visuals", 
            {}
        )

        -- Put the charged ability on the basic attack slot
        self:GetParent():SwapAbilities( 
            "spectre_basic_attack_lua",
            self:GetAbility():GetAbilityName(),
            false,
            true
        )
	end
end