local ____lualib = require("lualib_bundle")
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 78,["10"] = 1,["11"] = 1,["12"] = 114,["13"] = 115,["14"] = 115,["15"] = 115,["16"] = 115,["18"] = 125,["19"] = 127,["20"] = 206,["21"] = 207,["23"] = 210,["24"] = 211,["26"] = 214,["27"] = 215,["28"] = 216,["29"] = 218,["30"] = 219,["32"] = 222,["33"] = 223,["35"] = 239,["36"] = 240,["37"] = 240,["38"] = 240,["39"] = 240,["40"] = 240,["42"] = 242,["44"] = 248,["46"] = 255,["47"] = 256,["49"] = 270,["50"] = 271,["51"] = 272,["52"] = 273,["53"] = 274,["55"] = 276,["58"] = 284,["59"] = 285,["61"] = 288,["62"] = 289,["64"] = 310,["65"] = 311,["66"] = 313,["67"] = 314,["68"] = 314,["69"] = 314,["70"] = 314,["73"] = 318,["74"] = 319,["75"] = 319,["76"] = 319,["78"] = 319,["80"] = 319,["81"] = 320,["83"] = 405,["84"] = 406,["85"] = 407,["86"] = 408,["89"] = 412,["91"] = 415,["92"] = 416,["93"] = 417,["94"] = 418,["95"] = 420,["96"] = 427,["97"] = 429,["98"] = 430,["99"] = 432,["100"] = 432,["101"] = 432,["102"] = 432,["103"] = 432,["104"] = 432,["105"] = 432,["106"] = 432,["107"] = 432,["108"] = 432,["109"] = 432,["110"] = 432,["111"] = 446,["112"] = 447,["113"] = 448,["114"] = 449,["115"] = 450,["116"] = 451,["119"] = 455,["120"] = 456,["121"] = 456,["122"] = 456,["123"] = 456,["125"] = 458,["126"] = 458,["127"] = 458,["128"] = 458,["130"] = 461,["131"] = 461,["132"] = 461,["133"] = 461,["134"] = 461,["135"] = 461,["136"] = 461,["138"] = 461,["139"] = 463,["140"] = 464,["141"] = 465,["146"] = 471,["148"] = 474,["149"] = 475,["150"] = 476,["151"] = 477,["152"] = 478,["153"] = 479,["154"] = 481,["159"] = 506,["161"] = 509,["162"] = 510,["163"] = 512,["164"] = 514,["165"] = 515,["166"] = 515,["167"] = 515,["168"] = 515,["169"] = 515,["170"] = 523,["171"] = 524,["172"] = 525,["173"] = 526,["174"] = 528,["175"] = 529,["176"] = 531,["177"] = 535,["181"] = 539,["183"] = 542,["184"] = 543,["185"] = 544,["186"] = 551,["187"] = 560,["190"] = 578,["192"] = 582,["193"] = 583,["194"] = 584,["195"] = 585,["196"] = 586,["198"] = 589,["199"] = 591,["200"] = 592,["201"] = 593,["203"] = 595,["206"] = 599,["207"] = 600,["208"] = 601,["209"] = 601,["210"] = 601,["211"] = 601,["212"] = 601,["213"] = 601,["214"] = 601,["215"] = 602,["217"] = 604,["220"] = 608,["221"] = 609,["222"] = 610,["223"] = 611,["224"] = 611,["225"] = 611,["226"] = 611,["227"] = 612,["228"] = 612,["229"] = 612,["230"] = 612,["231"] = 613,["232"] = 613,["233"] = 613,["234"] = 613,["235"] = 614,["236"] = 614,["237"] = 614,["238"] = 614,["239"] = 615,["241"] = 618,["242"] = 619,["244"] = 626,["245"] = 627,["247"] = 631,["248"] = 632,["250"] = 635,["251"] = 636,["253"] = 639,["254"] = 640,["256"] = 643,["257"] = 644,["258"] = 644,["259"] = 644,["260"] = 644,["261"] = 644,["262"] = 644,["263"] = 644,["264"] = 644,["265"] = 644,["266"] = 644,["267"] = 644,["268"] = 644,["270"] = 126,["271"] = 127,["272"] = 128,["273"] = 129,["274"] = 130,["275"] = 131,["276"] = 132,["277"] = 133,["278"] = 134,["279"] = 135,["280"] = 136,["281"] = 137,["282"] = 137,["283"] = 137,["285"] = 137,["286"] = 138,["287"] = 139,["288"] = 140,["289"] = 140,["290"] = 140,["292"] = 140,["293"] = 141,["294"] = 141,["295"] = 141,["297"] = 141,["298"] = 142,["299"] = 143,["300"] = 143,["301"] = 143,["303"] = 143,["304"] = 144,["305"] = 145,["306"] = 145,["307"] = 145,["309"] = 145,["310"] = 146,["311"] = 146,["312"] = 146,["314"] = 146,["315"] = 147,["316"] = 148,["317"] = 148,["318"] = 148,["320"] = 148,["321"] = 149,["322"] = 150,["323"] = 151,["324"] = 152,["325"] = 153,["326"] = 153,["327"] = 153,["329"] = 153,["330"] = 154,["331"] = 154,["332"] = 154,["334"] = 154,["335"] = 155,["336"] = 155,["337"] = 155,["339"] = 155,["340"] = 156,["341"] = 157,["342"] = 157,["343"] = 157,["345"] = 157,["346"] = 158,["347"] = 159,["348"] = 159,["349"] = 159,["351"] = 159,["352"] = 160,["353"] = 160,["354"] = 160,["356"] = 160,["357"] = 161,["358"] = 162,["359"] = 163,["360"] = 164,["361"] = 166,["362"] = 167,["363"] = 168,["364"] = 169,["365"] = 170,["366"] = 171,["367"] = 172,["368"] = 173,["369"] = 174,["370"] = 175,["371"] = 176,["372"] = 177,["373"] = 179,["374"] = 180,["375"] = 180,["376"] = 181,["377"] = 181,["378"] = 183,["379"] = 184,["381"] = 187,["382"] = 188,["384"] = 191,["385"] = 192,["387"] = 195,["388"] = 196,["389"] = 197,["390"] = 198,["391"] = 200,["392"] = 204,["393"] = 204,["394"] = 204,["395"] = 204,["396"] = 204,["397"] = 251,["398"] = 252,["399"] = 251,["400"] = 259,["401"] = 260,["402"] = 261,["403"] = 263,["404"] = 264,["405"] = 264,["406"] = 264,["407"] = 264,["408"] = 264,["409"] = 264,["410"] = 264,["411"] = 264,["413"] = 266,["414"] = 266,["415"] = 266,["416"] = 266,["417"] = 266,["418"] = 266,["419"] = 266,["420"] = 266,["422"] = 259,["423"] = 280,["424"] = 281,["425"] = 280,["426"] = 292,["427"] = 293,["428"] = 294,["430"] = 296,["431"] = 296,["432"] = 296,["433"] = 296,["434"] = 296,["435"] = 296,["436"] = 296,["437"] = 296,["438"] = 296,["439"] = 296,["440"] = 296,["442"] = 292,["443"] = 323,["444"] = 324,["445"] = 330,["446"] = 331,["448"] = 334,["449"] = 335,["452"] = 339,["453"] = 340,["454"] = 341,["455"] = 341,["456"] = 341,["457"] = 341,["458"] = 342,["459"] = 344,["460"] = 345,["461"] = 346,["462"] = 348,["463"] = 349,["464"] = 351,["465"] = 352,["466"] = 354,["467"] = 355,["468"] = 356,["470"] = 359,["471"] = 359,["472"] = 360,["475"] = 363,["478"] = 367,["481"] = 371,["484"] = 375,["485"] = 376,["486"] = 377,["487"] = 379,["488"] = 380,["491"] = 384,["492"] = 385,["494"] = 359,["497"] = 389,["498"] = 390,["500"] = 393,["501"] = 394,["502"] = 395,["503"] = 396,["504"] = 398,["505"] = 399,["507"] = 402,["508"] = 323,["509"] = 622,["510"] = 623,["511"] = 622,["512"] = 658,["513"] = 658,["514"] = 658,["515"] = 658,["517"] = 3,["518"] = 4,["519"] = 5,["520"] = 6,["521"] = 7,["522"] = 78,["523"] = 79,["524"] = 81,["525"] = 83,["526"] = 84,["527"] = 86,["528"] = 87,["529"] = 87,["530"] = 87,["531"] = 88,["532"] = 90,["533"] = 91,["535"] = 94,["536"] = 95,["537"] = 97,["538"] = 98,["539"] = 99,["540"] = 100,["541"] = 101,["543"] = 103,["547"] = 108,["548"] = 108,["549"] = 108,["550"] = 109,["551"] = 108,["552"] = 108,["553"] = 87,["554"] = 87,["555"] = 86,["556"] = 118,["557"] = 119,["558"] = 120,["559"] = 122,["560"] = 118});
local ____exports = {}
local removeProjectile, projectile, SPEED_FACTOR, PROJECTILES_VISUAL_OFFSET, projectiles
local ____util = require("util")
local isConsideredWall = ____util.isConsideredWall
function removeProjectile(self, projectileId)
    projectiles = __TS__ArrayFilter(
        projectiles,
        function(____, projectile) return projectile.id ~= projectileId end
    )
