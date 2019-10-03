modifier_middle_orb_base_lua = class ({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_middle_orb_base_lua:IsHidden()
	return false
end

function modifier_middle_orb_base_lua:IsDebuff()
	return false
end

function modifier_middle_orb_base_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_middle_orb_base_lua:OnCreated( kv )
	if IsServer() then
		--Get values
		self.mana = self:GetAbility():GetSpecialValueFor( "mana" )
		self.heal = self:GetAbility():GetSpecialValueFor( "heal" )
		self:StartIntervalThink(0.05)
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_middle_orb_base_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}
	return funcs
end

function modifier_middle_orb_base_lua:OnDeath(params)
	if IsServer() then

		local caster = self:GetAbility():GetCaster()
		-- filter other units with the same name
		local pass = false
		if params.unit==caster then
			pass = true
		end
		
		-- logic
		if pass then
			local killer = params.attacker
			local orb_origin = caster:GetOrigin()

			-- Find units from the killer team
			local killer_team = FindUnitsInRadius(
				killer:GetTeamNumber(),	-- int, your team number
				orb_origin,	-- point, center point
				nil,	-- handle, cacheUnit. (not known)
				FIND_UNITS_EVERYWHERE,	-- float, radius. or use FIND_UNITS_EVERYWHERE
				DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
				DOTA_UNIT_TARGET_HERO,	-- int, type filter
				DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED,	-- int, flag filter
				0,	-- int, order filter
				false	-- bool, can grow cache
			)

			-- Heal and give mana
			for _,ally in pairs(killer_team) do
				if ally:IsRealHero() then 
					-- Give Mana
					PseudoHeal(ally:GetHealth(), self.heal, ally)
					ally:GiveMana(self.mana)

					SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, ally, self.mana, nil )

					self:PlayEffects_b(ally)
				end
			end

			-- Graphics & sounds
			self:PlayEffects()
			caster:AddNoDraw()
		end
	end
end

-----------------------------------
-- Interval Effects
function modifier_middle_orb_base_lua:OnIntervalThink()
	-- Strong Dispel
	local RemovePositiveBuffs = false
	local RemoveDebuffs = true
	local BuffsCreatedThisFrameOnly = false
	local RemoveStuns = true
	local RemoveExceptions = false

	self:GetCaster():Purge( RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)
end

--------------------------------------------------------------------------------
function modifier_middle_orb_base_lua:PlayEffects()
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
function modifier_middle_orb_base_lua:PlayEffects_b( recipient )
	-- Get Resources
	local particle_cast = "particles/items_fx/arcane_boots_recipient.vpcf"
	local sound_cast = "DOTA_Item.ArcaneBoots.Activate"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, recipient )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, recipient )
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_middle_orb_base_lua:CheckState()
	local state = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
	}

	return state
end
