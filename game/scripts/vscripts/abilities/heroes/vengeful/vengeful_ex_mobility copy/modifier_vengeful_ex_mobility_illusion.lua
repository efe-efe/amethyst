modifier_vengeful_ex_second_attack_illusion = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_vengeful_ex_second_attack_illusion:IsHidden() return false
end

function modifier_vengeful_ex_second_attack_illusion:IsPurgable() return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_vengeful_ex_second_attack_illusion:OnCreated( kv )
    if IsServer() then
        ProgressBars:AddProgressBar(self:GetCaster(), self:GetName(), {
			style = "Generic",
			text = "duration",
			progressBarType = "duration",
			priority = 1,
		})
    end
end

function modifier_vengeful_ex_second_attack_illusion:OnDestroy( kv )
    if IsServer() then

        --Prevent trying to find a forgotten ability
        if self:GetAbility() then
            local my_name = self:GetAbility():GetAbilityName()
            local name = string.ends(my_name, "_ultimate") and "vengeful_ex_second_attack_swap_ultimate" or "vengeful_ex_second_attack_swap"
            local ability = self:GetCaster():FindAbilityByName(name)
            ability.illusion_index = nil

            local activate = not self:GetAbility():IsHidden()
            if string.ends(my_name, "_ultimate") then
                activate = true      
            end

            self:GetCaster():SwapAbilities( 
                my_name,
                name,
                activate,
                false
            )
        end
            
        if self:GetParent() ~= nil then
            self:GetParent():ForceKill( false )
            UTIL_Remove( self:GetParent() )
        end
	end
end

-- Status Effects
function modifier_vengeful_ex_second_attack_illusion:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_PROPERTY_DISABLE_AUTOATTACK] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_vengeful_ex_second_attack_illusion:GetEffectName()
	return "particles/items4_fx/nullifier_slow.vpcf"
end

function modifier_vengeful_ex_second_attack_illusion:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

