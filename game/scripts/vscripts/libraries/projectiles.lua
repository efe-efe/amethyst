PROJECTILES_VERSION = "1.00"

PROJECTILES_THINK = 0.01

-- Default constants
PROJECTILES_NOTHING = 0
PROJECTILES_DESTROY = 1
PROJECTILES_BOUNCE = 2
PROJECTILES_FOLLOW = 3

-- Initialize Projectiles Library
if Projectiles == nil then
    print ( '[PROJECTILES] creating Projectiles' )
    Projectiles = {}
    Projectiles.__index = Projectiles
end

-- Generate the thinkers
function Projectiles:start()
    Projectiles = self

    -- Set the think (refresh rate)
    if self.think_entity == nil then
        self.timers = {}
        self.think_entity = SpawnEntityFromTableSynchronous("info_target", {targetname="projectiles_lua_thinker"})
        self.think_entity:SetThink("Think", self, "projectiles", PROJECTILES_THINK)
    end
end

-- On think
function Projectiles:Think()
    if GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
        return
    end

    -- Track game time, since the dt passed in to think is actually wall-clock time not simulation time.
    local now = GameRules:GetGameTime()
    if Projectiles.t0 == nil then
        Projectiles.t0 = now
    end
    local dt = now - Projectiles.t0
    Projectiles.t0 = now

    if dt > 0 then
        -- Process timers
        for k,v in pairs(Projectiles.timers) do
        local bUseGameTime = true
        -- Check if the timer has finished
            
        -- Run the callback
        local status, nextCall = pcall(v.callback, Projectiles, v)

        -- Make sure it worked
        if status then
            -- Check if it needs to loop
            if nextCall then
            -- Change it's end time
            v.endTime = nextCall
            else
            Projectiles.timers[k] = nil
            end
        else
            Projectiles.timers[k] = nil
            print('[PROJECTILES] Timer error:' .. nextCall)
        end
        end  
    end

    return PROJECTILES_THINK
end

function Projectiles:CreateTimer(name, args)
    if not args.endTime or not args.callback then
        print("Invalid timer created: "..name)
        return
    end

    Projectiles.timers[name] = args
end

function Projectiles:RemoveTimer(name)
    Projectiles.timers[name] = nil
end

function Projectiles:CalcSlope(pos, unit, dir)

    dir = Vector(dir.x, dir.y, 0):Normalized()
    local f = GetGroundPosition(pos + dir, unit)
    local b = GetGroundPosition(pos - dir, unit)

    return (f - b):Normalized() 
end

function Projectiles:CalcNormal(pos, unit, scale)
    scale = scale or 1
    local nscale = -1 * scale
    local zl = GetGroundPosition(pos + Vector(nscale,0,0), unit).z
    local zr = GetGroundPosition(pos + Vector(scale,0,0), unit).z
    local zu = GetGroundPosition(pos + Vector(0,scale,0), unit).z
    local zd = GetGroundPosition(pos + Vector(0,nscale,0), unit).z
    return Vector(zl - zr, zd - zu, 2*scale):Normalized()
end