end
function projectile(self, options)
    local getIsReflectable, getIsDestructible, createParticle, resetDistanceTraveled, getSpawnOrigin, hasTimeExpired, hasDistanceExpired, destroy, testEntity, processEntities, processEntity, processTrees, processWalls, processGround, setVelocity, provideVision, getNormal, scheduleDestroy, setSource, getVelocity, getPosition, getSource, getHandler, visionTeamNumber, spawnOrigin, visionLingerDuration, positionCP, velocityCp, controlPoints, controlPointForwards, zCheck, expireTime, distance, destroyImmediate, groundOffset, ignoreSource, cutTrees, unitBehavior, treeBehavior, groundBehavior, wallBehavior, treeFullCollision, isReflectable, isDestructible, changeDelay, recreateOnChange, visionRadius, flyingVision, multipleHits, rehitDelay, visionTick, spawnTime, hitLog, currentTime, currentPosition, currentVelocity, remainingChanges, currentRadius, changeTime, distanceTraveled, currentFrame, source, unitTest, onUnitHit, onFinish, particleId, scheduledToDestroy
    function getIsReflectable(self)
        return isReflectable
    end
    function getIsDestructible(self)
        return isDestructible
    end
    function createParticle(self, position)
        local particleId = ParticleManager:CreateParticle(options.effectName, PATTACH_CUSTOMORIGIN, nil)
        ParticleManager:SetParticleAlwaysSimulate(particleId)
        for ____, controlPoint in ipairs(controlPoints) do
            ParticleManager:SetParticleControl(particleId, controlPoint[1], controlPoint[2])
        end
        for ____, controlPointForward in ipairs(controlPointForwards) do
            ParticleManager:SetParticleControlForward(particleId, controlPointForward[1], controlPointForward[2])
        end
        if position then
            ParticleManager:SetParticleControl(
                particleId,
                positionCP,
                position:__add(currentVelocity)
            )
        else
            ParticleManager:SetParticleControl(particleId, positionCP, spawnOrigin)
        end
        return particleId
    end
    function resetDistanceTraveled(self)
        distanceTraveled = 0
    end
    function getSpawnOrigin(self)
        if options.spawnOrigin.unit ~= nil then
            local attach = options.spawnOrigin.unit:ScriptLookupAttachment(options.spawnOrigin.attach)
            local attachPos = options.spawnOrigin.unit:GetAttachmentOrigin(attach)
            return attachPos:__add(Vector(options.spawnOrigin.offset, options.spawnOrigin.offset, options.spawnOrigin.offset))
        else
            return options.spawnOrigin
        end
    end
    function hasTimeExpired(self)
        return currentTime > spawnTime + expireTime
    end
    function hasDistanceExpired(self)
        return distanceTraveled > distance
    end
    function destroy(self, immediate)
        ParticleManager:DestroyParticle(particleId, destroyImmediate)
        if not immediate then
            onFinish(
                nil,
                getHandler(nil)
            )
        end
    end
    function testEntity(self, entity, zCheck)
        local ____ignoreSource_13
        if ignoreSource then
            ____ignoreSource_13 = entity ~= source
        else
            ____ignoreSource_13 = true
        end
        local sourceTest = ____ignoreSource_13
        return IsValidEntity(entity) and entity:IsAlive() and sourceTest
    end
    function processEntities(self, entities, position)
        for ____, entity in ipairs(entities) do
            if not processEntity(nil, entity, position) then
                return false
            end
        end
        return true
    end
    function processEntity(self, entity, position)
        local origin = entity:GetAbsOrigin()
        local origin2D = Vector(origin.x, origin.y, 0)
        local position2D = Vector(position.x, position.y, 0)
        local fHeight = 150
        if testEntity(nil, entity, zCheck) then
            local time = hitLog:get(entity:entindex())
            if time == nil or currentTime > time then
                if unitTest(nil, entity, {
                    getSource = getSource,
                    getIsReflectable = getIsReflectable,
                    getIsDestructible = getIsDestructible,
                    scheduleDestroy = scheduleDestroy,
                    getVelocity = getVelocity,
                    getPosition = getPosition,
                    resetDistanceTraveled = resetDistanceTraveled,
                    setSource = setSource,
                    setVelocity = setVelocity,
                    hitLog = hitLog
                }) then
                    if isConsideredWall(nil, entity) then
                        if CustomEntitiesLegacy:Allies(source, entity) then
                            return true
                        elseif wallBehavior == ____exports.ProjectileBehavior.DESTROY then
                            destroy(nil, false)
                            return false
                        end
                    end
                    if multipleHits then
                        hitLog:set(
                            entity:entindex(),
                            currentTime + rehitDelay
                        )
                    else
                        hitLog:set(
                            entity:entindex(),
                            currentTime + 10000
                        )
                    end
                    local ____onUnitHit_result_14 = onUnitHit(
                        nil,
                        entity,
                        getHandler(nil)
                    )
                    if ____onUnitHit_result_14 == nil then
                        ____onUnitHit_result_14 = false
                    end
                    local bypass = ____onUnitHit_result_14
                    if not bypass and unitBehavior == ____exports.ProjectileBehavior.DESTROY then
                        destroy(nil, false)
                        return false
                    end
                end
            end
        end
        return true
    end
    function processTrees(self, position, groundPosition)
        local navConnect = not GridNav:IsTraversable(position) or GridNav:IsBlocked(position)
        if navConnect then
            if cutTrees or treeBehavior ~= ____exports.ProjectileBehavior.NOTHING then
                local trees = GridNav:GetAllTreesAroundPoint(position, currentRadius, treeFullCollision)
                for ____, tree in ipairs(trees) do
                    if not zCheck or currentPosition.z < groundPosition.z + 280 + currentRadius - groundOffset and currentPosition.z + currentRadius + groundOffset > groundPosition.z then
                    end
                end
            end
        end
        return true
    end
    function processWalls(self, position, groundPosition, groundConnect)
        if wallBehavior ~= ____exports.ProjectileBehavior.NOTHING and groundConnect then
            local normal = getNormal(nil, groundPosition, source, 32)
            if normal.z < 0.8 then
                local vec = Vector(
                    GridNav:GridPosToWorldCenterX(GridNav:WorldToGridPosX(position.x)),
                    GridNav:GridPosToWorldCenterY(GridNav:WorldToGridPosY(position.y)),
                    groundPosition.z
                )
                if wallBehavior == ____exports.ProjectileBehavior.DESTROY then
                    destroy(nil, false)
                    return false
                elseif wallBehavior == ____exports.ProjectileBehavior.BOUNCE and remainingChanges > 0 and currentTime >= changeTime then
                    normal.z = 0
                    normal = normal:Normalized()
                    local newVelocity = (-2 * currentVelocity:Dot(normal) * normal + currentVelocity) * PROJECTILES_VISUAL_OFFSET
                    return true
                end
            end
        end
        return true
    end
    function processGround(self, position, groundConnect)
        if groundBehavior ~= ____exports.ProjectileBehavior.NOTHING and groundConnect then
            if groundBehavior == ____exports.ProjectileBehavior.DESTROY then
            elseif groundBehavior == ____exports.ProjectileBehavior.BOUNCE and remainingChanges > 0 and currentTime >= changeTime then
            elseif groundBehavior == ____exports.ProjectileBehavior.FOLLOW and remainingChanges > 0 and currentTime >= changeTime then
            end
        end
        return true
    end
    function setVelocity(self, newVelocity, newPosition, ignoreChanges)
        if remainingChanges > 0 or ignoreChanges then
            if not ignoreChanges then
                remainingChanges = remainingChanges - 1
                changeTime = GameRules:GetGameTime() + changeDelay
            end
            currentVelocity = newVelocity:__div(Vector(PROJECTILES_VISUAL_OFFSET, PROJECTILES_VISUAL_OFFSET, PROJECTILES_VISUAL_OFFSET))
            if recreateOnChange then
                ParticleManager:DestroyParticle(particleId, destroyImmediate)
                particleId = createParticle(nil, newPosition or currentPosition)
            end
            ParticleManager:SetParticleControl(particleId, velocityCp, newVelocity)
        end
    end
    function provideVision(self)
        if currentFrame == visionTick then
            AddFOWViewer(
                visionTeamNumber,
                currentPosition,
                visionRadius,
                visionLingerDuration,
                not flyingVision
            )
            currentFrame = 0
        else
            currentFrame = currentFrame + 1
        end
    end
    function getNormal(self, position, entity, scale)
        local mScale = scale or 1
        local nscale = -1 * mScale
        local zl = GetGroundPosition(
            position:__add(Vector(nscale, 0, 0)),
            entity
        ).z
        local zr = GetGroundPosition(
            position:__add(Vector(scale, 0, 0)),
            entity
        ).z
        local zu = GetGroundPosition(
            position:__add(Vector(0, scale, 0)),
            entity
        ).z
        local zd = GetGroundPosition(
            position:__add(Vector(0, nscale, 0)),
            entity
        ).z
        return Vector(zl - zr, zd - zu, 2 * mScale):Normalized()
    end
    function scheduleDestroy(self)
        scheduledToDestroy = true
    end
    function setSource(self, unit)
        source = unit
    end
    function getVelocity(self)
        return currentVelocity:__mul(PROJECTILES_VISUAL_OFFSET)
    end
    function getPosition(self)
        return currentPosition
    end
    function getSource(self)
        return source
    end
    function getHandler(self)
        return {
            getSource = getSource,
            getIsReflectable = getIsReflectable,
            getIsDestructible = getIsDestructible,
            scheduleDestroy = scheduleDestroy,
            getVelocity = getVelocity,
            getPosition = getPosition,
            resetDistanceTraveled = resetDistanceTraveled,
            setSource = setSource,
            setVelocity = setVelocity,
            hitLog = hitLog
        }
    end
    local visionTickTime = math.max(options.visionTickTime or 0.1, 0.1)
    visionTeamNumber = options.visionTeamNumber or options.source:GetTeam()
    spawnOrigin = getSpawnOrigin(nil)
    visionLingerDuration = math.max(options.visionLingerDuration or 1, visionTickTime or 1)
    local velocity = options.velocity:__mul(SPEED_FACTOR)
    local maxChanges = options.maxChanges or 1
    local startRadius = options.startRadius or 100
    positionCP = options.positionCP or 0
    velocityCp = options.velocityCp or 1
    controlPoints = options.controlPoints or ({})
    controlPointForwards = options.controlPointForwards or ({})
    local ____options_zCheck_0 = options.zCheck
    if ____options_zCheck_0 == nil then
        ____options_zCheck_0 = false
    end
    zCheck = ____options_zCheck_0
    expireTime = options.expireTime or 8
    distance = options.distance or 1000
    local ____options_destroyImmediate_1 = options.destroyImmediate
    if ____options_destroyImmediate_1 == nil then
        ____options_destroyImmediate_1 = true
    end
    destroyImmediate = ____options_destroyImmediate_1
    local ____options_draw_2 = options.draw
    if ____options_draw_2 == nil then
        ____options_draw_2 = false
    end
    local draw = ____options_draw_2
    local flagFilter = options.flagFilter or DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
    local ____options_groundLock_3 = options.groundLock
    if ____options_groundLock_3 == nil then
        ____options_groundLock_3 = false
    end
    local groundLock = ____options_groundLock_3
    groundOffset = options.groundOffset or 40
    local ____options_providesVision_4 = options.providesVision
    if ____options_providesVision_4 == nil then
        ____options_providesVision_4 = true
    end
    local providesVision = ____options_providesVision_4
    local ____options_ignoreSource_5 = options.ignoreSource
    if ____options_ignoreSource_5 == nil then
        ____options_ignoreSource_5 = true
    end
    ignoreSource = ____options_ignoreSource_5
    local endRadius = options.endRadius or 100
    local ____options_cutTrees_6 = options.cutTrees
    if ____options_cutTrees_6 == nil then
        ____options_cutTrees_6 = false
    end
    cutTrees = ____options_cutTrees_6
    unitBehavior = options.unitBehavior or ____exports.ProjectileBehavior.DESTROY
    treeBehavior = options.treeBehavior or ____exports.ProjectileBehavior.NOTHING
    groundBehavior = options.groundBehavior or ____exports.ProjectileBehavior.NOTHING
    wallBehavior = options.wallBehavior or ____exports.ProjectileBehavior.DESTROY
    local ____options_treeFullCollision_7 = options.treeFullCollision
    if ____options_treeFullCollision_7 == nil then
        ____options_treeFullCollision_7 = false
    end
    treeFullCollision = ____options_treeFullCollision_7
    local ____options_isReflectable_8 = options.isReflectable
    if ____options_isReflectable_8 == nil then
        ____options_isReflectable_8 = true
    end
    isReflectable = ____options_isReflectable_8
    local ____options_isDestructible_9 = options.isDestructible
    if ____options_isDestructible_9 == nil then
        ____options_isDestructible_9 = true
    end
    isDestructible = ____options_isDestructible_9
    changeDelay = options.changeDelay or 0.1
    local ____options_recreateOnChange_10 = options.recreateOnChange
    if ____options_recreateOnChange_10 == nil then
        ____options_recreateOnChange_10 = true
    end
    recreateOnChange = ____options_recreateOnChange_10
    visionRadius = options.visionRadius or 200
    local ____options_flyingVision_11 = options.flyingVision
    if ____options_flyingVision_11 == nil then
        ____options_flyingVision_11 = false
    end
    flyingVision = ____options_flyingVision_11
    local ____options_multipleHits_12 = options.multipleHits
    if ____options_multipleHits_12 == nil then
        ____options_multipleHits_12 = false
    end
    multipleHits = ____options_multipleHits_12
    rehitDelay = options.rehitDelay or 1
    visionTick = math.ceil(visionTickTime * PROJECTILES_VISUAL_OFFSET)
    spawnTime = GameRules:GetGameTime()
    hitLog = __TS__New(Map)
    local endTime = GameRules:GetGameTime()
    currentTime = GameRules:GetGameTime()
    currentPosition = spawnOrigin
    currentVelocity = velocity:__div(Vector(PROJECTILES_VISUAL_OFFSET, PROJECTILES_VISUAL_OFFSET, PROJECTILES_VISUAL_OFFSET))
    local previousVelocity = currentVelocity
    local previousPosition = spawnOrigin
    remainingChanges = maxChanges or 1
    currentRadius = startRadius
    changeTime = spawnTime
    distanceTraveled = 0
    currentFrame = visionTick
    source = options.source
    unitTest = function() return false end
    onUnitHit = function()
    end
    onFinish = function()
    end
    if options.unitTest then
        unitTest = options.unitTest
    end
    if options.onUnitHit then
        onUnitHit = options.onUnitHit
    end
    if options.onFinish then
        onFinish = options.onFinish
    end
    local radiusSquare = 0
    particleId = createParticle(nil)
    local id = particleId
    scheduledToDestroy = false
    local radiusStep = options.radiusStep and options.radiusStep / PROJECTILES_VISUAL_OFFSET or (endRadius - startRadius) / distance / currentVelocity:Length()
    ParticleManager:SetParticleControl(
        particleId,
        velocityCp,
        currentVelocity:__mul(PROJECTILES_VISUAL_OFFSET)
    )
    local function resetRehit(self)
        hitLog:clear()
    end
    local function debugDraw(self)
        local alpha = 1
        local color = Vector(200, 0, 0)
        if zCheck then
            DebugDrawSphere(
                currentPosition,
                color,
                alpha,
                currentRadius,
                true,
                0.01
            )
        else
            DebugDrawCircle(
                currentPosition,
                Vector(255, 0, 0),
                5,
                currentRadius,
                false,
                0.03
            )
        end
    end
    local function shouldDestroy(self)
        return hasTimeExpired(nil) or hasDistanceExpired(nil) or scheduledToDestroy
    end
    local function findEntities(self, position, radius)
        if zCheck then
            return Entities:FindAllInSphere(position, radius)
        else
            return FindUnitsInRadius(
                DOTA_TEAM_NOTEAM,
                position,
                nil,
                radius,
                DOTA_UNIT_TARGET_TEAM_BOTH,
                DOTA_UNIT_TARGET_ALL,
                flagFilter,
                FIND_ANY_ORDER,
                false
            )
        end
    end
    local function update(self)
        currentTime = GameRules:GetGameTime()
        if groundLock then
            currentPosition.z = GetGroundPosition(currentPosition, source).z + groundOffset
        end
        if shouldDestroy(nil) then
            destroy(nil, false)
            return
        end
        local velocityLength = currentVelocity:Length()
        local radiusSquare = currentRadius * currentRadius
        local pseudoFrames = math.max(
            1,
            math.ceil(velocityLength / 32)
        )
        local framesDivisor = 1 / pseudoFrames
        local somethingA = currentVelocity:__mul(framesDivisor)
        local somethingB = somethingA:__mul(pseudoFrames - 1)
        local vector2 = Vector(2, 2, 2)
        local something = somethingB:__div(vector2)
        local frameHalf = currentPosition:__add(something)
        local frameRadius = frameHalf:__sub(currentPosition):Length() + currentRadius
        local entities = findEntities(nil, frameHalf, frameRadius)
        local pseudoFramePosition = currentPosition
        local groundPosition = GetGroundPosition(pseudoFramePosition, source):__add(Vector(0, 0, groundOffset))
        local groundConnect = groundPosition.z > previousPosition.z
        do
            local index = 1
            while index <= pseudoFrames do
                if not processEntities(nil, entities, pseudoFramePosition) then
                    return
                end
                if not processTrees(nil, pseudoFramePosition, groundPosition) then
                    return
                end
                if not processWalls(nil, pseudoFramePosition, groundPosition, groundConnect) then
                    return
                end
                if not processGround(nil, pseudoFramePosition, groundConnect) then
                    return
                end
                pseudoFramePosition = currentPosition:__add(currentVelocity:__mul(framesDivisor * index))
                groundPosition = GetGroundPosition(pseudoFramePosition, source):__add(Vector(0, 0, groundOffset))
                groundConnect = groundPosition.z > previousPosition.z
                if distanceTraveled + pseudoFramePosition:__sub(currentPosition):Length() > distance then
                    destroy(nil, false)
                    return
                end
                if groundLock then
                    pseudoFramePosition.z = GetGroundPosition(pseudoFramePosition, source).z + groundOffset
                end
                index = index + 1
            end
        end
        if providesVision then
            provideVision(nil)
        end
        currentRadius = currentRadius + radiusStep
        previousPosition = currentPosition
        distanceTraveled = distanceTraveled + velocityLength
        currentPosition = currentPosition:__add(currentVelocity)
        if draw then
            debugDraw(nil)
        end
        return currentTime
    end
    local function setEndTime(self, time)
        endTime = time
    end
    return __TS__ObjectAssign(
        {id = id, update = update, setEndTime = setEndTime},
        getHandler(nil)
    )
