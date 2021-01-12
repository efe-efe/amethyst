modifier_burning_attacks = class({})

function modifier_burning_attacks:OnCreated(params)
    self.damage_table = {
        attacker = self:GetParent(),
        damage = 5,
        damage_type = DAMAGE_TYPE_PURE,
    }

    if IsServer() then
        self:SetStackCount(params.procs)
    end
end

function modifier_burning_attacks:OnStackCountChanged(iStackCount)
    if self:GetStackCount() == 0 then
        self:Destroy()
    end
end

function modifier_burning_attacks:DeclareFunctions()
    return { 
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
        MODIFIER_EVENT_ON_ATTACK_LANDED,
        MODIFIER_EVENT_ON_ATTACK,
    }
end

function modifier_burning_attacks:OnAttack(params)
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

function modifier_burning_attacks:OnAbilityFullyCast(params)
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

function modifier_burning_attacks:OnAttackLanded(event)
    self.damage_table.victim = event.target
    ApplyDamage(self.damage_table)
end

function modifier_burning_attacks:GetMaxStacks() return 10 end
function modifier_burning_attacks:GetStatusTriggerType() return STATUS_TRIGGER_STACKS end
function modifier_burning_attacks:GetStatusLabel() return "Ruby" end
function modifier_burning_attacks:GetStatusPriority() return 2 end
function modifier_burning_attacks:GetStatusStyle() return "Ruby" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_burning_attacks)