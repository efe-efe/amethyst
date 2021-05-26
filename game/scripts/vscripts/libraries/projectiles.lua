PROJECTILES_NOTHING = 0
PROJECTILES_DESTROY = 1
PROJECTILES_BOUNCE = 2
PROJECTILES_FOLLOW = 3
SPEED_FACTOR = 1.0
PROJECTILES_THINK = 0.01
PROJECTILES_VISUAL_OFFSET = 15

ProjectilesManager = class({
    tProjectiles = {}
})

function ProjectilesManager:constructor()
    self:Update()
end

function ProjectilesManager:Update()
    Timers:CreateTimer(PROJECTILES_THINK, function()
        local now = Time();

        if not self.fPrevious then
            self.fPrevious = now;
        end

        local dt = now - self.fPrevious
        self.fPrevious = now;

        if dt > 0 then
            for _,projectile in ipairs(self.tProjectiles) do
                local fNextCallTime = projectile:Update()
                if fNextCallTime then
                    projectile:SetEndTime(fNextCallTime)
                else
                    self:RemoveProjectile(projectile:GetId())
                end
            end
        end
        
        Timers:CreateTimer(PROJECTILES_THINK, function()
            self:Update()
        end)
    end)
end

function ProjectilesManager:RemoveProjectile(iProjectileID)
    for _,projectile in ipairs(self.tProjectiles) do
        if projectile:GetId() == iProjectileID then
            self.tProjectiles[_] = nil
            table.remove(self.tProjectiles, _)
        end
    end
end

function ProjectilesManager:CreateProjectile(tData)
    if not self.tProjectiles then
        self.tProjectiles = {}
    end

    local projectile = Projectile(tData)

    table.insert(self.tProjectiles, projectile)

    return projectile
end

if ProjectilesManagerInstance == nil then
    ProjectilesManagerInstance = ProjectilesManager()
end

Projectile = class({
    vVelocity =                     Vector(0,0,0) * SPEED_FACTOR,
    vSpawnOrigin =                  Vector(0,0,0),
    fDistance =                     1000.0,
    fStartRadius =                  100.0,
    fEndRadius =                    100.0,
    fRehitDelay =                   1.0,
    fExpireTime =                   8.0,
    fChangeDelay =                  0.1,
    fVisionTickTime =               0.1,
    fVisionLingerDuration =         1.0,
    fGroundOffset =                 40,
    nPeakHeight =                   -1,
    nSpeed =                        0,
    iFlagFilter =                   DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
    iChangeMax =                    1,
    iVisionRadius =                 200,
    iPositionCP =                   0,
    iVelocityCP =                   1,
    ControlPoints =                 {},
    ControlPointForwards =          {},
    ControlPointOrientations =      {},
    ControlPointEntityAttaches =    {},
    UnitBehavior =                  PROJECTILES_DESTROY,
    TreeBehavior =                  PROJECTILES_DESTROY,
    GroundBehavior =                PROJECTILES_DESTROY,
    WallBehavior =                  PROJECTILES_DESTROY,
    bMultipleHits =                 false,
    bIgnoreSource =                 true,
    bZCheck =                       false,
    bCutTrees =                     false,
    bDestroyImmediate =             true,
    bRecreateOnChange =             true,
    bGroundLock =                   false,
    bIsSlowable =                   true,
    bIsReflectable =                true,
    bIsReflectableByAllies =        false,
    bIsDestructible =               true,
    bTreeFullCollision =            false,
    bProvidesVision =               true,
    bFlyingVision =                 false,
    bDraw =                         false,
    UnitTest =                      function() return false end,
    OnUnitHit =                     function() return end,
    OnTreeHit =                     function() return end,
    OnWallHit =                     function() return end,
    OnGroundHit =                   function() return end,
    OnFinish =                      function() return end,
    OnIntervalThink =               function() return end,
})

