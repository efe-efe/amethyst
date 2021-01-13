PROJECTILES_THINK = 0.01

PROJECTILES_NOTHING = 0
PROJECTILES_DESTROY = 1
PROJECTILES_BOUNCE = 2
PROJECTILES_FOLLOW = 3
SPEED_FACTOR = 1.0

if Projectiles == nil then
    print ('[PROJECTILES] creating Projectiles')
    Projectiles = {}
end

function Projectiles:Initialize()
    Projectiles = self
    self.timers = {}

    GameRules.GameMode:RegisterThinker(PROJECTILES_THINK, function()
        self:OnThink()
    end)
end

function Projectiles:OnThink()
    local now = Time()

    if Projectiles.previous == nil then
        Projectiles.previous = now
    end

    local dt = now - Projectiles.previous
    Projectiles.previous = now

    if dt > 0 then
        for _,timer in pairs(Projectiles.timers) do
            local status, nextCall = pcall(timer.callback, Projectiles, timer)

            if status then
                if nextCall then
                    timer.end_time = nextCall
                else
                    Projectiles.timers[_] = nil
                end
            else
                Projectiles.timers[_] = nil
                print('[PROJECTILES] Timer error:' .. nextCall)
            end
        end  
    end

    return PROJECTILES_THINK
end

function Projectiles:CreateTimer(index, args)
    Projectiles.timers[index] = args
end

function Projectiles:RemoveTimer(index)
    Projectiles.timers[index] = nil
end

function Projectiles:CalcSlope(pos, unit, dir)
    local m_dir = Vector(dir.x, dir.y, 0):Normalized()
    local f = GetGroundPosition(pos + m_dir, unit)
    local b = GetGroundPosition(pos - m_dir, unit)

    return (f - b):Normalized() 
end

function Projectiles:CalcNormal(pos, unit, scale)
    local m_scale = scale or 1
    local nscale = -1 * m_scale
    local zl = GetGroundPosition(pos + Vector(nscale,0,0), unit).z
    local zr = GetGroundPosition(pos + Vector(scale,0,0), unit).z
    local zu = GetGroundPosition(pos + Vector(0,scale,0), unit).z
    local zd = GetGroundPosition(pos + Vector(0,nscale,0), unit).z
    return Vector(zl - zr, zd - zu, 2 * m_scale):Normalized()
end

