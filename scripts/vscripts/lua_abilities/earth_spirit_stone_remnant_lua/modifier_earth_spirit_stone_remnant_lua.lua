modifier_earth_spirit_stone_remnant_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_earth_spirit_stone_remnant_lua:IsHidden()
	return true
end

function modifier_earth_spirit_stone_remnant_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_earth_spirit_stone_remnant_lua:OnCreated( kv )

end

function modifier_earth_spirit_stone_remnant_lua:OnRefresh( kv )
	
end

function modifier_earth_spirit_stone_remnant_lua:OnDestroy( kv )
	if IsServer() then
		self:GetParent():ForceKill( false )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
-- function modifier_earth_spirit_stone_remnant_lua:DeclareFunctions()
-- 	local funcs = {
-- 		MODIFIER_PROPERTY_XX,
-- 		MODIFIER_EVENT_YY,
-- 	}

-- 	return funcs
-- end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_earth_spirit_stone_remnant_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_earth_spirit_stone_remnant_lua:GetEffectName()
-- 	return "particles/units/heroes/hero_nevermore/nevermore_shadowraze_debuff.vpcf"
-- end

-- function modifier_earth_spirit_stone_remnant_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end