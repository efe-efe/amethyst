modifier_middle_orb_base_lua = class ({})
LinkLuaModifier( "modifier_middle_orb_exiled_lua", "abilities/units/middle_orb/middle_orb_base_lua/modifier_middle_orb_exiled_lua", LUA_MODIFIER_MOTION_NONE )

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
		--Hide
		self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_middle_orb_exiled_lua",
			{ wait = 30.0 }
		)

		--Get values
		self.mana = self:GetAbility():GetSpecialValueFor( "mana" )
		self.heal = self:GetAbility():GetSpecialValueFor( "heal" )

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
			"modifier_middle_orb_exiled_lua",
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
			"modifier_middle_orb_exiled_lua",
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
			"modifier_middle_orb_exiled_lua",
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
			"modifier_middle_orb_exiled_lua",
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
			"modifier_middle_orb_exiled_lua",
			{ wait = 25.0 }
		)
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
				ally:GiveMana(self.mana)	
				ally:Heal( self.heal, self:GetParent() )

				self:PlayEffects_b(ally)
				--ally:SetCustomHealthLabel("asd", 50, 50, 50)	
			end

			-- Destroy all timers
			self.middle_orb_timer_a:ForceKill( false )
			self.middle_orb_timer_b:ForceKill( false )
			self.middle_orb_timer_c:ForceKill( false )
			self.middle_orb_timer_d:ForceKill( false )
			self.middle_orb_timer_e:ForceKill( false )

			-- Graphics & sounds
			self:PlayEffects()
			caster:AddNoDraw()
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
