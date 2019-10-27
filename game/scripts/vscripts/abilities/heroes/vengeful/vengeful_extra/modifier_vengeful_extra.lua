modifier_vengeful_extra = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_vengeful_extra:IsHidden()
	return false
end

function modifier_vengeful_extra:IsDebuff()
	return false
end

function modifier_vengeful_extra:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_vengeful_extra:OnCreated( kv )
    if IsServer() then
        local ability = self:GetCaster():FindAbilityByName("vengeful_extra")

        self.duration = ability:GetSpecialValueFor( "duration" )
        self.damage_block_initial = ability:GetSpecialValueFor( "damage_block" )
        self.damage_block = self.damage_block_initial
        
        self:PlayEffects(self.duration)

        if IsServer() then
            ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
                style = "Generic",
                text = "shield",
                progressBarType = "duration",
                priority = 1,
            })
        end
    end
end


function modifier_vengeful_extra:OnRefresh( kv )
    if IsServer() then
        self.damage_block = self.damage_block + self.damage_block_initial
        local new_duration = self:GetRemainingTime() + self.duration
        self:SetDuration(new_duration, true)
        self:StopEffects()
        self:PlayEffects(new_duration)
    end
end

--------------------------------------------------------------------------
---- Destroyer
function modifier_vengeful_extra:OnDestroy( kv )
    if IsServer() then
        self:StopEffects()
    end
end

function modifier_vengeful_extra:GetModifierIncomingDamage_Percentage( params )
    self.damage_block =  self.damage_block - params.damage

    if self.damage_block <= 0 then
        local reduction = 100 - (100 * self.damage_block * (-1) / params.damage)
        self:Destroy()
        return -reduction
    end
    return -100
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_vengeful_extra:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Graphics & Sounds

-- On activated
function modifier_vengeful_extra:PlayEffects( duration )
    -- Get Resources
	local particle_cast = "particles/items_fx/courier_shield.vpcf"
    local sound_cast = "Hero_Disruptor.KineticField"
    -- Create Sound
    EmitSoundOn(sound_cast, self:GetCaster())
    
    local origin = self:GetParent():GetOrigin()

    -- Create Particles
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
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(duration, 0,0) )
end

function modifier_vengeful_extra:StopEffects()
    if self.effect_cast then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
end

function modifier_vengeful_extra:GetTexture()
	return "vengeful_extra"
end