function Projectiles:CreateProjectile(projectile)
    local Projectiles = self 
    Projectiles:SetValues(projectile);
    Projectiles:CreateParticle(projectile);

    if projectile.GroundBehavior == PROJECTILES_FOLLOW then
        local future = projectile.current_position + projectile.current_velocity
        local ground = GetGroundPosition(projectile.current_position, projectile.Source) + Vector(0,0,projectile.fGroundOffset)
        
        if ground.z > future.z then
            local slope = Projectiles:CalcSlope(ground, projectile.Source, projectile.current_velocity)
            ParticleManager:SetParticleControl(projectile.id, projectile.iVelocityCP, projectile.current_velocity:Length() * slope * 30)
        else
            ParticleManager:SetParticleControl(projectile.id, projectile.iVelocityCP, projectile.current_velocity * 30)
        end
    else
        ParticleManager:SetParticleControl(projectile.id, projectile.iVelocityCP, projectile.current_velocity * 30)
    end

    function projectile:SetVelocity(newVel, newPos)
        if projectile.changes > 0 then
            projectile.changes = projectile.changes - 1
            projectile.current_velocity = newVel / 30
            projectile.changeTime = GameRules:GetGameTime() + projectile.fChangeDelay

            if projectile.bRecreateOnChange then
                ParticleManager:DestroyParticle(projectile.id, projectile.bDestroyImmediate)
                Projectiles:CreateParticle(projectile, newPos or projectile.current_position)
            end
            
            ParticleManager:SetParticleControl(projectile.id, projectile.iVelocityCP, newVel)
        end
    end

    function projectile:SetSource(source)
        projectile.Source = source
    end

    function projectile:SetVisionTeam(team)
        projectile.iVisionTeamNumber = team
    end

    function projectile:ResetDistanceTraveled()
        projectile.distanceTraveled = 0
    end

    function projectile:ResetRehit()
        projectile.rehit = {}
    end

    function projectile:Destroy(bImmediate)
        ParticleManager:DestroyParticle(projectile.id, projectile.bDestroyImmediate)
        
        if not bImmediate then
            if projectile.OnFinish then
                local status, out = pcall(projectile.OnFinish, projectile, projectile.current_position)
                if not status then
                    print('[PROJECTILES] Projectile OnFinish Failure!: ' .. out)
                end
            end
        end

        Projectiles:RemoveTimer(projectile.index)
    end

    projectile.index = DoUniqueString('proj')

    Projectiles:CreateTimer(projectile.index, {
        end_time = GameRules:GetGameTime(),
        use_game_time = true,
        callback = function()
            local current_time = GameRules:GetGameTime()
            local current_position = projectile.current_position

            if projectile.OnThinkBegin then
                pcall(projectile.OnThinkBegin, projectile, current_position)
            end

            -- Refresh position
            if projectile.bGroundLock then  -- Stick to the ground
                current_position.z = GetGroundPosition(current_position, projectile.Source).z + projectile.fGroundOffset
            end

            -- Follow
            if projectile.FollowTarget then
                projectile:SetVelocity((projectile.FollowTarget:GetAbsOrigin() - projectile.current_position):Normalized() * 1000)
            end
            
            -- Checks expiration
            if current_time > projectile.spawnTime + projectile.fExpireTime or projectile.distanceTraveled > projectile.fDistance then
                projectile:Destroy(false)
                return
            end
            
            -- Update values
            local radius = projectile.radius
            local radiusSq = radius * radius
            local current_velocity = projectile.current_velocity

            -- Frame and sub-frame collision checks
            local subpos = current_position
            local velLength = current_velocity:Length()
            local tot = math.max(1, math.ceil(velLength / 32)) -- lookahead number
            local div = 1 / tot

            -- unit detection prep
            local framehalf = current_position + (current_velocity * div * (tot-1))/2
            local framerad = (framehalf - current_position):Length() + radius

            -- Unit detection
            local entities = nil

            if projectile.bZCheck then
                entities = Entities:FindAllInSphere(framehalf, framerad)
            else
                entities = FindUnitsInRadius(
                    DOTA_TEAM_NOTEAM, 
                    framehalf, 
                    nil, 
                    framerad, 
                    DOTA_UNIT_TARGET_TEAM_BOTH, 
                    DOTA_UNIT_TARGET_ALL, 
                    projectile.iFlagFilter,
                    FIND_ANY_ORDER, 
                    false
                )
            end

            for index = 1, tot do
                for _,entity in pairs(entities) do
                    local zOffset = entity.zOffset or 0
                    local height = (entity.height or 150) + zOffset

                    local origin = entity:GetAbsOrigin()
                    local nozorg = Vector(origin.x, origin.y, 0)
                    local nozpos = Vector(subpos.x, subpos.y, 0)
                    local nozCheck = VectorDistanceSq(nozpos, nozorg) <= radiusSq

                    local zCheck = true
                    if projectile.bZCheck then
                        zCheck = subpos.z >= origin.z + zOffset and subpos.z <= origin.z + height
                    end

                    -- ON HIT AN ENTITY
                    if IsValidEntity(entity) and 
                        entity.GetUnitName and 
                        entity:IsAlive() and 
                        (not    projectile.bIgnoreSource or 
                                (projectile.bIgnoreSource and entity ~= projectile.Source)
                       ) --[[and 
                        nozCheck]] and 
                        zCheck 
                    then
                        --VectorDistanceSq(nozpos, origin) <= radiusSq and subpos.z >= orgz + zOffset and subpos.z <= orgz + height then
                        local time = projectile.rehit[entity:entindex()]
                        
                        if time == nil or current_time > time then
                            local status, test = pcall(projectile.UnitTest, projectile, entity)

                            if not status then
                                print('[PROJECTILES] Projectile UnitTest Failure!: ' .. test)
                            elseif test then
                                if CustomEntities:IsWall(entity) then
                                    if CustomEntities:Allies(projectile.Source, entity) then
                                        return
                                    elseif projectile.WallBehavior == PROJECTILES_DESTROY then
                                        projectile:Destroy(false)
                                        return
                                    end
                                end
                             
                                if projectile.bMultipleHits then
                                    projectile.rehit[entity:entindex()] = current_time + projectile.fRehitDelay
                                else
                                    projectile.rehit[entity:entindex()] = current_time + 10000
                                end
                                    
                                local continue = true
                                
                                for _,modifier_name in pairs(CustomEntities:GetOnProjectileHit(entity)) do
                                    local modifier_handle = entity:FindModifierByName(modifier_name)
                                    
                                    if not modifier_handle:OnProjectileHitCustom({ projectile = projectile, target = entity }) then
                                        continue = false
                                    end
                                end

                                if continue then
                                    local status, action = pcall(projectile.OnUnitHit, projectile, entity)
                                    if not status then
                                        print('[PROJECTILES] Projectile OnUnitHit Failure!: ' .. action)
                                    end

                                    if projectile.UnitBehavior == PROJECTILES_DESTROY then
                                        projectile:Destroy(false)
                                        return
                                    end
                                end
                            end
                        end
                    end
                end

                -- ON HIT AN TREE
                local navConnect = not GridNav:IsTraversable(subpos) or GridNav:IsBlocked(subpos) -- GNV connect
                local ground = GetGroundPosition(subpos, projectile.Source) + Vector(0,0,projectile.fGroundOffset)
                --print(tostring(ground.z) .. ' -- ' .. tostring(current_position.z))
                local groundConnect = ground.z > projectile.prevPos.z -- ground

                if navConnect then
                    if projectile.bCutTrees or projectile.TreeBehavior ~= PROJECTILES_NOTHING then
                        local trees = GridNav:GetAllTreesAroundPoint(subpos, projectile.radius, projectile.bTreeFullCollision)
                        for _,tree in pairs(trees) do
                            if not projectile.bZCheck or (current_position.z < ground.z + 280 + radius - projectile.fGroundOffset and current_position.z + radius + projectile.fGroundOffset > ground.z) then
                                if projectile.bCutTrees then
                                    tree:CutDown(projectile.Source:GetTeamNumber())
                                    navConnect = not GridNav:IsTraversable(subpos) or GridNav:IsBlocked(subpos)
                                end

                                if projectile.bCutTrees or projectile.TreeBehavior ~= PROJECTILES_NOTHING then
                                    local status, action = pcall(projectile.OnTreeHit, projectile, tree)
                                    if not status then
                                        print('[PROJECTILES] Projectile OnTreeHit Failure!: ' .. action)
                                    end
                                end

                                if projectile.TreeBehavior == PROJECTILES_DESTROY then
                                    projectile:Destroy(false)
                                    return
                                elseif projectile.TreeBehavior == PROJECTILES_BOUNCE and projectile.changes > 0 and current_time >= projectile.changeTime then
                                -- bounce calculation
                                end
                            end
                        end
                    end
                end

                -- ON HIT AN WALL
                if projectile.WallBehavior ~= PROJECTILES_NOTHING and groundConnect then--ground.z > projectile.prevPos.z then
                    local normal = Projectiles:CalcNormal(ground, projectile.Source, 32)
                    --DebugDrawLine_vCol(subpos, subpos + normal * 200, Vector(255,255,255), true, 1)

                    if normal.z < .8 then
                        local vec = Vector(GridNav:GridPosToWorldCenterX(GridNav:WorldToGridPosX(subpos.x)), GridNav:GridPosToWorldCenterY(GridNav:WorldToGridPosY(subpos.y)), ground.z)
                        local status, action = pcall(projectile.OnWallHit, projectile, vec)
                        if not status then
                            print('[PROJECTILES] Projectile OnWallHit Failure!: ' .. action)
                        end

                        if projectile.WallBehavior == PROJECTILES_DESTROY then
                            projectile:Destroy(false)
                            return
                        elseif projectile.WallBehavior == PROJECTILES_BOUNCE and projectile.changes > 0 and current_time >= projectile.changeTime then
                            --DebugDrawLine_vCol(subpos, subpos + normal * 200, Vector(255,255,255), true, 1)
                            normal.z = 0
                            normal = normal:Normalized()
                            --DebugDrawLine_vCol(subpos, subpos + normal * 200, Vector(0,255,0), true, 1)
                            projectile:SetVelocity(((-2 * current_velocity:Dot(normal) * normal) + current_velocity) * 30, subpos)
                            break
                        end
                    end 
                end

                -- ON HIT THE GROUND
                if projectile.GroundBehavior ~= PROJECTILES_NOTHING and groundConnect then
                    if projectile.GroundBehavior == PROJECTILES_DESTROY then
                        local status, action = pcall(projectile.OnGroundHit, projectile, ground)
                        if not status then
                            print('[PROJECTILES] Projectile OnGroundHit Failure!: ' .. action)
                        end
                        
                        projectile.Destroy(false)
                        return
                    elseif projectile.GroundBehavior == PROJECTILES_BOUNCE and projectile.changes > 0 and current_time >= projectile.changeTime then
                        local status, action = pcall(projectile.OnGroundHit, projectile, ground)
                        if not status then
                            print('[PROJECTILES] Projectile OnGroundHit Failure!: ' .. action)
                        end

                        local normal = Projectiles:CalcNormal(ground, projectile.Source)
                        projectile:SetVelocity(((-2 * current_velocity:Dot(normal) * normal) + current_velocity) * 30, subpos)
                        --entity:SetPhysicsVelocity(((-2 * newVelocity:Dot(normal) * normal) + newVelocity) * self.multiplier * 30)
                        break
                    elseif projectile.GroundBehavior == PROJECTILES_FOLLOW and projectile.changes > 0 and current_time >= projectile.changeTime then
                        -- follow calculation
                        
                        local slope = Projectiles:CalcSlope(ground, projectile.Source, current_velocity)
                        local dir = current_velocity:Normalized()
                        --projectile.fGroundOffset = projectile.fGroundOffset - 10
                        --print('follow ' .. slope:Dot(current_velocity:Normalized()) .. ' -- ' .. projectile.changes)
                        if dir.z < slope.z and slope:Dot(dir) < 1 then
                            local status, action = pcall(projectile.OnGroundHit, projectile, ground)
                            if not status then
                                print('[PROJECTILES] Projectile OnGroundHit Failure!: ' .. action)
                            end
                            --projectile.fGroundOffset = projectile.fGroundOffset - 10
                            --print('follow under')
                            projectile:SetVelocity(velLength * 30 * slope, subpos)
                        end
                        break
                    end
                end
                subpos = current_position + current_velocity * (div * index)

                if projectile.distanceTraveled + (subpos-current_position):Length() > projectile.fDistance then
                    projectile:Destroy(false)
                    return
                end

                if projectile.bGroundLock then
                    subpos.z = GetGroundPosition(subpos, projectile.Source).z + projectile.fGroundOffset
                end
            end

            if projectile.bProvidesVision then
                Projectiles:ProvideVision(projectile)
            end

            projectile.radius = radius + projectile.radiusStep
            projectile.prevPos = projectile.current_position
            projectile.distanceTraveled = projectile.distanceTraveled + velLength
            projectile.current_position = current_position + current_velocity

            -- Debug draw
            if projectile.draw then
                Projectiles:DebugDraw(projectile)
            end
            
            return current_time
        end
    })

    function projectile:GetCreationTime() return        projectile.spawnTime end
    function projectile:GetDistanceTraveled() return    projectile.distanceTraveled end
    function projectile:GetPosition() return            projectile.current_position end
    function projectile:GetVelocity() return            projectile.current_velocity * 30 end

    return projectile
