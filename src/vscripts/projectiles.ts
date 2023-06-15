import { isConsideredWall } from "./util";

export enum ProjectileBehavior {
    NOTHING = "NOTHING",
    DESTROY = "DESTROY",
    BOUNCE = "BOUNCE",
    FOLLOW = "FOLLOW"
}

export type ProjectileHandler = {
    hitLog: Map<EntityIndex, number>;
    getSource: () => CDOTA_BaseNPC;
    getIsReflectable: () => boolean;
    getIsDestructible: () => boolean;
    getVelocity: () => Vector;
    getPosition: () => Vector;
    scheduleDestroy: () => void;
    setVelocity: (newVelocity: Vector, newPosition: Vector, ignoreChanges?: boolean) => void;
    setSource: (unit: CDOTA_BaseNPC) => void;
    resetDistanceTraveled: () => void;
};

export type ProjectileOptions = {
    source: CDOTA_BaseNPC;
    velocity: Vector;
    spawnOrigin: Vector | { unit: CDOTA_BaseNPC; offset: number; attach: string };
    effectName: string;
    distance?: number;
    startRadius?: number;
    endRadius?: number;
    rehitDelay?: number;
    expireTime?: number;
    changeDelay?: number;
    visionTickTime?: number;
    visionTeamNumber?: DotaTeam;
    visionLingerDuration?: number;
    groundOffset?: number;
    //     nPeakHeight =                   -1,
    //     nSpeed =                        0,
    flagFilter?: UnitTargetFlags;
    maxChanges?: number;
    visionRadius?: number;
    positionCP?: number;
    velocityCp?: number;
    controlPoints?: [number, Vector][];
    controlPointForwards?: [number, Vector][];
    //     ControlPointOrientations =      {},
    //     ControlPointEntityAttaches =    {},
    unitBehavior?: ProjectileBehavior;
    treeBehavior?: ProjectileBehavior;
    groundBehavior?: ProjectileBehavior;
    wallBehavior?: ProjectileBehavior;
    multipleHits?: boolean;
    ignoreSource?: boolean;
    zCheck?: boolean;
    cutTrees?: boolean;
    destroyImmediate?: boolean; //Should be "destroy particle immediate"
    recreateOnChange?: boolean;
    groundLock?: boolean;
    //     bIsSlowable =                   true,
    isReflectable?: boolean;
    //     bIsReflectableByAllies =        false,
    isDestructible?: boolean;
    treeFullCollision?: boolean;
    providesVision?: boolean;
    flyingVision?: boolean;
    draw?: boolean;
    unitTest?: (unit: CDOTA_BaseNPC, projectile: ProjectileHandler) => boolean;
    onUnitHit?: (unit: CDOTA_BaseNPC, projectile: ProjectileHandler) => boolean | void;
    //     OnTreeHit =                     function() return end,
    //     OnWallHit =                     function() return end,
    //     OnGroundHit =                   function() return end,
    onFinish?: (projectile: ProjectileHandler) => void; // This should also have the projectile as parameter
    //     OnIntervalThink =               function() return end,
    radiusStep?: number;
};

const SPEED_FACTOR = 1.0;
const PROJECTILES_VISUAL_OFFSET = 15;

const PROJECTILES_THINK = 0.01;

let projectiles: ReturnType<typeof projectile>[] = [];
let previousUpdate: number | undefined = undefined;

export function updateProjectiles() {
    Timers.CreateTimer(PROJECTILES_THINK, () => {
        const now = Time();

        if (!previousUpdate) {
            previousUpdate = now;
        }

        const dt = now - previousUpdate;
        previousUpdate = now;

        if (dt > 0) {
            for (const projectile of projectiles) {
                const nextCallTime = projectile.update();
                if (nextCallTime) {
                    projectile.setEndTime(nextCallTime);
                } else {
                    removeProjectile(projectile.id);
                }
            }
        }

        Timers.CreateTimer(PROJECTILES_THINK, () => {
            updateProjectiles();
        });
    });
}

function removeProjectile(projectileId: number) {
    projectiles = projectiles.filter(projectile => projectile.id != projectileId);
}

export function createProjectile(options: ProjectileOptions) {
    const created = projectile(options);
    projectiles.push(created);

    return created;
}

