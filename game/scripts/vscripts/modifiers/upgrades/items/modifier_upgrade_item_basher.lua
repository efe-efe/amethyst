modifier_upgrade_item_basher = class({})
modifier_upgrade_item_basher_attack = class({})

function modifier_upgrade_item_basher:RemoveOnDeath() return false end
function modifier_upgrade_item_basher:IsPurgable() return false end

function modifier_upgrade_item_basher:OnCreated(params)
    self.damage_per_stack = 10
    self.extra_health = 100
    
    if IsServer() then
        self.proc_chance_pct =  25
    end
end

function modifier_upgrade_item_basher:DeclareFunctions()
    return { 
		MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
end

function modifier_upgrade_item_basher:GetModifierPreAttack_BonusDamage(params)
    return self.damage_per_stack
end

function modifier_upgrade_item_basher:GetModifierHealthBonus()
	return self.extra_health
end

function modifier_upgrade_item_basher:OnEvent(params)
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_STARTED then
        self:GetParent():AddNewModifier(self:GetParent(), nil, 'modifier_upgrade_item_basher_attack', {
            proc_chance_pct = self.proc_chance_pct
        })
    end
end

function modifier_upgrade_item_basher_attack:IsHidden()
    return true
end

function modifier_upgrade_item_basher_attack:OnCreated(params)
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

function modifier_upgrade_item_basher_attack:OnEvent(params)
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

function modifier_upgrade_item_basher_attack:Stun(hSource, hTarget)
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

function modifier_upgrade_item_basher:GetTexture()
    return 'item_basher'
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.OnEvent(modifier_upgrade_item_basher)
Modifiers.OnEvent(modifier_upgrade_item_basher_attack)