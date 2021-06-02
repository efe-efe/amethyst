modifier_upgrade_maelstrom = class({})
modifier_upgrade_maelstrom_attack = class({})

function modifier_upgrade_maelstrom:RemoveOnDeath() return false end
function modifier_upgrade_maelstrom:IsPurgable() return false end

function modifier_upgrade_maelstrom:OnCreated(params)
    if IsServer() then
        self.proc_chance_pct =  50
    end
end

function modifier_upgrade_maelstrom:OnEvent(params)
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_STARTED then
        self:GetParent():AddNewModifier(self:GetParent(), nil, 'modifier_upgrade_maelstrom_attack', {
            proc_chance_pct = self.proc_chance_pct
        })
    end
end


function modifier_upgrade_maelstrom_attack:IsHidden()
    return true
end

function modifier_upgrade_maelstrom_attack:OnCreated(params)
    if IsServer() then
        self.proc_chance_pct = params.proc_chance_pct
        self.radius = 850
        self.procs = 5
        self.damage_table = {
            attacker = self:GetParent(),
            damage = 5,
            damage_type = DAMAGE_TYPE_MAGICAL,
        }
        self.targets = {}
        self.sources = {}
    end
end

function modifier_upgrade_maelstrom_attack:OnEvent(params)
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_ENDED then
        self:Destroy()
    end
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED then
        if IsServer() then
            if RandomInt(1, 100) <= self.proc_chance_pct then
                if params.hTarget:IsAlive() then
                    EmitSoundOn("Item.Maelstrom.Chain_Lightning", params.hTarget)
                    self:ReleaseBolt(self:GetParent(), params.hTarget)
                end
            end
        end
    end
end

function modifier_upgrade_maelstrom_attack:ReleaseBolt(hSource, hTarget)
    EFX("particles/econ/events/ti10/maelstrom_ti10.vpcf", PATTACH_CUSTOMORIGIN, hSource, {
        cp0 = {
            ent = hSource,
            point = 'attach_hitloc'
        },
        cp1 = {
            ent = hTarget,
            point = 'attach_hitloc'
        },
        release = true,
    })

    self.sources[hSource:GetEntityIndex()] = true
    self.targets[hTarget:GetEntityIndex()] = true
    self.damage_table.victim = hTarget
    ApplyDamage(self.damage_table)

    if self.procs > 0 then
        ApplyCallbackForUnitsInArea(self:GetParent(), hTarget:GetAbsOrigin(), self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
            if not self.targets[unit:GetEntityIndex()] and not self.sources[hSource] then
                self.procs = self.procs - 1
                EmitSoundOn("Item.Maelstrom.Chain_Lightning.Jump", unit)
                self:ReleaseBolt(hTarget, unit)
            end
        end)
    end
end

function modifier_upgrade_maelstrom:GetTexture()
    return 'item_maelstrom'
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.OnEvent(modifier_upgrade_maelstrom)
Modifiers.OnEvent(modifier_upgrade_maelstrom_attack)