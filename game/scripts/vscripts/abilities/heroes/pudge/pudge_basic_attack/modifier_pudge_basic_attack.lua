modifier_pudge_basic_attack = class({})

function modifier_pudge_basic_attack:OnCreated( params )
    if IsServer() then
        self.fading_slow_pct = self:GetAbility():GetSpecialValueFor("fading_slow_pct")
        self.fading_slow_duration = self:GetAbility():GetSpecialValueFor("fading_slow_duration")

        self:GetParent():AddStatusBar({
            label = "Infection", modifier = self, priority = 2, stylename="Infection"
        }) 
    end
end

function modifier_pudge_basic_attack:OnRefresh()
    if IsServer() then
        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_fading_slow_new", { 
            duration = self.fading_slow_duration,
            max_slow_pct = self.fading_slow_pct 
        })
        self:Destroy()
    end
end
