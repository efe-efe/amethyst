modifier_upgrade_stun_attack = class({})
modifier_upgrade_stun_attack_attack = class({})

function modifier_upgrade_stun_attack:RemoveOnDeath() return false end
function modifier_upgrade_stun_attack:IsPurgable() return false end

function modifier_upgrade_stun_attack:OnCreated(params)
    if IsServer() then
        self.proc_chance_pct =  15
        self.proc_chance_pct_per_stack = 10

        self:SetStackCount(1)
    end
end

function modifier_upgrade_stun_attack:OnRefresh(params)
    if IsServer() then
        self:IncrementStackCount()
    end
end

function modifier_upgrade_stun_attack:OnEvent(params)
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_STARTED then
        self:GetParent():AddNewModifier(self:GetParent(), nil, 'modifier_upgrade_stun_attack_attack', {
            proc_chance_pct = self.proc_chance_pct + (self.proc_chance_pct_per_stack * self:GetStackCount())
        })
    end
end


function modifier_upgrade_stun_attack_attack:IsHidden()
    return true
end

function modifier_upgrade_stun_attack_attack:OnCreated(params)
    if IsServer() then
        self.proc_chance_pct = params.proc_chance_pct
        self.damage_table = {
            attacker = self:GetParent(),
            damage = 10,
            damage_type = DAMAGE_TYPE_MAGICAL,
        }
        self.stun_duration = 1.0
    end
end

function modifier_upgrade_stun_attack_attack:OnEvent(params)
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_ENDED then
        self:Destroy()
    end
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED then
        if IsServer() then
            if RandomInt(1, 100) <= self.proc_chance_pct then
                if params.hTarget:IsAlive() then
                    self:Stun(self:GetParent(), params.hTarget)
                end
            end
        end
    end
end

function modifier_upgrade_stun_attack_attack:Stun(hSource, hTarget)
    local direction = Direction2D(hSource:GetAbsOrigin(), hTarget:GetAbsOrigin())
    EFX("particles/units/heroes/hero_spirit_breaker/spirit_breaker_greater_bash.vpcf", PATTACH_CUSTOMORIGIN, hTarget, {
        cp0 = {
            ent = hTarget,
            point = 'attach_hitloc'
        },
        cp0f = direction,
        release = true,
    })

    self.damage_table.victim = hTarget
    ApplyDamage(self.damage_table)
    hTarget:AddNewModifier(hSource, nil, "modifier_generic_stunned", { duration = self.stun_duration })

    EmitSoundOn("DOTA_Item.SkullBasher", hTarget)
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.OnEvent(modifier_upgrade_stun_attack)
Modifiers.OnEvent(modifier_upgrade_stun_attack_attack)