modifier_queen_attack = class({})

function modifier_queen_attack:OnCreated(params)
	if IsServer() then
        self.caster = self:GetCaster()
        self.damage_table = {
            attacker = self.caster,
            damage = 5,--self:GetAbility():GetSpecialValueFor("ability_damage"),
            damage_type = DAMAGE_TYPE_PURE,
            victim = self:GetParent()
        }
		self:StartIntervalThink(1.0)
	end
end

function modifier_queen_attack:OnIntervalThink()
	if IsServer() then
        ApplyDamage(self.damage_table)
	end
end

function modifier_queen_attack:GetEffectName()
    return "particles/generic_gameplay/rune_haste.vpcf"
end

function modifier_queen_attack:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_queen_attack:GetMaxSlowPercentage()
	return self:GetAbility():GetSpecialValueFor("fading_slow_pct")
end

function modifier_queen_attack:GetStatusEffectName()
    return "particles/status_fx/status_effect_terrorblade_reflection.vpcf"
end

function modifier_queen_attack:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end