function Projectiles:CreateProjectile(projectile)
    local Projectiles = self 
    Projectiles:InitialSetup(projectile);   -- Set defaults and initial values
    Projectiles:CreateParticle(projectile); -- Create visuals

    if projectile.GroundBehavior == PROJECTILES_FOLLOW then
        local future = projectile.currentPosition + projectile.currentVelocity
        local ground = GetGroundPosition(projectile.currentPosition, projectile.Source) + Vector(0,0,projectile.fGroundOffset)
        if ground.z > future.z then
            local slope = Projectiles:CalcSlope(ground, projectile.Source, projectile.currentVelocity)
            ParticleManager:SetParticleControl(projectile.id, projectile.iVelocityCP, projectile.currentVelocity:Length() * slope * 30)
        else
            ParticleManager:SetParticleControl(projectile.id, projectile.iVelocityCP, projectile.currentVelocity * 30)
        end
    else
        ParticleManager:SetParticleControl(projectile.id, projectile.iVelocityCP, projectile.currentVelocity * 30)
    end

    -------------------------------
    -- Getters asingment
    -------------------------------
    function projectile:GetCreationTime() return        projectile.spawnTime end
    function projectile:GetDistanceTraveled() return    projectile.distanceTraveled end
    function projectile:GetPosition() return            projectile.currentPosition end
    function projectile:GetVelocity() return            projectile.currentVelocity * 30 end

    -------------------------------
    -- Exposed methods
    -------------------------------
    function projectile:SetVelocity(newVel, newPos)
        if projectile.changes > 0 then
            projectile.changes = projectile.changes - 1
            projectile.currentVelocity = newVel / 30
            projectile.changeTime = GameRules:GetGameTime() + projectile.fChangeDelay

            if projectile.bRecreateOnChange then
                ParticleManager:DestroyParticle(projectile.id, projectile.bDestroyImmediate)
                Projectiles:CreateParticle(projectile, newPos or projectile.currentPosition)
            end
            
            ParticleManager:SetParticleControl(projectile.id, projectile.iVelocityCP, newVel)
        end
    end

    function projectile:Destroy()
        ParticleManager:DestroyParticle(projectile.id, projectile.bDestroyImmediate)
        Projectiles:RemoveTimer(projectile.ProjectileTimerName)
    end

    -- Logic of what is done every tick
    projectile.ProjectileTimerName = DoUniqueString('proj')
    Projectiles:CreateTimer(projectile.ProjectileTimerName, {
        endTime = GameRules:GetGameTime(),
        useGameTime = true,
        callback = function()
            local curTime = GameRules:GetGameTime()

            -- Refresh position
            local currentPosition = projectile.currentPosition
            if projectile.bGroundLock then  -- Stick to the ground
                currentPosition.z = GetGroundPosition(currentPosition, projectile.Source).z + projectile.fGroundOffset
            end
            
            -- Checks expiration
            if curTime > projectile.spawnTime + projectile.fExpireTime or projectile.distanceTraveled > projectile.fDistance then
                --ParticleManager:DestroyParticle(projectile.id, projectile.bDestroyImmediate)
                if projectile.OnFinish then
                    local status, out = pcall(projectile.OnFinish, projectile, currentPosition)
                    if not status then
                        print('[PROJECTILES] Collision UnitTest Failure!: ' .. out)
                    end
                end
                return
            end
            
            -- Update values
            local radius = projectile.radius
            local radiusSq = radius * radius
            local currentVelocity = projectile.currentVelocity
            
            -- Debug draw
            if projectile.draw then
                Projectiles:DebugDraw(projectile, currentPosition, radius)
            end

            -- Frame and sub-frame collision checks
            local subpos = currentPosition
            local velLength = currentVelocity:Length()
            local tot = math.max(1, math.ceil(velLength / 32)) -- lookahead number
            local div = 1 / tot

            -- unit detection prep
            local framehalf = currentPosition + (currentVelocity * div * (tot-1))/2
            local framerad = (framehalf - currentPosition):Length() + radius

            -- Unit detection
            local ents = nil
            if projectile.filter then
                if type(projectile.filter) == "table" then
                    ents = projectile.filter
                else
                    local status = nil
                    status, ents = pcall(projectile.filter, projectile)
                    if not status then
                        print('[PROJECTILES] Projectile Filter Failure!: ' .. ents)
                    end
                end
            else
                if projectile.bUseFindUnitsInRadius ~= nil then
                    if projectile.bUseFindUnitsInRadius then
                        ents = FindUnitsInRadius(0, framehalf, nil, framerad, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, 0, 0, false)
                    else
                        ents = Entities:FindAllInSphere(framehalf, framerad)
                    end
                    else
                    if projectile.bZCheck then
                        ents = Entities:FindAllInSphere(framehalf, framerad)
                    else
                        ents = FindUnitsInRadius(0, framehalf, nil, framerad, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
                    end
                end
            end

            for index=1,tot do
                -- unit check
                for i=1,#ents do
                    local entity = ents[i]

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
                    if  IsValidEntity(entity) and 
                        entity.GetUnitName and 
                        entity:IsAlive() and 
                        (not projectile.bIgnoreSource or 
                            (projectile.bIgnoreSource and 
                                entity ~= projectile.Source
                            )
                        ) --[[and 
                        nozCheck]] and 
                        zCheck 
                    then
                        
                        --VectorDistanceSq(nozpos, origin) <= radiusSq and subpos.z >= orgz + zOffset and subpos.z <= orgz + height then
                        local time = projectile.rehit[entity:entindex()]
                        
                        if time==nil or curTime > time then
                            local status, test = pcall(projectile.UnitTest, projectile, entity)

                            if not status then
                                print('[PROJECTILES] Projectile UnitTest Failure!: ' .. test)
                            elseif test then

                                -- If hits a slower or bouncer unit
                                local is_slower = entity:FindModifierByName("modifier_generic_projectile_slower_lua")
                                local is_reflector = entity:FindModifierByName("modifier_generic_projectile_reflector_lua")
                                local is_enemy_blocker = entity:FindModifierByName("modifier_generic_projectile_enemy_blocker_lua")

                                if is_slower ~= nil then
                                    if not is_slower:IsNull() then
                                        if projectile.bIsSlowable == true then
                                            local slow_percent = entity:GetAttackAnimationPoint()
                                            projectile:SetVelocity(projectile.vVelocity * (1 - slow_percent))
                                        end
                                    end
                                elseif is_reflector ~= nil then
                                    if not is_reflector:IsNull() then
                                        if projectile.bIsReflectable == true then

                                            local reflectedProjectile = projectile;

                                            reflectedProjectile.vSpawnOrigin = projectile.currentPosition;
                                            reflectedProjectile.Source = entity;
                                            reflectedProjectile.bIgnoreSource = true;
                                            reflectedProjectile.nChangeMax = projectile.nChangeMax - 1;
                                            reflectedProjectile.iVisionTeamNumber = entity:GetTeam();
                                            reflectedProjectile.vVelocity = -projectile.currentVelocity * 30,
                                            
                                            projectile:Destroy();
                                            
                                            -- Deal damage to activate counters
                                            local damage = {
                                                victim = entity,
                                                attacker = projectile.Source,
                                                damage = 1,
                                                damage_type = DAMAGE_TYPE_MAGICAL,
                                            }
                                            ApplyDamage( damage )

                                            Projectiles:CreateProjectile( reflectedProjectile )
                                            return
                                        end
                                    end
                                elseif is_enemy_blocker ~= nil then
                                    if not is_enemy_blocker:IsNull() then
                                        if projectile.Source:GetTeamNumber() ~= entity:GetTeamNumber() then
                                            ParticleManager:DestroyParticle(projectile.id, projectile.bDestroyImmediate)
                                            if projectile.OnFinish then
                                                local status, out = pcall(projectile.OnFinish, projectile, subpos)
                                                if not status then
                                                    print('[PROJECTILES] Projectile OnFinish Failure!: ' .. out)
                                                end
                                            end
                                            return
                                        end
                                    end
                                else

                                    --MOVED HERE
                                    if projectile.bMultipleHits then
                                        projectile.rehit[entity:entindex()] = curTime + projectile.fRehitDelay
                                    else
                                        projectile.rehit[entity:entindex()] = curTime + 10000
                                    end

                                    local status, action = pcall(projectile.OnUnitHit, projectile, entity)
                                    if not status then
                                        print('[PROJECTILES] Projectile OnUnitHit Failure!: ' .. action)
                                    end

                                    if projectile.UnitBehavior == PROJECTILES_DESTROY then
                                        ParticleManager:DestroyParticle(projectile.id, projectile.bDestroyImmediate)
                                        if projectile.OnFinish then
                                            local status, out = pcall(projectile.OnFinish, projectile, subpos)
                                            if not status then
                                                print('[PROJECTILES] Projectile OnFinish Failure!: ' .. out)
                                            end
                                        end
                                        return
                                    elseif projectile.UnitBehavior == PROJECTILES_BOUNCE then
                                    -- bounce math
                                    end

                                    --[[
                                    if projectile.bMultipleHits then
                                        projectile.rehit[entity:entindex()] = curTime + projectile.fRehitDelay
                                    else
                                        projectile.rehit[entity:entindex()] = curTime + 10000
                                    end
                                    ]]
                                end
                            end
                        end
                    end
                end

                -- ON HIT AN TREE
                local navConnect = not GridNav:IsTraversable(subpos) or GridNav:IsBlocked(subpos) -- GNV connect
                local ground = GetGroundPosition(subpos, projectile.Source) + Vector(0,0,projectile.fGroundOffset)
                --print(tostring(ground.z) .. ' -- ' .. tostring(currentPosition.z))
                local groundConnect = ground.z > projectile.prevPos.z -- ground

                if navConnect then
                    if projectile.bCutTrees or projectile.TreeBehavior ~= PROJECTILES_NOTHING then
                        local ents = GridNav:GetAllTreesAroundPoint(subpos, projectile.radius, projectile.bTreeFullCollision)
                        --print('tree hit')
                        --local vec = Vector(GridNav:GridPosToWorldCenterX(GridNav:WorldToGridPosX(subpos.x)), GridNav:GridPosToWorldCenterY(GridNav:WorldToGridPosY(subpos.y)), ground.z - projectile.fGroundOffset)
                        --DebugDrawCircle(vec, Vector(200,200,200), 100, 10, true, .5)
                        --local ents = Entities:FindAllByClassnameWithin("ent_dota_tree", vec, 70)
                        
                        for i=1,#ents do
                        local tree = ents[i]
                        if not projectile.bZCheck or (currentPosition.z < ground.z + 280 + radius - projectile.fGroundOffset and currentPosition.z + radius + projectile.fGroundOffset > ground.z) then
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
                            ParticleManager:DestroyParticle(projectile.id, projectile.bDestroyImmediate)
                            if projectile.OnFinish then
                                local status, out = pcall(projectile.OnFinish, projectile, subpos)
                                if not status then
                                print('[PROJECTILES] Projectile OnFinish Failure!: ' .. out)
                                end
                            end
                            return
                            elseif projectile.TreeBehavior == PROJECTILES_BOUNCE and projectile.changes > 0 and curTime >= projectile.changeTime then
                            -- bounce calculation
                            end
                        end
                        end
                    end
                end

                -- ON HIT AN WALL
                if projectile.WallBehavior ~= PROJECTILES_NOTHING and groundConnect then--ground.z > projectile.prevPos.z then
                    local normal = Projectiles:CalcNormal(ground, projectile.Source, 32)
                    --print(normal)
                    if normal.z < .6 then
                        local vec = Vector(GridNav:GridPosToWorldCenterX(GridNav:WorldToGridPosX(subpos.x)), GridNav:GridPosToWorldCenterY(GridNav:WorldToGridPosY(subpos.y)), ground.z)
                        local status, action = pcall(projectile.OnWallHit, projectile, vec)
                        if not status then
                        print('[PROJECTILES] Projectile OnWallHit Failure!: ' .. action)
                        end

                        if projectile.WallBehavior == PROJECTILES_DESTROY then
                        ParticleManager:DestroyParticle(projectile.id, projectile.bDestroyImmediate)
                        if projectile.OnFinish then
                            local status, out = pcall(projectile.OnFinish, projectile, subpos)
                            if not status then
                            print('[PROJECTILES] Projectile OnFinish Failure!: ' .. out)
                            end
                        end
                        return
                        elseif projectile.WallBehavior == PROJECTILES_BOUNCE and projectile.changes > 0 and curTime >= projectile.changeTime then
                            -- bounce calculation
                            --local normal = Projectiles:CalcNormal(ground, projectile.Source)
                            --DebugDrawLine_vCol(subpos, subpos + normal * 200, Vector(255,255,255), true, 1)
                            -- remove z
                            normal.z = 0
                            normal = normal:Normalized()
                            --DebugDrawLine_vCol(subpos, subpos + normal * 200, Vector(0,255,0), true, 1)
                            projectile:SetVelocity(((-2 * currentVelocity:Dot(normal) * normal) + currentVelocity) * 30, subpos)
                            break
                        end
                    end 
                end

                -- ON HIT THE GROUND
                if projectile.GroundBehavior ~= PROJECTILES_NOTHING and groundConnect then
                    --print('groundConnect')
                    if projectile.GroundBehavior == PROJECTILES_DESTROY then
                        ParticleManager:DestroyParticle(projectile.id, projectile.bDestroyImmediate)
                        local status, action = pcall(projectile.OnGroundHit, projectile, ground)
                        if not status then
                            print('[PROJECTILES] Projectile OnGroundHit Failure!: ' .. action)
                        end

                        if projectile.OnFinish then
                            local status, out = pcall(projectile.OnFinish, projectile, subpos)
                            if not status then
                            print('[PROJECTILES] Projectile OnFinish Failure!: ' .. out)
                            end
                        end
                        return
                    elseif projectile.GroundBehavior == PROJECTILES_BOUNCE and projectile.changes > 0 and curTime >= projectile.changeTime then
                        -- bounce calculation
                        local status, action = pcall(projectile.OnGroundHit, projectile, ground)
                        if not status then
                            print('[PROJECTILES] Projectile OnGroundHit Failure!: ' .. action)
                        end

                        local normal = Projectiles:CalcNormal(ground, projectile.Source)
                        projectile:SetVelocity(((-2 * currentVelocity:Dot(normal) * normal) + currentVelocity) * 30, subpos)
                        --entity:SetPhysicsVelocity(((-2 * newVelocity:Dot(normal) * normal) + newVelocity) * self.multiplier * 30)
                        break
                    elseif projectile.GroundBehavior == PROJECTILES_FOLLOW and projectile.changes > 0 and curTime >= projectile.changeTime then
                        -- follow calculation
                        
                        local slope = Projectiles:CalcSlope(ground, projectile.Source, currentVelocity)
                        local dir = currentVelocity:Normalized()
                        --projectile.fGroundOffset = projectile.fGroundOffset - 10
                        --print('follow ' .. slope:Dot(currentVelocity:Normalized()) .. ' -- ' .. projectile.changes)
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
                --DebugDrawCircle(subpos, Vector(200,200,200), 100, 10, true, .01)
                subpos = currentPosition + currentVelocity * (div * index)

                if projectile.distanceTraveled + (subpos-currentPosition):Length() > projectile.fDistance then
                    ParticleManager:DestroyParticle(projectile.id, projectile.bDestroyImmediate)
                    if projectile.OnFinish then
                        local status, out = pcall(projectile.OnFinish, projectile, subpos)
                        if not status then
                            print('[PROJECTILES] Projectile OnFinish Failure!: ' .. out)
                        end
                    end
                    return
                end

                if projectile.bGroundLock then
                subpos.z = GetGroundPosition(subpos, projectile.Source).z + projectile.fGroundOffset
                end
            end

            -- Vision logic
            if projectile.bProvidesVision then
                Projectiles:ProvideVision(projectile)
            end

            projectile.radius = radius + projectile.radiusStep
            projectile.prevPos = projectile.currentPosition
            projectile.distanceTraveled = projectile.distanceTraveled + velLength
            projectile.currentPosition = currentPosition + currentVelocity

            return curTime
        end
    })
    return projectile
end

-- Default Values
function Projectiles:InitialSetup(projectile)
    -- Movement
    projectile.vVelocity = projectile.vVelocity or Vector(0,0,0)
    projectile.fDistance = projectile.fDistance or 1000

    -- Special behaviors
    if projectile.bIsSlowable == nil then projectile.bIsSlowable = true end
    if projectile.bIsReflectable == nil then projectile.bIsReflectable = true end
    if projectile.bisReflectableByAllies == nil then projectile.bisReflectableByAllies = true end
    
    -- Radius
    projectile.fStartRadius =       projectile.fStartRadius or projectile.fUniqueRadius or 100
    projectile.fEndRadius =         projectile.fEndRadius or projectile.fUniqueRadius or  100

    -- Control points
    projectile.iPositionCP =                    projectile.iPositionCP or 0
    projectile.iVelocityCP =                    projectile.iVelocityCP or 1
    projectile.ControlPoints =                  projectile.ControlPoints or {}
    projectile.ControlPointForwards =           projectile.ControlPointForwards or {}
    projectile.ControlPointOrientations =       projectile.ControlPointOrientations or {}
    projectile.ControlPointEntityAttaches =     projectile.ControlPointEntityAttaches or {}

    -- Behavior
    projectile.UnitBehavior = projectile.UnitBehavior or PROJECTILES_DESTROY
    projectile.TreeBehavior = projectile.TreeBehavior or PROJECTILES_DESTROY
    projectile.GroundBehavior = projectile.GroundBehavior or PROJECTILES_DESTROY
    projectile.WallBehavior = projectile.WallBehavior or PROJECTILES_DESTROY

    -- Multiple hits
    if projectile.bMultipleHits == nil then projectile.bMultipleHits = false end
    projectile.fRehitDelay = projectile.fRehitDelay or 1

    -- Misc
    if projectile.bIgnoreSource == nil then projectile.bIgnoreSource = true end
    if projectile.bZCheck == nil then projectile.bZCheck = false end
    if projectile.bCutTrees == nil then projectile.bCutTrees = false end
    if projectile.bDestroyImmediate == nil then projectile.bDestroyImmediate = true end
    projectile.fExpireTime = projectile.fExpireTime or 8.0

    -- Changes
    if projectile.bRecreateOnChange == nil then projectile.bRecreateOnChange = true end
    projectile.nChangeMax = projectile.nChangeMax or 1
    projectile.fChangeDelay = projectile.fChangeDelay or .1

    -- Position
    projectile.bGroundLock = projectile.bGroundLock or true
    projectile.fGroundOffset = projectile.fGroundOffset or 40

    -- Unit filter
    projectile.UnitTest = projectile.UnitTest or function() return false end

    --- On hit function
    projectile.OnUnitHit = projectile.OnUnitHit or function() return end
    projectile.OnTreeHit = projectile.OnTreeHit or function() return end
    projectile.OnWallHit = projectile.OnWallHit or function() return end
    projectile.OnGroundHit = projectile.OnGroundHit or function() return end
    
    -- On finish
    projectile.OnFinish = projectile.OnFinish or nil

    if projectile.bTreeFullCollision == nil then projectile.bTreeFullCollision = false end

    -- Vision
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

    -- Origin
    if projectile.vSpawnOrigin and projectile.vSpawnOrigin.unit then
        local attach = projectile.vSpawnOrigin.unit:ScriptLookupAttachment(projectile.vSpawnOrigin.attach)
        local attachPos = projectile.vSpawnOrigin.unit:GetAttachmentOrigin(attach)
        projectile.vSpawnOrigin = attachPos + (projectile.vSpawnOrigin.offset or Vector(0,0,0))
    else
        projectile.vSpawnOrigin = projectile.vSpawnOrigin or Vector(0,0,0)
    end

    -- Initial setup
    projectile.rehit =              {}
    projectile.currentPosition =     projectile.vSpawnOrigin
    projectile.currentVelocity =     projectile.vVelocity / 30
    projectile.prevVel =            projectile.currentVelocity
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
        projectile.radiusStep = (projectile.fEndRadius - projectile.fStartRadius) / (projectile.fDistance / projectile.currentVelocity:Length())
    end
end

-- Visuals
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
            origin = v.origin or position + projectile.currentVelocity
        else
            origin = v.origin or projectile.vSpawnOrigin
        end
        ParticleManager:SetParticleControlEnt(projectile.id, k, unit, pattach, attachPoint, origin, true)
    end

    if position ~= nil then
        ParticleManager:SetParticleControl(projectile.id, projectile.iPositionCP, position + projectile.currentVelocity)
    else
        ParticleManager:SetParticleControl(projectile.id, projectile.iPositionCP, projectile.vSpawnOrigin)
    end

    if projectile.ControlPointForwards[1] == nil and projectile.ControlPointOrientations[1] == nil then
        ParticleManager:SetParticleControlForward(projectile.id, projectile.iPositionCP, projectile.currentVelocity:Normalized())
    end
end

function Projectiles:DebugDraw(projectile, position, radius)
    -- Defaults
    local alpha = 1
    local color = Vector(200,0,0)
    
    -- Not defaults
    if type(projectile.draw) == "table" then
        alpha = projectile.draw.alpha or alpha
        color = projectile.draw.color or color
    end

    --Draw
    DebugDrawSphere(position, color, alpha, radius, true, .01)
end

function Projectiles:ProvideVision(projectile)
    if projectile.currentFrame == projectile.visionTick then
        AddFOWViewer(projectile.iVisionTeamNumber, projectile.currentPosition, projectile.iVisionRadius, projectile.fVisionLingerDuration, not projectile.bFlyingVision)
        projectile.currentFrame = 0
    else
        projectile.currentFrame = projectile.currentFrame + 1
    end
end

-- Initialize
if not Projectiles.timers then Projectiles:start() end