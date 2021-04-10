item_blink_custom = class({})

function item_blink_custom:OnSpellStart()
    local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local min_range = self:GetSpecialValueFor("min_range")
	local point = ClampPosition(caster:GetOrigin(), CustomAbilities:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), min_range)
    
    self:PlayEffects(0)
	FindClearSpaceForUnit(caster, point , true)
    self:PlayEffects(1)
end

function item_blink_custom:PlayEffects(mode)
    if mode == 0 then
        local sound_cast = "DOTA_Item.BlinkDagger.Activate"
        EmitSoundOn(sound_cast, self:GetCaster())

	    local particle_cast = "particles/items_fx/blink_dagger_start.vpcf"
        local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
        ParticleManager:ReleaseParticleIndex(effect_cast)
    end

	local particle_cast = "particles/items_fx/blink_dagger_end.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end