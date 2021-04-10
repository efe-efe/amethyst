Boss = Boss or class({}, nil, UnitEntity)
Centaur = Centaur or class({}, nil, Boss)

local BossState = {
    IDLE = 0,
}

function Boss:constructor(vOrigin, sUnitName)
    getbase(Boss).constructor(self, vOrigin, sUnitName, DOTA_TEAM_CUSTOM_1)
    self.state = BossState.IDLE
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
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false
	)

    if #units >= 0 then
        return units[1]
    else
        return nil
    end
end

function Boss:OnDeath(params)
    self:Destroy()
end

function Boss:Update()
end

function Centaur:constructor(vOrigin, sUnitName)    
    getbase(Centaur).constructor(self, vOrigin, sUnitName)
    self.unit = self:GetUnit()
    self.short_attack = self.unit:FindAbilityByName("centaur_short_attack")
    self.charge = self.unit:FindAbilityByName("centaur_charge")
end

function Centaur:Update()
    if self.state == BossState.IDLE then
        local hTarget = self:FindEnemy(2000)
        if hTarget then
            print('There is a target!')
            if not CustomEntities:IsDisplacing(self.unit) and not self.unit:HasModifier("modifier_casting") then
                print('\tNot displacing and not casting !')
                if CustomEntities:GetDistance(self.unit, hTarget) <= self.short_attack:GetSpecialValueFor("radius") and self.short_attack:IsCooldownReady() then
                    print('\t\tshort_attack redy!')
                    --self.unit:CastAbilityNoTarget(self.short_attack, 0)
                    ExecuteOrderFromTable({
                        OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
                        UnitIndex = self.unit:GetEntityIndex(),
                        AbilityIndex = self.short_attack:GetEntityIndex(),
                    })
                elseif self.charge:IsCooldownReady() then
                    print('\t\tcharge redy!')
                    ExecuteOrderFromTable({
                        OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                        UnitIndex = self.unit:GetEntityIndex(),
                        AbilityIndex = self.charge:GetEntityIndex(),
                        Position = hTarget:GetAbsOrigin()
                    })
                end
            end
        end
    end
end