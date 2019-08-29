modifier_thinker_indicator = class({})

--------------------------------------------------------------------------------
-- Initializer
function modifier_thinker_indicator:OnCreated( kv )
    if IsServer() then
        local thinker = kv.thinker

        self.show_all = kv.show_all
        self.radius = kv.radius
        self.delay_time = kv.delay_time
        self.caster = self:GetCaster()
        self.origin = self:GetParent():GetOrigin()
        self.effects_cast_aoe = {}

        CreateModifierThinker(
            self.caster, --hCaster
            self:GetAbility(), --hAbility
            thinker, --modifierName
            {}, --paramTable
            self.origin, --vOrigin
            self.caster:GetTeamNumber(), --nTeamNumber
            false --bPhantomBlocker
        )

        self:PlayEffects()
        -- Start Interval
        self:StartIntervalThink( self.delay_time )
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_thinker_indicator:OnDestroy()
    if IsServer() then
	    self:StopEffects()
	end
end

--------------------------------------------------------------------------------
-- On Think
function modifier_thinker_indicator:OnIntervalThink()
    if IsServer() then
	    self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
function modifier_thinker_indicator:PlayEffects()                
    local particle_cast = "particles/econ/events/ti9/mekanism_recipient_b_ti9.vpcf"--ally
    local particle_cast_aoe = "particles/dev/new_heroes/new_hero_aoe_ring_rope.vpcf"
    local effect_cast
    
    if self.show_all == 1 then
        for _,actual_team in pairs(GameMode.teams) do
            self.effects_cast_aoe[_] = ParticleManager:CreateParticleForTeam( particle_cast_aoe, PATTACH_WORLDORIGIN, self.caster, _ )

            ParticleManager:SetParticleControl( self.effects_cast_aoe[_], 0, self.origin)	-- line origin
            ParticleManager:SetParticleControl( self.effects_cast_aoe[_], 1, Vector(self.radius, 1,1))
            effect_cast = ParticleManager:CreateParticleForTeam( particle_cast, PATTACH_WORLDORIGIN, self.caster, _ )

            if self.caster:GetTeam() == _ then
                ParticleManager:SetParticleControl( self.effects_cast_aoe[_], 15, Vector(70, 70, 250))
            else
                ParticleManager:SetParticleControl( self.effects_cast_aoe[_], 15, Vector(250, 70, 70))
            end

            ParticleManager:SetParticleControl( effect_cast, 0, self.origin)	-- line origin
            ParticleManager:SetParticleControl( effect_cast, 1, self.origin)	-- line origin
            ParticleManager:ReleaseParticleIndex( effect_cast )
        end
    else
        effect_cast = ParticleManager:CreateParticleForPlayer( particle_cast, PATTACH_WORLDORIGIN, self.caster, parent_owner )
        self.effect_cast_aoe = ParticleManager:CreateParticleForPlayer( particle_cast_aoe, PATTACH_WORLDORIGIN, self.caster, parent_owner )

        ParticleManager:SetParticleControl( self.effect_cast_aoe, 0, self.origin)	-- line origin
        ParticleManager:SetParticleControl( self.effect_cast_aoe, 1, Vector(self.radius, 1,1))
        ParticleManager:SetParticleControl( self.effect_cast_aoe, 15, Vector(70, 70, 250))
        
        ParticleManager:SetParticleControl( effect_cast, 0, self.origin)	-- line origin
        ParticleManager:SetParticleControl( effect_cast, 1, self.origin)	-- line origin
        ParticleManager:ReleaseParticleIndex( effect_cast )
    end
end

function modifier_thinker_indicator:StopEffects()
	if self.effect_cast_aoe ~= nil then
		ParticleManager:DestroyParticle( self.effect_cast_aoe, false ) 
		ParticleManager:ReleaseParticleIndex( self.effect_cast_aoe )
    end
    
    for _,actual_team in pairs(GameMode.teams) do
        if self.effects_cast_aoe[_]  ~= nil then
            ParticleManager:DestroyParticle( self.effects_cast_aoe[_], false ) 
            ParticleManager:ReleaseParticleIndex( self.effects_cast_aoe[_] )
        end
    end
end