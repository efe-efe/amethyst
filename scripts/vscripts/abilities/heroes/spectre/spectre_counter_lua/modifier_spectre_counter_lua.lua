modifier_spectre_counter_lua = class({})
LinkLuaModifier( "modifier_spectre_counter_thinker_lua", "abilities/heroes/spectre/spectre_counter_lua/modifier_spectre_counter_thinker_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_counter_lua:OnCreated( kv )
    if IsServer() then
        self.speed_debuff = -self:GetAbility():GetSpecialValueFor("speed_debuff")
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


function modifier_spectre_counter_lua:GetModifierIncomingDamage_Percentage( params )
    if IsServer() then
		local parent = self:GetParent()
		local attacker = params.attacker

		--create the thinker
		CreateModifierThinker(
			parent, --hCaster
			self:GetAbility(), --hAbility
			"modifier_spectre_counter_thinker_lua", --modifierName
			{}, --paramTable
			attacker:GetOrigin(), --vOrigin
			parent:GetTeamNumber(), --nTeamNumber
			false --bPhantomBlocker
		)

		-- find and destroy the timer modifier from the basic attack
		local basic_attack_timer = parent:FindModifierByNameAndCaster( 
			"modifier_spectre_basic_attack_charged_timer", parent 
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
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	}

	return funcs
end

function modifier_spectre_counter_lua:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_debuff
end


-- Graphics & Animations
function modifier_spectre_counter_lua:GetEffectName()
	return "particles/econ/items/spectre/spectre_transversant_soul/spectre_transversant_spectral_dagger_path_owner.vpcf"
end

function modifier_spectre_counter_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

-- Graphics & Animations
function modifier_spectre_counter_lua:PlayEffects()
	local particle_cast = "particles/econ/events/ti6/radiance_owner_ti6.vpcf"

	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
end


-- Graphics & Animations
function modifier_spectre_counter_lua:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end
