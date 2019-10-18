modifier_vengeful_mobility_illusion = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_vengeful_mobility_illusion:IsHidden()
	return false
end

function modifier_vengeful_mobility_illusion:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_vengeful_mobility_illusion:OnCreated( kv )
    if IsServer() then
        ProgressBars:AddProgressBar(self:GetCaster(), self:GetName(), {
			style = "Generic",
			text = "duration",
			progressBarType = "duration",
			priority = 1,
		})
    end
end

function modifier_vengeful_mobility_illusion:OnDestroy( kv )
    if IsServer() then
        
        self:GetCaster():SwapAbilities( 
            "vengeful_mobility",
            "vengeful_mobility_swap",
            true,
            false
        )
            
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