end

-- Default Values
function Projectiles:SetValues(projectile)
    projectile.vVelocity = projectile.vVelocity * SPEED_FACTOR or Vector(0,0,0) * SPEED_FACTOR
    projectile.fDistance = projectile.fDistance or 1000
    projectile.FollowTarget = projectile.FollowTarget or nil

    if projectile.bIsSlowable == nil then projectile.bIsSlowable = true end
    if projectile.bIsReflectable == nil then projectile.bIsReflectable = true end
    if projectile.bIsReflectableByAllies == nil then projectile.bIsReflectableByAllies = true end
    if projectile.bIsDestructible == nil then projectile.bIsDestructible = true end
    
    projectile.iFlagFilter =        projectile.iFlagFilter or DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES 

    projectile.fStartRadius =       projectile.fStartRadius or 100
    projectile.fEndRadius =         projectile.fEndRadius or projectile.fStartRadius or  100

    projectile.iPositionCP =                    projectile.iPositionCP or 0
    projectile.iVelocityCP =                    projectile.iVelocityCP or 1
    projectile.ControlPoints =                  projectile.ControlPoints or {}
    projectile.ControlPointForwards =           projectile.ControlPointForwards or {}
    projectile.ControlPointOrientations =       projectile.ControlPointOrientations or {}
    projectile.ControlPointEntityAttaches =     projectile.ControlPointEntityAttaches or {}

    projectile.UnitBehavior = projectile.UnitBehavior or PROJECTILES_DESTROY
    projectile.TreeBehavior = projectile.TreeBehavior or PROJECTILES_DESTROY
    projectile.GroundBehavior = projectile.GroundBehavior or PROJECTILES_DESTROY
    projectile.WallBehavior = projectile.WallBehavior or PROJECTILES_DESTROY

    if projectile.bMultipleHits == nil then projectile.bMultipleHits = false end
    projectile.fRehitDelay = projectile.fRehitDelay or 1

    if projectile.bIgnoreSource == nil then projectile.bIgnoreSource = true end
    if projectile.bZCheck == nil then projectile.bZCheck = false end
    if projectile.bCutTrees == nil then projectile.bCutTrees = false end
    if projectile.bDestroyImmediate == nil then projectile.bDestroyImmediate = true end
    projectile.fExpireTime = projectile.fExpireTime or 8.0

    if projectile.bRecreateOnChange == nil then projectile.bRecreateOnChange = true end
    projectile.nChangeMax = projectile.nChangeMax or 1
    projectile.fChangeDelay = projectile.fChangeDelay or .1

    projectile.bGroundLock = projectile.bGroundLock or false
    projectile.fGroundOffset = projectile.fGroundOffset or 40

    projectile.UnitTest = projectile.UnitTest or function() return false end

    projectile.OnUnitHit = projectile.OnUnitHit or function() return end
    projectile.OnTreeHit = projectile.OnTreeHit or function() return end
    projectile.OnWallHit = projectile.OnWallHit or function() return end
    projectile.OnGroundHit = projectile.OnGroundHit or function() return end
    
    projectile.OnFinish = projectile.OnFinish or nil
    projectile.OnThinkBegin = projectile.OnThinkBegin or nil

    if projectile.bTreeFullCollision == nil then projectile.bTreeFullCollision = false end

    projectile.bProvidesVision = projectile.bProvidesVision or true
    if projectile.bFlyingVision == nil then projectile.bFlyingVision = false end
    projectile.iVisionRadius = projectile.iVisionRadius or 200
    projectile.iVisionTeamNumber = projectile.iVisionTeamNumber or projectile.Source:GetTeam()
    projectile.fVisionTickTime = projectile.fVisionTickTime or .1
    if projectile.fVisionTickTime <= 0 then
        projectile.fVisionTickTime = .1
    end
    projectile.fVisionLingerDuration = projectile.fVisionLingerDuration or 1
    if projectile.fVisionLingerDuration < projectile.fVisionTickTime then
        projectile.fVisionLingerDuration = projectile.fVisionTickTime
    end

    if projectile.vSpawnOrigin and projectile.vSpawnOrigin.unit then
        local attach = projectile.vSpawnOrigin.unit:ScriptLookupAttachment(projectile.vSpawnOrigin.attach)
        local attachPos = projectile.vSpawnOrigin.unit:GetAttachmentOrigin(attach)
        projectile.vSpawnOrigin = attachPos + (projectile.vSpawnOrigin.offset or Vector(0,0,0))
    else
        projectile.vSpawnOrigin = projectile.vSpawnOrigin or Vector(0,0,0)
    end

    projectile.rehit =              {}
    projectile.current_position =   projectile.vSpawnOrigin
    projectile.current_velocity =   projectile.vVelocity / 30
    projectile.prevVel =            projectile.current_velocity
    projectile.prevPos =            projectile.vSpawnOrigin
    projectile.radius =             projectile.fStartRadius
    projectile.changes =            projectile.nChangeMax
    projectile.spawnTime =          GameRules:GetGameTime()
    projectile.changeTime =         projectile.spawnTime
    projectile.distanceTraveled =   0
    projectile.visionTick =         math.ceil(projectile.fVisionTickTime * 30)
    projectile.currentFrame =       projectile.visionTick

    if projectile.fRadiusStep then
        projectile.radiusStep = projectile.fRadiusStep / 30
    else
        projectile.radiusStep = (projectile.fEndRadius - projectile.fStartRadius) / (projectile.fDistance / projectile.current_velocity:Length())
    end
