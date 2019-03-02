modifier_spectre_basic_attack_charged_timer_lua = class({})
LinkLuaModifier( "modifier_spectre_basic_attack_charged_visuals_lua", "abilities/heroes/spectre/spectre_basic_attack_lua/modifier_spectre_basic_attack_charged_visuals_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function modifier_spectre_basic_attack_charged_timer_lua:IsDebuff()
	return false
end

function modifier_spectre_basic_attack_charged_timer_lua:IsHidden()
	return false
end

function modifier_spectre_basic_attack_charged_timer_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
---- Destroyer
function modifier_spectre_basic_attack_charged_timer_lua:OnDestroy( kv )
    if IsServer() then
        self:GetParent():AddNewModifier(
            self:GetParent(),
            self:GetAbility(), 
            "modifier_spectre_basic_attack_charged_visuals_lua", 
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