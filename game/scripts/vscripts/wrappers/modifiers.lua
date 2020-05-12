Modifiers = {}

function Modifiers.Recast( modifier, data )
    
    local onCreated =           modifier.OnCreated
    local onDestroy =           modifier.OnDestroy
    local declareFunctions =    modifier.DeclareFunctions
    local getRecastAbility =    modifier.GetRecastAbility
    
    function modifier:OnCreated( params )
        if IsServer() then
            if data.charges then
                self:SetStackCount(data.charges)
            end

            if data.keep_order ~= 1 then
                self:GetParent():SwapAbilities(
                    self:GetAbility():GetName(), 
                    self:GetRecastAbility():GetName(), 
                    false, 
                    true
                )
            end
            
            self:GetParent():AddRecastVisual({
                key = data.key,
                modifier = self,
                abilityName = self:GetRecastAbility():GetName(),
            })
        end
        
        if onCreated then onCreated(self, params) end
    end

    function modifier:OnDestroy()
        if IsServer() then
            if data.keep_order ~= 1 then
                self:GetParent():SwapAbilities(
                    self:GetAbility():GetName(), 
                    self:GetRecastAbility():GetName(), 
                    true, 
                    false
                )
            end
        end
        if onDestroy then onDestroy(self) end
    end
        
    function modifier:OnStackCountChanged(old)
        if IsServer() then
            if self:GetStackCount() <= 0 then
                self:Destroy()
            end
        end
    end

    function modifier:DeclareFunctions()
        local funcs = {}

        if declareFunctions then
            for _,func in pairs(declareFunctions()) do
                table.insert(funcs, func)
            end
        end

        table.insert(funcs, MODIFIER_EVENT_ON_ABILITY_EXECUTED)

        return funcs
    end
    
    function modifier:OnAbilityExecuted(params)
        if IsServer() then
            if params.unit ~= self:GetParent() then
                return
            end

            if params.ability == self:GetRecastAbility() then
                if data.charges then
                    self:DecrementStackCount()
                end
            end
        end
    end

    function modifier:GetRecastAbility()
        if getRecastAbility then return getRecastAbility(self) end
        return self:GetAbility()
    end
    
    function modifier:GetStatusLabel() return "Recast" end
    function modifier:GetStatusPriority() return 6 end
    function modifier:GetStatusStyle() return "Recast" end

    if IsClient() then require("wrappers/modifiers") end
    Modifiers.Status(modifier)
end

CHARGES_TYPE_SYNC = 1
CHARGES_TYPE_ASYNC = 2

