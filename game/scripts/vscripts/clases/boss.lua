Boss = Boss or class({}, nil, UnitEntity)
Centaur = Centaur or class({}, nil, Boss)
Queen = Queen or class({}, nil, Boss)

local BossState = {
    READY = 0,
    CASTING = 1,
    RESTING = 2,
}

function Boss:constructor(vOrigin, sUnitName)
    getbase(Boss).constructor(self, vOrigin, sUnitName, DOTA_TEAM_CUSTOM_1)
    self.nState = BossState.READY
    self.nFollowRange = 750
    self.nAbilitiesRange = 2500
    self.bWanderer = true
    self.bBackToCenter = true
    self.tAbilities = {
        --hAbility = hAbility,
        --nPriority = 0,
        --fRequirements = function() end,
        --fCast = function() end,
    }
    --self:GetUnit():SetUnitCanRespawn(false)
end

function Boss:FindEnemy(iRadius)
    local unit = self:GetUnit()
    local units = FindUnitsInRadius(
        unit:GetTeamNumber(),
        unit:GetAbsOrigin(),
        nil,
        iRadius,
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NO_INVIS,
        FIND_ANY_ORDER,
        false
	)

    if #units >= 0 then
        return units[1]
    else
        return nil
    end
end

function Boss:IsAbilityReady(hAbility)
    return hAbility:IsCooldownReady() and not hAbility:IsInAbilityPhase()
end

function Boss:RegisterAbility(tAbility)
    tAbility.fCast = function(hAbility, hTarget)
        ExecuteOrderFromTable({
            OrderType = tAbility.nOrderType,
            UnitIndex = self:GetUnit():GetEntityIndex(),
            AbilityIndex = hAbility:GetEntityIndex(),
            Position = hTarget and hTarget:GetAbsOrigin() or nil
        }) 
    end
    table.insert(self.tAbilities, tAbility)
end

function Boss:StartRest(nRestTime)
    self.nRemainingRestTime = nRestTime * 30
end

function Boss:Update()
    if self.nRemainingRestTime > 0 then
        self.nRemainingRestTime = self.nRemainingRestTime - 1

        if self.nState ~= BossState.RESTING then
            self.nState = BossState.RESTING
        end

        if self.bWanderer then
            if self.vRestDirection == nil then
                self.vRestDirection = Vector(RandomFloat(-1.0, 1.0), RandomFloat(-1.0, 1.0))
                CustomEntities:SetDirection(self.hUnit, self.vRestDirection.x, self.vRestDirection.y)
            end
        end

        return
    else
        self.vRestDirection = nil
    end

    if self.hUnit:HasModifier("modifier_casting") or CustomEntities:IsChanneling(self.hUnit) then
        self.nState = BossState.CASTING
    else 
        self.nState = BossState.READY
    end

    if self.nState == BossState.READY then
        local vDirection = Vector(0,0)

        if self.bBackToCenter then
            if (self.hUnit:GetAbsOrigin() - Vector(0,0,0)):Length2D() < 10 then
                vDirection = Vector(0,0)
            else
                vDirection = (Vector(0,0,0) - self.hUnit:GetAbsOrigin()):Normalized()
            end
        else
            vDirection = Vector(RandomFloat(-1.0, 1.0), RandomFloat(-1.0, 1.0))
        end

        local hTarget = self:FindEnemy(self.nFollowRange)

        if hTarget then
            local nDistance = CustomEntities:GetDistance(self.hUnit, hTarget)

            if hTarget:IsAlive() and nDistance > 250 then
                vDirection = (hTarget:GetAbsOrigin() - self.hUnit:GetAbsOrigin()):Normalized()
            end
        end

        if not CustomEntities:IsDisplacing(self.hUnit) then
            hTarget = self:FindEnemy(self.nAbilitiesRange)

            local tAbilityToExecute = nil 
            for _,tAbility in pairs(self.tAbilities) do
                if tAbility.fRequirments(tAbility.hAbility, hTarget) then
                    if tAbilityToExecute == nil then
                        tAbilityToExecute = tAbility
                    end
                    if tAbility.nPriority > tAbilityToExecute.nPriority then
                        tAbilityToExecute = tAbility
                    end
                end
            end

            if tAbilityToExecute then
                tAbilityToExecute.fCast(tAbilityToExecute.hAbility, hTarget)
                self:StartRest(self.nRestTime)
            end
        end

        if self.bWanderer then
            CustomEntities:SetDirection(self.hUnit, vDirection.x, vDirection.y)
        end
    end