end

function Projectiles:CreateParticle(projectile, position)
    --Set the ID based on the unique particle ID (They are unique)
    projectile.id = ParticleManager:CreateParticle(projectile.EffectName, PATTACH_CUSTOMORIGIN, nil)
    ParticleManager:SetParticleAlwaysSimulate(projectile.id)

    for k,v in pairs(projectile.ControlPoints) do
        ParticleManager:SetParticleControl(projectile.id, k, v)
    end

    for k,v in pairs(projectile.ControlPointForwards) do
        ParticleManager:SetParticleControlForward(projectile.id, k, v)
    end

    for k,v in pairs(projectile.ControlPointOrientations) do
        ParticleManager:SetParticleControlOrientation(projectile.id, k, v[1], v[2], v[3])
    end

    for k,v in pairs(projectile.ControlPointEntityAttaches) do
        local unit = v.unit or projectile.Source
        local pattach = v.pattach or PATTACH_CUSTOMORIGIN
        local attachPoint = v.attachPoint
        local origin
        if position ~= nil then
            origin = v.origin or position + projectile.current_velocity
        else
            origin = v.origin or projectile.vSpawnOrigin
        end
        ParticleManager:SetParticleControlEnt(projectile.id, k, unit, pattach, attachPoint, origin, true)
    end

    if position ~= nil then
        ParticleManager:SetParticleControl(projectile.id, projectile.iPositionCP, position + projectile.current_velocity)
    else
        ParticleManager:SetParticleControl(projectile.id, projectile.iPositionCP, projectile.vSpawnOrigin)
    end

    if projectile.ControlPointForwards[1] == nil and projectile.ControlPointOrientations[1] == nil then
        ParticleManager:SetParticleControlForward(projectile.id, projectile.iPositionCP, projectile.current_velocity:Normalized())
    end
