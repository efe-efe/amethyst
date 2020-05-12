modifier_terrorblade_mobility_illusion = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_terrorblade_mobility_illusion:IsHidden() return false
end

function modifier_terrorblade_mobility_illusion:IsPurgable() return false
end

function modifier_terrorblade_mobility_illusion:Model()
    local base = self:GetCaster():FindModifierByName("modifier_terrorblade_base")
    if base == nil then print("modifier_terrorblade_mobility_illusion: ERROR ON MODEL SELECITON") return "NOTHING" end

    if base:GetState() == "NORMAL" then
        return "models/heroes/terrorblade/demon.vmdl"
    else
        return "models/heroes/terrorblade/terrorblade.vmdl"
    end
end

function modifier_terrorblade_mobility_illusion:OnDestroy( kv )
    if IsServer() then
        if self:GetParent() ~= nil then
            self:GetParent():ForceKill( false )
            UTIL_Remove( self:GetParent() )
        end
	end
end

-- Status Effects
function modifier_terrorblade_mobility_illusion:CheckState()
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
-- Modifier Effects
function modifier_terrorblade_mobility_illusion:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
	}

	return funcs
end

function modifier_terrorblade_mobility_illusion:GetModifierModelChange()
	return self:Model()
end

function modifier_terrorblade_mobility_illusion:GetModifierModelScale()
    if self:Model() == "models/heroes/terrorblade/demon.vmdl" then
        return -15
    else
        return 0
    end
end


--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_terrorblade_mobility_illusion:GetEffectName()
	return "particles/status_fx/status_effect_terrorblade_reflection.vpcf"
end

function modifier_terrorblade_mobility_illusion:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

