modifier_ruby = class({})
modifier_ruby_attack = class({})

function modifier_ruby:OnCreated(params)
    if IsServer() then
        self.damage = params.damage
        self.efx_index = ParticleManager:CreateParticle("particles/generic_gameplay/rune_haste_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    end
end

function modifier_ruby:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.efx_index, false)
        ParticleManager:ReleaseParticleIndex(self.efx_index)
    end
end

function modifier_ruby:DeclareFunctions()
    return { 
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
        --MODIFIER_EVENT_ON_ATTACK_LANDED,
        --MODIFIER_EVENT_ON_ATTACK_FAIL,
        --MODIFIER_EVENT_ON_ATTACK,
    }
end

function modifier_ruby:OnAbilityFullyCast(params)
    if IsServer() then
        if params.unit ~= self:GetParent() then
            return
        end

        if params.ability == self:GetParent():GetAbilityByIndex(0) then
            EFX("particles/gems/ruby_rings.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), {
                cp1 = self:GetParent():GetAbsOrigin(),
                release = true
            })
        end
    end
end

function modifier_ruby:OnEvent(params)
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_STARTED then
        self:GetParent():AddNewModifier(self:GetParent(), nil, 'modifier_ruby_attack', {
            damage = self.damage
        })
    end
end

--[[
function modifier_ruby:OnAttack(params)
    if params.attacker ~= self:GetParent() then
        return
    end

    EmitSoundOn("Hero_DoomBringer.LvlDeath", params.target)
    EFX("particles/gems/ruby.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = params.target:GetAbsOrigin(),
        cp1 = params.target:GetAbsOrigin(),
        release = true
    })
end 

function modifier_ruby:OnAttackLanded(params)
    if params.attacker ~= self:GetParent() then
        return
    end

    if IsServer() then
        self.damage_table.victim = params.target
        ApplyDamage(self.damage_table)
    end
end

function modifier_ruby:OnAttackFail(params)
    if params.attacker ~= self:GetParent() then
        return
    end
end
]]
function modifier_ruby:GetStatusLabel() return "Ruby" end
function modifier_ruby:GetStatusPriority() return 2 end
function modifier_ruby:GetStatusStyle() return "Ruby" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_ruby)
Modifiers.OnEvent(modifier_ruby)

function modifier_ruby_attack:OnCreated(params)
    if IsServer() then
        self.damage_table = {
            attacker = self:GetParent(),
            damage = params.damage,
            damage_type = DAMAGE_TYPE_PURE,
        }
    end
end

function modifier_ruby_attack:OnEvent(params)
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_ENDED then
        self:Destroy()
    end
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED then
        if IsServer() then
            self.damage_table.victim = params.hTarget
            ApplyDamage(self.damage_table)

            EmitSoundOn("Hero_DoomBringer.LvlDeath", params.hTarget)
            EFX("particles/gems/ruby.vpcf", PATTACH_WORLDORIGIN, nil, {
                cp0 = params.hTarget:GetAbsOrigin(),
                cp1 = params.hTarget:GetAbsOrigin(),
                release = true
            })
        end
    end
end

Modifiers.OnEvent(modifier_ruby_attack)