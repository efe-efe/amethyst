modifier_spectre_counter_lua = class({})
LinkLuaModifier( "modifier_generic_projectile_reflector_lua", "abilities/generic/modifier_generic_projectile_reflector_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_counter_lua:OnCreated( kv )
	if IsServer() then
		-- Add modifier
		self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_generic_projectile_reflector_lua",
			{ duration = self:GetAbility():GetDuration() }
		)

		self.speed_debuff = self:GetAbility():GetSpecialValueFor("speed_debuff")
		self:StartIntervalThink(0.05)
        self:PlayEffects()
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_spectre_counter_lua:OnDestroy( kv )
    if IsServer() then
        -- effects
		self:StopEffects()
    end
end


function modifier_spectre_counter_lua:OnAbilityExecuted( params )
	if IsServer() then
		if params.unit~=self:GetParent() then return end
		self:Destroy()
	end
end

-----------------------------------
-- Interval Effects
function modifier_spectre_counter_lua:OnIntervalThink()
		-- Strong Dispel
		local RemovePositiveBuffs = false
		local RemoveDebuffs = true
		local BuffsCreatedThisFrameOnly = false
		local RemoveStuns = true
		local RemoveExceptions = false

		self:GetCaster():Purge( RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)
end

function modifier_spectre_counter_lua:GetModifierIncomingDamage_Percentage( params )
    if IsServer() then
		local parent = self:GetParent()
		local attacker = params.attacker

        if params.damage_type ~= DAMAGE_TYPE_PURE then
			-- find and destroy the timer modifier from the basic attack
			local basic_attack_timer = parent:FindModifierByNameAndCaster( 
				"modifier_spectre_basic_attack_charged_timer_lua", parent 
			)
		
			if basic_attack_timer~=nil then
				if not basic_attack_timer:IsNull() then
					basic_attack_timer:Destroy()
				end
			end

			--remove cooldown from basic attack charged
			local basic_attack_charged = parent:FindAbilityByName("spectre_basic_attack_charged_lua")
			basic_attack_charged:EndCooldown()
			
			return -100
        end
        return 0
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_spectre_counter_lua:CheckState()
	local state = {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spectre_counter_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
		MODIFIER_PROPERTY_STATUS_RESISTANCE,
	}

	return funcs
end

function modifier_spectre_counter_lua:GetModifierMoveSpeedOverride()
    return self.speed_debuff
end

function modifier_spectre_counter_lua:GetModifierStatusResistance()
	return -80
end


function modifier_spectre_counter_lua:PlayEffects()
	local sound_cast = "Hero_Spectre.HauntCast"

	local particle_cast = "particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8_swirl_rop.vpcf"
	local particle_cast2 = "particles/customgames/capturepoints/cp_wood.vpcf"

	self.effect_cast = ParticleManager:CreateParticle( 
		particle_cast, 
		PATTACH_CUSTOMORIGIN, 
		self:GetParent()
	)

	ParticleManager:SetParticleControlEnt( 
		self.effect_cast, 
		0, 
		self:GetParent(), 
		PATTACH_POINT_FOLLOW, 
		"attach_hitloc", 
		self:GetParent():GetOrigin(), 
		true 
	)
	ParticleManager:SetParticleControlEnt( 
		self.effect_cast, 
		3, 
		self:GetParent(), 
		PATTACH_POINT_FOLLOW, 
		"attach_hitloc", 
		self:GetParent():GetOrigin(), 
		true 
	)



	self.effect_cast2 = ParticleManager:CreateParticle( particle_cast2, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast2, 0, self:GetParent():GetOrigin() )

	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_spectre_counter_lua:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )

	ParticleManager:DestroyParticle( self.effect_cast2, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast2 )
end

