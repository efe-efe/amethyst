modifier_orb_timer_apply_glow_lua = class ({})
--------------------------------------------------------------------------------
-- Classifications
function modifier_orb_timer_apply_glow_lua:IsHidden()
	return false
end

function modifier_orb_timer_apply_glow_lua:IsDebuff()
	return false
end

function modifier_orb_timer_apply_glow_lua:IsPurgable()
	return false
end

-- Graphics & Animations
function modifier_orb_timer_apply_glow_lua:GetEffectName()
	--return "models/items/rubick/rubick_arcana/sfm/particles/rubick_arcana_temp_2_rocks_glow.vpcf"
	--return "particles/base_attacks/ranged_badguy_persistent_glow_green.vpcf"
	return "particles/units/heroes/hero_wisp/wisp_overcharge_c.vpcf"
end

function modifier_orb_timer_apply_glow_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_orb_timer_apply_glow_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	}

	return state
end

