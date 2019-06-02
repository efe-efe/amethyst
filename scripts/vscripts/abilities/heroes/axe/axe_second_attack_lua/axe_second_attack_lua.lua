axe_second_attack_lua = class({})
LinkLuaModifier( "modifier_axe_second_attack_debuff_lua", "abilities/heroes/axe/axe_second_attack_lua/modifier_axe_second_attack_debuff_lua", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_axe_second_attack_buff_lua", "abilities/heroes/axe/axe_second_attack_lua/modifier_axe_second_attack_buff_lua", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_generic_fading_slow_lua", "abilities/generic/modifier_generic_fading_slow_lua", LUA_MODIFIER_MOTION_NONE )

function axe_second_attack_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function axe_second_attack_lua:OnAbilityPhaseStart()
	-- play effects 
	local sound_cast = "Hero_Axe.BerserkersCall.Item.Shoutmask"
	EmitSoundOn( sound_cast, self:GetCaster() )

	self:Animate()
	return true -- if success
end

function axe_second_attack_lua:OnSpellStart()
	self.point = self:GetCursorPosition()
	self.radius = self:GetSpecialValueFor("radius")
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local duration = self:GetSpecialValueFor("duration")
	local mana_gain = self:GetSpecialValueFor("mana_gain")

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
				"modifier_axe_second_attack_debuff_lua",
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
				"modifier_axe_second_attack_buff_lua", -- modifier name
				{ duration = duration } -- kv
			)
		end
				
		-- if at least 1 enemy
		if #enemies > 0 then
			-- Give Mana
			local mana_gain_final = self:GetCaster():GetMaxMana() * mana_gain
			self:GetCaster():GiveMana(mana_gain_final)    
		end


	self:PlayEffects()
end

function axe_second_attack_lua:PlayEffects()
    -- Create sound
    local sound_cast = "Hero_EarthShaker.Totem"
    EmitSoundOn(sound_cast, self:GetCaster())

	-- Create Particles
	local particle_cast_a_b = "particles/econ/items/axe/axe_helm_shoutmask/axe_beserkers_call_owner_shoutmask.vpcf"
	local particle_cast_c = "particles/econ/events/darkmoon_2017/darkmoon_calldown_marker_ring.vpcf"
	
	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a_b, PATTACH_WORLDORIGIN, self:GetCaster() )
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_a_b, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	local effect_cast_c = ParticleManager:CreateParticle( particle_cast_c, PATTACH_WORLDORIGIN, nil )
	
	ParticleManager:SetParticleControl( effect_cast_a, 0, self.point )
	ParticleManager:SetParticleControl( effect_cast_b, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast_c, 0, self.point )
	ParticleManager:SetParticleControl( effect_cast_c, 1, Vector( self.radius, 1, 1 ) )
	ParticleManager:SetParticleControl( effect_cast_c, 2, Vector( 1, 1, 1 ) )

	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
	ParticleManager:ReleaseParticleIndex( effect_cast_c )
end


function axe_second_attack_lua:Animate()
	StartAnimation(self:GetCaster(), {duration=0.5, translate="come_get_it", activity=ACT_DOTA_TAUNT, rate=1.3})
end