-- TODO: What happens if the modifier has na OnIntervalThink function?
function Modifiers.Charges(modifier, data)
    local onCreated = modifier.OnCreated
    local onDestroy = modifier.OnDestroy
    local onRefresh = modifier.OnRefresh
    local getReplenishTime = modifier.GetReplenishTime
    local getReplenishType = modifier.GetReplenishType
    local getMaxCharges = modifier.GetMaxCharges

    function modifier:IsHidden()            return false end
    function modifier:IsDebuff()            return false end
    function modifier:IsPurgable()          return false end
    function modifier:DestroyOnExpire()     return false end

    function modifier:OnCreated(params)
        self.extra_charges = self:GetAbility():GetSpecialValueFor("extra_charges")

        if IsServer() then
            self:SetStackCount(self:GetMaxCharges())

            if self:GetReplenishType() == CHARGES_TYPE_ASYNC then    
                self:CalculateCharge()
            end
            if self:GetReplenishType() == CHARGES_TYPE_SYNC then
                self.replenish_time = self:GetReplenishTime()

                if data.show_icon == 1 then
                    self:GetParent():AddChargesVisual({ modifier = self })
                end
            end
        end
        if onCreated then onCreated(self, params) end
    end

    function modifier:OnRefresh(params)
        if IsServer() then
            self:CalculateCharge()
        end
        if onRefresh then onRefresh(self, params) end
    end

    function modifier:CalculateCharge()
        if self:GetReplenishType() == CHARGES_TYPE_ASYNC then
            self:GetAbility():EndCooldown()
            if self:GetStackCount() >= self:GetMaxCharges() then
                -- Stop charging
                self:SetStackCount(self:GetMaxCharges())
                self:SetDuration( -1, true )
                self:StartIntervalThink( -1 )
            else
                -- If not charging
                if self:GetRemainingTime() <= 0.05 then
                    -- Start charging
                    local charge_time = self:GetAbility():GetCooldown( -1 )
                    self:StartIntervalThink( charge_time )
                    self:SetDuration( charge_time, true )
                end

                -- Set on cooldown if no charges
                if self:GetStackCount() == 0 then
                    self:GetAbility():StartCooldown( self:GetRemainingTime() )
                end
            end
        end
        if self:GetReplenishType() == CHARGES_TYPE_SYNC then
            if self:GetStackCount() == self:GetMaxCharges() then
                -- Stop charging
                self:SetDuration( -1, false )
                self:StartIntervalThink( -1 )
            end
            if self:GetStackCount() < self:GetMaxCharges() then
                -- If not charging
                if self:GetRemainingTime() <= 0.05 then
                    self.replenish_time = self:GetReplenishTime()
                    self:StartIntervalThink( self.replenish_time )
                    self:SetDuration( self.replenish_time, true )
                end
                -- Set on cooldown if no charges
                if self:GetStackCount() == 0 then
                    self:GetAbility():StartCooldown(self:GetRemainingTime())
                end
            end
        end
    end

    function modifier:OnIntervalThink()
        if self:GetReplenishType() == CHARGES_TYPE_ASYNC then
            self:IncrementStackCount()
            self:StartIntervalThink(-1)
            self:CalculateCharge()
        end
        if self:GetReplenishType() == CHARGES_TYPE_SYNC then
            self:SetStackCount(self:GetMaxCharges())
            self:StartIntervalThink(-1)
        end
    end

    function modifier:OnStackCountChanged(old)
        if IsServer() then
            if data.show_icon == 1 then
                GameRules.GameMode:UpdateHeroCharges(self:GetParent(), self:GetStackCount())
            end
        end
    end

    function modifier:DeclareFunctions()
        local funcs = {}

        if declareFunctions then
            for _,func in pairs(declareFunctions()) do
                table.insert(funcs, func)
            end
        end

        table.insert(funcs, MODIFIER_EVENT_ON_ABILITY_EXECUTED)
        table.insert(funcs, MODIFIER_EVENT_ON_DEATH)

        return funcs
    end
    
    function modifier:OnDeath( params )
        if IsServer() then
            if params.unit ~= self:GetParent() then return end
            self:SetStackCount(self:GetMaxCharges())
        end
    end

    function modifier:OnAbilityExecuted(params)
        if IsServer() then
            if params.unit ~= self:GetParent() then
                return
            end

            if params.ability == self:GetAbility() then
                self:DecrementStackCount()
                self:CalculateCharge()
            end
        end
    end

    function modifier:GetMaxCharges()
        if getMaxCharges then return getMaxCharges(self) end
        return 1
    end

    function modifier:GetReplenishTime()
        if getReplenishTime then return getReplenishTime(self) end
        return 0
    end

    function modifier:GetReplenishType()
        if getReplenishType then return getReplenishType(self) end
        return CHARGES_TYPE_SYNC
    end
end

