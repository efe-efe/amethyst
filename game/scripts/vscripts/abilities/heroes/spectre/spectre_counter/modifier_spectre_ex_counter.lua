modifier_spectre_ex_counter = class({})

function modifier_spectre_ex_counter:OnCreated()
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.parent = self:GetParent()
        self.heal = self:GetAbility():GetSpecialValueFor("heal")
		self.fading_slow_duration = self:GetAbility():GetSpecialValueFor("fading_slow_duration")
		self.fading_slow_pct = self:GetAbility():GetSpecialValueFor("fading_slow_pct")
        self.damage_table = {
            attacker = self.parent,
            damage = self:GetAbility():GetSpecialValueFor("ability_damage"),
            damage_type = DAMAGE_TYPE_PURE,
        }

        local origin = self.parent:GetAbsOrigin()
        local efx = ParticleManager:CreateParticle("particles/spectre/spectre_ex_counter.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
        ParticleManager:SetParticleControl(efx, 2, Vector(self.radius, self.radius, self.radius))
        ParticleManager:SetParticleControlEnt(efx, 3, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, origin, true)
        ParticleManager:SetParticleControlEnt(efx, 6, self.parent, PATTACH_POINT_FOLLOW, "attach_attack2", origin, true)
        self:AddParticle(efx, false, false, -1, false, false)
    end
end

function modifier_spectre_ex_counter:OnDestroy()
    if IsServer() then
        local origin = self.parent:GetAbsOrigin()
        local give_health = false
        ApplyCallbackForUnitsInArea(self.parent, origin, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
            self.damage_table.victim = unit
            ApplyDamage(self.damage_table)

            unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_fading_slow", { 
                duration = self.fading_slow_duration,
                max_slow_pct = self.fading_slow_pct 
            })

            if unit:ProvidesMana() then
                give_health = true
            end
            
            EFX('particles/econ/items/outworld_devourer/od_shards_exile_gold/od_shards_exile_prison_end_gold.vpcf', PATTACH_WORLDORIGIN, unit, {
                cp0 = unit:GetAbsOrigin(),
                release = true,
            })

            FindClearSpaceForUnit(unit, origin, true)
                
            EFX('particles/econ/items/outworld_devourer/od_shards_exile_gold/od_shards_exile_prison_end_gold.vpcf', PATTACH_WORLDORIGIN, unit, {
                cp0 = unit:GetAbsOrigin(),
                release = true,
            })
        end)

        if give_health then
            self.parent:Heal(self.heal, self.parent)
        end

        EmitSoundOn("Hero_ShadowDemon.DemonicPurge.Damage", self.parent)
        local efx = ParticleManager:CreateParticle("particles/units/heroes/hero_grimstroke/grimstroke_ink_swell_aoe.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
        ParticleManager:SetParticleControl(efx, 2, Vector(self.radius, self.radius, self.radius))

        CreateRadiusMarker(self.parent, origin, self.radius, RADIUS_SCOPE_PUBLIC, 0.1)
    end
end

function modifier_spectre_ex_counter:GetStatusLabel() return "Revenant" end
function modifier_spectre_ex_counter:GetStatusPriority() return 2 end
function modifier_spectre_ex_counter:GetStatusStyle() return "Revenant" end
function modifier_spectre_ex_counter:GetStatusContentType() return STATUS_CONTENT_FILLUP end
function modifier_spectre_ex_counter:GetStatusEffectName()
    return "particles/status_fx/status_effect_grimstroke_ink_swell.vpcf"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_spectre_ex_counter)