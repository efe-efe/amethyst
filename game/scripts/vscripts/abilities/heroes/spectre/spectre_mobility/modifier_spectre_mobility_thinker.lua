modifier_spectre_mobility_thinker = class({})

function modifier_spectre_mobility_thinker:OnCreated(params)
    if IsServer() then
        local caster = self:GetCaster()
        local origin = self:GetParent():GetAbsOrigin()
        self.radius = self:GetAbility():GetSpecialValueFor('radius')
        self.heal = self:GetAbility():GetSpecialValueFor('heal')
        self.desolate_duration = self:GetAbility():GetSpecialValueFor('desolate_duration')
        self.fear_duration = self:GetAbility():GetSpecialValueFor('fear_duration')
        CreateTimedRadiusMarker(caster, origin, self.radius, self:GetDuration(), 0.2, RADIUS_SCOPE_PUBLIC)
    end
end

function modifier_spectre_mobility_thinker:OnDestroy()
    if IsServer() then
        local caster = self:GetCaster()
        local origin = self:GetParent():GetAbsOrigin()
        FindClearSpaceForUnit(caster, origin, false)
        SafeDestroyModifier("modifier_spectre_banish", caster, caster)
        
        local enemies = ApplyCallbackForUnitsInArea(caster, self:GetParent():GetAbsOrigin(), self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(enemy)
            enemy:AddNewModifier(caster, self, "modifier_spectre_desolate_custom", { duration = self.desolate_duration })
            if self:GetAbility():GetLevel() >= 2 then
                enemy:AddNewModifier(caster, self, "modifier_spectre_ex_mobility_fear", { duration = self.fear_duration })
            end
            EmitSoundOn("Hero_Spectre.Attack", enemy)
        end)

        if #enemies > 0 then
            caster:Heal(self.heal, caster)
        end

        EFX('particles/econ/items/outworld_devourer/od_shards_exile_gold/od_shards_exile_prison_end_gold.vpcf', PATTACH_WORLDORIGIN, caster, {
            cp0 = self:GetParent():GetAbsOrigin(),
            release = true,
        })
        EFX('particles/spectre/spectre_mobility.vpcf', PATTACH_WORLDORIGIN, caster, {
            cp0 = self:GetParent():GetAbsOrigin(),
            cp2 = Vector(self.radius, 1, 1),
            release = true,
        })

        UTIL_Remove(self:GetParent())
    end
end