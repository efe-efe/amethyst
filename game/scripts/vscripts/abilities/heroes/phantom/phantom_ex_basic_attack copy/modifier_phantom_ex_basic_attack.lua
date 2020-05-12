modifier_phantom_ex_basic_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phantom_ex_basic_attack:IsHidden() return false
end

function modifier_phantom_ex_basic_attack:IsDebuff() return false
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
        self:PlayEffectsOnCast()
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
        self:StopEffects()
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
    if  params.ability==self:GetParent():FindAbilityByName("phantom_basic_attack") or 
        params.ability==self:GetParent():FindAbilityByName("phantom_special_attack") 
    then
        -- Wait to be read on basic attack before destroying
        Timers:CreateTimer(params.ability:GetCastPoint() + 0.1, function()
            self:DecrementStackCount()
            if self:GetStackCount()<=0 then
                self:Destroy()
            end
        end)
    end
end


function modifier_phantom_ex_basic_attack:GetModifierProcAttack_BonusDamage_Physical( params )
	if IsServer() then
        self:GetParent():Heal( self.heal, self:GetParent() )
        self:PlayEffectsLifeSteal()
        return 0
	end
end



function modifier_phantom_ex_basic_attack:PlayEffectsOnCast()
    local particle_cast = "particles/econ/courier/courier_greevil_green/courier_greevil_green_ambient_2.vpcf"
    local origin = self:GetParent():GetOrigin()

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
        origin, 
        true 
    )
    ParticleManager:SetParticleControlEnt( 
        self.effect_cast, 
        1, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        origin, 
        true 
    )

    particle_cast = "particles/econ/courier/courier_babyroshan_winter18/courier_babyroshan_winter18_ambient_sparks.vpcf"

    self.effect_cast_sparks = ParticleManager:CreateParticle( 
        particle_cast, 
        PATTACH_CUSTOMORIGIN, 
        self:GetParent()
    )

    ParticleManager:SetParticleControlEnt( 
        self.effect_cast_sparks, 
        0, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        origin, 
        true 
    )
end

function modifier_phantom_ex_basic_attack:StopEffects()
    if self.effect_cast ~= nil then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end

    if self.effect_cast_sparks ~= nil then
        ParticleManager:DestroyParticle( self.effect_cast_sparks, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast_sparks )
    end
    
end

function modifier_phantom_ex_basic_attack:PlayEffectsLifeSteal()
	-- Get Resources
	local particle_cast = "particles/generic_gameplay/generic_lifesteal.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end