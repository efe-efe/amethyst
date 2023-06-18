local ____lualib = require("lualib_bundle")
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 78,["10"] = 1,["11"] = 1,["12"] = 114,["13"] = 115,["14"] = 115,["15"] = 115,["16"] = 115,["18"] = 125,["19"] = 127,["20"] = 211,["21"] = 212,["23"] = 215,["24"] = 216,["26"] = 219,["27"] = 220,["28"] = 221,["29"] = 223,["30"] = 224,["32"] = 227,["33"] = 228,["35"] = 244,["36"] = 245,["37"] = 245,["38"] = 245,["39"] = 245,["40"] = 245,["42"] = 247,["44"] = 253,["46"] = 260,["47"] = 261,["49"] = 275,["50"] = 276,["51"] = 277,["52"] = 278,["53"] = 279,["55"] = 281,["58"] = 289,["59"] = 290,["61"] = 293,["62"] = 294,["64"] = 315,["65"] = 316,["66"] = 318,["67"] = 319,["68"] = 319,["69"] = 319,["70"] = 319,["73"] = 323,["74"] = 324,["75"] = 324,["76"] = 324,["78"] = 324,["80"] = 324,["81"] = 325,["83"] = 412,["84"] = 413,["85"] = 414,["86"] = 415,["89"] = 419,["91"] = 422,["92"] = 423,["93"] = 424,["94"] = 425,["95"] = 427,["96"] = 434,["97"] = 436,["98"] = 437,["99"] = 439,["100"] = 439,["101"] = 439,["102"] = 439,["103"] = 439,["104"] = 439,["105"] = 439,["106"] = 439,["107"] = 439,["108"] = 439,["109"] = 439,["110"] = 439,["111"] = 453,["112"] = 454,["113"] = 455,["114"] = 456,["115"] = 457,["116"] = 458,["119"] = 462,["120"] = 463,["121"] = 463,["122"] = 463,["123"] = 463,["125"] = 465,["126"] = 465,["127"] = 465,["128"] = 465,["130"] = 468,["131"] = 468,["132"] = 468,["133"] = 468,["134"] = 468,["135"] = 468,["136"] = 468,["138"] = 468,["139"] = 470,["140"] = 471,["141"] = 472,["146"] = 478,["148"] = 481,["149"] = 482,["150"] = 483,["151"] = 484,["152"] = 485,["153"] = 486,["154"] = 488,["159"] = 513,["161"] = 516,["162"] = 517,["163"] = 519,["164"] = 521,["165"] = 522,["166"] = 522,["167"] = 522,["168"] = 522,["169"] = 522,["170"] = 530,["171"] = 531,["172"] = 532,["173"] = 533,["174"] = 535,["175"] = 536,["176"] = 538,["177"] = 542,["181"] = 546,["183"] = 549,["184"] = 550,["185"] = 551,["186"] = 558,["187"] = 567,["190"] = 585,["192"] = 589,["193"] = 590,["194"] = 591,["195"] = 592,["196"] = 593,["198"] = 596,["199"] = 598,["200"] = 599,["201"] = 600,["203"] = 602,["206"] = 606,["207"] = 607,["208"] = 608,["209"] = 608,["210"] = 608,["211"] = 608,["212"] = 608,["213"] = 608,["214"] = 608,["215"] = 609,["217"] = 611,["220"] = 615,["221"] = 616,["222"] = 617,["223"] = 618,["224"] = 618,["225"] = 618,["226"] = 618,["227"] = 619,["228"] = 619,["229"] = 619,["230"] = 619,["231"] = 620,["232"] = 620,["233"] = 620,["234"] = 620,["235"] = 621,["236"] = 621,["237"] = 621,["238"] = 621,["239"] = 622,["241"] = 625,["242"] = 626,["244"] = 633,["245"] = 634,["247"] = 638,["248"] = 639,["250"] = 642,["251"] = 643,["253"] = 646,["254"] = 647,["256"] = 650,["257"] = 651,["258"] = 651,["259"] = 651,["260"] = 651,["261"] = 651,["262"] = 651,["263"] = 651,["264"] = 651,["265"] = 651,["266"] = 651,["267"] = 651,["268"] = 651,["270"] = 126,["271"] = 127,["272"] = 128,["273"] = 129,["274"] = 130,["275"] = 131,["276"] = 132,["277"] = 133,["278"] = 134,["279"] = 135,["280"] = 136,["281"] = 137,["282"] = 137,["283"] = 137,["285"] = 137,["286"] = 138,["287"] = 139,["288"] = 140,["289"] = 140,["290"] = 140,["292"] = 140,["293"] = 141,["294"] = 141,["295"] = 141,["297"] = 141,["298"] = 142,["299"] = 143,["300"] = 143,["301"] = 143,["303"] = 143,["304"] = 144,["305"] = 145,["306"] = 145,["307"] = 145,["309"] = 145,["310"] = 146,["311"] = 146,["312"] = 146,["314"] = 146,["315"] = 147,["316"] = 148,["317"] = 148,["318"] = 148,["320"] = 148,["321"] = 149,["322"] = 150,["323"] = 151,["324"] = 152,["325"] = 153,["326"] = 153,["327"] = 153,["329"] = 153,["330"] = 154,["331"] = 154,["332"] = 154,["334"] = 154,["335"] = 155,["336"] = 155,["337"] = 155,["339"] = 155,["340"] = 156,["341"] = 157,["342"] = 157,["343"] = 157,["345"] = 157,["346"] = 158,["347"] = 159,["348"] = 159,["349"] = 159,["351"] = 159,["352"] = 160,["353"] = 160,["354"] = 160,["356"] = 160,["357"] = 161,["358"] = 162,["359"] = 163,["360"] = 164,["361"] = 166,["362"] = 167,["363"] = 168,["364"] = 169,["365"] = 170,["366"] = 171,["367"] = 172,["368"] = 173,["369"] = 174,["370"] = 175,["371"] = 176,["372"] = 177,["373"] = 179,["374"] = 180,["375"] = 180,["376"] = 181,["377"] = 181,["378"] = 182,["379"] = 182,["380"] = 184,["381"] = 185,["383"] = 188,["384"] = 189,["386"] = 192,["387"] = 193,["389"] = 196,["390"] = 197,["392"] = 200,["393"] = 201,["394"] = 202,["395"] = 203,["396"] = 205,["397"] = 209,["398"] = 209,["399"] = 209,["400"] = 209,["401"] = 209,["402"] = 256,["403"] = 257,["404"] = 256,["405"] = 264,["406"] = 265,["407"] = 266,["408"] = 268,["409"] = 269,["410"] = 269,["411"] = 269,["412"] = 269,["413"] = 269,["414"] = 269,["415"] = 269,["416"] = 269,["418"] = 271,["419"] = 271,["420"] = 271,["421"] = 271,["422"] = 271,["423"] = 271,["424"] = 271,["425"] = 271,["427"] = 264,["428"] = 285,["429"] = 286,["430"] = 285,["431"] = 297,["432"] = 298,["433"] = 299,["435"] = 301,["436"] = 301,["437"] = 301,["438"] = 301,["439"] = 301,["440"] = 301,["441"] = 301,["442"] = 301,["443"] = 301,["444"] = 301,["445"] = 301,["447"] = 297,["448"] = 328,["449"] = 329,["450"] = 335,["451"] = 336,["453"] = 339,["454"] = 340,["457"] = 344,["458"] = 345,["459"] = 346,["460"] = 346,["461"] = 346,["462"] = 346,["463"] = 347,["464"] = 349,["465"] = 350,["466"] = 351,["467"] = 353,["468"] = 354,["469"] = 356,["470"] = 357,["471"] = 359,["472"] = 360,["473"] = 361,["475"] = 364,["476"] = 364,["477"] = 365,["480"] = 368,["483"] = 372,["486"] = 376,["489"] = 380,["490"] = 381,["491"] = 382,["492"] = 384,["493"] = 385,["496"] = 389,["497"] = 390,["499"] = 364,["502"] = 394,["503"] = 395,["505"] = 398,["506"] = 399,["507"] = 400,["508"] = 401,["509"] = 403,["510"] = 404,["512"] = 407,["513"] = 407,["514"] = 407,["515"] = 407,["516"] = 409,["517"] = 328,["518"] = 629,["519"] = 630,["520"] = 629,["521"] = 665,["522"] = 665,["523"] = 665,["524"] = 665,["526"] = 3,["527"] = 4,["528"] = 5,["529"] = 6,["530"] = 7,["531"] = 78,["532"] = 79,["533"] = 81,["534"] = 83,["535"] = 84,["536"] = 86,["537"] = 87,["538"] = 87,["539"] = 87,["540"] = 88,["541"] = 90,["542"] = 91,["544"] = 94,["545"] = 95,["546"] = 97,["547"] = 98,["548"] = 99,["549"] = 100,["550"] = 101,["552"] = 103,["556"] = 108,["557"] = 108,["558"] = 108,["559"] = 109,["560"] = 108,["561"] = 108,["562"] = 87,["563"] = 87,["564"] = 86,["565"] = 118,["566"] = 119,["567"] = 120,["568"] = 122,["569"] = 118});
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
    local function afterUpdate()
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
    if options.afterUpdate then
        afterUpdate = options.afterUpdate
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
        afterUpdate(
            nil,
            getHandler(nil)
        )
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
