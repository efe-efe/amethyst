modifier_phantom_assassin_ex_basic_attack_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phantom_assassin_ex_basic_attack_lua:IsHidden()
	return false
end

function modifier_phantom_assassin_ex_basic_attack_lua:IsDebuff()
	return false
end

function modifier_phantom_assassin_ex_basic_attack_lua:IsStunDebuff()
	return false
end

function modifier_phantom_assassin_ex_basic_attack_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_assassin_ex_basic_attack_lua:OnCreated( kv )
	-- references
    if IsServer() then
        local charges = self:GetAbility():GetSpecialValueFor( "charges" )
        self.heal = self:GetAbility():GetSpecialValueFor( "heal" )


		self:SetStackCount(charges)
	end
end

function modifier_phantom_assassin_ex_basic_attack_lua:OnRefresh( kv )
	-- references

	if IsServer() then
        local charges = self:GetAbility():GetSpecialValueFor( "charges" )
        self.heal = self:GetAbility():GetSpecialValueFor( "heal" )

		self:SetStackCount(charges)
	end
end

function modifier_phantom_assassin_ex_basic_attack_lua:OnDestroy( kv )

end
--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_assassin_ex_basic_attack_lua:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}

	return funcs
end

function modifier_phantom_assassin_ex_basic_attack_lua:OnAbilityFullyCast(params)
    if params.ability==self:GetParent():FindAbilityByName("phantom_assassin_basic_attack_lua") then
        self:DecrementStackCount()

        if self:GetStackCount()<=0 then
            self:Destroy()
        end
    end
end


function modifier_phantom_assassin_ex_basic_attack_lua:GetModifierProcAttack_BonusDamage_Physical( params )
	if IsServer() then
		if self:GetParent():PassivesDisabled() then return end
            self:GetParent():Heal( self.heal, self:GetParent() )
            self:PlayEffects()
        
        return 0
	end
end


function modifier_phantom_assassin_ex_basic_attack_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/generic_gameplay/generic_lifesteal.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end