modifier_ex_pudge_counter_debuff = class({})

function modifier_ex_pudge_counter_debuff:OnCreated()
    self.speed_debuff_pct = -self:GetAbility():GetSpecialValueFor("speed_debuff_pct")

    if IsServer() then
        self.caster = self:GetCaster()
        self.damage_per_tick = self:GetAbility():GetSpecialValueFor("damage_per_second")/2
        self.interval = 0.5
        self.parent = self:GetParent()

        self.parent:AddStatusBar({
            label = "Rot", modifier = self, priority = 3, stylename="Infection"
        })

        self:OnIntervalThink()
        self:StartIntervalThink(self.interval)
        self:PlayEffectsOnCreated()
    end
end

function modifier_ex_pudge_counter_debuff:OnIntervalThink()
    local damage_table = {
        victim = self.parent,
        attacker = self.caster,
        damage = self.damage_per_tick,
        damage_type = DAMAGE_TYPE_PURE,
    }

    ApplyDamage( damage_table )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_ex_pudge_counter_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_EVENT_ON_ORDER,
	}

	return funcs
end

function modifier_ex_pudge_counter_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_debuff_pct
end

function modifier_ex_pudge_counter_debuff:PlayEffectsOnCreated()
    local nFXIndex = ParticleManager:CreateParticle( "particles/econ/items/pudge/pudge_immortal_arm/pudge_immortal_arm_rot_recipient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
    self:AddParticle( nFXIndex, false, false, -1, false, false )
end
