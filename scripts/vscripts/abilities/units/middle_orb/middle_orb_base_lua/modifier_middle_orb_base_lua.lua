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

		--[[self.orb_timers_ent = {}
		self.orb_timers_ent[1] = Entities:FindByName(nil, "orb_timer1")
		self.orb_timers_ent[2] = Entities:FindByName(nil, "orb_timer2")
		self.orb_timers_ent[3] = Entities:FindByName(nil, "orb_timer3")
		self.orb_timers_ent[4] = Entities:FindByName(nil, "orb_timer4")
		self.orb_timers_ent[5] = Entities:FindByName(nil, "orb_timer5")
		self.counter = 0.0
		
		for _,orb_timer_ent in pairs(self.orb_timers_ent) do
			self.counter = self.counter + 5.0
			local orb_origin = orb_timer_ent:GetOrigin()

			self.orb_timers_ent[_].unit = CreateUnitByName(
				"npc_dota_creature_middle_orb_timer", --szUnitName
				orb_origin, --vLocation
				true, --bFindClearSpace
				nil, --hNPCOwner
				nil, --hUnitOwner
				DOTA_TEAM_NOTEAM
			)
		end]]--

		--[[
		local orb_timer1 = Entities:FindByName(nil, "orb_timer1"):GetOrigin()
		local orb_timer2 = Entities:FindByName(nil, "orb_timer2"):GetOrigin()
		local orb_timer3 = Entities:FindByName(nil, "orb_timer3"):GetOrigin()
		local orb_timer4 = Entities:FindByName(nil, "orb_timer4"):GetOrigin()
		local orb_timer5 = Entities:FindByName(nil, "orb_timer5"):GetOrigin()

		--Creating Orbs
		self.middle_orb_timer_a = CreateUnitByName(
			"npc_dota_creature_middle_orb_timer", --szUnitName
			orb_timer1, --vLocation
			true, --bFindClearSpace
			nil, --hNPCOwner
			nil, --hUnitOwner
			7
		)
		self.middle_orb_timer_a:SetOrigin(orb_timer1)
		self.middle_orb_timer_a:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_middle_orb_exiled",
			{ wait = 5.0 }
		)

		
		self.middle_orb_timer_b = CreateUnitByName(
			"npc_dota_creature_middle_orb_timer", --szUnitName
			orb_timer2, --vLocation
			true, --bFindClearSpace
			nil, --hNPCOwner
			nil, --hUnitOwner
			7
		)
		self.middle_orb_timer_b:SetOrigin(orb_timer2)
		self.middle_orb_timer_b:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_middle_orb_exiled",
			{ wait = 10.0 }
		)
		
		self.middle_orb_timer_c = CreateUnitByName(
			"npc_dota_creature_middle_orb_timer", --szUnitName
			orb_timer3, --vLocation
			true, --bFindClearSpace
			nil, --hNPCOwner
			nil, --hUnitOwner
			7
		)
		self.middle_orb_timer_c:SetOrigin(orb_timer3)
		self.middle_orb_timer_c:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_middle_orb_exiled",
			{ wait = 15.0 }
		)
		
		self.middle_orb_timer_d = CreateUnitByName(
			"npc_dota_creature_middle_orb_timer", --szUnitName
			orb_timer4, --vLocation
			true, --bFindClearSpace
			nil, --hNPCOwner
			nil, --hUnitOwner
			7
		)
		self.middle_orb_timer_d:SetOrigin(orb_timer4)
		self.middle_orb_timer_d:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_middle_orb_exiled",
			{ wait = 20.0 }
		)
		
		self.middle_orb_timer_e = CreateUnitByName(
			"npc_dota_creature_middle_orb_timer", --szUnitName
			orb_timer5, --vLocation
			true, --bFindClearSpace
			nil, --hNPCOwner
			nil, --hUnitOwner
			7
		)
		self.middle_orb_timer_e:SetOrigin(orb_timer5)
		self.middle_orb_timer_e:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_middle_orb_exiled",
			{ wait = 25.0 }
		)
		]]
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
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
				DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED,	-- int, flag filter
				0,	-- int, order filter
				false	-- bool, can grow cache
			)

			-- Heal and give mana
			for _,ally in pairs(killer_team) do
				-- Give Mana
				PseudoHeal(ally:GetHealth(), self.heal, ally)

				SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, ally, self.mana, nil )

				self:PlayEffects_b(ally)
			end

			-- Destroy all timers
			--[[
				self.middle_orb_timer_a:ForceKill( false )
				self.middle_orb_timer_b:ForceKill( false )
				self.middle_orb_timer_c:ForceKill( false )
				self.middle_orb_timer_d:ForceKill( false )
				self.middle_orb_timer_e:ForceKill( false )
			]]
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
	}

	return state
end
