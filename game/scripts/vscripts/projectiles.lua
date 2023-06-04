local ____lualib = require("lualib_bundle")
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 77,["9"] = 1,["10"] = 1,["11"] = 113,["12"] = 114,["13"] = 114,["14"] = 114,["15"] = 114,["17"] = 124,["18"] = 126,["19"] = 205,["20"] = 206,["22"] = 209,["23"] = 210,["25"] = 213,["26"] = 214,["27"] = 215,["28"] = 217,["29"] = 218,["31"] = 221,["32"] = 222,["34"] = 238,["35"] = 239,["36"] = 239,["37"] = 239,["38"] = 239,["39"] = 239,["41"] = 241,["43"] = 247,["45"] = 254,["46"] = 255,["48"] = 269,["49"] = 270,["50"] = 271,["51"] = 272,["52"] = 273,["54"] = 275,["57"] = 283,["58"] = 284,["60"] = 287,["61"] = 288,["63"] = 309,["64"] = 310,["65"] = 312,["66"] = 313,["69"] = 317,["70"] = 318,["71"] = 318,["72"] = 318,["74"] = 318,["76"] = 318,["77"] = 319,["79"] = 404,["80"] = 405,["81"] = 406,["82"] = 407,["85"] = 411,["87"] = 414,["88"] = 415,["89"] = 416,["90"] = 417,["91"] = 419,["92"] = 426,["93"] = 428,["94"] = 429,["95"] = 431,["96"] = 431,["97"] = 431,["98"] = 431,["99"] = 431,["100"] = 431,["101"] = 431,["102"] = 431,["103"] = 431,["104"] = 431,["105"] = 431,["106"] = 444,["107"] = 445,["108"] = 446,["109"] = 447,["110"] = 448,["111"] = 449,["114"] = 453,["115"] = 454,["116"] = 454,["117"] = 454,["118"] = 454,["120"] = 456,["121"] = 456,["122"] = 456,["123"] = 456,["125"] = 460,["126"] = 460,["127"] = 460,["128"] = 460,["129"] = 460,["130"] = 460,["131"] = 460,["132"] = 460,["133"] = 460,["134"] = 460,["135"] = 460,["136"] = 460,["137"] = 460,["139"] = 459,["140"] = 472,["141"] = 473,["142"] = 474,["147"] = 480,["149"] = 483,["150"] = 484,["151"] = 485,["152"] = 486,["153"] = 487,["154"] = 488,["155"] = 490,["160"] = 515,["162"] = 518,["163"] = 519,["164"] = 521,["165"] = 523,["166"] = 524,["167"] = 524,["168"] = 524,["169"] = 524,["170"] = 524,["171"] = 532,["172"] = 533,["173"] = 534,["174"] = 535,["175"] = 537,["176"] = 538,["177"] = 540,["178"] = 544,["182"] = 548,["184"] = 551,["185"] = 552,["186"] = 553,["187"] = 560,["188"] = 569,["191"] = 587,["193"] = 591,["194"] = 592,["195"] = 593,["196"] = 594,["197"] = 595,["199"] = 598,["200"] = 600,["201"] = 601,["202"] = 602,["204"] = 604,["207"] = 608,["208"] = 609,["209"] = 610,["210"] = 610,["211"] = 610,["212"] = 610,["213"] = 610,["214"] = 610,["215"] = 610,["216"] = 611,["218"] = 613,["221"] = 617,["222"] = 618,["223"] = 619,["224"] = 620,["225"] = 620,["226"] = 620,["227"] = 620,["228"] = 621,["229"] = 621,["230"] = 621,["231"] = 621,["232"] = 622,["233"] = 622,["234"] = 622,["235"] = 622,["236"] = 623,["237"] = 623,["238"] = 623,["239"] = 623,["240"] = 624,["242"] = 627,["243"] = 628,["245"] = 635,["246"] = 636,["248"] = 640,["249"] = 641,["251"] = 644,["252"] = 645,["254"] = 125,["255"] = 126,["256"] = 127,["257"] = 128,["258"] = 129,["259"] = 130,["260"] = 131,["261"] = 132,["262"] = 133,["263"] = 134,["264"] = 135,["265"] = 136,["266"] = 136,["267"] = 136,["269"] = 136,["270"] = 137,["271"] = 138,["272"] = 139,["273"] = 139,["274"] = 139,["276"] = 139,["277"] = 140,["278"] = 140,["279"] = 140,["281"] = 140,["282"] = 141,["283"] = 142,["284"] = 142,["285"] = 142,["287"] = 142,["288"] = 143,["289"] = 144,["290"] = 144,["291"] = 144,["293"] = 144,["294"] = 145,["295"] = 145,["296"] = 145,["298"] = 145,["299"] = 146,["300"] = 147,["301"] = 147,["302"] = 147,["304"] = 147,["305"] = 148,["306"] = 149,["307"] = 150,["308"] = 151,["309"] = 152,["310"] = 152,["311"] = 152,["313"] = 152,["314"] = 153,["315"] = 153,["316"] = 153,["318"] = 153,["319"] = 154,["320"] = 154,["321"] = 154,["323"] = 154,["324"] = 155,["325"] = 156,["326"] = 156,["327"] = 156,["329"] = 156,["330"] = 157,["331"] = 158,["332"] = 158,["333"] = 158,["335"] = 158,["336"] = 159,["337"] = 159,["338"] = 159,["340"] = 159,["341"] = 160,["342"] = 161,["343"] = 162,["344"] = 163,["345"] = 165,["346"] = 166,["347"] = 167,["348"] = 168,["349"] = 169,["350"] = 170,["351"] = 171,["352"] = 172,["353"] = 173,["354"] = 174,["355"] = 175,["356"] = 176,["357"] = 178,["358"] = 179,["359"] = 179,["360"] = 180,["361"] = 180,["362"] = 182,["363"] = 183,["365"] = 186,["366"] = 187,["368"] = 190,["369"] = 191,["371"] = 194,["372"] = 195,["373"] = 196,["374"] = 197,["375"] = 199,["376"] = 203,["377"] = 203,["378"] = 203,["379"] = 203,["380"] = 203,["381"] = 250,["382"] = 251,["383"] = 250,["384"] = 258,["385"] = 259,["386"] = 260,["387"] = 262,["388"] = 263,["389"] = 263,["390"] = 263,["391"] = 263,["392"] = 263,["393"] = 263,["394"] = 263,["395"] = 263,["397"] = 265,["398"] = 265,["399"] = 265,["400"] = 265,["401"] = 265,["402"] = 265,["403"] = 265,["404"] = 265,["406"] = 258,["407"] = 279,["408"] = 280,["409"] = 279,["410"] = 291,["411"] = 292,["412"] = 293,["414"] = 295,["415"] = 295,["416"] = 295,["417"] = 295,["418"] = 295,["419"] = 295,["420"] = 295,["421"] = 295,["422"] = 295,["423"] = 295,["424"] = 295,["426"] = 291,["427"] = 322,["428"] = 323,["429"] = 329,["430"] = 330,["432"] = 333,["433"] = 334,["436"] = 338,["437"] = 339,["438"] = 340,["439"] = 340,["440"] = 340,["441"] = 340,["442"] = 341,["443"] = 343,["444"] = 344,["445"] = 345,["446"] = 347,["447"] = 348,["448"] = 350,["449"] = 351,["450"] = 353,["451"] = 354,["452"] = 355,["454"] = 358,["455"] = 358,["456"] = 359,["459"] = 362,["462"] = 366,["465"] = 370,["468"] = 374,["469"] = 375,["470"] = 376,["471"] = 378,["472"] = 379,["475"] = 383,["476"] = 384,["478"] = 358,["481"] = 388,["482"] = 389,["484"] = 392,["485"] = 393,["486"] = 394,["487"] = 395,["488"] = 397,["489"] = 398,["491"] = 401,["492"] = 322,["493"] = 631,["494"] = 632,["495"] = 631,["496"] = 648,["498"] = 3,["499"] = 4,["500"] = 5,["501"] = 6,["502"] = 7,["503"] = 77,["504"] = 78,["505"] = 80,["506"] = 82,["507"] = 83,["508"] = 85,["509"] = 86,["510"] = 86,["511"] = 86,["512"] = 87,["513"] = 89,["514"] = 90,["516"] = 93,["517"] = 94,["518"] = 96,["519"] = 97,["520"] = 98,["521"] = 99,["522"] = 100,["524"] = 102,["528"] = 107,["529"] = 107,["530"] = 107,["531"] = 108,["532"] = 107,["533"] = 107,["534"] = 86,["535"] = 86,["536"] = 85,["537"] = 117,["538"] = 118,["539"] = 119,["540"] = 121,["541"] = 117});
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
    local getIsReflectable, getIsDestructible, createParticle, resetDistanceTraveled, getSpawnOrigin, hasTimeExpired, hasDistanceExpired, destroy, testEntity, processEntities, processEntity, processTrees, processWalls, processGround, setVelocity, provideVision, getNormal, scheduleDestroy, setSource, getVelocity, getPosition, visionTeamNumber, spawnOrigin, visionLingerDuration, positionCP, velocityCp, controlPoints, controlPointForwards, zCheck, expireTime, distance, destroyImmediate, groundOffset, ignoreSource, cutTrees, unitBehavior, treeBehavior, groundBehavior, wallBehavior, treeFullCollision, isReflectable, isDestructible, changeDelay, recreateOnChange, visionRadius, flyingVision, multipleHits, rehitDelay, visionTick, spawnTime, hitLog, currentTime, currentPosition, currentVelocity, remainingChanges, currentRadius, changeTime, distanceTraveled, currentFrame, source, unitTest, onUnitHit, onFinish, particleId, scheduledToDestroy
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
            onFinish(nil, currentPosition)
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
                    source = source,
                    getIsReflectable = getIsReflectable,
                    getIsDestructible = getIsDestructible,
                    scheduleDestroy = scheduleDestroy,
                    getVelocity = getVelocity,
                    getPosition = getPosition,
                    resetDistanceTraveled = resetDistanceTraveled,
                    setSource = setSource,
                    setVelocity = setVelocity
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
                    local ____onUnitHit_result_14 = onUnitHit(nil, entity, {
                        source = source,
                        getIsReflectable = getIsReflectable,
                        getIsDestructible = getIsDestructible,
                        scheduleDestroy = scheduleDestroy,
                        getVelocity = getVelocity,
                        getPosition = getPosition,
                        resetDistanceTraveled = resetDistanceTraveled,
                        setSource = setSource,
                        setVelocity = setVelocity
                    })
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
    treeBehavior = options.treeBehavior or ____exports.ProjectileBehavior.DESTROY
    groundBehavior = options.groundBehavior or ____exports.ProjectileBehavior.DESTROY
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
    return {id = id, update = update, setEndTime = setEndTime, scheduleDestroy = scheduleDestroy}
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