end

function Projectiles:DebugDraw(projectile, color)
    local alpha = 1
    local color = color and color or Vector(200,0,0)
    local position = projectile.current_position
    local radius = projectile.radius
    
    if projectile.bZCheck then
        DebugDrawSphere(position, color, alpha, radius, true, .01)
    else
        DebugDrawCircle(position, Vector(255,0,0), 5, radius, false, 0.03)
    end
end

function Projectiles:ProvideVision(projectile)
    if projectile.currentFrame == projectile.visionTick then
        AddFOWViewer(projectile.iVisionTeamNumber, projectile.current_position, projectile.iVisionRadius, projectile.fVisionLingerDuration, not projectile.bFlyingVision)
        projectile.currentFrame = 0
    else
        projectile.currentFrame = projectile.currentFrame + 1
    end
end














ProjectilesManager = class({
    tProjectiles = {}
})

if ProjectilesManagerInstance == nil then
    ProjectilesManagerInstance = ProjectilesManager()
end

function ProjectilesManager:Initialize()
    GameRules.GameMode:RegisterThinker(PROJECTILES_THINK, function()
        self:Update()
    end)
end

function ProjectilesManager:Update()
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
end

function ProjectilesManager:RemoveProjectile(iProjectileID)
    for _,projectile in ipairs(self.tProjectiles) do
        if projectile:GetId() == iProjectileID then
            self.tProjectiles[_] = nil
        end
    end