function projectile(options: ProjectileOptions) {
    const visionTickTime = Math.max(options.visionTickTime ?? 0.1, 0.1);
    const visionTeamNumber = options.visionTeamNumber ?? options.source.GetTeam();
    const spawnOrigin = getSpawnOrigin();
    const visionLingerDuration = Math.max(options.visionLingerDuration ?? 1.0, visionTickTime ?? 1.0);
    const velocity = options.velocity.__mul(SPEED_FACTOR);
    const maxChanges = options.maxChanges ?? 1;
    const startRadius = options.startRadius ?? 100;
    const positionCP = options.positionCP ?? 0;
    const velocityCp = options.velocityCp ?? 1;
    const controlPoints = options.controlPoints ?? [];
    const controlPointForwards = options.controlPointForwards ?? [];
    const zCheck = options.zCheck ?? false;
    const expireTime = options.expireTime ?? 8.0;
    const distance = options.distance ?? 1000;
    const destroyImmediate = options.destroyImmediate ?? true;
    const draw = options.draw ?? false;
    const flagFilter = options.flagFilter ?? UnitTargetFlags.MAGIC_IMMUNE_ENEMIES;
    const groundLock = options.groundLock ?? false;
    const groundOffset = options.groundOffset ?? 40;
    const providesVision = options.providesVision ?? true;
    const ignoreSource = options.ignoreSource ?? true;
    const endRadius = options.endRadius ?? 100;
    const cutTrees = options.cutTrees ?? false;
    const unitBehavior = options.unitBehavior ?? ProjectileBehavior.DESTROY;
    const treeBehavior = options.treeBehavior ?? ProjectileBehavior.NOTHING;
    const groundBehavior = options.groundBehavior ?? ProjectileBehavior.NOTHING;
    const wallBehavior = options.wallBehavior ?? ProjectileBehavior.DESTROY;
    const treeFullCollision = options.treeFullCollision ?? false;
    const isReflectable = options.isReflectable ?? true;
    const isDestructible = options.isDestructible ?? true;
    const changeDelay = options.changeDelay ?? 0.1;
    const recreateOnChange = options.recreateOnChange ?? true;
    const visionRadius = options.visionRadius ?? 200;
    const flyingVision = options.flyingVision ?? false;
    const multipleHits = options.multipleHits ?? false;
    const rehitDelay = options.rehitDelay ?? 1.0;
    const visionTick = Math.ceil(visionTickTime * PROJECTILES_VISUAL_OFFSET);
    const spawnTime = GameRules.GetGameTime(); //Same as initial time?
    const hitLog: Map<EntityIndex, number> = new Map();

    let endTime = GameRules.GetGameTime();
    let currentTime = GameRules.GetGameTime(); //Should I be doing this?
    let currentPosition = spawnOrigin;
    let currentVelocity = velocity.__div(Vector(PROJECTILES_VISUAL_OFFSET, PROJECTILES_VISUAL_OFFSET, PROJECTILES_VISUAL_OFFSET));
    const previousVelocity = currentVelocity;
    let previousPosition = spawnOrigin; // Should be undefined?
    let remainingChanges = maxChanges ?? 1;
    let currentRadius = startRadius;
    let changeTime = spawnTime;
    let distanceTraveled = 0;
    let currentFrame = visionTick;
    let source = options.source;

    let unitTest: (unit: CDOTA_BaseNPC, projectile: ProjectileHandler) => boolean = () => false;
    let onUnitHit: (unit: CDOTA_BaseNPC, projectile: ProjectileHandler) => boolean | void = () => {};
    let onFinish: (projectile: ProjectileHandler) => void = () => {};

    if (options.unitTest) {
        unitTest = options.unitTest;
    }

    if (options.onUnitHit) {
        onUnitHit = options.onUnitHit;
    }

    if (options.onFinish) {
        onFinish = options.onFinish;
    }

    const radiusSquare = 0.0;
    let particleId = createParticle();
    const id = particleId;
    let scheduledToDestroy = false;

    const radiusStep = options.radiusStep
        ? options.radiusStep / PROJECTILES_VISUAL_OFFSET
        : (endRadius - startRadius) / distance / currentVelocity.Length();

    ParticleManager.SetParticleControl(particleId, velocityCp, currentVelocity.__mul(PROJECTILES_VISUAL_OFFSET));

    function getIsReflectable() {
        return isReflectable;
    }

    function getIsDestructible() {
        return isDestructible;
    }

    function createParticle(position?: Vector) {
        const particleId = ParticleManager.CreateParticle(options.effectName, ParticleAttachment.CUSTOMORIGIN, undefined);
        ParticleManager.SetParticleAlwaysSimulate(particleId);

        for (const controlPoint of controlPoints) {
            ParticleManager.SetParticleControl(particleId, controlPoint[0], controlPoint[1]);
        }

        for (const controlPointForward of controlPointForwards) {
            ParticleManager.SetParticleControlForward(particleId, controlPointForward[0], controlPointForward[1]);
        }

        // for k,v in pairs(self.ControlPointEntityAttaches) do
        //     const unit = v.unit or self.Source
        //     const pattach = v.pattach or ParticleAttachment.CUSTOMORIGIN
        //     const attachPoint = v.attachPoint
        //     const origin
        //     if position ~= nil then
        //         origin = v.origin or position + self.currentVelocity
        //     else
        //         origin = v.origin or self.vSpawnOrigin
        //     end
        //     ParticleManager.SetParticleControlEnt(particleId, k, unit, pattach, attachPoint, origin, true)
        // end

        if (position) {
            ParticleManager.SetParticleControl(particleId, positionCP, position.__add(currentVelocity));
        } else {
            ParticleManager.SetParticleControl(particleId, positionCP, spawnOrigin);
        }

        // if self.ControlPointForwards[1] == nil and self.ControlPointOrientations[1] == nil then
        //     ParticleManager.SetParticleControlForward(particleId, self.positionCP, self.currentVelocity:Normalized())
        // end
        return particleId;
    }

    function resetRehit() {
        hitLog.clear();
    }

    function resetDistanceTraveled() {
        distanceTraveled = 0;
    }

    function debugDraw() {
        const alpha = 1;
        const color = Vector(200, 0, 0);

        if (zCheck) {
            DebugDrawSphere(currentPosition, color, alpha, currentRadius, true, 0.01);
        } else {
            DebugDrawCircle(currentPosition, Vector(255, 0, 0), 5, currentRadius, false, 0.03);
        }
    }

    function getSpawnOrigin() {
        if ("unit" in options.spawnOrigin) {
            const attach = options.spawnOrigin.unit.ScriptLookupAttachment(options.spawnOrigin.attach);
            const attachPos = options.spawnOrigin.unit.GetAttachmentOrigin(attach);
            return attachPos.__add(Vector(options.spawnOrigin.offset, options.spawnOrigin.offset, options.spawnOrigin.offset));
        } else {
            return options.spawnOrigin;
        }
    }

    function shouldDestroy() {
        return hasTimeExpired() || hasDistanceExpired() || scheduledToDestroy;
    }

    function hasTimeExpired() {
        return currentTime > spawnTime + expireTime;
    }

    function hasDistanceExpired() {
        return distanceTraveled > distance;
    }

    function findEntities(position: Vector, radius: number) {
        if (zCheck) {
            return Entities.FindAllInSphere(position, radius);
        } else {
            return FindUnitsInRadius(
                DotaTeam.NOTEAM,
                position,
                undefined,
                radius,
                UnitTargetTeam.BOTH,
                UnitTargetType.ALL,
                flagFilter,
                FindOrder.ANY,
                false
            );
        }
    }

    function destroy(immediate: boolean) {
        ParticleManager.DestroyParticle(particleId, destroyImmediate);

        if (!immediate) {
            onFinish(getHandler());
        }
    }

    function testEntity(entity: CDOTA_BaseNPC, zCheck: boolean) {
        const sourceTest = ignoreSource ? entity != source : true;
        return IsValidEntity(entity) && entity.IsAlive() && sourceTest; //--[[and bZCheck2D]] and zCheck
    }

    function update() {
        currentTime = GameRules.GetGameTime();

        // if self.OnIntervalThink then
        //     pcall(self.OnIntervalThink, self, self.currentPosition)
        // end

        if (groundLock) {
            currentPosition.z = GetGroundPosition(currentPosition, source).z + groundOffset;
        }

        if (shouldDestroy()) {
            destroy(false);
            return;
        }

        const velocityLength = currentVelocity.Length();
        const radiusSquare = currentRadius * currentRadius;
        const pseudoFrames = Math.max(1, Math.ceil(velocityLength / 32)); // tot (idk what this is)
        const framesDivisor = 1 / pseudoFrames; // div (idk what this is)

        const somethingA = currentVelocity.__mul(framesDivisor);
        const somethingB = somethingA.__mul(pseudoFrames - 1);
        const vector2 = Vector(2, 2, 2);

        const something = somethingB.__div(vector2); // It's clear that idk what this is
        const frameHalf = currentPosition.__add(something); //--frameHalf (idk what this is)

        const frameRadius = frameHalf.__sub(currentPosition).Length() + currentRadius; //--framerad(idk what this is)
        const entities = findEntities(frameHalf, frameRadius) as CDOTA_BaseNPC[]; // Find a better way to do this instead of casting

        let pseudoFramePosition = currentPosition;
        let groundPosition = GetGroundPosition(pseudoFramePosition, source).__add(Vector(0, 0, groundOffset));
        let groundConnect = groundPosition.z > previousPosition.z; //-- self.groundPosition

        //Im not sure on the <=, maybe it is <
        for (let index = 1; index <= pseudoFrames; index++) {
            if (!processEntities(entities, pseudoFramePosition)) {
                return;
            }
            if (!processTrees(pseudoFramePosition, groundPosition)) {
                return;
            }

            if (!processWalls(pseudoFramePosition, groundPosition, groundConnect)) {
                return;
            }

            if (!processGround(pseudoFramePosition, groundConnect)) {
                return;
            }

            pseudoFramePosition = currentPosition.__add(currentVelocity.__mul(framesDivisor * index));
            groundPosition = GetGroundPosition(pseudoFramePosition, source).__add(Vector(0, 0, groundOffset));
            groundConnect = groundPosition.z > previousPosition.z; //-- self.groundPosition

            if (distanceTraveled + pseudoFramePosition.__sub(currentPosition).Length() > distance) {
                destroy(false);
                return;
            }

            if (groundLock) {
                pseudoFramePosition.z = GetGroundPosition(pseudoFramePosition, source).z + groundOffset;
            }
        }

        if (providesVision) {
            provideVision();
        }

        currentRadius = currentRadius + radiusStep;
        previousPosition = currentPosition;
        distanceTraveled = distanceTraveled + velocityLength;
        currentPosition = currentPosition.__add(currentVelocity);

        if (draw) {
            debugDraw();
        }

        return currentTime;
    }

    function processEntities(entities: CDOTA_BaseNPC[], position: Vector) {
        for (const entity of entities) {
            if (!processEntity(entity, position)) {
                return false;
            }
        }

        return true;
    }

    function processEntity(entity: CDOTA_BaseNPC, position: Vector) {
        const origin = entity.GetAbsOrigin();
        const origin2D = Vector(origin.x, origin.y, 0);
        const position2D = Vector(position.x, position.y, 0);
        // const bZCheck2D = VectorDistanceSq(position2D, origin2D) <= self.radiusSquare
        const fHeight = 150;

        // const zCheck = true
        // if self.zCheck then
        //     zCheck = position.z >= origin.z and position.z <= origin.z + fHeight
        // end

        if (testEntity(entity, zCheck)) {
            //     --VectorDistanceSq(position2D, origin) <= self.radiusSquare and position.z >= orgz and position.z <= orgz + height then
            const time = hitLog.get(entity.entindex());
            if (time == undefined || currentTime > time) {
                if (
                    unitTest(entity, {
                        getSource,
                        getIsReflectable,
                        getIsDestructible,
                        scheduleDestroy,
                        getVelocity,
                        getPosition,
                        resetDistanceTraveled,
                        setSource,
                        setVelocity,
                        hitLog
                    })
                ) {
                    // @Refactor refactor this isWall
                    if (isConsideredWall(entity)) {
                        if (CustomEntitiesLegacy.Allies(source, entity)) {
                            return true;
                        } else if (wallBehavior == ProjectileBehavior.DESTROY) {
                            destroy(false);
                            return false;
                        }
                    }

                    if (multipleHits) {
                        hitLog.set(entity.entindex(), currentTime + rehitDelay);
                    } else {
                        hitLog.set(entity.entindex(), currentTime + 10000);
                    }

                    const bypass = onUnitHit(entity, getHandler()) ?? false;

                    if (!bypass && unitBehavior == ProjectileBehavior.DESTROY) {
                        destroy(false);
                        return false;
                    }
                }
            }
        }

        return true;
    }

    function processTrees(position: Vector, groundPosition: Vector) {
        const navConnect = !GridNav.IsTraversable(position) || GridNav.IsBlocked(position); // GNV connect
        if (navConnect) {
            if (cutTrees || treeBehavior != ProjectileBehavior.NOTHING) {
                const trees = GridNav.GetAllTreesAroundPoint(position, currentRadius, treeFullCollision);
                for (const tree of trees) {
                    if (
                        !zCheck ||
                        (currentPosition.z < groundPosition.z + 280 + currentRadius - groundOffset &&
                            currentPosition.z + currentRadius + groundOffset > groundPosition.z)
                    ) {
                        //                 if self.cutTrees then
                        //                     tree:CutDown(self.Source:GetTeamNumber())
                        //                     navConnect = not GridNav:IsTraversable(self.position) or GridNav:IsBlocked(self.position)
                        //                 end
                        //                 if self.cutTrees or self.treeBehavior ~= ProjectileBehavior.NOTHING then
                        //                     local status, action = pcall(self.OnTreeHit, self, tree)
                        //                     if not status then
                        //                         print('[PROJECTILES] Projectile OnTreeHit Failure!: ' .. action)
                        //                     end
                        //                 end
                        //                 if self.treeBehavior == ProjectileBehavior.DESTROY then
                        //                     self:destroy(false)
                        //                     return false
                        //                 elseif self.treeBehavior == ProjectileBehavior.BOUNCE and self.remainingChanges > 0 and self.currentTime >= self.changeTime then
                        //                 -- bounce calculation
                        //                 end
                    }
                }
            }
        }

        return true;
    }

    function processWalls(position: Vector, groundPosition: Vector, groundConnect: boolean) {
        if (wallBehavior != ProjectileBehavior.NOTHING && groundConnect) {
            //--groundPosition.z > self.previousPosition.z) {
            let normal = getNormal(groundPosition, source, 32);
            //         --DebugDrawLine_vCol(position, position + normal * 200, Vector(255,255,255), true, 1)
            if (normal.z < 0.8) {
                const vec = Vector(
                    GridNav.GridPosToWorldCenterX(GridNav.WorldToGridPosX(position.x)),
                    GridNav.GridPosToWorldCenterY(GridNav.WorldToGridPosY(position.y)),
                    groundPosition.z
                );

                // onWallHit(this, vec);

                if (wallBehavior == ProjectileBehavior.DESTROY) {
                    destroy(false);
                    return false;
                } else if (wallBehavior == ProjectileBehavior.BOUNCE && remainingChanges > 0 && currentTime >= changeTime) {
                    // DebugDrawLine_vCol(position, position + normal * 200, Vector(255,255,255), true, 1)
                    normal.z = 0;
                    normal = normal.Normalized();
                    // DebugDrawLine_vCol(position, position + normal * 200, Vector(0,255,0), true, 1)
                    const newVelocity = (-2 * currentVelocity.Dot(normal) * normal + currentVelocity) * PROJECTILES_VISUAL_OFFSET;
                    // setVelocity(newVelocity, position);

                    //Check this, maybe I should check the changes before returning true
                    return true;
                }
            }
        }
        return true;
    }

    function processGround(position: Vector, groundConnect: boolean) {
        if (groundBehavior != ProjectileBehavior.NOTHING && groundConnect) {
            if (groundBehavior == ProjectileBehavior.DESTROY) {
                //             local status, action = pcall(self.OnGroundHit, self, self.groundPosition)
                //             if not status then
                //                 print('[PROJECTILES] Projectile OnGroundHit Failure!: ' .. action)
                //             end
                //             self:destroy(false)
                //             return false
            } else if (groundBehavior == ProjectileBehavior.BOUNCE && remainingChanges > 0 && currentTime >= changeTime) {
                //             local status, action = pcall(self.OnGroundHit, self, self.groundPosition)
                //             if not status then
                //                 print('[PROJECTILES] Projectile OnGroundHit Failure!: ' .. action)
                //             end
                //             local normal = self:GetNormal(self.groundPosition, self.Source)
                // self:SetVelocity(((-2 * self.currentVelocity:Dot(normal) * normal) + self.currentVelocity) * PROJECTILES_VISUAL_OFFSET, position)
                // --entity:SetPhysicsVelocity(((-2 * newVelocity:Dot(normal) * normal) + newVelocity) * self.multiplier * PROJECTILES_VISUAL_OFFSET)
                //             return true--break
            } else if (groundBehavior == ProjectileBehavior.FOLLOW && remainingChanges > 0 && currentTime >= changeTime) {
                //             -- follow calculation
                //             local slope = self:GetSlope(self.groundPosition, self.Source, self.currentVelocity)
                //             local dir = self.currentVelocity:Normalized()
                //             --self.groundOffset = self.groundOffset - 10
                //             --print('follow ' .. slope:Dot(self.currentVelocity:Normalized()) .. ' -- ' .. self.changes)
                //             if dir.z < slope.z and slope:Dot(dir) < 1 then
                //                 local status, action = pcall(self.OnGroundHit, self, self.groundPosition)
                //                 if not status then
                //                     print('[PROJECTILES] Projectile OnGroundHit Failure!: ' .. action)
                //                 end
                //                 --self.groundOffset = self.groundOffset - 10
                //                 --print('follow under')
                // self:SetVelocity(velocityLength * PROJECTILES_VISUAL_OFFSET * slope, position)
                //             end
                //             return true--break
            }
        }
        return true;
    }

    //Check the ignoreChanges
    function setVelocity(newVelocity: Vector, newPosition: Vector, ignoreChanges?: boolean) {
        if (remainingChanges > 0 || ignoreChanges) {
            if (!ignoreChanges) {
                remainingChanges = remainingChanges - 1;
                changeTime = GameRules.GetGameTime() + changeDelay;
            }

            currentVelocity = newVelocity.__div(Vector(PROJECTILES_VISUAL_OFFSET, PROJECTILES_VISUAL_OFFSET, PROJECTILES_VISUAL_OFFSET));

            if (recreateOnChange) {
                ParticleManager.DestroyParticle(particleId, destroyImmediate);
                particleId = createParticle(newPosition || currentPosition);
            }
            ParticleManager.SetParticleControl(particleId, velocityCp, newVelocity);
        }
    }

    function provideVision() {
        if (currentFrame == visionTick) {
            AddFOWViewer(visionTeamNumber, currentPosition, visionRadius, visionLingerDuration, !flyingVision);
            currentFrame = 0;
        } else {
            currentFrame = currentFrame + 1;
        }
    }

    function getNormal(position: Vector, entity: CDOTA_BaseNPC, scale?: number) {
        const mScale = scale ?? 1;
        const nscale = -1 * mScale;
        const zl = GetGroundPosition(position.__add(Vector(nscale, 0, 0)), entity).z;
        const zr = GetGroundPosition(position.__add(Vector(scale, 0, 0)), entity).z;
        const zu = GetGroundPosition(position.__add(Vector(0, scale, 0)), entity).z;
        const zd = GetGroundPosition(position.__add(Vector(0, nscale, 0)), entity).z;
        return Vector(zl - zr, zd - zu, 2 * mScale).Normalized();
    }

    function scheduleDestroy() {
        scheduledToDestroy = true;
    }

    function setEndTime(time: number) {
        endTime = time;
    }

    function setSource(unit: CDOTA_BaseNPC) {
        source = unit;
    }

    //@Refactor this needs revision, I don't remember the PROJECTILES_VISUAL_OFFSET thing
    function getVelocity() {
        return currentVelocity.__mul(PROJECTILES_VISUAL_OFFSET);
    }

    function getPosition() {
        return currentPosition;
    }

    function getSource() {
        return source;
    }

    function getHandler() {
        return {
            getSource,
            getIsReflectable,
            getIsDestructible,
            scheduleDestroy,
            getVelocity,
            getPosition,
            resetDistanceTraveled,
            setSource,
            setVelocity,
            hitLog
        };
    }

    return {
        id,
        update,
        setEndTime,
        ...getHandler()
    };
}

// function Projectile:GetSlope(vPosition, hEntity, vDirection)
//     local m_dir = Vector(vDirection.x, vDirection.y, 0):Normalized()
//     local f = GetGroundPosition(vPosition + m_dir, hEntity)
//     local b = GetGroundPosition(vPosition - m_dir, hEntity)

//     return (f - b):Normalized()
// end

// function Projectile:SetPosition(vNewPosition)
//     if self.recreateOnChange then
//         ParticleManager:DestroyParticle(self.iEfx, self.destroyImmediate)
//         self.iEfx = self:CreateParticle(vNewPosition)
//     end

//     ParticleManager:SetParticleControl(self.iEfx, self.velocityCp, self.currentVelocity)
//     self.currentPosition = vNewPosition
// end

// function Projectile:SetVisionTeam(iTeam)
//     self.visionTeamNumber = iTeam
// end
