modifier_slark_basic_attack = class ({})

--- Misc 
function modifier_slark_basic_attack:IsHidden()
    return false
end

function modifier_slark_basic_attack:DestroyOnExpire()
    return false
end

function modifier_slark_basic_attack:IsPurgable()
    return false
end

function modifier_slark_basic_attack:RemoveOnDeath()
    return false
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_slark_basic_attack:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_slark_basic_attack:OnCreated( kv )
    --Initializers
    if IsServer() then
        -- references
        self.ability = self:GetAbility()
        self.stacks_duration = self.ability:GetSpecialValueFor( "stacks_duration" )
        self.attackspeed_variation = self.ability:GetSpecialValueFor( "attackspeed_variation" )
        self.damage_variation = self.ability:GetSpecialValueFor( "damage_variation" )
        self.max_stacks = self.ability:GetSpecialValueFor( "max_stacks" )

        local caster = self.ability:GetCaster()
        
        caster:AddNewModifier(caster, self.ability , "modifier_mana_on_attack", {})
    end
end

function modifier_slark_basic_attack:OnRefresh( kv )
    if IsServer() then
        -- references
        self.ability = self:GetAbility()
        self.stacks_duration = self.ability:GetSpecialValueFor( "stacks_duration" )
        self.attackspeed_variation = self.ability:GetSpecialValueFor( "attackspeed_variation" )
        self.damage_variation = self.ability:GetSpecialValueFor( "damage_variation" )
        self.max_stacks = self.ability:GetSpecialValueFor( "max_stacks" )
    end
end

function modifier_slark_basic_attack:GetModifierProcAttack_Feedback( params )
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		-- filter enemy
		local target = params.target
		if (not target:IsHero()) or target:IsIllusion() then
			return
		end

		if ( self:GetStackCount() == self.max_stacks ) then
			return
		end
		
		-- Apply debuff to enemy
		local debuff = params.target:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_slark_basic_attack_debuff",
			{
				stacks_duration = self.stacks_duration,
				attackspeed_variation = self.attackspeed_variation,
				damage_variation = self.damage_variation
			}
		)

		-- Apply buff to self
		self:AddStack( )

        -- Play effects
		self:PlayEffects( params.target )
	end
end

function modifier_slark_basic_attack:GetModifierBaseAttack_BonusDamage( params )
    if IsServer() then
        return ( self:GetStackCount() * self.damage_variation )
    end
    return 0
end

function modifier_slark_basic_attack:GetModifierAttackSpeedBonus_Constant( params )
    if IsServer() then
        return ( self:GetStackCount() * self.attackspeed_variation )
    end
    return 0
end

--------------------------------------------------------------------------------
-- Helper
function modifier_slark_basic_attack:AddStack( duration )
	-- Add counter
	local parent = tempTable:AddATValue( self )
	self:GetParent():AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_stack",
		{
			duration = self.stacks_duration,
			modifier = parent,
		}
	)

	-- Add stack
	self:IncrementStackCount()
end

function modifier_slark_basic_attack:RemoveStack()
	self:DecrementStackCount()
end

-- Graphics & Animations
function modifier_slark_basic_attack:PlayEffects( target )
	local particle_cast = "particles/units/heroes/hero_slark/slark_essence_shift.vpcf"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 1, self:GetParent():GetOrigin() + Vector( 0, 0, 64 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end