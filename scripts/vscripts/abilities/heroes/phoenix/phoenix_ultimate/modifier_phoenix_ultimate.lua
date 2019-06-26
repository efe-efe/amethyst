modifier_phoenix_ultimate = class({})
LinkLuaModifier( "modifier_generic_rooted_lua", "abilities/generic/modifier_generic_rooted_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Classifications
function modifier_phoenix_ultimate:IsHidden()
	return false
end

function modifier_phoenix_ultimate:IsDebuff()
	return true
end

function modifier_phoenix_ultimate:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_phoenix_ultimate:OnCreated( kv )
	-- references
	self.model = "models/heroes/phoenix/phoenix_egg.vmdl"
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.damage_per_think = self:GetAbility():GetSpecialValueFor("damage_per_think")
	self.root_duration = self:GetAbility():GetSpecialValueFor("root_duration")
	self.mana_gain = self:GetAbility():GetSpecialValueFor("mana_gain")/100
	self.heal = self:GetAbility():GetSpecialValueFor("heal")
	local think_interval = self:GetAbility():GetSpecialValueFor("think_interval")

	if IsServer() then
		self.base_health = kv.base_health

		-- play effects
        self:PlayEffects_b()
        self:PlayEffects_a()

		self:GetParent():Heal(self:GetParent():GetMaxHealth(), self:GetParent())

		self:OnIntervalThink()
		self:StartIntervalThink(think_interval)
	end
end

function modifier_phoenix_ultimate:OnIntervalThink()
   local units = FindUnitsInRadius( 
		self:GetParent():GetTeamNumber(), -- int, your team number
		self:GetParent():GetOrigin(), -- point, center point
		nil, -- handle, cacheUnit. (not known)
		self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0, -- int, flag filter
		0, -- int, order filter
		false -- bool, can grow cache
   )

   for _,unit in pairs(units) do
		local damage = {
			victim = unit,
			attacker = self:GetCaster(),
			damage = self.damage_per_think,
			damage_type = DAMAGE_TYPE_PURE,
		}

		ApplyDamage( damage )
   end
end

function modifier_phoenix_ultimate:OnDestroy( kv )
	if IsServer() then
		-- play effects
        self:StopEffects()
        self:PlayEffects_c()
        
		if self:GetRemainingTime() < 0.05 then
			local units = FindUnitsInRadius( 
				self:GetParent():GetTeamNumber(), -- int, your team number
				self:GetParent():GetOrigin(), -- point, center point
				nil, -- handle, cacheUnit. (not known)
				self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
				DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
				0, -- int, flag filter
				0, -- int, order filter
				false -- bool, can grow cache
		   )
		
		   for _,unit in pairs(units) do
				unit:AddNewModifier(
					self:GetParent(),
					self:GetAbility(),
					"modifier_generic_rooted_lua",
					{ duration = self.root_duration }
				)
		   end

		   self:GetParent():SetHealth(self.base_health + self.heal)

			-- Gives mana
			local mana_gain_final = self:GetParent():GetMaxMana() * self.mana_gain
			self:GetParent():GiveMana(mana_gain_final)
		end
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phoenix_ultimate:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_MODEL_CHANGE,
        MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
	}

	return funcs
end

function modifier_phoenix_ultimate:GetModifierExtraHealthBonus()
    return -130
end

function modifier_phoenix_ultimate:GetModifierModelChange()
	return self.model
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_phoenix_ultimate:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}

	return state
end


--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_phoenix_ultimate:PlayEffects_a( )
    local sound_cast = "Hero_Phoenix.SuperNova.Cast"
    EmitSoundOn(sound_cast, self:GetParent())
    
	local particle_cast = "particles/units/heroes/hero_phoenix/phoenix_supernova_start.vpcf"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetParent() )
    ParticleManager:ReleaseParticleIndex( effect_cast )

end

function modifier_phoenix_ultimate:PlayEffects_b( )
    local sound_cast = "Hero_Phoenix.SuperNova.Begin"
    EmitSoundOn(sound_cast, self:GetParent())

	local particle_cast = "particles/mod_units/heroes/hero_phoenix/phoenix_supernova_egg.vpcf"

	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast, 1, self:GetParent():GetOrigin() )
end

function modifier_phoenix_ultimate:StopEffects( )
    ParticleManager:DestroyParticle( self.effect_cast, false )
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

function modifier_phoenix_ultimate:PlayEffects_c( )
    -- Create Sounds
    local sound_cast = "Hero_Phoenix.SuperNova.Explode"
    EmitSoundOn(sound_cast, self:GetParent())
    
    -- Create particles
	local particle_cast = "particles/units/heroes/hero_phoenix/phoenix_supernova_reborn.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetParent() )
end
