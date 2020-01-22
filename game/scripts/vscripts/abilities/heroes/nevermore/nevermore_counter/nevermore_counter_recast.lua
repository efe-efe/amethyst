nevermore_counter_recast = class({})

function nevermore_counter_recast:OnCastPointEnd()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	
	local point = CalcPoint(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local delay_time = self:GetSpecialValueFor( "delay_time" )
	local radius = self:GetSpecialValueFor("radius")
	local ability = caster:FindAbilityByName("nevermore_counter")
	local damage = ability:GetSpecialValueFor("ability_damage")
	local lift_duration = ability:GetSpecialValueFor("lift_duration")
	
	FindClearSpaceForUnit( caster, point , true )
	caster:RemoveNoDraw()
	caster:RemoveModifierByName("modifier_banish")
	
	local enemies = self:GetCaster():FindUnitsInRadius(
		caster:GetOrigin(), 
		radius, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER
	)

	local damage_table = {
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_PURE,
	}
	
	local distance = 300
	
	for _,enemy in pairs(enemies) do
		damage_table.victim = enemy
		ApplyDamage( damage_table )

		enemy:RemoveModifierByName("modifier_generic_displacement")
		enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_generic_displacement", -- modifier name
			{
				x = 0,
				y = 0,
				r = distance,
				speed = (distance/lift_duration),
				peak = 500,
				restricted = 1,
				effect = 1,
				i_frame = 1,
			} -- kv
		)
	end

	StartAnimation(caster, { 
		duration = 0.5, 
		activity = ACT_DOTA_RAZE_2, 
		rate = 1.2
	})

	CreateRadiusMarker(caster, point, {
		show_all = 1,
		radius = radius
	})

	self:PlayEffectsOnCast()
end

function nevermore_counter_recast:PlayEffectsOnCast()
    local caster = self:GetCaster()
	EmitSoundOn( "Hero_Nevermore.Shadowraze", caster )

	local particle_cast = "particles/econ/events/ti9/blink_dagger_ti9_end.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, caster:GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    
    -- create particle
	local particle_cast_b = "particles/econ/events/ti9/phase_boots_ti9_body_magic.vpcf"
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast_b, 0, caster:GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )

	particle_cast_b = "particles/earthshaker_arcana_aftershock.vpcf"
	effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast_b, 0, caster:GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
end


if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
    nevermore_counter_recast,
	nil,
	{ movement_speed = 0 },
	{ modifier_name = "modifier_nevermore_counter_recast" }
)