end


function Centaur:constructor(vOrigin)    
    getbase(Centaur).constructor(self, vOrigin, "npc_dota_hero_centaur")
    self.hUnit = self:GetUnit()
    
    self.nRestTime = 1.0
    self.nRemainingRestTime = 0
    self.vRestDirection = nil

    self:RegisterAbility({
        hAbility = self.hUnit:FindAbilityByName("centaur_short_attack"),
        nPriority = 3,
        nOrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
        fRequirments = function(hAbility, hTarget)
            if hTarget then
                local nDistance = CustomEntities:GetDistance(self.hUnit, hTarget)
                return (hTarget and CustomEntities:GetDistance(self.hUnit, hTarget) <= hAbility:GetSpecialValueFor("radius") and self:IsAbilityReady(hAbility))
            else
                return false
            end
        end,
    })
    self:RegisterAbility({
        hAbility = self.hUnit:FindAbilityByName("centaur_range_attack"),
        nPriority = 1,
        nOrderType = DOTA_UNIT_ORDER_CAST_POSITION,
        fRequirments = function(hAbility, hTarget)
            return (hTarget and self:IsAbilityReady(hAbility))
        end,
    })
    self:RegisterAbility({
        hAbility = self.hUnit:FindAbilityByName("centaur_charge"),
        nPriority = 4,
        nOrderType = DOTA_UNIT_ORDER_CAST_POSITION,
        fRequirments = function(hAbility, hTarget)
            return (hTarget and self:IsAbilityReady(hAbility))
        end,
    })
    self:RegisterAbility({
        hAbility = self.hUnit:FindAbilityByName("centaur_rage"),
        nPriority = 5,
        nOrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
        fRequirments = function(hAbility)
            return self:IsAbilityReady(hAbility) 
        end,
    })
    self:RegisterAbility({
        hAbility = self.hUnit:FindAbilityByName("centaur_axe_attack"),
        nPriority = 2,
        nOrderType = DOTA_UNIT_ORDER_CAST_POSITION,
        fRequirments = function(hAbility, hTarget)
            if hTarget then
                local nDistance = CustomEntities:GetDistance(self.hUnit, hTarget)
                return CustomEntities:GetDistance(self.hUnit, hTarget) <= hAbility:GetSpecialValueFor("radius") and self:IsAbilityReady(hAbility)
            else
                return false
            end
        end,
    })
end

function Queen:constructor(vOrigin)    
    getbase(Queen).constructor(self, vOrigin, "npc_dota_hero_queenofpain")
    self.hUnit = self:GetUnit()
    
    self.nRestTime = 1.0
    self.nRemainingRestTime = 0
    self.vRestDirection = nil
    
    self:RegisterAbility({
        hAbility = self.hUnit:FindAbilityByName("queen_dodge"),
        nPriority = 0,
        nOrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
        fRequirments = function(hAbility)
            return self:IsAbilityReady(hAbility) 
        end,
    })
    self:RegisterAbility({
        hAbility = self.hUnit:FindAbilityByName("queen_wave"),
        nPriority = 1,
        nOrderType = DOTA_UNIT_ORDER_CAST_POSITION,
        fRequirments = function(hAbility, hTarget)
            return (hTarget and self:IsAbilityReady(hAbility))
        end,
    })
    self:RegisterAbility({
        hAbility = self.hUnit:FindAbilityByName("queen_blink"),
        nPriority = 2,
        nOrderType = DOTA_UNIT_ORDER_CAST_POSITION,
        fRequirments = function(hAbility, hTarget)
            return (hTarget and self:IsAbilityReady(hAbility))
        end,
    })
    self:RegisterAbility({
        hAbility = self.hUnit:FindAbilityByName("queen_daggers"),
        nPriority = 3,
        nOrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
        fRequirments = function(hAbility)
            return self:IsAbilityReady(hAbility) 
        end,
    })
    self:RegisterAbility({
        hAbility = self.hUnit:FindAbilityByName("queen_scream"),
        nPriority = 4,
        nOrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
        fRequirments = function(hAbility)
            return self:IsAbilityReady(hAbility) 
        end,
    })
    self:RegisterAbility({
        hAbility = self.hUnit:FindAbilityByName("queen_attack"),
        nPriority = 5,
        nOrderType = DOTA_UNIT_ORDER_CAST_POSITION,
        fRequirments = function(hAbility, hTarget)
            return (hTarget and self:IsAbilityReady(hAbility))
        end,
    })
end
