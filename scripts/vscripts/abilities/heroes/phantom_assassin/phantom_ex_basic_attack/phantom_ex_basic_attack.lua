phantom_ex_basic_attack = class({})
LinkLuaModifier("modifier_phantom_ex_basic_attack", "abilities/heroes/phantom_assassin/phantom_ex_basic_attack/modifier_phantom_ex_basic_attack", LUA_MODIFIER_MOTION_NONE)

function phantom_ex_basic_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("phantom_basic_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function phantom_ex_basic_attack:OnSpellStart()
	-- Initialize bariables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration= 0.3, activity=ACT_DOTA_CAST_ABILITY_3, rate=1.5})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
		duration = cast_point, 
        no_target = 1
	})
end

function phantom_ex_basic_attack:OnEndPseudoCastPoint( pos )
    local caster = self:GetCaster()

    caster:AddNewModifier(
        caster,
        self,
        "modifier_phantom_ex_basic_attack",
        {}
    )

    self:PlayEffects()
end


function phantom_ex_basic_attack:PlayEffects()
    local caster = self:GetCaster()

    -- Create Particles
    local particle_cast = "particles/units/heroes/hero_demonartist/demonartist_spiritwalk_buff_start_rope.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
	ParticleManager:SetParticleControl( effect_cast, 3, caster:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

