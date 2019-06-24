axe_second_attack = class({})
LinkLuaModifier( "modifier_axe_second_attack_debuff", "abilities/heroes/axe/axe_second_attack/modifier_axe_second_attack_debuff", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_axe_second_attack_buff", "abilities/heroes/axe/axe_second_attack/modifier_axe_second_attack_buff", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_generic_fading_slow_lua", "abilities/generic/modifier_generic_fading_slow_lua", LUA_MODIFIER_MOTION_NONE )

function axe_second_attack:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function axe_second_attack:OnAbilityPhaseStart()
	-- play effects 
	local sound_cast = "Hero_Axe.BerserkersCall.Item.Shoutmask"
	EmitSoundOn( sound_cast, self:GetCaster() )

	self:Animate()
	return true -- if success
end

function axe_second_attack:OnSpellStart()
	self.point = self:GetCursorPosition()
	self.radius = self:GetSpecialValueFor("radius")
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local duration = self:GetSpecialValueFor("duration")
	local mana_gain = self:GetSpecialValueFor("mana_gain")/100

	local enemies = FindUnitsInRadius( 
        caster:GetTeamNumber(), -- int, your team number
        self.point, -- point, center point
        nil, -- handle, cacheUnit. (not known)
        self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        0, -- int, flag filter
        0, -- int, order filter
        false -- bool, can grow cache
    )

    -- Print units
    for _,enemy in pairs(enemies) do
		enemy:AddNewModifier(
			caster,
			self,
			"modifier_axe_second_attack_debuff",
			{ duration = duration }
		)
		enemy:AddNewModifier(
			caster,
			self,
			"modifier_generic_fading_slow_lua",
			{ duration = duration }
		)

		caster:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_axe_second_attack_buff", -- modifier name
			{ duration = duration } -- kv
		)
	end
				
	-- if at least 1 enemy
	if #enemies > 0 then
		-- Give Mana
		local mana_gain_final = caster:GetMaxMana() * mana_gain
		caster:GiveMana(mana_gain_final)    
	end


	self:PlayEffects()
end

function axe_second_attack:PlayEffects()
    -- Create sound
    local sound_cast = "Hero_EarthShaker.Totem"
    EmitSoundOn(sound_cast, self:GetCaster())

	-- Create Particles
	local particle_cast_a = "particles/econ/items/axe/axe_cinder/axe_cinder_battle_hunger_cast.vpcf"
	local particle_cast_b = "particles/econ/items/axe/axe_helm_shoutmask/axe_beserkers_call_owner_shoutmask.vpcf"
	
	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_WORLDORIGIN, self:GetCaster() )
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	local effect_cast_c = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, self:GetCaster() )
	
	ParticleManager:SetParticleControl( effect_cast_a, 0, Vector(self.point.x, self.point.y, self.point.z + 128) )
	
	ParticleManager:SetParticleControl( effect_cast_b, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast_b, 2, Vector(50,0,0))
	
	ParticleManager:SetParticleControl( effect_cast_c, 0, self.point )
	ParticleManager:SetParticleControl( effect_cast_c, 2, Vector( self.radius, 1, 1 ) )

	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
	ParticleManager:ReleaseParticleIndex( effect_cast_c )
end


function axe_second_attack:Animate()
	StartAnimation(self:GetCaster(), {duration=0.5, translate="come_get_it", activity=ACT_DOTA_TAUNT, rate=1.3})
end