function Projectile:constructor(tData)
    if tData then
        self:SetDefaultVariables(tData)
    end
    self:InitializeValues()
    self.id = self:CreateParticle(nil)
    self.iEfx = self.id
    ParticleManager:SetParticleControl(self.iEfx, self.iVelocityCP, self.vCurrentVelocity * PROJECTILES_VISUAL_OFFSET)
end

function Projectile:ResetDistanceTraveled()
    self.fDistanceTraveled = 0
end

function Projectile:ResetRehit()
    self.tHitLog = {}
end

function Projectile:Update()
    self.fCurrentTime = GameRules:GetGameTime()

    if self.OnIntervalThink then
        pcall(self.OnIntervalThink, self, self.vCurrentPosition)
    end

    if self.bGroundLock then
        self.vCurrentPosition.z = GetGroundPosition(self.vCurrentPosition, self.Source).z + self.fGroundOffset
    end
    
    if self:ShouldDestroy() then
        self:Destroy(false)
        return
    end
    
    local fVelocityLength =         self.vCurrentVelocity:Length()
    self.fRadiusSquare =            self.fRadius * self.fRadius
    self.fPseudoFrames =            math.max(1, math.ceil(fVelocityLength / 32)) --tot
    self.fFramesDivisor =           1 / self.fPseudoFrames; --div
    local fSomething =              (self.vCurrentVelocity * self.fFramesDivisor * (self.fPseudoFrames - 1))/2
    self.fFrameHalf =               self.vCurrentPosition + fSomething --frameHalf
    self.fFrameRadius =             (self.fFrameHalf - self.vCurrentPosition):Length() + self.fRadius --framerad
    self.vPseudoFramePosition =     self.vCurrentPosition
    self.tEntities =                self:FindEntities()

    for index = 1, self.fPseudoFrames do
        if not self:ProcessPseudoFrame(index) then return end
    end

    if self.bProvidesVision then
        self:ProvideVision(self)
    end

    self.fRadius = self.fRadius + self.fRadiusStep
    self.vPreviousPosition = self.vCurrentPosition
    self:UpdateTraveledDistance(fVelocityLength)
    self.vCurrentPosition = self.vCurrentPosition + self.vCurrentVelocity

    if self.bDraw then
        self:DebugDraw()
    end

    --[[
        local g = -9.8
        local AlturaInicial = 0
        local TiempoTotal = self.fDistance/self.nSpeed
        local TiempoDeSubida = TiempoTotal/2
        local VelocidadInicialZ = ((self.nPeakHeight - AlturaInicial) - (0.5 * g * (TiempoTotal * TiempoTotal)))/TiempoDeSubida
        local VelocidadActualZ = VelocidadInicialZ + (g * self:ElapsedTime())
        local VelocidadInicialXY = nSpeed               
        local VelocidadInicial = VelocidadInicialXY / math.cos(Angulo) = VelocidadInicialZ / math.sin(Angulo)
        local angle = math.atan(VelocidadInicialZ / VelocidadInicialXY)
        local VelocidadActualZ = VelocidadInicialZ + (g * TiempoTotal)
        local Velocidad = Vector(VelocidadActualZ)
        local weirdFormat = (self.vCurrentVelocity + Vector(0, 0, 1 * 30))
        self:SetVelocity(weirdFormat, nil, true)
        print(self.vCurrentVelocity.x, self.vCurrentVelocity.y, VelocidadActualZ, self:ElapsedTime(), TiempoTotal)
    ]]
    return self.fCurrentTime
end

function Projectile:DebugDraw()
    local alpha = 1
    local color = Vector(200,0,0)
    
    if self.bZCheck then
        DebugDrawSphere(self.vCurrentPosition, color, alpha, self.fRadius, true, .01)
    else
        DebugDrawCircle(self.vCurrentPosition, Vector(255,0,0), 5, self.fRadius, false, 0.03)
    end
end

