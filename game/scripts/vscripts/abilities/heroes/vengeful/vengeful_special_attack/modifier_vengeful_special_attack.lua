modifier_vengeful_special_attack = class({})

function modifier_vengeful_special_attack:OnCreated(params)
    if IsServer() then
        self.max_range = self:GetAbility():GetSpecialValueFor("link_range")
        self.extra_damage = self:GetAbility():GetSpecialValueFor("extra_damage")
        self.root_duration = self:GetAbility():GetSpecialValueFor("root_duration")
        self.caster = self:GetCaster()
        self.parent = self:GetParent()
        self.damage_table = {
            victim = self.parent,
            attacker = self.caster,
            damage = self.extra_damage,
            damage_type = DAMAGE_TYPE_PURE,
            ability = self:GetAbility(),
        }

        self.efx = EFX("particles/vengeful/vengeful_special_attack.vpcf", PATTACH_CUSTOMORIGIN, self.parent, {
            cp0 = {
                ent = self.caster,
                point = 'attach_hitloc'
            },
            cp1 = {
                ent = self.parent,
                point = 'attach_hitloc'
            },
        })

        self:StartIntervalThink(0.03)
    end
end

function modifier_vengeful_special_attack:OnRefresh(params)
    if IsServer() then
        self:OnTrigger()
    end
end

function modifier_vengeful_special_attack:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.efx, false)
        ParticleManager:ReleaseParticleIndex(self.efx)

        if self:GetRemainingTime() < 0.05 then
            self:OnTrigger()
        else 
            --EmitSoundOn("Hero_VengefulSpirit.MagicMissileImpact", self.parent)
        end
    end
end

function modifier_vengeful_special_attack:OnIntervalThink()
    local target_origin = self.caster:GetAbsOrigin()
    local caster_origin = self.parent:GetAbsOrigin()
    local distance = (caster_origin - target_origin):Length2D()

    if distance > self.max_range then
        self:Destroy()
    end
end

function modifier_vengeful_special_attack:OnTrigger()
    ApplyDamage(self.damage_table)
    self.parent:AddNewModifier(self.caster, self.ability , "modifier_generic_stunned", { duration = 0.1 })
    self.parent:AddNewModifier(self.caster, self.ability , "modifier_generic_root", { duration = self.root_duration })

    EmitSoundOn("Hero_VengefulSpirit.MagicMissileImpact", self.parent)
    EFX("particles/econ/items/vengeful/vs_ti8_immortal_shoulder/vs_ti8_immortal_magic_missle_end.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = self.parent:GetAbsOrigin(),
        cp3 = self.parent:GetAbsOrigin(),
        release = true
    })

    EFX("particles/vengeful/vengeful_special_attack_trigger.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = self.parent:GetAbsOrigin(),
        cp1 = self.parent:GetAbsOrigin(),
        release = true
    })
end

function modifier_vengeful_special_attack:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_vengeful_special_attack:OnDeath(params)
    if IsServer() then 
        if params.unit == self.caster then 
            self:Destroy()
        end
    end
end

function modifier_vengeful_special_attack:GetStatusLabel() return "Soul Bond" end
function modifier_vengeful_special_attack:GetStatusPriority() return 4 end
function modifier_vengeful_special_attack:GetStatusStyle() return "SoulBond" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_vengeful_special_attack)