sniper_mobility = class({})
LinkLuaModifier( "modifier_sniper_shrapnel_thinker_custom", "abilities/heroes/sniper/sniper_shared_modifiers/modifier_sniper_shrapnel_thinker_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_mobility_displacement", "abilities/heroes/sniper/sniper_mobility/modifier_sniper_mobility_displacement", LUA_MODIFIER_MOTION_BOTH )

function sniper_mobility:GetCastPoint()
	return self:GetSpecialValueFor("cast_point")
end

function sniper_mobility:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local min_range = self:GetSpecialValueFor("min_range")
	local point = CalcPoint(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), min_range)
    local shrapnel = caster:FindAbilityByName("sniper_special_attack")

	local direction = (point - origin):Normalized()
	local distance = (point - origin):Length2D()

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_sniper_mobility_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = (distance/0.5),
			peak = 400,
        }
	)

	CreateModifierThinker(
		caster, --hCaster
		shrapnel, --hAbility
		"modifier_sniper_shrapnel_thinker_custom", --modifierName
		{ duration = shrapnel:GetSpecialValueFor( "duration" ) }, --paramTable
		caster:GetOrigin(), --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

    self:PlayEffectsOnCast()
end

function sniper_mobility:PlayEffectsOnCast()
	EmitSoundOn( "Hero_Techies.LandMine.Detonate", self:GetCaster() )	

	local particle_cast = "particles/econ/courier/courier_cluckles/courier_cluckles_ambient_rocket_explosion.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin())
    ParticleManager:ReleaseParticleIndex( effect_cast )  
end