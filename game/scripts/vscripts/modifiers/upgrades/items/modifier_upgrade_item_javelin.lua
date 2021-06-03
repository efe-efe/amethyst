modifier_upgrade_item_javelin = class({})
modifier_upgrade_item_javelin_attack = class({})

function modifier_upgrade_item_javelin:RemoveOnDeath() return false end
function modifier_upgrade_item_javelin:IsPurgable() return false end

function modifier_upgrade_item_javelin:OnCreated(params)
    if IsServer() then
        self.proc_chance_pct =  25
    end
end

function modifier_upgrade_item_javelin:OnEvent(params)
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_STARTED then
        self:GetParent():AddNewModifier(self:GetParent(), nil, 'modifier_upgrade_item_javelin_attack', {
            proc_chance_pct = self.proc_chance_pct
        })
    end
end

function modifier_upgrade_item_javelin_attack:IsHidden()
    return true
end

function modifier_upgrade_item_javelin_attack:OnCreated(params)
    if IsServer() then
        self.proc_chance_pct = params.proc_chance_pct
        self.damage_table = {
            attacker = self:GetParent(),
            damage = 10,
            damage_type = DAMAGE_TYPE_MAGICAL,
        }
    end
end

function modifier_upgrade_item_javelin_attack:OnEvent(params)
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_ENDED then
        self:Destroy()
    end
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED then
        if IsServer() then
            if RandomInt(1, 100) <= self.proc_chance_pct then
                if params.hTarget:IsAlive() then
                    self.damage_table.victim = hTarget
                    ApplyDamage(self.damage_table)
                    EmitSoundOn("DOTA_Item.Javelin", hTarget)
                end
            end
        end
    end
end

function modifier_upgrade_item_javelin:GetTexture()
    return 'item_javelin'
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.OnEvent(modifier_upgrade_item_javelin)
Modifiers.OnEvent(modifier_upgrade_item_javelin_attack)