function Projectile:ProcessPseudoFrame(iIndex)
    if not self:ProcessEntities()   then return false end
    if not self:ProcessTrees()      then return false end
    if not self:ProcessWalls()      then return false end
    if not self:ProcessGround()     then return false end

    self.vPseudoFramePosition =     self.vCurrentPosition + self.vCurrentVelocity * (self.fFramesDivisor * iIndex)
    self.vGroundPosition =          GetGroundPosition(self.vPseudoFramePosition, self.Source) + Vector(0, 0, self.fGroundOffset)
    self.bGroundConnect =           self.vGroundPosition.z > self.vPreviousPosition.z -- self.vGroundPosition

    if self.fDistanceTraveled + (self.vPseudoFramePosition - self.vCurrentPosition):Length() > self.fDistance then
        self:Destroy(false)
        return false
    end

    if self.bGroundLock then
        self.vPseudoFramePosition.z = GetGroundPosition(self.vPseudoFramePosition, self.Source).z + self.fGroundOffset
    end

    return true
end

function Projectile:ProcessEntities()
    for _,entity in pairs(self.tEntities) do
        if not self:ProcessEntity(entity) then return false end
    end

    return true
end

function Projectile:ProcessEntity(hEntity)
    local vOrigin = hEntity:GetAbsOrigin()
    local vOrigin2D = Vector(vOrigin.x, vOrigin.y, 0)
    local vPosition2D = Vector(self.vPseudoFramePosition.x, self.vPseudoFramePosition.y, 0)
    local bZCheck2D = VectorDistanceSq(vPosition2D, vOrigin2D) <= self.fRadiusSquare
    local fHeight = 150

    local zCheck = true
    if self.bZCheck then
        zCheck = self.vPseudoFramePosition.z >= vOrigin.z and self.vPseudoFramePosition.z <= vOrigin.z + fHeight
    end

    if self:TestEntity(hEntity, zCheck) then
        --VectorDistanceSq(vPosition2D, vOrigin) <= self.fRadiusSquare and self.vPseudoFramePosition.z >= orgz and self.vPseudoFramePosition.z <= orgz + height then
        local time = self.tHitLog[hEntity:entindex()]
        
        if time == nil or self.fCurrentTime > time then
            local status, test = pcall(self.UnitTest, self, hEntity)

            if not status then
                print('[PROJECTILES] Projectile UnitTest Failure!: ' .. test)
            elseif test then
                if CustomEntitiesLegacy:IsWall(hEntity) then
                    if CustomEntitiesLegacy:Allies(self.Source, hEntity) then
                        return true
                    elseif self.WallBehavior == PROJECTILES_DESTROY then
                        self:Destroy(false)
                        return false
                    end
                end
                
                if self.bMultipleHits then
                    self.tHitLog[hEntity:entindex()] = self.fCurrentTime + self.fRehitDelay
                else
                    self.tHitLog[hEntity:entindex()] = self.fCurrentTime + 10000
                end
                 --[[   
                local continue = true
                
                for _,modifier_name in pairs(CustomEntitiesLegacy:GetOnProjectileHit(hEntity)) do
                    local modifier_handle = hEntity:FindModifierByName(modifier_name)
                    
                    if not modifier_handle:OnProjectileHitCustom({ projectile = self, target = hEntity }) then
                        continue = false
                    end
                end

                if continue then]]
                    local status, action = pcall(self.OnUnitHit, self, hEntity)
                    if not status then
                        print('[PROJECTILES] Projectile OnUnitHit Failure!: ' .. action)
                    end

                    if not self.bIgnoreNextUnitBehavior then
                        if self.UnitBehavior == PROJECTILES_DESTROY then
                            self:Destroy(false)
                            return false
                        end
                    else
                        self.bIgnoreNextUnitBehavior = false
                    end
                --end
            end
        end
    end

    return true
end

function Projectile:IgnoreNextUnitBehavior()
    self.bIgnoreNextUnitBehavior = true
end

