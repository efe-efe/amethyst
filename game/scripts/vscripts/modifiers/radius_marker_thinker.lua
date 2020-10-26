radius_marker_thinker = class({})

function radius_marker_thinker:OnCreated(params)
    self.initialized = false

    if IsServer() then
        self.radius = params.radius
        self.delay = params.delay
        self.afterDelay = params.afterDelay
        self.scope = params.scope

        self:DrawVisuals()

        if self.delay > 0 then
            self.counter = 0
            self:StartIntervalThink(0.03)
        else 
            self.initialized = true
            self:OnIntervalThink()
        end
    end
end

function radius_marker_thinker:OnDestroy()
    if IsServer() then
        self:RemoveVisuals()
        UTIL_Remove(self:GetParent())
    end
end

function radius_marker_thinker:OnIntervalThink()
    if not self.initialized then
        local percentage = self.counter/(self.delay * 30)
    
        if IsServer() then
            for _,effect in pairs(self.effects_cast_progress) do
                ParticleManager:SetParticleControl(effect, 0, self:GetParent():GetAbsOrigin() + Vector(0, 0, 16))
                ParticleManager:SetParticleControl(effect, 1, Vector(self.radius, percentage, 0))
            end
        end

        if percentage >= 1.0 then
            self.initialized = true
        end

        self.counter = self.counter + 1
    else 
        self:SetDuration(self.afterDelay, true)
        self:StartIntervalThink(-1)
    end
end

function radius_marker_thinker:DrawVisuals()
    local percentage = 1.0
    local caster_alliance = self:GetCaster():GetAlliance()

    if self.delay > 0 then
        percentage = 0.0
    end

    local particle_cast = "particles/progress_circle/generic_progress_circle.vpcf"
    self.effects_cast_progress = {}

    if self.scope == RADIUS_SCOPE_PUBLIC then
        for _,alliance in pairs(GameRules.GameMode.alliances) do
            for _,team in pairs(alliance.teams) do
                self.effects_cast_progress[team] = ParticleManager:CreateParticleForTeam(particle_cast, PATTACH_WORLDORIGIN, self:GetCaster(), team)

                ParticleManager:SetParticleControlForward(self.effects_cast_progress[team], 0, Vector(0,-1,0))	
                ParticleManager:SetParticleControl(self.effects_cast_progress[team], 0, self:GetParent():GetAbsOrigin() + Vector(0,0,16))
                ParticleManager:SetParticleControl(self.effects_cast_progress[team], 1, Vector(self.radius, percentage, 1))
                ParticleManager:SetParticleControl(self.effects_cast_progress[team], 16, Vector(1, 0, 0))
                
                local alliance = GameRules.GameMode:FindAllianceByTeam(team)

                if alliance == caster_alliance then
                    ParticleManager:SetParticleControl(self.effects_cast_progress[team], 15, Vector(70, 70, 250))
                else
                    ParticleManager:SetParticleControl(self.effects_cast_progress[team], 15, Vector(250, 70, 70))
                end
            end
        end
    end
    if self.scope == RADIUS_SCOPE_LOCAL then
        local parent_owner = self:GetCaster():GetPlayerOwner()

        self.effects_cast_progress["1"] = ParticleManager:CreateParticleForPlayer(particle_cast, PATTACH_WORLDORIGIN, self:GetCaster(), parent_owner)

        ParticleManager:SetParticleControl(self.effects_cast_progress["1"], 0, self:GetParent():GetAbsOrigin() + Vector(0,0,16))
        ParticleManager:SetParticleControl(self.effects_cast_progress["1"], 1, Vector(self.radius, percentage, 1))
        ParticleManager:SetParticleControl(self.effects_cast_progress["1"], 15, Vector(70, 70, 250))
    end
end

function radius_marker_thinker:RemoveVisuals()
    for _,effect in pairs(self.effects_cast_progress) do
        ParticleManager:DestroyParticle(effect, false) 
        ParticleManager:ReleaseParticleIndex(effect)
    end
end