end

function ProjectilesManager:CreateProjectile(tData)
    if not self.tProjectiles then
        self.tProjectiles = {}
    end

    local projectile = Projectile(tData)

    PrintTable(self.tProjectiles)
    table.insert(self.tProjectiles, projectile)
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
    OnThinkBegin =                  function() return end,
})

function Projectile:constructor(tData)
    if tData then
        self:SetDefaultVariables(tData)
    end
    self:InitializeValues()
    self.id = self:CreateParticle(nil)
    ParticleManager:SetParticleControl(self.id, self.iVelocityCP, self.vCurrentVelocity * 30)
    PrintTable(self)
end

function Projectile:SetVelocity(vNewVelocity, vNewPosition)
    if self.iChanges > 0 then
        self.iChanges = self.iChanges - 1
        self.vCurrentVelocity = vNewVelocity / 30
        self.fChangeTime = GameRules:GetGameTime() + self.fChangeDelay

        if self.bRecreateOnChange then
            ParticleManager:DestroyParticle(self.id, self.bDestroyImmediate)
            self:CreateParticle(vNewPosition or self.vCurrentPosition)
        end
        
        ParticleManager:SetParticleControl(self.id, self.iVelocityCP, vNewVelocity)
    end
end
    
function Projectile:SetSource(source)
    self.Source = source
end

function Projectile:SetVisionTeam(team)
    self.iVisionTeamNumber = team
end

function Projectile:ResetDistanceTraveled()
    self.fDistanceTraveled = 0
end

function Projectile:ResetRehit()
    self.tHitLog = {}
end

