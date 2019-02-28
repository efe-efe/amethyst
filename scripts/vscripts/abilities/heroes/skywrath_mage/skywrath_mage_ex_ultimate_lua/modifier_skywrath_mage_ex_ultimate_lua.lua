modifier_skywrath_mage_ex_ultimate_lua = class({})

--------------------------------------------------------------------------------
-- Initializations
function modifier_skywrath_mage_ex_ultimate_lua:OnCreated( kv )
    if IsServer() then
        self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
        self.damage_block = self:GetAbility():GetSpecialValueFor( "damage_block" )
        
        self:PlayEffects()
    end
end
--------------------------------------------------------------------------
---- Destroyer
function modifier_skywrath_mage_ex_ultimate_lua:OnDestroy( kv )
    if IsServer() then
        self:StopEffects()
    end
end

function modifier_skywrath_mage_ex_ultimate_lua:GetModifierIncomingDamage_Percentage( params )
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
function modifier_skywrath_mage_ex_ultimate_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Graphics & Sounds

-- On activated
function modifier_skywrath_mage_ex_ultimate_lua:PlayEffects()
    -- Get Resources
	local particle_cast = "particles/items_fx/courier_shield.vpcf"
    local sound_cast = "Hero_SkywrathMage.ConcussiveShot.Cast"
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
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(self.duration, 0,0) )
end

function modifier_skywrath_mage_ex_ultimate_lua:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end