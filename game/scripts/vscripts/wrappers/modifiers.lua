Modifiers = {}

function Modifiers.Recast( modifier, data )
    
    local onCreated = modifier.OnCreated
    local onDestroy = modifier.OnDestroy

    function modifier:OnCreated( params )
        if IsServer() then
            if data.create_ability == 1 then
                local recast_ability = self:GetParent():AddAbility( data.ability_name )
                recast_ability:SetLevel( 1 )
            end
            
            local charges = data.charges or 1
            if charges == -1 then
                self:SetStackCount(999)
            else
                self:SetStackCount(charges)
            end

            if data.keep_order ~= 1 then
                self:GetParent():SwapAbilities(
                    self:GetAbility():GetName(), 
                    data.ability_name, 
                    false, 
                    true
                )
            end
            
            self:GetParent():AddRecastVisual({
                key = data.key,
                modifier = self,
                abilityName = data.ability_name,
            })
        end
        
        if onCreated then onCreated(self, params) end
    end

    function modifier:OnDestroy()
        if IsServer() then
            if data.keep_order ~= 1 then
                self:GetParent():SwapAbilities(
                    self:GetAbility():GetName(), 
                    data.ability_name, 
                    true, 
                    false
                )
            end
            
            if data.create_ability == 1 then
                self:GetParent():RemoveAbility( data.ability_name )
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
end

function Modifiers.Charges( modifier, data )
    function modifier:IsHidden() return false end
    function modifier:IsDebuff() return false end
    function modifier:IsPurgable() return false end
    function modifier:DestroyOnExpire() return false end
    function modifier:DeclareFunctions() return { MODIFIER_EVENT_ON_DEATH } end

    function modifier:OnCreated( kv )
        self.max_charges = self:GetAbility():GetSpecialValueFor("max_charges")
        self.extra_charges = self:GetAbility():GetSpecialValueFor("extra_charges")

        if IsServer() then
            self:SetStackCount( self.max_charges )

            if data.type == "unsynced" then    
                self:CalculateCharge()
            elseif data.type == "synced" then
                self.replenish_time = self:GetAbility():GetSpecialValueFor("replenish_time")

                if data.show_icon == 1 then
                    GameMode:InitializeHeroCharges(self:GetParent(), self:GetStackCount())
                end
            end
        end
    end

    function modifier:OnRefresh( kv )
        self.max_charges = self:GetAbility():GetSpecialValueFor( "max_charges" )
        if IsServer() then
            self:CalculateCharge()
        end
    end

    function modifier:OnSpellCast( )
        if IsServer() then
            self:DecrementStackCount()
            self:CalculateCharge()
        end
    end

    function modifier:OnDeath( params )
        if IsServer() then
            if params.unit ~= self:GetParent() then return end
            self:SetStackCount( self.max_charges )
        end
    end

    function modifier:OnIntervalThink()
        if data.type == "unsynced" then
            self:IncrementStackCount()
            self:StartIntervalThink(-1)
            self:CalculateCharge()
        elseif data.type == "synced" then
            self:SetStackCount(self.max_charges)
            self:StartIntervalThink(-1)
        end
    end

    function modifier:CalculateCharge()
        if data.type == "unsynced" then
            self:GetAbility():EndCooldown()
            if self:GetStackCount() >= self.max_charges then
                -- Stop charging
                self:SetStackCount( self.max_charges )
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
        elseif data.type == "synced" then
            if self:GetStackCount() > self.max_charges then
                print("HER")
            elseif self:GetStackCount() == self.max_charges then
                -- Stop charging
                self:SetDuration( -1, false )
                self:StartIntervalThink( -1 )
            else
                -- If not charging
                if self:GetRemainingTime() <= 0.05 then
                    self:StartIntervalThink( self.replenish_time )
                    self:SetDuration( self.replenish_time, true )
                end
        
                -- Set on cooldown if no charges
                if self:GetStackCount() == 0 then
                    self:GetAbility():StartCooldown( self:GetRemainingTime() )
                end
            end
        end
    end

    function modifier:OnStackCountChanged(old)
        if IsServer() then
            if data.show_icon == 1 then
                GameMode:UpdateHeroCharges(self:GetParent(), self:GetStackCount())
            end
        end
    end
end