function Projectile:TestEntity(hEntity, bZCheck)
    local bSourceTest = true
    if self.bIgnoreSource then
        bSourceTest = hEntity ~= self.Source
    end

    return IsValidEntity(hEntity) and hEntity.GetUnitName and hEntity:IsAlive() and bSourceTest --[[and bZCheck2D]] and bZCheck 
end

function Projectile:ProcessTrees()
    local navConnect = not GridNav:IsTraversable(self.vPseudoFramePosition) or GridNav:IsBlocked(self.vPseudoFramePosition) -- GNV connect

    if navConnect then
        if self.bCutTrees or self.TreeBehavior ~= PROJECTILES_NOTHING then
            local trees = GridNav:GetAllTreesAroundPoint(self.vPseudoFramePosition, self.fRadius, self.bTreeFullCollision)
            for _,tree in pairs(trees) do
                if not self.bZCheck or (self.vCurrentPosition.z < self.vGroundPosition.z + 280 + self.fRadius - self.fGroundOffset and self.vCurrentPosition.z + self.fRadius + self.fGroundOffset > self.vGroundPosition.z) then
                    if self.bCutTrees then
                        tree:CutDown(self.Source:GetTeamNumber())
                        navConnect = not GridNav:IsTraversable(self.vPseudoFramePosition) or GridNav:IsBlocked(self.vPseudoFramePosition)
                    end

                    if self.bCutTrees or self.TreeBehavior ~= PROJECTILES_NOTHING then
                        local status, action = pcall(self.OnTreeHit, self, tree)
                        if not status then
                            print('[PROJECTILES] Projectile OnTreeHit Failure!: ' .. action)
                        end
                    end

                    if self.TreeBehavior == PROJECTILES_DESTROY then
                        self:Destroy(false)
                        return false
                    elseif self.TreeBehavior == PROJECTILES_BOUNCE and self.iChanges > 0 and self.fCurrentTime >= self.fChangeTime then
                    -- bounce calculation
                    end
                end
            end
        end
    end
    return true
end

function Projectile:ScheduleDestroy()
    self.bShouldDestroy = true
end

function Projectile:ProcessWalls()
    if self.WallBehavior ~= PROJECTILES_NOTHING and self.bGroundConnect then--self.vGroundPosition.z > self.vPreviousPosition.z then
        local normal = self:GetNormal(self.vGroundPosition, self.Source, 32)
        --DebugDrawLine_vCol(self.vPseudoFramePosition, self.vPseudoFramePosition + normal * 200, Vector(255,255,255), true, 1)

        if normal.z < .8 then
            local vec = Vector(GridNav:GridPosToWorldCenterX(GridNav:WorldToGridPosX(self.vPseudoFramePosition.x)), GridNav:GridPosToWorldCenterY(GridNav:WorldToGridPosY(self.vPseudoFramePosition.y)), self.vGroundPosition.z)
            local status, action = pcall(self.OnWallHit, self, vec)
            if not status then
                print('[PROJECTILES] Projectile OnWallHit Failure!: ' .. action)
            end

            if self.WallBehavior == PROJECTILES_DESTROY then
                self:Destroy(false)
                return false
            elseif self.WallBehavior == PROJECTILES_BOUNCE and self.iChanges > 0 and self.fCurrentTime >= self.fChangeTime then
                --DebugDrawLine_vCol(self.vPseudoFramePosition, self.vPseudoFramePosition + normal * 200, Vector(255,255,255), true, 1)
                normal.z = 0
                normal = normal:Normalized()
                --DebugDrawLine_vCol(self.vPseudoFramePosition, self.vPseudoFramePosition + normal * 200, Vector(0,255,0), true, 1)
                self:SetVelocity(((-2 * self.vCurrentVelocity:Dot(normal) * normal) + self.vCurrentVelocity) * PROJECTILES_VISUAL_OFFSET, self.vPseudoFramePosition)
                return true--break
            end
        end 
    end
    return true
end

