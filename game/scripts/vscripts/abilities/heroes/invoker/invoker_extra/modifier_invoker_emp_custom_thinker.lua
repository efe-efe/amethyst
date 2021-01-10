modifier_invoker_emp_custom_thinker = class({})

function modifier_invoker_emp_custom_thinker:OnCreated(params)
    self.caster = self:GetCaster()
    self.origin = self:GetParent():GetAbsOrigin()
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.mana_burn = 25--self:GetAbility():GetSpecialValueFor("mana_burn")

    if IsServer() then
        self.damage_table = {
            attacker = self.caster,
            damage = self.mana_burn,
            damage_type = DAMAGE_TYPE_PURE,
        }

        CreateTimedRadiusMarker(self.caster, self.origin, self.radius, self:GetDuration(), 0.2, RADIUS_SCOPE_PUBLIC)
        AddFOWViewer(self.caster:GetTeamNumber(), self.origin, self.radius, self:GetDuration() +  0.2, true)
        self:StartIntervalThink(0.03)

        self.efx = EFX("particles/units/heroes/hero_invoker/invoker_emp.vpcf", PATTACH_WORLDORIGIN, self.caster, {
            cp0 = self.origin,
            cp1 = Vector(self.radius, 0, 0)
        })
        EmitSoundOn("Hero_Invoker.EMP.Charge", self:GetParent())
    end
end

function modifier_invoker_emp_custom_thinker:OnDestroy()
    if IsServer() then
        ApplyCallbackForUnitsInArea(self.caster, self.origin, self.radius/2, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
            self.damage_table.victim = unit
            ApplyDamage(self.damage_table)
            unit:GiveManaCustom(-self.mana_burn)
        end)

        
        ApplyCallbackForUnitsInArea(self.caster, self.origin, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
            self.damage_table.victim = unit
            ApplyDamage(self.damage_table)
            unit:GiveManaCustom(-self.mana_burn)
        end)
    
        ParticleManager:DestroyParticle(self.efx, true)
        ParticleManager:ReleaseParticleIndex(self.efx)
        
        StopSoundOn("Hero_Invoker.EMP.Charge", self:GetParent())
        EmitSoundOn("Hero_Invoker.EMP.Discharge", self:GetParent())

        UTIL_Remove(self:GetParent())
    end
end

function modifier_invoker_emp_custom_thinker:OnIntervalThink()
    if IsServer() then
        local enemies = CustomEntities:FindUnitsInRadius(
            self:GetCaster(),
            self.origin, 
            self.radius, 
            DOTA_UNIT_TARGET_TEAM_ENEMY, 
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER
       )
        for _,enemy in pairs(enemies) do
            local direction = (self.origin - enemy:GetOrigin()):Normalized()
            local point = enemy:GetAbsOrigin() + direction * 8
            enemy:SetAbsOrigin(point)
            FindClearSpaceForUnit(enemy, enemy:GetAbsOrigin(), true)
        end
    end
end
