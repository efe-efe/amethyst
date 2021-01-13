modifier_puck_ultimate_area_check = class({})

function modifier_puck_ultimate_area_check:OnCreated(params)
    self.snap_stun_duration = self:GetAbility():GetSpecialValueFor("snap_stun_duration")
    self.damage_table = {
        victim = self:GetParent(),
        attacker = self:GetCaster(),
        damage = self:GetAbility():GetSpecialValueFor("ability_damage"),
        damage_type = DAMAGE_TYPE_PURE
    }
end

function modifier_puck_ultimate_area_check:OnDestroy()
    if IsServer() then
        if self:GetParent():HasModifier("modifier_puck_ultimate_debuff") then

            ApplyDamage(self.damage_table)

            self:GetParent():RemoveModifierByName("modifier_puck_ultimate_debuff")
            self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_stunned", { duration = self.snap_stun_duration })
            
            EmitSoundOn("Hero_Puck.Dream_Coil_Snap", self:GetParent())
        end
    end
end