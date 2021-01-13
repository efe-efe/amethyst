modifier_ruby = class({})

function modifier_ruby:OnCreated(params)
    self.damage_table = {
        attacker = self:GetParent(),
        damage = 5,
        damage_type = DAMAGE_TYPE_PURE,
    }

    if IsServer() then
        self:SetStackCount(params.procs)
        self.efx_index = ParticleManager:CreateParticle("particles/generic_gameplay/rune_haste_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    end
end

function modifier_ruby:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.efx_index, false)
        ParticleManager:ReleaseParticleIndex(self.efx_index)
    end
end

function modifier_ruby:OnStackCountChanged(iStackCount)
    if self:GetStackCount() == 0 then
        self:Destroy()
    end
end

function modifier_ruby:DeclareFunctions()
    return { 
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
        MODIFIER_EVENT_ON_ATTACK_LANDED,
        MODIFIER_EVENT_ON_ATTACK,
    }
end

function modifier_ruby:OnAttack(params)
    if params.attacker ~= self:GetParent() then
        return
    end

    EmitSoundOn("Hero_DoomBringer.LvlDeath", params.target)
    EFX("particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_fireblast.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = params.target:GetAbsOrigin(),
        cp1 = params.target:GetAbsOrigin(),
        release = true
    })
    self:DecrementStackCount()
end 

function modifier_ruby:OnAbilityFullyCast(params)
    if IsServer() then
        if params.unit ~= self:GetParent() then
            return
        end

        if params.ability == self:GetParent():GetAbilityByIndex(0) then
            EFX("particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_fireblast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), {
                cp1 = self:GetParent():GetAbsOrigin(),
                release = true
            })
        end
    end
end

function modifier_ruby:OnAttackLanded(event)
    self.damage_table.victim = event.target
    ApplyDamage(self.damage_table)
end

function modifier_ruby:GetMaxStacks() return 10 end
function modifier_ruby:GetStatusTriggerType() return STATUS_TRIGGER_STACKS end
function modifier_ruby:GetStatusLabel() return "Ruby" end
function modifier_ruby:GetStatusPriority() return 2 end
function modifier_ruby:GetStatusStyle() return "Ruby" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_ruby)