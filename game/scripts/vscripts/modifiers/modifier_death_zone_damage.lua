modifier_death_zone_damage = class({})

function modifier_death_zone_damage:IsHidden() return false end
function modifier_death_zone_damage:IsDebuff() return true end

function modifier_death_zone_damage:OnCreated(kv)
    if IsServer() then
        EmitSoundOn("Hero_Phoenix.SuperNova.Cast", self:GetParent())
        ScreenShake(self:GetParent():GetAbsOrigin(), 100, 300, 0.45, 1000, 0, true)

        self:StartIntervalThink(1.0)

        self.effect_cast = ParticleManager:CreateParticle("particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_ignite_burn.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        self.effect_cast_b = ParticleManager:CreateParticle("particles/mod_units/heroes/hero_phoenix/phoenix_fire_spirit_burn.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        self.effect_cast_c = ParticleManager:CreateParticle("particles/econ/events/ti10/radiance_ti10.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    end
end

function modifier_death_zone_damage:OnDestroy()
    if IsServer() then
        StopSoundOn("Hero_Phoenix.SuperNova.Cast", self:GetParent())
        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)
        
        ParticleManager:DestroyParticle(self.effect_cast_b, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast_b)

        ParticleManager:DestroyParticle(self.effect_cast_c, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast_c)
    end
end

function modifier_death_zone_damage:OnIntervalThink()
    local damage_table = {
        damage = 15,
        damage_type = DAMAGE_TYPE_PURE,
        victim = self:GetParent(),
        attacker = self:GetParent(),
    }
    ApplyDamage(damage_table)
    self:PlayEffectsOnTarget(self:GetParent())
    self:Destroy()
end

function modifier_death_zone_damage:PlayEffectsOnTarget(hTarget)
    local particle_cast = "particles/econ/items/lion/fish_stick_retro/fish_stick_spell_fish_retro_b.vpcf"

    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)
    ParticleManager:ReleaseParticleIndex(effect_cast)

--TODO
    local particle_cast_b = "particles/econ/items/zeus/arcana_chariot/zeus_tgw_screen_damage.vpcf"
    local effect_cast_b = ParticleManager:CreateParticleForPlayer(particle_cast_b, PATTACH_EYES_FOLLOW, hTarget, hTarget:GetPlayerOwner())
    ParticleManager:ReleaseParticleIndex(effect_cast_b)
end

function modifier_death_zone_damage:GetTexture()
    return "modifier_death_zone_damage"
end