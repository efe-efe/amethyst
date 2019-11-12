modifier_thinker_indicator = class({})

--------------------------------------------------------------------------------
-- Initializer
function modifier_thinker_indicator:OnCreated( kv )
    if IsServer() then
        local thinker = kv.thinker

        self.show_all = kv.show_all
        self.radius = kv.radius
        self.delay_time = kv.delay_time
        self.draw_clock = kv.draw_clock 

        local extra_one = kv.extra_one
        local thinker_duration = kv.thinker_duration

        self.caster = self:GetCaster()
        self.origin = self:GetParent():GetOrigin()
        self.effects_cast_aoe = {}
        self.effects_cast = {}

        CreateModifierThinker(
            self.caster, --hCaster
            self:GetAbility(), --hAbility
            thinker, --modifierName
            { duration = thinker_duration, extra_one = extra_one }, --paramTable
            self.origin, --vOrigin
            self.caster:GetTeamNumber(), --nTeamNumber
            false --bPhantomBlocker
        )

        self:PlayEffects()

        self.current_degree = 0
        self.max_degree = 360
        self.interval = self.delay_time/self.max_degree
        self:StartIntervalThink( self.interval )
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_thinker_indicator:OnDestroy()
    if IsServer() then
        self:StopEffects()
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- On Think
function modifier_thinker_indicator:OnIntervalThink()
    if self.current_degree >= self.max_degree then
        self:Destroy()
        return
    end

    if self.draw_clock == 1 then 
        local x = self.origin.x + self.radius * math.cos(self.current_degree * math.pi/180)
        local y = self.origin.y + self.radius * math.sin(self.current_degree * math.pi/180)
        local target_point = Vector(x, y, self.origin.z)

        DebugDrawLine_vCol(
            self.origin, 
            target_point, 
            Vector(254, 255, 234), 
            false, 
            self.interval
        )

        self:PlayEffectsDot(target_point, self.current_degree)
    end

    self.current_degree = (self.current_degree + 1)
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
function modifier_thinker_indicator:PlayEffects()                
    local particle_cast = "particles/econ/events/ti9/mekanism_recipient_b_ti9.vpcf"--ally
    local particle_cast_aoe = "particles/dev/new_heroes/new_hero_aoe_ring_rope.vpcf"
    local effect_cast
    
    if self.show_all == 1 then
        for _,alliance in pairs(GameMode.alliances) do
            for _,team in pairs(alliance.teams) do
                effect_cast = ParticleManager:CreateParticleForTeam( particle_cast, PATTACH_WORLDORIGIN, self.caster, _ )
                self.effects_cast_aoe[team] = ParticleManager:CreateParticleForTeam( particle_cast_aoe, PATTACH_WORLDORIGIN, self.caster, team )

                ParticleManager:SetParticleControl( self.effects_cast_aoe[team], 0, self.origin)	-- line origin
                ParticleManager:SetParticleControl( self.effects_cast_aoe[team], 1, Vector(self.radius, 1,1))

                if self.caster:GetTeam() == team then
                    ParticleManager:SetParticleControl( self.effects_cast_aoe[team], 15, Vector(70, 70, 250))
                else
                    ParticleManager:SetParticleControl( self.effects_cast_aoe[team], 15, Vector(250, 70, 70))
                end

                ParticleManager:SetParticleControl( effect_cast, 0, self.origin)	-- line origin
                ParticleManager:SetParticleControl( effect_cast, 1, self.origin)	-- line origin
                ParticleManager:ReleaseParticleIndex( effect_cast )
            end
        end
    else

        local parent_owner = self.caster:GetPlayerOwner()

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
    
    for _,alliance in pairs(GameMode.alliances) do
        for _,team in pairs(alliance.teams) do
            if self.effects_cast_aoe[team]  ~= nil then
                ParticleManager:DestroyParticle( self.effects_cast_aoe[team], false ) 
                ParticleManager:ReleaseParticleIndex( self.effects_cast_aoe[team] )
            end
        end
    end


    for _,effect in pairs(self.effects_cast) do
        if effect ~= nil then
            ParticleManager:DestroyParticle( effect, false ) 
            ParticleManager:ReleaseParticleIndex( effect )
        end

    end
end

function modifier_thinker_indicator:PlayEffectsDot(pos, index)
    local particle_cast = "particles/units/heroes/hero_warlock/warlock_base_attack_sphere_glow.vpcf"
    self.effects_cast[index] = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( self.effects_cast[index], 0, pos)
    ParticleManager:SetParticleControl( self.effects_cast[index], 1, pos )
    ParticleManager:SetParticleControl( self.effects_cast[index], 2, pos )
    ParticleManager:SetParticleControl( self.effects_cast[index], 3, pos )
    ParticleManager:SetParticleControl( self.effects_cast[index], 4, pos )
end