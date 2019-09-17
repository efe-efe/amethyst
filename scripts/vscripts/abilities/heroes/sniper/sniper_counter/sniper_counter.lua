sniper_counter = class({})
LinkLuaModifier( "modifier_sniper_counter", "abilities/heroes/sniper/sniper_counter/modifier_sniper_counter", LUA_MODIFIER_MOTION_NONE )
--------------------------------------------------------------------------------
-- Ability Start
function sniper_counter:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	
	-- Animation and pseudo cast point
	StartAnimation(caster, { duration= cast_point + 0.1, activity=ACT_DOTA_CAST_ABILITY_1, rate=1.5 })
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
        duration = cast_point, 
        movement_speed = 100,
        no_target = 1, 
    })
end


--------------------------------------------------------------------------------
function sniper_counter:OnEndPseudoCastPoint( point ) 
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    self:PlayEffects()

    caster:AddNewModifier(
        caster,
        self,
        "modifier_sniper_counter",
        { duration = duration }
    )

end

function sniper_counter:PlayEffects()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()

    -- Cast Sound
    local sound_cast = "DOTA_Item.SmokeOfDeceit.Activate"
    EmitSoundOn( sound_cast , caster )

    -- Cast particle
    local particle_cast_a="particles/econ/items/vengeful/vs_ti8_immortal_shoulder/vs_ti8_immortal_magic_missle_end_smoke.vpcf"
    local particle_cast_b="particles/econ/items/riki/riki_head_ti8/riki_smokebomb_ti8_start_ring.vpcf"

    local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_WORLDORIGIN, nil )
    local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, nil )

    ParticleManager:SetParticleControl( effect_cast_a, 3, Vector(origin.x, origin.y, origin.z + 64) )
    ParticleManager:SetParticleControl( effect_cast_b, 0, origin)
    
	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
end