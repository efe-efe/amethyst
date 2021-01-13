
-------------------------------------------------
-- Modifier Definition

modifier_progress_bars_dummy = class({})

function modifier_progress_bars_dummy:OnCreated(keys) 

end

function modifier_progress_bars_dummy:GetAttributes()
  return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE --+ MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_progress_bars_dummy:IsHidden()
  return true
end

function modifier_progress_bars_dummy:IsDebuff() 
  return false
end

function modifier_progress_bars_dummy:IsPurgable() 
  return false
end

function modifier_progress_bars_dummy:CheckState() 
  local state = {  }
  return state
end

