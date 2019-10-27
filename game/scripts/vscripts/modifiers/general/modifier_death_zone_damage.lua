modifier_death_zone_damage = class({})


function modifier_death_zone_damage:IsHidden()
	return false
end

function modifier_death_zone_damage:IsDebuff()
	return true
end


--------------------------------------------------------------------------------
--Initializer
function modifier_death_zone_damage:OnCreated( kv )
    if IsServer() then
        self:StartIntervalThink(1.0)      
    end
end

--------------------------------------------------------------------------------
--On think
function modifier_death_zone_damage:OnIntervalThink()
    local damage_table = {
        damage = 15,
        damage_type = DAMAGE_TYPE_PURE,
        victim = self:GetParent(),
        attacker = self:GetParent(),
    }
    ApplyDamage( damage_table )
    self:PlayEffectsOnTarget(self:GetParent())
end


function modifier_death_zone_damage:PlayEffectsOnTarget( hTarget )
    local particle_cast = "particles/econ/items/lion/fish_stick_retro/fish_stick_spell_fish_retro_b.vpcf"

    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )
    ParticleManager:ReleaseParticleIndex( effect_cast )

--TODO
    local particle_cast_b = "particles/econ/items/zeus/arcana_chariot/zeus_tgw_screen_damage.vpcf"
    local effect_cast_b = ParticleManager:CreateParticleForPlayer(particle_cast_b, PATTACH_EYES_FOLLOW, hTarget, hTarget:GetPlayerOwner())
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
end

function modifier_death_zone_damage:GetTexture()
    return "modifier_death_zone_damage"
end