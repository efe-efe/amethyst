modifier_amethyst_base = class ({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_amethyst_base:IsHidden()
	return false
end

function modifier_amethyst_base:IsDebuff()
	return false
end

function modifier_amethyst_base:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_amethyst_base:OnCreated( params )
	if IsServer() then
		--Get values
		self.mana = params.mana or 0
		self.heal = params.heal or 0
		self:StartIntervalThink(0.05)
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_amethyst_base:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}
	return funcs
end

function modifier_amethyst_base:OnDeath(params)
	if IsServer() then
		local caster = self:GetParent()
		local pass = false 

		-- filter other units with the same name
		if params.unit == caster and params.unit == self:GetParent() then
			pass = true 
		end

		if pass then
			local killer = params.attacker
			local orb_origin = caster:GetOrigin()

			local killer_team = killer:FindUnitsInRadius(
				orb_origin, 
				FIND_UNITS_EVERYWHERE, 
				DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
				DOTA_UNIT_TARGET_HERO, 
				DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED,
				FIND_ANY_ORDER
			)

			local final_heal = self.heal / #killer_team
			local final_mana = self.mana / #killer_team

			-- Heal and give mana
			for _,ally in pairs(killer_team) do
				if ally:IsRealHero() then 
					-- Give Mana
					PseudoHeal(ally:GetHealth(), final_heal, ally)
					ally:GiveMana(final_mana)

					SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, ally, final_mana, nil )

					self:PlayEffects_b(ally)
				end
			end

			self:PlayEffects()
			caster:AddNoDraw()
		end
	end
end

-----------------------------------
-- Interval Effects
function modifier_amethyst_base:OnIntervalThink()
	self:GetCaster():StrongPurge()
end

--------------------------------------------------------------------------------
function modifier_amethyst_base:PlayEffects()
	local parent = self:GetParent()
	local origin = parent:GetOrigin()
	-- Cast sound
	local sound_cast = "Hero_Magnataur.ReversePolarity.Cast"
	EmitSoundOn( sound_cast, parent )

	-- Cast particles
	local particle_cast_a = "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf"
	local particle_cast_b = "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf"

	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_WORLDORIGIN, parent )
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, parent )
	
	ParticleManager:SetParticleControl( effect_cast_a, 0, origin )
	ParticleManager:SetParticleControl( effect_cast_a, 2, Vector(255, 80, 230) )

    ParticleManager:SetParticleControl( effect_cast_b, 0, origin)
    ParticleManager:SetParticleControl( effect_cast_b, 5, origin)

	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )

end

--------------------------------------------------------------------------------
function modifier_amethyst_base:PlayEffects_b( recipient )
	-- Get Resources
	local particle_cast = "particles/items_fx/arcane_boots_recipient.vpcf"
	local sound_cast = "DOTA_Item.ArcaneBoots.Activate"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, recipient )
	ParticleManager:ReleaseParticleIndex( effect_cast )

--particles/units/heroes/hero_clinkz/clinkz_death_pact_buff_ring_rope_bright.vpcf
	-- Create Particle
	effect_cast = ParticleManager:CreateParticle( "particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8_swirl_rope.vpcf", PATTACH_ABSORIGIN_FOLLOW, recipient )
	ParticleManager:SetParticleControl( effect_cast, 3, recipient:GetOrigin())
	ParticleManager:SetParticleControl( effect_cast, 15, Vector(115, 248, 255))
	ParticleManager:SetParticleControl( effect_cast, 16, Vector(1,0,0))
	ParticleManager:ReleaseParticleIndex( effect_cast )


	effect_cast = ParticleManager:CreateParticle( "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/cm_arcana_pup_lvlup_godray.vpcf", PATTACH_ABSORIGIN_FOLLOW, recipient )
	ParticleManager:SetParticleControl( effect_cast, 1, recipient:GetOrigin())
	ParticleManager:SetParticleControl( effect_cast, 3, recipient:GetOrigin())
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, recipient )
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_amethyst_base:CheckState()
	local state = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
	}

	return state
end
