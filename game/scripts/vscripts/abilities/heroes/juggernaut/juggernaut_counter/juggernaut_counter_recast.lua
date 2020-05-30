juggernaut_counter_recast = class({})
LinkLuaModifier( "modifier_juggernaut_counter_countering", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_counter_countering", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_juggernaut_counter_recast", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_counter_recast", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_juggernaut_counter", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_counter", LUA_MODIFIER_MOTION_NONE )

function juggernaut_counter_recast:OnSpellStart()
    local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local min_range = self:GetSpecialValueFor("min_range")
	local point = Clamp(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), min_range)
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
	
    local filtered_enemies = {}
    local counter = 0

    for _,enemy in pairs(enemies) do
        if  (not enemy:IsObstacle()) and 
			(not enemy:IsCountering())
        then
            counter = counter + 1
            filtered_enemies[counter] = enemy
        end
    end

	for _,enemy in pairs(enemies) do
		local damage_table = {
			victim = enemy,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
		}
		ApplyDamage( damage_table )
		
		self:PlayEffectsOnTarget(enemy)
	end

	if #filtered_enemies > 0 then
		local modifier = caster:AddNewModifier(
			caster,
			self,
			"modifier_juggernaut_counter",
			{}
		)

		if modifier:GetStackCount() < ability:GetSpecialValueFor("recasts") then
			caster:AddNewModifier(
				caster,
				ability,
				"modifier_juggernaut_counter_recast",
				{ duration = 5.0 }
			)
		else
			caster:RemoveModifierByName("modifier_juggernaut_counter")
		end
	else
		caster:RemoveModifierByName("modifier_juggernaut_counter")
		self:PlayEffectsOnMiss()
	end

	ability:StartCooldown(ability:GetCooldown(0))

	local particle_cast = "particles/mod_units/heroes/hero_juggernaut/void_spirit_astral_step.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, origin )
	ParticleManager:SetParticleControl( effect_cast, 1, new_origin )
	ParticleManager:ReleaseParticleIndex( effect_cast )    
end

function juggernaut_counter_recast:PlayEffectsOnTarget( hTarget )
	EmitSoundOn( "Hero_Juggernaut.BladeDance.Arcana", hTarget )
	EmitSoundOn( "Hero_Juggernaut.BladeDance.Layer", hTarget )
	EmitSoundOn( "Hero_Juggernaut.Attack", hTarget )
end

function juggernaut_counter_recast:PlayEffectsOnMiss()
	EmitSoundOn("Hero_Juggernaut.Attack", self:GetCaster())
end