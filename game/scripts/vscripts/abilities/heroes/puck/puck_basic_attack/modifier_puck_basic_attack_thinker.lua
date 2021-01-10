modifier_puck_basic_attack_thinker = class({})

function modifier_puck_basic_attack_thinker:OnCreated(params)
    self.caster = self:GetCaster()
    self.origin = self:GetParent():GetAbsOrigin()
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.mana_gain_pct = self:GetAbility():GetSpecialValueFor("mana_gain_pct")
    
    if IsServer() then
        self.ex_basic_attack = self.caster:FindAbilityByName('puck_ex_basic_attack')
        self.duration = self.ex_basic_attack:GetSpecialValueFor("duration")
        self.shield_per_hit = self.ex_basic_attack:GetSpecialValueFor("shield_per_hit")
        self.heal_per_hit = self.ex_basic_attack:GetSpecialValueFor("heal_per_hit")
        self.fairy_dust_duration = self.ex_basic_attack:GetSpecialValueFor("fairy_dust_duration")
        self.fairy_dust_slow_pct = self.ex_basic_attack:GetSpecialValueFor("fairy_dust_slow_pct")

        self.damage_table = {
            attacker = self.caster,
            damage = self.caster:GetAverageTrueAttackDamage(self.caster),
            damage_type = DAMAGE_TYPE_PURE,
        }
        self.charged = params.charged == 1
        local delay_time = self.ex_basic_attack:GetSpecialValueFor('delay_time')
        CreateTimedRadiusMarker(self.caster, self.origin, self.radius, delay_time, 0.2, RADIUS_SCOPE_PUBLIC)
        self:StartIntervalThink(delay_time)
    end
end

function modifier_puck_basic_attack_thinker:OnDestroy()
    if IsServer() then
        UTIL_Remove(self:GetParent())
    end
end

function modifier_puck_basic_attack_thinker:OnIntervalThink()
    EmitSoundOn("Hero_Leshrac.Lightning_Storm", self:GetParent())
    local color = Vector(0,0,0)
    if self.charged then
        color = Vector(100,0,0)

        EFX("particles/econ/generic/generic_aoe_explosion_sphere_1/generic_aoe_explosion_sphere_1.vpcf", PATTACH_WORLDORIGIN, nil, {
            cp0 = self.origin,
            cp1 = Vector(200, 0, 0),
            cp2 = Vector(2.0, 1, 1),
            cp3 = Vector(255, 0, 229),
            cp4 = Vector(250, 0, 255),
            release = true
        })
    end

    EFX("particles/puck/puck_basic_attack_related.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = self.origin,
        cp1 = self.origin,
        cp6 = color,
        release = true
    })

    local give_mana = false

    ApplyCallbackForUnitsInArea(self.caster, self.origin, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
        self.damage_table.victim = unit
        ApplyDamage(self.damage_table)
        unit:AddNewModifier(self.caster, nil, "modifier_puck_fairy_dust", { duration = self.fairy_dust_duration, slow_pct = self.fairy_dust_slow_pct })

        if not CustomEntities:IsObstacle(unit) then
            give_mana = true
        end
    end)
    
    if give_mana then
        if self:GetAbility():GetLevel() >=2 then
            self.caster:FindModifierByName("modifier_puck_basic_attack_cooldown"):Replenish()
        end
        
        if self.ex_basic_attack:GetLevel() >= 2 then
            self.caster:Heal(self.heal_per_hit, self.caster)
        end

        self.caster:AddNewModifier(self.caster, nil, "modifier_shield", { duration = 6.0, damage_block = self.shield_per_hit })
        CustomEntities:GiveManaAndEnergyPercent(self.caster, self.mana_gain_pct, true)
    end
    self:Destroy()
end