end
____exports.ProjectileBehavior = ProjectileBehavior or ({})
____exports.ProjectileBehavior.NOTHING = "NOTHING"
____exports.ProjectileBehavior.DESTROY = "DESTROY"
____exports.ProjectileBehavior.BOUNCE = "BOUNCE"
____exports.ProjectileBehavior.FOLLOW = "FOLLOW"
SPEED_FACTOR = 1
PROJECTILES_VISUAL_OFFSET = 15
local PROJECTILES_THINK = 0.01
projectiles = {}
local previousUpdate = nil
function ____exports.updateProjectiles(self)
    Timers:CreateTimer(
        PROJECTILES_THINK,
        function()
            local now = Time()
            if not previousUpdate then
                previousUpdate = now
            end
            local dt = now - previousUpdate
            previousUpdate = now
            if dt > 0 then
                for ____, projectile in ipairs(projectiles) do
                    local nextCallTime = projectile:update()
                    if nextCallTime then
                        projectile:setEndTime(nextCallTime)
                    else
                        removeProjectile(nil, projectile.id)
                    end
                end
            end
            Timers:CreateTimer(
                PROJECTILES_THINK,
                function()
                    ____exports.updateProjectiles(nil)
                end
            )
        end
    )
end
function ____exports.createProjectile(self, options)
    local created = projectile(nil, options)
    projectiles[#projectiles + 1] = created
    return created
end
return ____exports