function Projectile:Update()
    local fCurrentTime = GameRules:GetGameTime()
    local vCurrentPosition = self.vCurrentPosition

    if self.OnThinkBegin then
        pcall(self.OnThinkBegin, self, self.vCurrentPosition)
    end

    if self.bGroundLock then  -- Stick to the ground
        vCurrentPosition.z = GetGroundPosition(vCurrentPosition, self.Source).z + self.fGroundOffset
    end
    
    if self:ShouldDestroy(fCurrentTime) then
        self:Destroy(false)
        return
    end
    
    local radius = self.fRadius
    local radiusSq = radius * radius
    local vCurrentVelocity = self.vCurrentVelocity

    -- Frame and sub-frame collision checks
    local subpos = vCurrentPosition
    local fVelocityLength = self.vCurrentVelocity:Length()
    local tot = math.max(1, math.ceil(fVelocityLength / 32)) -- lookahead number
    local div = 1 / tot

    -- unit detection prep
    local framehalf = vCurrentPosition + (vCurrentVelocity * div * (tot-1))/2
    local framerad = (framehalf - vCurrentPosition):Length() + radius

    -- Unit detection
    local entities = nil

    if self.bZCheck then
        entities = Entities:FindAllInSphere(framehalf, framerad)
    else
        entities = FindUnitsInRadius(
            DOTA_TEAM_NOTEAM, 
            framehalf, 
            nil, 
            framerad, 
            DOTA_UNIT_TARGET_TEAM_BOTH, 
            DOTA_UNIT_TARGET_ALL, 
            self.iFlagFilter,
            FIND_ANY_ORDER, 
            false
        )
    end

    for index = 1, tot do
        for _,entity in pairs(entities) do
            local zOffset = entity.zOffset or 0
            local height = (entity.height or 150) + zOffset

            local origin = entity:GetAbsOrigin()
            local nozorg = Vector(origin.x, origin.y, 0)
            local nozpos = Vector(subpos.x, subpos.y, 0)
            local nozCheck = VectorDistanceSq(nozpos, nozorg) <= radiusSq

            local zCheck = true
            if self.bZCheck then
                zCheck = subpos.z >= origin.z + zOffset and subpos.z <= origin.z + height
            end

            -- ON HIT AN ENTITY
            if IsValidEntity(entity) and 
                entity.GetUnitName and 
                entity:IsAlive() and 
                (not    self.bIgnoreSource or 
                        (self.bIgnoreSource and entity ~= self.Source)
                ) --[[and 
                nozCheck]] and 
                zCheck 
            then
                --VectorDistanceSq(nozpos, origin) <= radiusSq and subpos.z >= orgz + zOffset and subpos.z <= orgz + height then
                local time = self.tHitLog[entity:entindex()]
                
                if time == nil or current_time > time then
                    local status, test = pcall(self.UnitTest, self, entity)

                    if not status then
                        print('[PROJECTILES] Projectile UnitTest Failure!: ' .. test)
                    elseif test then
                        if CustomEntities:IsWall(entity) then
                            if CustomEntities:Allies(self.Source, entity) then
                                return
                            elseif self.WallBehavior == PROJECTILES_DESTROY then
                                self:Destroy(false)
                                return
                            end
                        end
                        
                        if self.bMultipleHits then
                            self.tHitLog[entity:entindex()] = fCurrentTime + self.fRehitDelay
                        else
                            self.tHitLog[entity:entindex()] = fCurrentTime + 10000
                        end
                            
                        local continue = true
                        
                        for _,modifier_name in pairs(CustomEntities:GetOnProjectileHit(entity)) do
                            local modifier_handle = entity:FindModifierByName(modifier_name)
                            
                            if not modifier_handle:OnProjectileHitCustom({ projectile = self, target = entity }) then
                                continue = false
                            end
                        end

                        if continue then
                            local status, action = pcall(self.OnUnitHit, self, entity)
                            if not status then
                                print('[PROJECTILES] Projectile OnUnitHit Failure!: ' .. action)
                            end

                            if self.UnitBehavior == PROJECTILES_DESTROY then
                                self:Destroy(false)
                                return
                            end
                        end
                    end
                end
            end
        end

        -- ON HIT AN TREE
        local navConnect = not GridNav:IsTraversable(subpos) or GridNav:IsBlocked(subpos) -- GNV connect
        local ground = GetGroundPosition(subpos, self.Source) + Vector(0,0,self.fGroundOffset)
        --print(tostring(ground.z) .. ' -- ' .. tostring(vCurrentPosition.z))
        local groundConnect = ground.z > self.vPreviousPosition.z -- ground

        if navConnect then
            if self.bCutTrees or self.TreeBehavior ~= PROJECTILES_NOTHING then
                local trees = GridNav:GetAllTreesAroundPoint(subpos, self.fRadius, self.bTreeFullCollision)
                for _,tree in pairs(trees) do
                    if not self.bZCheck or (vCurrentPosition.z < ground.z + 280 + radius - self.fGroundOffset and vCurrentPosition.z + radius + self.fGroundOffset > ground.z) then
                        if self.bCutTrees then
                            tree:CutDown(self.Source:GetTeamNumber())
                            navConnect = not GridNav:IsTraversable(subpos) or GridNav:IsBlocked(subpos)
                        end

                        if self.bCutTrees or self.TreeBehavior ~= PROJECTILES_NOTHING then
                            local status, action = pcall(self.OnTreeHit, self, tree)
                            if not status then
                                print('[PROJECTILES] Projectile OnTreeHit Failure!: ' .. action)
                            end
                        end

                        if self.TreeBehavior == PROJECTILES_DESTROY then
                            self:Destroy(false)
                            return
                        elseif self.TreeBehavior == PROJECTILES_BOUNCE and self.iChanges > 0 and fCurrentTime >= self.fChangeTime then
                        -- bounce calculation
                        end
                    end
                end
            end
        end

        -- ON HIT AN WALL
        if self.WallBehavior ~= PROJECTILES_NOTHING and groundConnect then--ground.z > self.vPreviousPosition.z then
            local normal = Projectiles:CalcNormal(ground, self.Source, 32)
            --DebugDrawLine_vCol(subpos, subpos + normal * 200, Vector(255,255,255), true, 1)

            if normal.z < .8 then
                local vec = Vector(GridNav:GridPosToWorldCenterX(GridNav:WorldToGridPosX(subpos.x)), GridNav:GridPosToWorldCenterY(GridNav:WorldToGridPosY(subpos.y)), ground.z)
                local status, action = pcall(self.OnWallHit, self, vec)
                if not status then
                    print('[PROJECTILES] Projectile OnWallHit Failure!: ' .. action)
                end

                if self.WallBehavior == PROJECTILES_DESTROY then
                    self:Destroy(false)
                    return
                elseif self.WallBehavior == PROJECTILES_BOUNCE and self.iChanges > 0 and fCurrentTime >= self.fChangeTime then
                    --DebugDrawLine_vCol(subpos, subpos + normal * 200, Vector(255,255,255), true, 1)
                    normal.z = 0
                    normal = normal:Normalized()
                    --DebugDrawLine_vCol(subpos, subpos + normal * 200, Vector(0,255,0), true, 1)
                    self:SetVelocity(((-2 * vCurrentVelocity:Dot(normal) * normal) + vCurrentVelocity) * 30, subpos)
                    break
                end
            end 
        end

        -- ON HIT THE GROUND
        if self.GroundBehavior ~= PROJECTILES_NOTHING and groundConnect then
            if self.GroundBehavior == PROJECTILES_DESTROY then
                local status, action = pcall(self.OnGroundHit, self, ground)
                if not status then
                    print('[PROJECTILES] Projectile OnGroundHit Failure!: ' .. action)
                end
                
                self.Destroy(false)
                return
            elseif self.GroundBehavior == PROJECTILES_BOUNCE and self.iChanges > 0 and fCurrentTime >= self.fChangeTime then
                local status, action = pcall(self.OnGroundHit, self, ground)
                if not status then
                    print('[PROJECTILES] Projectile OnGroundHit Failure!: ' .. action)
                end

                local normal = Projectiles:CalcNormal(ground, self.Source)
                self:SetVelocity(((-2 * vCurrentVelocity:Dot(normal) * normal) + vCurrentVelocity) * 30, subpos)
                --entity:SetPhysicsVelocity(((-2 * newVelocity:Dot(normal) * normal) + newVelocity) * self.multiplier * 30)
                break
            elseif self.GroundBehavior == PROJECTILES_FOLLOW and self.iChanges > 0 and fCurrentTime >= self.fChangeTime then
                -- follow calculation
                
                local slope = Projectiles:CalcSlope(ground, self.Source, vCurrentVelocity)
                local dir = vCurrentVelocity:Normalized()
                --self.fGroundOffset = self.fGroundOffset - 10
                --print('follow ' .. slope:Dot(vCurrentVelocity:Normalized()) .. ' -- ' .. self.changes)
                if dir.z < slope.z and slope:Dot(dir) < 1 then
                    local status, action = pcall(self.OnGroundHit, self, ground)
                    if not status then
                        print('[PROJECTILES] Projectile OnGroundHit Failure!: ' .. action)
                    end
                    --self.fGroundOffset = self.fGroundOffset - 10
                    --print('follow under')
                    self:SetVelocity(fVelocityLength * 30 * slope, subpos)
                end
                break
            end
        end
        subpos = vCurrentPosition + vCurrentVelocity * (div * index)

        if self.fDistanceTraveled + (subpos-vCurrentPosition):Length() > self.fDistance then
            self:Destroy(false)
            return
        end

        if self.bGroundLock then
            subpos.z = GetGroundPosition(subpos, self.Source).z + self.fGroundOffset
        end
    end

    if self.bProvidesVision then
        self:ProvideVision(self)
    end

    self.fRadius = radius + self.fRadiusStep
    self.vPreviousPosition = self.vCurrentPosition
    self:UpdateTraveledDistance(fVelocityLength)
    self.vCurrentPosition = vCurrentPosition + vCurrentVelocity

    -- Debug draw
    if self.bDraw then
        Projectiles:DebugDraw(self)
    end
    





    return fCurrentTime
