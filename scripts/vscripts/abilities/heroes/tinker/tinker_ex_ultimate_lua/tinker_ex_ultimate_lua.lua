tinker_ex_ultimate_lua = class({})
LinkLuaModifier( "modifier_generic_pseudo_cast_point_lua", "abilities/generic/modifier_generic_pseudo_cast_point_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Channeling
function tinker_ex_ultimate_lua:OnSpellStart(  )
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- stop effects
	local sound_cast = "DOTA_Item.SoulRing.Activate"
	StopSoundOn( sound_cast, self:GetCaster() )
	
	-- Animation and pseudo cast point
	self:Animate()
	self:PlayEffects()
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point_lua", { duration = cast_point})
end

--------------------------------------------------------------------------------
-- Effects
function tinker_ex_ultimate_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/econ/items/doom/doom_f2p_death_effect/doom_bringer_f2p_death_ring.vpcf"
	local sound_cast = "Hero_Tinker.RearmStart"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, self:GetCaster() )
end

function tinker_ex_ultimate_lua:OnEndPseudoCastPoint()
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
    ApplyDamage( damage )

	local sound_cast = "DOTA_Item.SoulRing.Activate"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function tinker_ex_ultimate_lua:Animate()
	local cast_point = self:GetCastPoint()
	StartAnimation(self:GetCaster(), {
		duration = cast_point, 
		activity = ACT_DOTA_TELEPORT_END, 
		translate = "bot", 
		rate = 0.6
	})
end
