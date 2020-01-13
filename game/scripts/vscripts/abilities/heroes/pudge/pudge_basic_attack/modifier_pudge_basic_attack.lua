modifier_pudge_basic_attack = class({})

function modifier_pudge_basic_attack:OnCreated( params )
    self.damage = self:GetAbility():GetSpecialValueFor("extra_damage")
    if IsServer() then
        self:GetParent():AddStatusBar({
            label = "Infection", modifier = self, priority = 4, stylename="Infection"
        }) 
    end
end

function modifier_pudge_basic_attack:OnDestroy()
    if IsServer() then
        local damage_table = {
            victim = self:GetParent(),
            attacker = self:GetCaster(),
            damage = self.damage,
            damage_type = DAMAGE_TYPE_PURE,
        }
        ApplyDamage( damage_table )

        local effect_cast = ParticleManager:CreateParticle( "particles/econ/items/sand_king/sandking_ti7_arms/sandking_ti7_caustic_finale_explode.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
        ParticleManager:ReleaseParticleIndex( effect_cast )
    end
end

function modifier_pudge_basic_attack:OnRefresh()
    if IsServer() then
        self:Destroy()
    end
end