function Modifiers.Banish( modifier, data )
    function modifier:OnCreated(params)
        if IsServer() then
            if data.disable == 1 then
                self:SetStackCount(1)
            else
                self:SetStackCount(0)
            end
            self:GetParent():AddNoDraw()
        end
    end
    
    function modifier:CheckState()
        local state = {
            [MODIFIER_STATE_COMMAND_RESTRICTED] = self:GetStackCount() == 1 and true or false,
            [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
            [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
            [MODIFIER_STATE_INVULNERABLE] = true,
            [MODIFIER_STATE_OUT_OF_GAME] = true,
        }
    
        return state
    end
end

UNIT_COLLISION = 1
WALL_COLLISION = 2

function Modifiers.Displacement(modifier)
    local onCreated =               modifier.OnCreated
    local onDestroy =               modifier.OnDestroy
    local onCollide =               modifier.OnCollide
    local getCollisionRadius =      modifier.GetCollisionRadius
    local getCollisionOffset =      modifier.GetCollisionOffset
    local checkState =              modifier.CheckState
    
    function modifier:IsHidden()    return false end
    function modifier:IsPurgable() 	return false end

    function modifier:OnCreated(params)
        if IsServer() then
            self.distance =         params.r
            self.speed =            params.speed
            self.peak =             params.peak
            self.direction =        Vector(params.x,params.y,0):Normalized()
            
            self.parent =           self:GetParent()   
            self.origin =           self.parent:GetAbsOrigin()         
            self.prev_origin =      nil
    
            self.duration =         self.distance/self.speed
            self.gravity =          -self.peak/(self.duration * self.duration * 0.125)
            self.hVelocity =        self.speed
            self.vVelocity =        (-0.5) * self.gravity * self.duration
    
            self.elapsed_time =      0
            self.motion_tick =       {}
            self.motion_tick[0] =    0
            self.motion_tick[1] =    0
            self.motion_tick[2] =    0

            if self:ApplyVerticalMotionController() == false then self:Destroy() end
            if self:ApplyHorizontalMotionController() == false then self:Destroy() end
            self.parent:AddModifierTracker(self:GetName(), MODIFIER_DISPLACEMENT)
        end
        if onCreated then onCreated(self, params) end
    end

    function modifier:OnDestroy()
        if IsServer() then
            self.parent:InterruptMotionControllers( true )
            FindClearSpaceForUnit( self.parent, self.parent:GetAbsOrigin() , true )
            self.parent:RemoveModifierTracker(self:GetName(), MODIFIER_DISPLACEMENT)
        end
        if onDestroy then onDestroy(self, params) end
    end
    
    function modifier:SyncTime( iDir, dt )
        local current_z = GetGroundPosition(self:GetParent():GetAbsOrigin(), self:GetParent()).z

        -- check if already synced
        if self.motion_tick[1]==self.motion_tick[2] then
            self.motion_tick[0] = self.motion_tick[0] + 1
            self.elapsed_time = self.elapsed_time + dt
        end

        -- sync time
        self.motion_tick[iDir] = self.motion_tick[0]
        
        -- end motion
        if self.elapsed_time > self.duration and self.motion_tick[1] == self.motion_tick[2] then
            self:Destroy()
        end

        local origin = self.parent:GetAbsOrigin() + Vector(self.direction.x, self.direction.y, 0) * self:GetCollisionOffset()
        local units = self:GetCaster():FindUnitsInRadius(
            origin, 
            self:GetCollisionRadius(), 
            DOTA_UNIT_TARGET_TEAM_BOTH, 
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER
        )

        if self.prev_origin then
            if current_z - self.prev_origin.z > 32  then
                self:OnCollide({
                    type = WALL_COLLISION,
                })
            end
        end

        if #units >= 1 then
            self:OnCollide({
                units = units,
                type = UNIT_COLLISION,
            })
        end

        self.prev_origin = self:GetParent():GetAbsOrigin()
    end

    function modifier:UpdateHorizontalMotion( me, dt )
        self:SyncTime(1, dt)
        local target = self.direction * self.hVelocity * self.elapsed_time
        self.parent:SetAbsOrigin(self.origin + target)
    end

    function modifier:OnHorizontalMotionInterrupted()
        if IsServer() then
            self:Destroy()
        end
    end

    function modifier:UpdateVerticalMotion( me, dt )
        self:SyncTime(2, dt)
        local target = self.vVelocity * self.elapsed_time + 0.5 * self.gravity * self.elapsed_time * self.elapsed_time
        self.parent:SetAbsOrigin( Vector( self.parent:GetAbsOrigin().x, self.parent:GetAbsOrigin().y, self.origin.z + target ) )
    end

    function modifier:OnVerticalMotionInterrupted()
        if IsServer() then
            self:Destroy()
        end
    end

    function modifier:CheckState()
        local states = {}

        if checkState then
            for _,state in pairs(checkState()) do
                states[_] = state
            end
        end
        
        states[MODIFIER_STATE_COMMAND_RESTRICTED] = true
        return states
    end

    function modifier:OnCollide(params)
        if onCollide then onCollide(self, params) end
    end

    function modifier:GetCollisionRadius()
        if getCollisionRadius then return getCollisionRadius(self) end
        return 80
    end
    
    function modifier:GetCollisionOffset()
        if getCollisionOffset then return getCollisionOffset(self) end
        return 80
    end
end

function Modifiers.Counter(modifier)
    local onCreated =                   modifier.OnCreated
    local onDestroy =                   modifier.OnDestroy
    local onTrigger =                   modifier.OnTrigger
    local declareFunctions =            modifier.DeclareFunctions
    local checkState =                  modifier.CheckState
    local getMovementSpeedPercentage =  modifier.GetMovementSpeedPercentage

    function modifier:OnCreated(params)
        if IsServer() then
            self.effect_cast = ParticleManager:CreateParticle("particles/items_fx/black_king_bar_avatar.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
            self:GetParent():AddModifierTracker(self:GetName(), MODIFIER_COUNTER)
        end
        if onCreated then onCreated(self, params) end
    end

    function modifier:OnDestroy(params)
        if IsServer() then
            ParticleManager:DestroyParticle(self.effect_cast, false)
            ParticleManager:ReleaseParticleIndex( self.effect_cast )
            self:GetParent():RemoveModifierTracker(self:GetName(), MODIFIER_COUNTER)
        end
        if onDestroy then onDestroy(self, params) end
    end
    
    function modifier:OnTrigger(params)
        if onTrigger then onTrigger(self, params) end
    end

    function modifier:GetMovementSpeedPercentage()
        if getMovementSpeedPercentage then return getMovementSpeedPercentage(self) end
        return 0
    end  

    function modifier:DeclareFunctions()
        local funcs = {}

        if declareFunctions then
            for _,func in pairs(declareFunctions()) do
                table.insert(funcs, func)
            end
        end

        table.insert(funcs, MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE)
        table.insert(funcs, MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE)
        table.insert(funcs, MODIFIER_EVENT_ON_ORDER)

        return funcs
    end

    function modifier:OnOrder(params)
        if params.unit == self:GetParent() then
            if params.order_type == DOTA_UNIT_ORDER_STOP or params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION then
                self:Destroy()
            end
        end
    end

    function modifier:GetModifierMoveSpeedBonus_Percentage()
        if self:GetMovementSpeedPercentage() ~= 0 then
            return - (100 - self:GetMovementSpeedPercentage())
        end
        return 0
    end
    
    function modifier:GetModifierIncomingDamage_Percentage(params)
        if IsServer() then
            if params.damage_type ~= DAMAGE_TYPE_PURE then
                self:OnTrigger(params)
                return -100
            end
            return 0
        end
    end

    function modifier:CheckState()
        local states = {}

        if checkState then
            for _,state in pairs(checkState()) do
                states[_] = state
            end
        end
        
        if self:GetMovementSpeedPercentage() == 0 then
            states[MODIFIER_STATE_ROOTED] = true
        end
        return states
    end

    function modifier:GetStatusEffectName()
        return "particles/status_fx/status_effect_avatar.vpcf"
    end

    function modifier:GetStatusLabel() return "Counter" end
    function modifier:GetStatusPriority() return 4 end
    function modifier:GetStatusStyle() return "Counter" end

    if IsClient() then require("wrappers/modifiers") end
    Modifiers.Status(modifier)
end

function Modifiers.Reflect(modifier)
    local onCreated = modifier.OnCreated
    local onDestroy = modifier.OnDestroy

    function modifier:OnCreated(params)
        if IsServer() then
            self:GetParent():AddModifierTracker(self:GetName(), MODIFIER_REFLECT)
        end
        if onCreated then onCreated(self, params) end
    end

    function modifier:OnDestroy(params)
        if IsServer() then
            self:GetParent():RemoveModifierTracker(self:GetName(), MODIFIER_REFLECT)
        end
        if onDestroy then onDestroy(self, params) end
    end
end

function Modifiers.Animation(modifier)
    local onCreated = modifier.OnCreated
    local onDestroy = modifier.OnDestroy

    function modifier:OnCreated(params)
        if IsServer() then
            self:GetParent():AddModifierTracker(self:GetName(), MODIFIER_ANIMATION)
        end
        if onCreated then onCreated(self, params) end
    end

    function modifier:OnDestroy(params)
        if IsServer() then
            self:GetParent():RemoveModifierTracker(self:GetName(), MODIFIER_ANIMATION)
        end
        if onDestroy then onDestroy(self, params) end
    end
end

THINKER_VISUALS_PUBLIC = 1
THINKER_VISUALS_LOCAL = 2

function Modifiers.Thinker(modifier)
    local onCreated = modifier.OnCreated
    local onDestroy = modifier.OnDestroy
    local getAOERadius = modifier.GetAOERadius
    local getDelayTime = modifier.GetDelayTime
    local onIntervalThink = modifier.OnIntervalThink

    function modifier:OnCreated(params)
        if IsServer() then
            self.origin = self:GetParent():GetAbsOrigin()

            if self:GetAOERadius() > 0 then
                self:DrawVisuals()
            end
        end
        if self:GetDelayTime() > 0 then
            self.initialized = false
            self.counter = 0
            
            self:StartIntervalThink(0.03)
        else
            if onCreated then onCreated(self, params) end
        end
    end

    function modifier:OnDestroy(params)
        if IsServer() then
            if self:GetAOERadius() > 0 then
                self:RemoveVisuals()
            end
        end
        if onDestroy then onDestroy(self, params) end
    end

    function modifier:OnIntervalThink()
        if not self.initialized then
            local percentage = self.counter/(self:GetDelayTime() * 30)
            
            if IsServer() then
                for _,effect in pairs(self.effects_cast_progress) do
                    ParticleManager:SetParticleControl(effect, 1, Vector(self:GetAOERadius(), percentage, 0))
                end
            end

            if percentage >= 1.0 then
                self.initialized = true
                if onCreated then onCreated(self, params) end
            end
            self.counter = self.counter + 1
        else
            if onIntervalThink then onIntervalThink(self) end
        end
    end

    function modifier:GetAOERadius()
        if getAOERadius then return getAOERadius(self) end
        return 0
    end

    function modifier:GetDelayTime()
        if getDelayTime then return getDelayTime(self) end
        return 0
    end

    function modifier:DrawVisuals()
        local percentage = 1.0
        local caster_alliance = self:GetCaster():GetAlliance()

        if self:GetDelayTime() > 0 then
            percentage = 0.0
        end

        local particle_cast = "particles/progress_circle/generic_progress_circle.vpcf"
        self.effects_cast_progress = {}

        if self:GetVisualScope() == THINKER_VISUALS_PUBLIC then
            for _,alliance in pairs(GameRules.GameMode.alliances) do
                for _,team in pairs(alliance.teams) do
                    self.effects_cast_progress[team] = ParticleManager:CreateParticleForTeam( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster(), team )

                    ParticleManager:SetParticleControlForward(self.effects_cast_progress[team], 0, Vector(0,-1,0))	
                    ParticleManager:SetParticleControl(self.effects_cast_progress[team], 0, self.origin + Vector(0,0,16))
                    ParticleManager:SetParticleControl(self.effects_cast_progress[team], 1, Vector(self:GetAOERadius(), percentage, 1))
                    ParticleManager:SetParticleControl(self.effects_cast_progress[team], 16, Vector(1, 0, 0))
                    
                    local alliance = GameRules.GameMode:FindAllianceByTeam(team)

                    if alliance == caster_alliance then
                        ParticleManager:SetParticleControl( self.effects_cast_progress[team], 15, Vector(70, 70, 250))
                    else
                        ParticleManager:SetParticleControl( self.effects_cast_progress[team], 15, Vector(250, 70, 70))
                    end
                end
            end
        end
        if self:GetVisualScope() == THINKER_VISUALS_LOCAL then
            local parent_owner = self:GetCaster():GetPlayerOwner()

            self.effects_cast_progress["1"] = ParticleManager:CreateParticleForPlayer(particle_cast, PATTACH_WORLDORIGIN, self:GetCaster(), parent_owner)

            ParticleManager:SetParticleControl(self.effects_cast_progress["1"], 0, self.origin + Vector(0,0,16))
            ParticleManager:SetParticleControl(self.effects_cast_progress["1"], 1, Vector(self:GetAOERadius(), percentage, 1))
            ParticleManager:SetParticleControl( self.effects_cast_progress["1"], 15, Vector(70, 70, 250))
        end
    end

    function modifier:RemoveVisuals()
        for _,effect in pairs(self.effects_cast_progress) do
            ParticleManager:DestroyParticle(effect, false) 
            ParticleManager:ReleaseParticleIndex(effect)
        end
    end

    function modifier:GetVisualScope()
        return THINKER_VISUALS_PUBLIC
    end

    function modifier:IsInitialized()
        return self.initialized
    end
end

function Modifiers.Channeling(modifier)
    local onCreated = modifier.OnCreated
    local onDestroy = modifier.OnDestroy
    local declareFunctions =    modifier.DeclareFunctions
    local checkState =    modifier.CheckState

    function modifier:OnCreated(params)
        if IsServer() then
            self:GetParent():AddModifierTracker(self:GetName(), MODIFIER_CHANNELING)
        end
        if onCreated then onCreated(self, params) end
    end

    function modifier:OnDestroy(params)
        if IsServer() then
            self:GetParent():RemoveModifierTracker(self:GetName(), MODIFIER_CHANNELING)
        end
        if onDestroy then onDestroy(self, params) end
    end

    function modifier:DeclareFunctions()
        local funcs = {}

        if declareFunctions then
            for _,func in pairs(declareFunctions()) do
                table.insert(funcs, func)
            end
        end

        table.insert(funcs, MODIFIER_EVENT_ON_ORDER)
        return funcs
    end

    function modifier:OnOrder(params)
        if params.unit == self:GetParent() then
            if  params.order_type == DOTA_UNIT_ORDER_STOP or 
                params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION or 
                params.order_type == DOTA_UNIT_ORDER_CAST_POSITION or
                params.order_type == DOTA_UNIT_ORDER_CAST_NO_TARGET
            then
                self:Destroy()
            end
        end
    end

    function modifier:CheckState()
        local states = {}

        if checkState then
            for _,state in pairs(checkState()) do
                states[_] = state
            end
        end
        
        states[MODIFIER_STATE_ROOTED] = true
        return states
    end

        
    function modifier:GetStatusLabel() return "Channeling" end
    function modifier:GetStatusPriority() return 4 end
    function modifier:GetStatusStyle() return "Channeling" end

    if IsClient() then require("wrappers/modifiers") end
    Modifiers.Status(modifier)
end

STATUS_TRIGGER_DURATION = 1
STATUS_TRIGGER_STACKS = 2

STATUS_CONTENT_CLEAROUT = 1
STATUS_CONTENT_FILLUP = 2

STATUS_SCOPE_PUBLIC = 1
STATUS_SCOPE_LOCAL = 2

function Modifiers.Status(modifier)
    local onCreated = modifier.OnCreated
    local onDestroy = modifier.OnDestroy
    local getStatusLabel = modifier.GetStatusLabel
    local getStatusStyle = modifier.GetStatusStyle
    local getStatusPriority = modifier.GetStatusPriority
    local getStatusTriggerType = modifier.GetStatusTriggerType
    local getStatusContentType = modifier.GetStatusContentType
    local getStatusScope = modifier.GetStatusScope
    local getStatusEnabled = modifier.GetStatusEnabled

    function modifier:OnCreated(params)
        if IsServer() then
            if self:GetStatusEnabled() then
                self:GetParent():AddStatus({
                    label = self:GetStatusLabel(), 
                    modifier_name = self:GetName(), 
                    priority = self:GetStatusPriority(), 
                    trigger = self:GetStatusTriggerType(),
                    content = self:GetStatusContentType(),
                    style_name = self:GetStatusStyle(),
                    scope = self:GetStatusScope()
                })
            end
        end
        if onCreated then onCreated(self, params) end
    end

    function modifier:OnDestroy(params)
        if IsServer() then		
            self:GetParent():RemoveStatus(self:GetName())
        end
        if onDestroy then onDestroy(self, params) end
    end
    
    function modifier:GetStatusEnabled()
        if getStatusEnabled then return getStatusEnabled(self) end
        return true
    end
    function modifier:GetStatusLabel()
        if getStatusLabel then return getStatusLabel(self) end
        return "No Label"
    end
    function modifier:GetStatusPriority()
        if getStatusPriority then return getStatusPriority(self) end
        return 0
    end
    function modifier:GetStatusTriggerType()
        if getStatusTriggerType then return getStatusTriggerType(self) end
        return STATUS_TRIGGER_DURATION
    end
    function modifier:GetStatusStyle()
        if getStatusStyle then return getStatusStyle(self) end
        return "Generic"
    end
    function modifier:GetStatusContentType()
        if getStatusContentType then return getStatusContentType(self) end
        return STATUS_CONTENT_CLEAROUT
    end
    function modifier:GetStatusScope()
        if getStatusScope then return getStatusScope(self) end
        return STATUS_SCOPE_PUBLIC
    end
end