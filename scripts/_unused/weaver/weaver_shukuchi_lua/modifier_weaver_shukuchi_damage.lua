modifier_weaver_shukuchi_damage = class({})

--------------------------------------------------------------------------------
-- Initializations
function modifier_weaver_shukuchi_damage:OnCreated( kv )
    local damage = self:GetAbility():GetSpecialValueFor( "damage" )
    local mana_gain = self:GetAbility():GetSpecialValueFor( "mana_gain" )
    local attacker = self:GetAbility():GetCaster()
    
    local mana_gain_final = math.floor(attacker:GetMaxMana() * mana_gain)


	if IsServer() then
        -- Apply Damage
        local damageTable = {
            victim = self:GetParent(),
            attacker = attacker,
            damage = damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            damage_flags = DOTA_DAMAGE_FLAG_NONE,
            --ability = self:GetAbility(), --Optional.
        }
        attacker:GiveMana(mana_gain_final)
        ApplyDamage(damageTable)
        self:PlayEffects()
    end
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function modifier_weaver_shukuchi_damage:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_weaver/weaver_shukuchi_damage.vpcf"
	local sound_cast = "Hero_Weaver.Shukuchi.Cast"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end