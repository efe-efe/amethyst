modifier_upgrade_tarrasque = class({})

function modifier_upgrade_tarrasque:RemoveOnDeath() return false end
function modifier_upgrade_tarrasque:IsPurgable() return false end
function modifier_upgrade_tarrasque:IsHidden() return false end

function modifier_upgrade_tarrasque:OnCreated()
    if IsServer() then
        self.extra_health = 50
        self:SetStackCount(1)
    end
end

function modifier_upgrade_tarrasque:OnRefresh()
    if IsServer() then
        self:IncrementStackCount()
    end
end

function modifier_upgrade_tarrasque:OnStackCountChanged(iStackCount)
    if IsServer() then
        EmitSoundOn('Hero_Oracle.FortunesEnd.Target', self:GetParent());
        EFX('particles/gems/emerald.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), {
            cp3 = {
                ent = self:GetParent(),
                point = 'attach_hitloc'
            },
            release = true,
        })
    end
end

function modifier_upgrade_tarrasque:DeclareFunctions()
    return { 
		MODIFIER_PROPERTY_HEALTH_BONUS,
    }
end

function modifier_upgrade_tarrasque:GetModifierHealthBonus()
	return self:GetStackCount() * self.extra_health
end