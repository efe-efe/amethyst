spectre_ultimate_swap = class({})

spectre_ultimate_swap.illusion_index = nil

--------------------------------------------------------------------------------
function spectre_ultimate_swap:OnCastPointEnd()
    -- unit identifier
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local delay_time = self:GetSpecialValueFor( "delay_time" )
	local radius = self:GetSpecialValueFor( "radius" )
	local point = CalcRange(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
    local illusion = EntIndexToHScript( self.illusion_index )

    FindClearSpaceForUnit( caster, illusion:GetOrigin() , true )
    FindClearSpaceForUnit( illusion, origin , true )

    self:PlayEffects()
end

function spectre_ultimate_swap:PlayEffects()
    -- Get Resources
    EmitSoundOn( "Hero_Spectre.Reality", self:GetCaster() )

    local particle_cast = "particles/units/heroes/hero_spectre/spectre_death.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	spectre_ultimate_swap,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 10 }
)