function Projectile:GetNormal(vPosition, hEntity, fScale)
    local m_scale = fScale or 1
    local nscale = -1 * m_scale
    local zl = GetGroundPosition(vPosition + Vector(nscale,0,0), hEntity).z
    local zr = GetGroundPosition(vPosition + Vector(fScale,0,0), hEntity).z
    local zu = GetGroundPosition(vPosition + Vector(0,fScale,0), hEntity).z
    local zd = GetGroundPosition(vPosition + Vector(0,nscale,0), hEntity).z
    return Vector(zl - zr, zd - zu, 2 * m_scale):Normalized()
end

function Projectile:GetSlope(vPosition, hEntity, vDirection)
    local m_dir = Vector(vDirection.x, vDirection.y, 0):Normalized()
    local f = GetGroundPosition(vPosition + m_dir, hEntity)
    local b = GetGroundPosition(vPosition - m_dir, hEntity)

    return (f - b):Normalized() 
end

function Projectile:ProcessGround()
    if self.GroundBehavior ~= PROJECTILES_NOTHING and self.bGroundConnect then
        if self.GroundBehavior == PROJECTILES_DESTROY then
            local status, action = pcall(self.OnGroundHit, self, self.vGroundPosition)
            if not status then
                print('[PROJECTILES] Projectile OnGroundHit Failure!: ' .. action)
            end
            
            self:Destroy(false)
            return false
        elseif self.GroundBehavior == PROJECTILES_BOUNCE and self.iChanges > 0 and self.fCurrentTime >= self.fChangeTime then
            local status, action = pcall(self.OnGroundHit, self, self.vGroundPosition)
            if not status then
                print('[PROJECTILES] Projectile OnGroundHit Failure!: ' .. action)
            end

            local normal = self:GetNormal(self.vGroundPosition, self.Source)
            self:SetVelocity(((-2 * self.vCurrentVelocity:Dot(normal) * normal) + self.vCurrentVelocity) * PROJECTILES_VISUAL_OFFSET, self.vPseudoFramePosition)
            --entity:SetPhysicsVelocity(((-2 * newVelocity:Dot(normal) * normal) + newVelocity) * self.multiplier * PROJECTILES_VISUAL_OFFSET)
            return true--break
        elseif self.GroundBehavior == PROJECTILES_FOLLOW and self.iChanges > 0 and self.fCurrentTime >= self.fChangeTime then
            -- follow calculation
            
            local slope = self:GetSlope(self.vGroundPosition, self.Source, self.vCurrentVelocity)
            local dir = self.vCurrentVelocity:Normalized()
            --self.fGroundOffset = self.fGroundOffset - 10
            --print('follow ' .. slope:Dot(self.vCurrentVelocity:Normalized()) .. ' -- ' .. self.changes)
            if dir.z < slope.z and slope:Dot(dir) < 1 then
                local status, action = pcall(self.OnGroundHit, self, self.vGroundPosition)
                if not status then
                    print('[PROJECTILES] Projectile OnGroundHit Failure!: ' .. action)
                end
                --self.fGroundOffset = self.fGroundOffset - 10
                --print('follow under')
                self:SetVelocity(fVelocityLength * PROJECTILES_VISUAL_OFFSET * slope, self.vPseudoFramePosition)
            end
            return true--break
        end
    end

    return true
end

function Projectile:Destroy(bImmediate)
    ParticleManager:DestroyParticle(self.iEfx, self.bDestroyImmediate)
    
    if not bImmediate then
        if self.OnFinish then
            local status, out = pcall(self.OnFinish, self, self.vCurrentPosition)
            if not status then
                print('[PROJECTILES] Projectile OnFinish Failure!: ' .. out)
            end
        end
    end
end

function Projectile:FindEntities()
    if self.bZCheck then
        return Entities:FindAllInSphere(self.fFrameHalf, self.fFrameRadius)
    else
        return FindUnitsInRadius(
            DOTA_TEAM_NOTEAM, 
            self.fFrameHalf, 
            nil, 
            self.fFrameRadius, 
            DOTA_UNIT_TARGET_TEAM_BOTH, 
            DOTA_UNIT_TARGET_ALL, 
            self.iFlagFilter,
            FIND_ANY_ORDER, 
            false
        )
    end
