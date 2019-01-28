modifier_orb_on_death_lua = class ({})
--------------------------------------------------------------------------------
-- Classifications
function modifier_orb_on_death_lua:IsHidden()
	return false
end

function modifier_orb_on_death_lua:IsDebuff()
	return false
end

function modifier_orb_on_death_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_orb_on_death_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}
	return funcs
end


function modifier_orb_on_death_lua:OnDeath(kv)
	local killer = kv.attacker
	local orbOrigin = self:GetAbility():GetCaster()
	
	self:PlayEffects()

	-- Find Units in Radius
	local killer_team = FindUnitsInRadius(
		killer:GetTeamNumber(),	-- int, your team number
		orbOrigin:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		FIND_UNITS_EVERYWHERE,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,ally in pairs(killer_team) do
		-- Give Mana
		ally:GiveMana(25)
		self:PlayEffects2(ally)
	end
end

--------------------------------------------------------------------------------
function modifier_orb_on_death_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf"
	local sound_cast = "sounds/weapons/hero/magnataur/reverse_polarity_cast.vsnd"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end

--------------------------------------------------------------------------------
function modifier_orb_on_death_lua:PlayEffects2( recipient )
	-- Get Resources
	local particle_cast = "particles/items_fx/arcane_boots_recipient.vpcf"
	local sound_cast = "sounds/items/dota_item_arcane_boots.vsnd"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, recipient )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, recipient )
end