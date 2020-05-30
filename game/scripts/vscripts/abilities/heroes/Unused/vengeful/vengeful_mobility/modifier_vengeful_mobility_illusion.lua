modifier_vengeful_mobility_illusion = class({})
LinkLuaModifier( "modifier_vengeful_mobility_recast", "abilities/heroes/vengeful/vengeful_mobility/modifier_vengeful_mobility_recast", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_vengeful_mobility_recast_ultimate", "abilities/heroes/vengeful/vengeful_mobility/modifier_vengeful_mobility_recast", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Classifications
function modifier_vengeful_mobility_illusion:IsHidden() return false
end

function modifier_vengeful_mobility_illusion:IsPurgable() return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_vengeful_mobility_illusion:OnCreated( kv )
    if IsServer() then
        local ability = self:GetParent():FindAbilityByName("vengeful_mobility")
        local illusion_duration = ability:GetSpecialValueFor("duration")

        local my_name = self:GetAbility():GetAbilityName()
        local name = string.ends(my_name, "_ultimate") and "modifier_vengeful_mobility_recast_ultimate" or "modifier_vengeful_mobility_recast"
        self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), name, { duration = illusion_duration })
    end
end

function modifier_vengeful_mobility_illusion:OnDestroy( kv )
    if IsServer() then

        --Prevent trying to find a forgotten ability
        if self:GetAbility() then
            local my_name = self:GetAbility():GetAbilityName()
            local name = string.ends(my_name, "_ultimate") and "vengeful_mobility_swap_ultimate" or "vengeful_mobility_swap"
            local modifier_name = string.ends(my_name, "_ultimate") and "modifier_vengeful_mobility_recast_ultimate" or "modifier_vengeful_mobility_recast"

            local ability = self:GetCaster():FindAbilityByName(name)
            ability.illusion_index = nil

            --local activate = not self:GetAbility():IsHidden()
            if string.ends(my_name, "_ultimate") then
                activate = true      
            end

            self:GetCaster():SwapAbilities( 
                my_name,
                name,
                true,--activate,
                false
            )
            SafeDestroyModifier( modifier_name, self:GetCaster(), self:GetCaster() )
        end


        if self:GetParent() ~= nil then
            self:GetParent():ForceKill( false )
            UTIL_Remove( self:GetParent() )
        end
	end
end

-- Status Effects
function modifier_vengeful_mobility_illusion:CheckState()
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
function modifier_vengeful_mobility_illusion:GetEffectName()
	return "particles/items4_fx/nullifier_slow.vpcf"
end

function modifier_vengeful_mobility_illusion:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