end

function Projectile:ShouldDestroy()
    return self:HasTimeExpired(self.fCurrentTime) or self:HasDistanceExpired() or self.bShouldDestroy
end

function Projectile:ElapsedTime()
    return self.fCurrentTime - self.nInitialTime
end

function Projectile:HasTimeExpired()
    return self.fCurrentTime > self.fSpawnTime + self.fExpireTime;
end

function Projectile:HasDistanceExpired()
    return self.fDistanceTraveled > self.fDistance;
end

function Projectile:SetDefaultVariables(tData)
    for key,value in pairs(tData) do
        if tData[key] ~= nil then 
            if  key ~= 'vSpawnOrigin' and
                key ~= 'fVisionTickTime' and
                key ~= 'fVisionLingerDuration'
            then
                self[key] = value
            end
        end
    end

    if not tData.fVisionTickTime then
        self.fVisionTickTime = 0.1
    end
    
    if not tData.iVisionTeamNumber then
        self.iVisionTeamNumber = self.Source:GetTeam()
    end

    if tData.vSpawnOrigin then
        if tData.vSpawnOrigin.unit then
            local attach = tData.vSpawnOrigin.unit:ScriptLookupAttachment(tData.vSpawnOrigin.attach)
            local attachPos = tData.vSpawnOrigin.unit:GetAttachmentOrigin(attach)
            self.vSpawnOrigin = attachPos + (tData.vSpawnOrigin.offset or Vector(0,0,0))
        else
            self.vSpawnOrigin = tData.vSpawnOrigin
        end
    end

    if tData.fVisionTickTime then
        if tData.fVisionTickTime <= 0 then
            self.fVisionTickTime = 0.1
        else
            self.fVisionTickTime = tData.fVisionTickTime
        end
    end

    if tData.fVisionLingerDuration then
        if tData.fVisionLingerDuration < self.fVisionTickTime then
            self.fVisionLingerDuration = self.fVisionTickTime
        else
            self.fVisionLingerDuration = tData.fVisionLingerDuration
        end
    end
end

function Projectile:CreateParticle(vPosition)
    local efx = ParticleManager:CreateParticle(self.EffectName, PATTACH_CUSTOMORIGIN, nil)
    ParticleManager:SetParticleAlwaysSimulate(efx)

    for k,v in pairs(self.ControlPoints) do
        ParticleManager:SetParticleControl(efx, k, v)
    end

    for k,v in pairs(self.ControlPointForwards) do
        ParticleManager:SetParticleControlForward(efx, k, v)
    end

    for k,v in pairs(self.ControlPointOrientations) do
        ParticleManager:SetParticleControlOrientation(efx, k, v[1], v[2], v[3])
    end

    for k,v in pairs(self.ControlPointEntityAttaches) do
        local unit = v.unit or self.Source
        local pattach = v.pattach or PATTACH_CUSTOMORIGIN
        local attachPoint = v.attachPoint
        local origin
        if vPosition ~= nil then
            origin = v.origin or vPosition + self.vCurrentVelocity
        else
            origin = v.origin or self.vSpawnOrigin
        end
        ParticleManager:SetParticleControlEnt(efx, k, unit, pattach, attachPoint, origin, true)
    end

    if vPosition ~= nil then
        ParticleManager:SetParticleControl(efx, self.iPositionCP, vPosition + self.vCurrentVelocity)
    else
        ParticleManager:SetParticleControl(efx, self.iPositionCP, self.vSpawnOrigin)
    end

    if self.ControlPointForwards[1] == nil and self.ControlPointOrientations[1] == nil then
        ParticleManager:SetParticleControlForward(efx, self.iPositionCP, self.vCurrentVelocity:Normalized())
    end

    return efx
end

