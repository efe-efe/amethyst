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
-- Modifier Effects
function modifier_middle_orb_base_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}
	return funcs
end

function modifier_middle_orb_base_lua:OnCreated( kv )
	--Get values
	self.mana = self:GetAbility():GetSpecialValueFor( "mana" )
	self.heal = self:GetAbility():GetSpecialValueFor( "heal" )
end

function modifier_middle_orb_base_lua:OnDeath(params)
	if IsServer() then
		-- filter
		local pass = false
		if params.unit==self:GetAbility():GetCaster() then
			pass = true
		end
		
		-- logic
		if pass then
			local killer = params.attacker
			local orb_origin = self:GetCaster():GetOrigin()
			
			self:PlayEffects()

			-- Find units from the killer team
			local killer_team = FindUnitsInRadius(
				killer:GetTeamNumber(),	-- int, your team number
				orb_origin,	-- point, center point
				nil,	-- handle, cacheUnit. (not known)
				FIND_UNITS_EVERYWHERE,	-- float, radius. or use FIND_UNITS_EVERYWHERE
				DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
				DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED,	-- int, flag filter
				0,	-- int, order filter
				false	-- bool, can grow cache
			)

				-- Heal and Mana
			for _,ally in pairs(killer_team) do
				-- Give Mana
				ally:GiveMana(self.mana)	
				ally:Heal( self.heal, self:GetParent() )

				self:PlayEffects2(ally)
				--ally:SetCustomHealthLabel("asd", 50, 50, 50)	
			end

			-- Find orb timers
			local orb_timers = FindUnitsInRadius(
				self:GetParent():GetTeamNumber(),	-- int, your team number
				orb_origin,	-- point, center point
				nil,	-- handle, cacheUnit. (not known)
				FIND_UNITS_EVERYWHERE,	-- float, radius. or use FIND_UNITS_EVERYWHERE
				DOTA_UNIT_TARGET_TEAM_BOTH,	-- int, team filter
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
				0,	-- int, flag filter
				0,	-- int, order filter
				false	-- bool, can grow cache
			)
		end
	end
end

--------------------------------------------------------------------------------
function modifier_middle_orb_base_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf"
	local sound_cast = "Hero_Magnataur.ReversePolarity.Cast"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	-- Create Particle
	local effect_cast2 = ParticleManager:CreateParticle( particle_cast2, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast2 )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end

--------------------------------------------------------------------------------
function modifier_middle_orb_base_lua:PlayEffects2( recipient )
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
	}

	return state
end
