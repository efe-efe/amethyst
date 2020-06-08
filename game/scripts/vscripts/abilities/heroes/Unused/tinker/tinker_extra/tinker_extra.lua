tinker_extra = class({})

--------------------------------------------------------------------------------
-- Ability Channeling
function tinker_extra:OnSpellStart()
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- stop effects
	local sound_cast = "DOTA_Item.SoulRing.Activate"
	StopSoundOn(sound_cast, self:GetCaster())
	
	-- Animation and pseudo cast point
	StartAnimation(self:GetCaster(), {
		duration = cast_point + 0.1, 
		activity = ACT_DOTA_TELEPORT_END, 
		translate = "bot", 
		rate = 1.0
	})
	self:PlayEffects()
	caster:AddNewModifier(caster, self , "modifier_cast_point_old", { duration = cast_point, no_target = 1 })
end

--------------------------------------------------------------------------------
-- Effects
function tinker_extra:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/econ/items/doom/doom_f2p_death_effect/doom_bringer_f2p_death_ring.vpcf"
	local sound_cast = "Hero_Tinker.RearmStart"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, self:GetCaster())
end

function tinker_extra:OnCastPointEnd()
    local caster = self:GetCaster()
    local mana_gain = self:GetSpecialValueFor("mana_gain")
    local life_loss = self:GetSpecialValueFor("life_loss")
    
    -- Give Mana
    caster:GiveMana(mana_gain)    
    -- Remove hp
    local damage = {
        victim = caster,
        attacker = caster,
        damage = life_loss,
        damage_type = DAMAGE_TYPE_PURE,
        ability = self
    }
    ApplyDamage(damage)

	local sound_cast = "DOTA_Item.SoulRing.Activate"
	
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, caster, mana_gain, nil)

	EmitSoundOn(sound_cast, self:GetCaster())
end

