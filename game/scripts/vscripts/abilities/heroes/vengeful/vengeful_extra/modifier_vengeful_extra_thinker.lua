modifier_vengeful_extra_thinker = class({})
LinkLuaModifier( "modifier_vengeful_extra", "abilities/heroes/vengeful/vengeful_extra/modifier_vengeful_extra", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Initializer
function modifier_vengeful_extra_thinker:OnCreated( kv )
    if IsServer() then
        self.ability = self:GetCaster():FindAbilityByName("vengeful_extra")
        self.radius = self.ability:GetSpecialValueFor( "radius" )
        self.delay_time = self.ability:GetSpecialValueFor( "delay_time" )
        self.duration = self.ability:GetSpecialValueFor( "duration" )
        self.damage_block = self.ability:GetSpecialValueFor( "damage_block" )

        -- Start Interval
        self:StartIntervalThink( self.delay_time )
        self:PlayEffectsOnCreated()
    end
end

--------------------------------------------------------------------------------
-- On think
function modifier_vengeful_extra_thinker:OnIntervalThink()
    if IsServer() then
        local caster = self:GetCaster()
        local thinker = self:GetParent()

         -- Find allies
         local allies = caster:FindUnitsInRadius( 
            thinker:GetOrigin(), 
            self.radius, 
            DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER
        )

        for _,ally in pairs(allies) do
            ally:AddNewModifier(caster, self:GetAbility(), "modifier_shield", { duration = self.duration, damage_block = self.damage_block })
            --ally:AddNewModifier(caster, self:GetAbility(), "modifier_vengeful_extra", { duration = self.duration })
        end

        CreateRadiusMarker(caster, thinker:GetOrigin(), { 
            show_all = 1,
            radius = self.radius,
        })
        
		self:PlayEffectsOnImpact()
	    self:Destroy()
	end
end

--------------------------------------------------------------------------------

function modifier_vengeful_extra_thinker:PlayEffectsOnCreated()
    local thinker = self:GetParent()
    -- Create sound
    EmitSoundOn( "Hero_VengefulSpirit.Missile.Cast.TI8.Layer", thinker )
    
    -- Create particles
	local particle_cast = "particles/addons_gameplay/morokai_orb_large.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, thinker )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector(1, 0, 0) )
    ParticleManager:SetParticleControl( effect_cast, 10, Vector(2.5, 0, 0) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_vengeful_extra_thinker:PlayEffectsOnImpact()
    local thinker = self:GetParent()
    -- Create sound
    EmitSoundOn( "Hero_VengefulSpirit.Missile.Target.TI8.Layer", thinker )

    -- Create particles
	local particle_cast = "particles/units/heroes/hero_treant/treant_overgrowth_hero_glow.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, thinker )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    local particle_cast_b = "particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_n_cowlofice.vpcf"
    local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, thinker )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
end

