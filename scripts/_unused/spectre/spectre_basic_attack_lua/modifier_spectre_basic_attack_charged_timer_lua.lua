modifier_spectre_basic_attack_charged_timer_lua = class({})

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
---- Initializer     
function modifier_spectre_basic_attack_charged_timer_lua:OnCreated( kv )
    if IsServer() then
        local parent = self:GetParent()
        self.charged = parent:FindAbilityByName("spectre_basic_attack_charged_lua")
        self.non_charged = parent:FindAbilityByName("spectre_basic_attack_lua")
        
        -- Put the non charged ability on the basic attack slot
		parent:SwapAbilities( 
            "spectre_basic_attack_lua",
            "spectre_basic_attack_charged_lua",
			true,
			false
        )
	end
end
--------------------------------------------------------------------------------
---- Destroyer
function modifier_spectre_basic_attack_charged_timer_lua:OnDestroy( kv )
    if IsServer() then
        local parent = self:GetParent()
                
        self.charged:PlayEffects_d()
        local cooldown = self.non_charged:GetCooldownTimeRemaining()
        self.charged:StartCooldown(cooldown)

        -- Put the charged ability on the basic attack slot
        parent:SwapAbilities( 
            "spectre_basic_attack_lua",
            "spectre_basic_attack_charged_lua",
            false,
            true
        )

	end
end
