juggernaut_counter_recast = class({})
LinkLuaModifier( "modifier_juggernaut_counter_recast", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_counter_recast", LUA_MODIFIER_MOTION_NONE )

function juggernaut_counter_recast:OnCastPointEnd( pos )
    local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = CalcPoint(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local ability = caster:FindAbilityByName("juggernaut_counter")
	local damage = ability:GetSpecialValueFor("ability_damage")
	
	FindClearSpaceForUnit( caster, point , true )

	local new_origin = caster:GetOrigin()

	local enemies = caster:FindUnitsInLine( 
		new_origin, 
		origin, 
		100, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE
	)
	
	for _,enemy in pairs(enemies) do
		local damage_table = {
			victim = enemy,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
		}
		ApplyDamage( damage_table )
	end

	print(caster:FindModifierByName("modifier_juggernaut_counter_recast"))

	if #enemies > 0 then
		caster:AddNewModifier(
			caster,
			ability,
			"modifier_juggernaut_counter_recast",
			{ duration = 5.0, last = 1 }
		)
	end

	ability:StartCooldown(ability:GetCooldown(0))

	local particle_cast = "particles/mod_units/heroes/hero_juggernaut/void_spirit_astral_step.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, origin )
	ParticleManager:SetParticleControl( effect_cast, 1, new_origin )
	ParticleManager:ReleaseParticleIndex( effect_cast )    
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	juggernaut_counter_recast,
	{ activity = ACT_DOTA_GENERIC_CHANNEL_1, rate = 1.0 },
	{ movement_speed = 0, disable_all = false },
	{ modifier_name = "modifier_juggernaut_counter_recast" }
)
