--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 2,["9"] = 2,["10"] = 2,["11"] = 2,["12"] = 8,["13"] = 8,["14"] = 8,["15"] = 8,["16"] = 8,["17"] = 8,["18"] = 8,["19"] = 14,["20"] = 15,["21"] = 15,["22"] = 16,["23"] = 16,["24"] = 17,["25"] = 17,["26"] = 18,["27"] = 18,["28"] = 21,["29"] = 22,["30"] = 22,["31"] = 23,["32"] = 23,["33"] = 24,["34"] = 24,["35"] = 25,["36"] = 25,["37"] = 26,["38"] = 26,["39"] = 27,["40"] = 27,["41"] = 28,["42"] = 28,["43"] = 29,["44"] = 29,["45"] = 30,["46"] = 30,["47"] = 61,["48"] = 61,["49"] = 61,["50"] = 79,["51"] = 62,["52"] = 63,["53"] = 66,["54"] = 67,["55"] = 70,["56"] = 71,["57"] = 80,["58"] = 89,["59"] = 90,["60"] = 90,["61"] = 90,["62"] = 90,["63"] = 90,["64"] = 90,["65"] = 90,["66"] = 90,["67"] = 91,["69"] = 94,["70"] = 95,["71"] = 96,["72"] = 97,["73"] = 98,["74"] = 99,["75"] = 100,["76"] = 100,["77"] = 100,["78"] = 100,["79"] = 100,["80"] = 79,["81"] = 103,["82"] = 104,["83"] = 104,["84"] = 104,["85"] = 104,["86"] = 104,["87"] = 104,["88"] = 104,["89"] = 104,["90"] = 104,["91"] = 104,["92"] = 104,["93"] = 116,["94"] = 117,["96"] = 119,["98"] = 103,["99"] = 123,["100"] = 124,["101"] = 126,["102"] = 127,["105"] = 130,["108"] = 133,["110"] = 123,["111"] = 137,["112"] = 138,["113"] = 139,["114"] = 141,["115"] = 142,["116"] = 143,["117"] = 145,["118"] = 146,["120"] = 149,["121"] = 150,["123"] = 152,["124"] = 137,["125"] = 155,["126"] = 156,["127"] = 155,["128"] = 159,["129"] = 160,["130"] = 160,["131"] = 160,["132"] = 160,["133"] = 164,["134"] = 165,["135"] = 165,["136"] = 165,["137"] = 165,["138"] = 165,["139"] = 165,["140"] = 165,["141"] = 165,["142"] = 160,["143"] = 172,["144"] = 172,["145"] = 172,["146"] = 172,["147"] = 172,["148"] = 172,["149"] = 172,["150"] = 160,["151"] = 160,["152"] = 181,["153"] = 159,["154"] = 184,["155"] = 185,["156"] = 184,["157"] = 188,["158"] = 189,["159"] = 191,["160"] = 192,["162"] = 195,["163"] = 196,["164"] = 197,["165"] = 188,["166"] = 200,["167"] = 201,["168"] = 202,["170"] = 205,["171"] = 206,["172"] = 207,["173"] = 207,["174"] = 207,["175"] = 208,["176"] = 210,["177"] = 211,["178"] = 212,["179"] = 213,["182"] = 216,["183"] = 217,["184"] = 218,["187"] = 221,["188"] = 222,["189"] = 222,["190"] = 222,["191"] = 222,["192"] = 222,["193"] = 222,["194"] = 223,["195"] = 224,["198"] = 227,["199"] = 228,["200"] = 228,["201"] = 228,["202"] = 229,["203"] = 230,["207"] = 234,["208"] = 235,["210"] = 237,["211"] = 238,["213"] = 207,["214"] = 207,["215"] = 242,["216"] = 243,["217"] = 244,["218"] = 245,["219"] = 246,["221"] = 248,["223"] = 200,["224"] = 252,["225"] = 253,["226"] = 252,["227"] = 256,["228"] = 257,["229"] = 258,["230"] = 260,["231"] = 261,["233"] = 263,["234"] = 264,["235"] = 265,["237"] = 256,["238"] = 269,["239"] = 270,["240"] = 271,["241"] = 272,["242"] = 272,["243"] = 272,["244"] = 272,["245"] = 272,["246"] = 273,["247"] = 273,["248"] = 273,["249"] = 273,["250"] = 273,["251"] = 274,["252"] = 269,["253"] = 277,["254"] = 278,["255"] = 277,["256"] = 281,["257"] = 282,["258"] = 283,["259"] = 284,["261"] = 281,["262"] = 288,["263"] = 289,["264"] = 290,["266"] = 292,["267"] = 293,["269"] = 295,["270"] = 296,["273"] = 299,["274"] = 300,["275"] = 301,["276"] = 302,["277"] = 303,["278"] = 304,["281"] = 307,["282"] = 308,["285"] = 311,["286"] = 312,["290"] = 316,["291"] = 317,["292"] = 318,["294"] = 288,["295"] = 323,["296"] = 329,["297"] = 330,["298"] = 331,["299"] = 335,["300"] = 335,["301"] = 335,["302"] = 335,["303"] = 335,["304"] = 335,["305"] = 339,["306"] = 339,["307"] = 339,["308"] = 339,["309"] = 339,["310"] = 339,["311"] = 343,["312"] = 343,["313"] = 343,["314"] = 343,["315"] = 343,["316"] = 343,["317"] = 343,["318"] = 350,["319"] = 350,["320"] = 350,["321"] = 350,["322"] = 350,["323"] = 350,["324"] = 354,["325"] = 354,["326"] = 354,["327"] = 354,["328"] = 354,["329"] = 354,["330"] = 354,["331"] = 361,["332"] = 361,["333"] = 361,["334"] = 361,["335"] = 361,["336"] = 361,["337"] = 361,["338"] = 368,["339"] = 329,["340"] = 329,["341"] = 328,["342"] = 372,["343"] = 373,["344"] = 374,["345"] = 376,["346"] = 376,["347"] = 376,["348"] = 376,["349"] = 376,["350"] = 376,["351"] = 376,["352"] = 383,["353"] = 383,["354"] = 383,["355"] = 383,["356"] = 383,["357"] = 383,["358"] = 383,["359"] = 390,["360"] = 390,["361"] = 390,["362"] = 390,["363"] = 390,["364"] = 390,["365"] = 390,["366"] = 397,["367"] = 397,["368"] = 397,["369"] = 397,["370"] = 397,["371"] = 397,["372"] = 397,["373"] = 404,["374"] = 404,["375"] = 404,["376"] = 404,["377"] = 404,["378"] = 404,["379"] = 408,["380"] = 372,["381"] = 372,["382"] = 328,["383"] = 412,["384"] = 413,["385"] = 414,["386"] = 419,["387"] = 419,["388"] = 419,["389"] = 419,["390"] = 419,["391"] = 419,["392"] = 423,["393"] = 423,["394"] = 423,["395"] = 423,["396"] = 423,["397"] = 423,["398"] = 423,["399"] = 430,["400"] = 412,["401"] = 412,["402"] = 328,["403"] = 434,["404"] = 435,["405"] = 436,["406"] = 441,["407"] = 441,["408"] = 441,["409"] = 441,["410"] = 441,["411"] = 441,["412"] = 441,["413"] = 448,["414"] = 434,["415"] = 434,["416"] = 328,["417"] = 452,["418"] = 453,["419"] = 454,["420"] = 459,["421"] = 459,["422"] = 459,["423"] = 459,["424"] = 459,["425"] = 459,["426"] = 463,["427"] = 463,["428"] = 463,["429"] = 463,["430"] = 463,["431"] = 463,["432"] = 463,["433"] = 470,["434"] = 452,["435"] = 452,["436"] = 328,["437"] = 474,["438"] = 475,["439"] = 476,["440"] = 483,["441"] = 483,["442"] = 483,["443"] = 483,["444"] = 483,["445"] = 483,["446"] = 483,["447"] = 491,["448"] = 492,["449"] = 474,["450"] = 474,["451"] = 328,["452"] = 496,["453"] = 497,["454"] = 498,["455"] = 505,["456"] = 505,["457"] = 505,["458"] = 505,["459"] = 505,["460"] = 505,["461"] = 505,["462"] = 513,["463"] = 514,["464"] = 496,["465"] = 496,["466"] = 328,["467"] = 518,["468"] = 519,["469"] = 520,["470"] = 527,["471"] = 527,["472"] = 527,["473"] = 527,["474"] = 527,["475"] = 527,["476"] = 527,["477"] = 535,["478"] = 518,["479"] = 518,["480"] = 328,["481"] = 539,["482"] = 540,["483"] = 541,["484"] = 545,["485"] = 545,["486"] = 545,["487"] = 545,["488"] = 545,["489"] = 545,["490"] = 545,["491"] = 552,["492"] = 553,["493"] = 539,["494"] = 539,["495"] = 328,["496"] = 328});
local ____exports = {}
local CustomAIState = CustomAIState or ({})
CustomAIState.IDLE = 0
CustomAIState[CustomAIState.IDLE] = "IDLE"
CustomAIState.WANDERING = 1
CustomAIState[CustomAIState.WANDERING] = "WANDERING"
CustomAIState.RESTING = 2
CustomAIState[CustomAIState.RESTING] = "RESTING"
local CustomAIBehavior = CustomAIBehavior or ({})
CustomAIBehavior.FOLLOWER = 0
CustomAIBehavior[CustomAIBehavior.FOLLOWER] = "FOLLOWER"
CustomAIBehavior.WANDERER = 1
CustomAIBehavior[CustomAIBehavior.WANDERER] = "WANDERER"
CustomAIBehavior.STATIC = 2
CustomAIBehavior[CustomAIBehavior.STATIC] = "STATIC"
____exports.CustomAITier = CustomAITier or ({})
____exports.CustomAITier.BASIC = 1
____exports.CustomAITier[____exports.CustomAITier.BASIC] = "BASIC"
____exports.CustomAITier.MID = 2
____exports.CustomAITier[____exports.CustomAITier.MID] = "MID"
____exports.CustomAITier.HIGH = 3
____exports.CustomAITier[____exports.CustomAITier.HIGH] = "HIGH"
____exports.CustomAITier.BOSS = 4
____exports.CustomAITier[____exports.CustomAITier.BOSS] = "BOSS"
____exports.NPCNames = NPCNames or ({})
____exports.NPCNames.DIRE_ZOMBIE_RANGE = 0
____exports.NPCNames[____exports.NPCNames.DIRE_ZOMBIE_RANGE] = "DIRE_ZOMBIE_RANGE"
____exports.NPCNames.DIRE_ZOMBIE_RANGE_MEGA = 1
____exports.NPCNames[____exports.NPCNames.DIRE_ZOMBIE_RANGE_MEGA] = "DIRE_ZOMBIE_RANGE_MEGA"
____exports.NPCNames.DIRE_ZOMBIE_MEELE_MEGA = 2
____exports.NPCNames[____exports.NPCNames.DIRE_ZOMBIE_MEELE_MEGA] = "DIRE_ZOMBIE_MEELE_MEGA"
____exports.NPCNames.RADIANT_ZOMBIE_RANGE_MEGA = 3
____exports.NPCNames[____exports.NPCNames.RADIANT_ZOMBIE_RANGE_MEGA] = "RADIANT_ZOMBIE_RANGE_MEGA"
____exports.NPCNames.RADIANT_ZOMBIE_MEELE_MEGA = 4
____exports.NPCNames[____exports.NPCNames.RADIANT_ZOMBIE_MEELE_MEGA] = "RADIANT_ZOMBIE_MEELE_MEGA"
____exports.NPCNames.FLYING_SKULL = 5
____exports.NPCNames[____exports.NPCNames.FLYING_SKULL] = "FLYING_SKULL"
____exports.NPCNames.DIRE_TOWER = 6
____exports.NPCNames[____exports.NPCNames.DIRE_TOWER] = "DIRE_TOWER"
____exports.NPCNames.QUEEN = 7
____exports.NPCNames[____exports.NPCNames.QUEEN] = "QUEEN"
____exports.NPCNames.CENTAUR = 8
____exports.NPCNames[____exports.NPCNames.CENTAUR] = "CENTAUR"
____exports.CustomAI = __TS__Class()
local CustomAI = ____exports.CustomAI
CustomAI.name = "CustomAI"
function CustomAI.prototype.____constructor(self, name, origin, options)
    self.state = CustomAIState.IDLE
    self.abilities = {}
    self.tauntedDuration = 3
    self.tauntedRemainingDuration = 0
    self.remainingRestTime = 0
    self.rangeOfAction = 3000
    self.unit = CreateUnitByName(name, origin, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    if options.shield then
        self.unit:AddNewModifier(
            self.unit,
            nil,
            "modifier_generic_npc_shield",
            {
                damage_block = self.unit:GetMaxHealth()
            }
        )
        self.unit:AddNewModifier(self.unit, nil, "modifier_generic_npc_mini_stun", {})
    end
    self.restTime = options.restTime or 1
    self.followRange = options.followRange or 2500
    self.tauntedFollowRange = self.followRange * 1.5
    self.minFollowRange = options.minFollowRange or 0
    self.behavior = options.behavior or CustomAIBehavior.FOLLOWER
    self.originalPosition = origin
    ListenToGameEvent(
        "entity_hurt",
        function(event) return self:OnUnitHurt(event) end,
        nil
    )
end
function CustomAI.prototype.FindEnemy(self, radius)
    local units = FindUnitsInRadius(
        self.unit:GetTeamNumber(),
        self.unit:GetAbsOrigin(),
        nil,
        radius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NO_INVIS,
        FIND_ANY_ORDER,
        false
    )
    if #units > 0 then
        return units[1]
    else
        return nil
    end
end
function CustomAI.prototype.UpdateTarget(self)
    local followRange = ((self.tauntedRemainingDuration > 0) and self.tauntedFollowRange) or self.followRange
    if self.followTarget then
        if (CustomEntitiesLegacy:GetDistance(self.unit, self.followTarget) <= followRange) and (not self.followTarget:IsInvisible()) then
            return
        else
            self.followTarget = nil
        end
    else
        self.followTarget = self:FindEnemy(followRange)
    end
end
function CustomAI.prototype.Follow(self)
    local origin = self.unit:GetAbsOrigin()
    self:UpdateTarget()
    if self.followTarget and self.followTarget:IsAlive() then
        local distance = CustomEntitiesLegacy:GetDistance(self.unit, self.followTarget)
        local direction = Vector(0, 0)
        if self.followTarget:IsAlive() and (distance > self.minFollowRange) then
            direction = self.followTarget:GetAbsOrigin():__sub(origin):Normalized()
        end
        CustomEntitiesLegacy:SetDirection(self.unit, direction.x, direction.y)
        return true
    end
    return false
end
function CustomAI.prototype.IsAbilityReady(self, ability)
    return ability:IsCooldownReady() and (not ability:IsInAbilityPhase())
end
function CustomAI.prototype.RegisterAbility(self, options)
    local npcAbility = {
        ability = options.ability,
        orderType = options.orderType,
        priority = #self.abilities + 1,
        cast = function(____, ability, target)
            ExecuteOrderFromTable(
                {
                    OrderType = options.orderType,
                    UnitIndex = self.unit:GetEntityIndex(),
                    AbilityIndex = ability:GetEntityIndex(),
                    Position = (target and target:GetAbsOrigin()) or nil
                }
            )
        end,
        requirements = (options.requirements and __TS__ObjectAssign(
            {},
            options.requirements,
            {
                cooldownReady = (((options.requirements.cooldownReady ~= nil) and (function() return options.requirements.cooldownReady end)) or (function() return true end))(),
                phaseReady = (((options.requirements.phaseReady ~= nil) and (function() return options.requirements.phaseReady end)) or (function() return true end))()
            }
        )) or ({cooldownReady = true, phaseReady = true})
    }
    __TS__ArrayPush(self.abilities, npcAbility)
end
function CustomAI.prototype.StartRest(self, restTime)
    self.remainingRestTime = restTime * 30
end
function CustomAI.prototype.BackToOrigin(self, origin)
    local distanceFromOrigin = self.originalPosition:__sub(origin):Length2D()
    if self.rangeOfAction > distanceFromOrigin then
        return false
    end
    local direction = self.originalPosition:__sub(origin):Normalized()
    CustomEntitiesLegacy:SetDirection(self.unit, direction.x, direction.y)
    return true
end
function CustomAI.prototype.Cast(self)
    if ((CustomEntitiesLegacy:IsDisplacing(self.unit) or CustomEntitiesLegacy:IsCasting(self.unit)) or CustomEntitiesLegacy:IsChanneling(self.unit)) or (self.remainingRestTime > 0) then
        return false
    end
    local abilityToExecute = nil
    local abilityTarget = nil
    __TS__ArrayForEach(
        self.abilities,
        function(____, npcAbility)
            local ability = npcAbility.ability
            if npcAbility.requirements then
                if npcAbility.requirements.cooldownReady then
                    if not npcAbility.ability:IsCooldownReady() then
                        return false
                    end
                end
                if npcAbility.requirements.phaseReady then
                    if npcAbility.ability:IsInAbilityPhase() then
                        return false
                    end
                end
                if npcAbility.requirements.targetInCastRange then
                    abilityTarget = self:FindEnemy(
                        ability:GetCastRange(
                            Vector(0, 0, 0),
                            nil
                        )
                    )
                    if not abilityTarget then
                        return false
                    end
                end
                if npcAbility.requirements.targetInRadius then
                    abilityTarget = self:FindEnemy(
                        ability:GetSpecialValueFor("radius")
                    )
                    if not abilityTarget then
                        return false
                    end
                end
            end
            if abilityToExecute == nil then
                abilityToExecute = npcAbility
            end
            if npcAbility.priority > abilityToExecute.priority then
                abilityToExecute = npcAbility
            end
        end
    )
    if abilityToExecute then
        abilityToExecute = abilityToExecute
        abilityToExecute:cast(abilityToExecute.ability, abilityTarget)
        self:StartRest(self.restTime)
        return true
    else
        return false
    end
end
function CustomAI.prototype.StopMoving(self)
    CustomEntitiesLegacy:SetDirection(self.unit, 0, 0)
end
function CustomAI.prototype.MoveTowards(self, point)
    local origin = self.unit:GetAbsOrigin()
    local distance = point:__sub(origin):Length2D()
    if distance < 10 then
        return false
    else
        local direction = point:__sub(origin):Normalized()
        CustomEntitiesLegacy:SetDirection(self.unit, direction.x, direction.y)
        return true
    end
end
function CustomAI.prototype.PickTargetPosition(self)
    local origin = self.unit:GetAbsOrigin()
    local worldLimits = 1500
    local x = Clamp(
        origin.x + RandomInt(-400, 400),
        worldLimits,
        -worldLimits
    )
    local y = Clamp(
        origin.y + RandomInt(-400, 400),
        worldLimits,
        -worldLimits
    )
    self.targetPosition = Vector(x, y)
end
function CustomAI.prototype.ClearTargetPosition(self)
    self.targetPosition = nil
end
function CustomAI.prototype.OnUnitHurt(self, event)
    local victim = EntIndexToHScript(event.entindex_killed)
    if self.unit == victim then
        self.tauntedRemainingDuration = self.tauntedDuration * 30
    end
end
function CustomAI.prototype.Update(self)
    if self.tauntedRemainingDuration > 0 then
        self.tauntedRemainingDuration = self.tauntedRemainingDuration - 1
    end
    if self.remainingRestTime > 0 then
        self.remainingRestTime = self.remainingRestTime - 1
    end
    if not self:Cast() then
        if self.behavior == CustomAIBehavior.STATIC then
            return
        end
        if self.behavior == CustomAIBehavior.WANDERER then
            if (self.state == CustomAIState.WANDERING) and self.targetPosition then
                if not self:MoveTowards(self.targetPosition) then
                    self.state = CustomAIState.IDLE
                    self:ClearTargetPosition()
                    self:StopMoving()
                end
            else
                self.state = CustomAIState.WANDERING
                self:PickTargetPosition()
            end
        else
            if not self:Follow() then
                self:StopMoving()
            end
        end
    else
        self.remainingRestTime = 1 * 30
        self:ClearTargetPosition()
        self:StopMoving()
    end
end
____exports.CustomAIMeta = {
    [____exports.NPCNames.QUEEN] = {
        factory = function(____, origin)
            local ai = __TS__New(____exports.CustomAI, "npc_dota_hero_queenofpain", origin, {minFollowRange = 500})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("queen_scream"),
                    orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("queen_dodge"),
                    orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("queen_blink"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("queen_daggers"),
                    orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("queen_attack"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("queen_wave"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            return ai
        end,
        tier = ____exports.CustomAITier.BOSS
    },
    [____exports.NPCNames.CENTAUR] = {
        factory = function(____, origin)
            local ai = __TS__New(____exports.CustomAI, "npc_dota_hero_centaur", origin, {})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("centaur_axe_attack"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInRadius = true}
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("centaur_range_attack"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("centaur_short_attack"),
                    orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
                    requirements = {targetInRadius = true}
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("centaur_charge"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("centaur_rage"),
                    orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
                }
            )
            return ai
        end,
        tier = ____exports.CustomAITier.BOSS
    },
    [____exports.NPCNames.RADIANT_ZOMBIE_RANGE_MEGA] = {
        factory = function(____, origin)
            local ai = __TS__New(____exports.CustomAI, "radiant_zombie_healer", origin, {behavior = CustomAIBehavior.WANDERER, shield = true})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("radiant_zombie_heal_aura"),
                    orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("dire_zombie_attack"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            return ai
        end,
        tier = ____exports.CustomAITier.MID
    },
    [____exports.NPCNames.DIRE_ZOMBIE_RANGE] = {
        factory = function(____, origin)
            local ai = __TS__New(____exports.CustomAI, "dire_zombie_range", origin, {behavior = CustomAIBehavior.WANDERER, shield = true})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("dire_zombie_attack"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            return ai
        end,
        tier = ____exports.CustomAITier.BASIC
    },
    [____exports.NPCNames.DIRE_ZOMBIE_RANGE_MEGA] = {
        factory = function(____, origin)
            local ai = __TS__New(____exports.CustomAI, "dire_zombie_range_mega", origin, {behavior = CustomAIBehavior.WANDERER, shield = true})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("dire_zombie_rage_aura"),
                    orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
                }
            )
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("dire_zombie_attack"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            return ai
        end,
        tier = ____exports.CustomAITier.MID
    },
    [____exports.NPCNames.DIRE_ZOMBIE_MEELE_MEGA] = {
        factory = function(____, origin)
            local ai = __TS__New(____exports.CustomAI, "dire_zombie_meele_mega", origin, {followRange = 1500, minFollowRange = 200, behavior = CustomAIBehavior.FOLLOWER, shield = true})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("dire_zombie_attack_meele"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            ai.unit:SetHullRadius(95)
            return ai
        end,
        tier = ____exports.CustomAITier.MID
    },
    [____exports.NPCNames.RADIANT_ZOMBIE_MEELE_MEGA] = {
        factory = function(____, origin)
            local ai = __TS__New(____exports.CustomAI, "radiant_zombie_meele", origin, {followRange = 1500, minFollowRange = 200, behavior = CustomAIBehavior.FOLLOWER, shield = true})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("dire_zombie_attack_meele"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            ai.unit:SetHullRadius(95)
            return ai
        end,
        tier = ____exports.CustomAITier.BASIC
    },
    [____exports.NPCNames.FLYING_SKULL] = {
        factory = function(____, origin)
            local ai = __TS__New(____exports.CustomAI, "flying_skull", origin, {followRange = 1000, minFollowRange = 150, behavior = CustomAIBehavior.FOLLOWER, shield = true})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("flying_skull_dash"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            return ai
        end,
        tier = ____exports.CustomAITier.BASIC
    },
    [____exports.NPCNames.DIRE_TOWER] = {
        factory = function(____, origin)
            local ai = __TS__New(____exports.CustomAI, "dire_tower", origin, {behavior = CustomAIBehavior.STATIC})
            ai:RegisterAbility(
                {
                    ability = ai.unit:FindAbilityByName("dire_tower_attack"),
                    orderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    requirements = {targetInCastRange = true}
                }
            )
            ai.unit:SetHullRadius(100)
            return ai
        end,
        tier = ____exports.CustomAITier.HIGH
    }
}
return ____exports
