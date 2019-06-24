modifier_phantom_ex_basic_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phantom_ex_basic_attack:IsHidden()
	return false
end

function modifier_phantom_ex_basic_attack:IsDebuff()
	return false
end

function modifier_phantom_ex_basic_attack:IsStunDebuff()
	return false
end

function modifier_phantom_ex_basic_attack:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_ex_basic_attack:OnCreated( kv )
	-- references
    if IsServer() then
        local charges = self:GetAbility():GetSpecialValueFor( "charges" )
        self.heal = self:GetAbility():GetSpecialValueFor( "heal" )


		self:SetStackCount(charges)


		local particle_cast = "particles/units/heroes/hero_skeletonking/wraith_king_reincarnate_slow_debuff.vpcf"
        local origin = self:GetParent():GetOrigin()
        
        self.effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_CUSTOMORIGIN, 
            nil
        )

        ParticleManager:SetParticleControlEnt( 
            self.effect_cast, 
            0, 
            self:GetParent(), 
            PATTACH_POINT_FOLLOW, 
            "attach_attack1", 
            origin + Vector( 0, 0, 96 ), 
            true 
        )
	end
end

function modifier_phantom_ex_basic_attack:OnRefresh( kv )
	-- references

	if IsServer() then
        local charges = self:GetAbility():GetSpecialValueFor( "charges" )
        self.heal = self:GetAbility():GetSpecialValueFor( "heal" )

		self:SetStackCount(charges)
	end
end

function modifier_phantom_ex_basic_attack:OnDestroy( kv )
	if IsServer() then
		ParticleManager:DestroyParticle( self.effect_cast, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end
end
--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_ex_basic_attack:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}

	return funcs
end

function modifier_phantom_ex_basic_attack:OnAbilityFullyCast(params)
    if params.ability==self:GetParent():FindAbilityByName("phantom_basic_attack") or params.ability==self:GetParent():FindAbilityByName("phantom_special_attack") then
        self:DecrementStackCount()

        if self:GetStackCount()<=0 then
            self:Destroy()
        end
    end
end


function modifier_phantom_ex_basic_attack:GetModifierProcAttack_BonusDamage_Physical( params )
	if IsServer() then
		if self:GetParent():PassivesDisabled() then return end
            self:GetParent():Heal( self.heal, self:GetParent() )
            self:PlayEffects()
        
        return 0
	end
end


function modifier_phantom_ex_basic_attack:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/generic_gameplay/generic_lifesteal.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end