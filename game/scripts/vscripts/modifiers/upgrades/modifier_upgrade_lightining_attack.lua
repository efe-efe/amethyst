modifier_upgrade_lightining_attack = class({})
modifier_upgrade_lightining_attack_attack = class({})

function modifier_upgrade_lightining_attack:OnCreated(params)
    if IsServer() then
        self.efx_index = ParticleManager:CreateParticle("particles/generic_gameplay/rune_haste_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    end
end

function modifier_upgrade_lightining_attack:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.efx_index, false)
        ParticleManager:ReleaseParticleIndex(self.efx_index)
    end
end

function modifier_upgrade_lightining_attack:OnEvent(params)
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_STARTED then
        self:GetParent():AddNewModifier(self:GetParent(), nil, 'modifier_upgrade_lightining_attack_attack', {})
    end
end


function modifier_upgrade_lightining_attack_attack:IsHidden()
    return true
end

function modifier_upgrade_lightining_attack_attack:OnCreated(params)
    if IsServer() then
        self.proc_chance_pct = 50
        self.radius = 850
        self.procs = 5
        self.damage_table = {
            attacker = self:GetParent(),
            damage = 2,
            damage_type = DAMAGE_TYPE_MAGICAL,
        }
        self.targets = {}
        self.sources = {}
    end
end

function modifier_upgrade_lightining_attack_attack:OnEvent(params)
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_ENDED then
        self:Destroy()
    end
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED then
        if IsServer() then
            if RandomInt(1, 100) <= self.proc_chance_pct then
                if params.hTarget:IsAlive() then
                    self:ReleaseBolt(self:GetParent(), params.hTarget)
                end
            end
        end
    end
end

function modifier_upgrade_lightining_attack_attack:ReleaseBolt(hSource, hTarget)
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
                self:ReleaseBolt(hTarget, unit)
            end
        end)
    end
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.OnEvent(modifier_upgrade_lightining_attack)
Modifiers.OnEvent(modifier_upgrade_lightining_attack_attack)