end

function Projectile:Destroy(bImmediate)
    ParticleManager:DestroyParticle(self.id, self.bDestroyImmediate)
    
    --[[if not bImmediate then
        if projectile.OnFinish then
            local status, out = pcall(projectile.OnFinish, projectile, projectile.vCurrentPosition)
            if not status then
                print('[PROJECTILES] Projectile OnFinish Failure!: ' .. out)
            end
        end
    end]]
end

function Projectile:GetPosition()
    return self.vCurrentPosition
end

function Projectile:GetVelocity() 
    return self.vCurrentVelocity * 30 
end

function Projectile:SetEndTime(fTime)
    self.fEndTime = fTime
end

function Projectile:ShouldDestroy(fCurrentTime)
    return self:HasTimeExpired(fCurrentTime) or self:HasDistanceExpired()
end

function Projectile:HasTimeExpired(fCurrentTime)
    return fCurrentTime > self.fSpawnTime + self.fExpireTime;
end

function Projectile:HasDistanceExpired()
    return self.fDistanceTraveled > self.fDistance;
end

function Projectile:SetDefaultVariables(tData)
    for key,value in pairs(tData) do
        if tData[key] then 
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

function Projectile:GetId()
    return self.id
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
    self.fEndTime =             GameRules:GetGameTime()
    self.tHitLog =              {}
    self.vCurrentPosition =     self.vSpawnOrigin
    self.vCurrentVelocity =     self.vVelocity / 30
    self.vPreviousVelocity =    self.vCurrentVelocity
    self.vPreviousPosition =    self.vSpawnOrigin
    self.iChanges =             self.iChangeMax
    self.fRadius =              self.fStartRadius
    self.fSpawnTime =           GameRules:GetGameTime()
    self.fChangeTime =          self.fSpawnTime
    self.fDistanceTraveled =    0
    self.fVisionTick =          math.ceil(self.fVisionTickTime * 30)
    self.fCurrentFrame =        self.fVisionTick

    if self.fRadiusStep then
        self.fRadiusStep = self.fRadiusStep / 30
    else
        self.fRadiusStep = (self.fEndRadius - self.fStartRadius) / (self.fDistance / self.vCurrentVelocity:Length())
    end
end