function Projectile:UpdateTraveledDistance(fVelocityLength)
    self.fDistanceTraveled = self.fDistanceTraveled + fVelocityLength
end

function Projectile:ProvideVision()
    if self.fCurrentFrame == self.fVisionTick then
        AddFOWViewer(self.iVisionTeamNumber, self.vCurrentPosition, self.iVisionRadius, self.fVisionLingerDuration, not self.bFlyingVision)
        self.fCurrentFrame = 0
    else
        self.fCurrentFrame = self.fCurrentFrame + 1
    end
end

function Projectile:InitializeValues()
    self.fEndTime =                 GameRules:GetGameTime()
    self.tHitLog =                  {}
    self.vCurrentPosition =         self.vSpawnOrigin
    self.vCurrentVelocity =         self.vVelocity / PROJECTILES_VISUAL_OFFSET
    self.vPreviousVelocity =        self.vCurrentVelocity
    self.vPreviousPosition =        self.vSpawnOrigin
    self.iChanges =                 self.iChangeMax
    self.iEfx =                     -1
    self.fRadius =                  self.fStartRadius
    self.fSpawnTime =               GameRules:GetGameTime()
    self.fChangeTime =              self.fSpawnTime
    self.fDistanceTraveled =        0
    self.fVisionTick =              math.ceil(self.fVisionTickTime * PROJECTILES_VISUAL_OFFSET)
    self.fCurrentFrame =            self.fVisionTick
    self.fPseudoFrames =            0.0
    self.fFramesDivisor =           0.0
    self.fFrameHalf =               0.0
    self.fFrameRadius =             0.0
    self.fRadiusSquare =            0.0
    self.vPseudoFramePosition =     Vector(0, 0, 0)
    self.vGroundPosition =          Vector(0, 0, 0)
    self.tEntities =                {}
    self.bGroundConnect =           false
    self.bShouldDestroy =           false
    self.nInitialTime =             GameRules:GetGameTime()

    if self.fRadiusStep then
        self.fRadiusStep = self.fRadiusStep / PROJECTILES_VISUAL_OFFSET
    else
        self.fRadiusStep = (self.fEndRadius - self.fStartRadius) / (self.fDistance / self.vCurrentVelocity:Length())
    end
end

function Projectile:SetEndTime(fTime)
    self.fEndTime = fTime
end

function Projectile:SetVelocity(vNewVelocity, vNewPosition, bIgnoreChanges)
    if self.iChanges > 0 or bIgnoreChanges then
        if not bIgnoreChanges then
            self.iChanges = self.iChanges - 1
            self.fChangeTime = GameRules:GetGameTime() + self.fChangeDelay
        end
        
        self.vCurrentVelocity = vNewVelocity / PROJECTILES_VISUAL_OFFSET

        if self.bRecreateOnChange then
            ParticleManager:DestroyParticle(self.iEfx, self.bDestroyImmediate)
            self.iEfx = self:CreateParticle(vNewPosition or self.vCurrentPosition)
        end
        
        ParticleManager:SetParticleControl(self.iEfx, self.iVelocityCP, vNewVelocity)
    end
end
    
function Projectile:SetPosition(vNewPosition)
    if self.bRecreateOnChange then
        ParticleManager:DestroyParticle(self.iEfx, self.bDestroyImmediate)
        self.iEfx = self:CreateParticle(vNewPosition)
    end
    
    ParticleManager:SetParticleControl(self.iEfx, self.iVelocityCP, self.vCurrentVelocity)
    self.vCurrentPosition = vNewPosition
end

function Projectile:SetSource(hSource)
    self.Source = hSource
end

function Projectile:SetVisionTeam(iTeam)
    self.iVisionTeamNumber = iTeam
end

function Projectile:GetId()
    return self.id
end

function Projectile:GetPosition()
    return self.vCurrentPosition
end

function Projectile:GetVelocity() 
    return self.vCurrentVelocity * PROJECTILES_VISUAL_OFFSET 
end