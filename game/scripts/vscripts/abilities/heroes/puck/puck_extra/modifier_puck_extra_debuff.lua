modifier_puck_extra_debuff = class({})

function modifier_puck_extra_debuff:OnCreated(params)
    if IsServer() then
        self.silence_duration = self:GetAbility():GetSpecialValueFor("silence_duration")
    end
end

function modifier_puck_extra_debuff:DeclareFunctions()
    return { MODIFIER_EVENT_ON_ORDER }
end

function modifier_puck_extra_debuff:OnOrder(params)
    if params.unit == self:GetParent() then
        if
            params.order_type == DOTA_UNIT_ORDER_CAST_POSITION or
            params.order_type == DOTA_UNIT_ORDER_CAST_NO_TARGET
        then
            if self:GetAbility():GetLevel() >= 2 then
                self:GetAbility():EndCooldown()
                EFX("particles/puck/puck_ex_base_attack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster(), {
                    release = true
                })
            end

            self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_silence", { duration = self.silence_duration })

            EmitSoundOn("Hero_Puck.IIllusory_Orb_Damage", self:GetParent())

            local effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_puck/puck_waning_rift.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
            ParticleManager:SetParticleControl(effect_cast, 1, Vector(100, 100, 100))
            ParticleManager:ReleaseParticleIndex(effect_cast)

            self:Destroy()
        end
    end
end

function modifier_puck_extra_debuff:GetStatusLabel() return "SpellBlock" end
function modifier_puck_extra_debuff:GetStatusPriority() return 4 end
function modifier_puck_extra_debuff:GetStatusStyle() return "SpellBlock" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_puck_extra_debuff)