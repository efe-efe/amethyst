--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 19,["30"] = 19,["31"] = 21,["32"] = 21,["33"] = 22,["34"] = 22,["35"] = 22,["36"] = 23,["37"] = 23,["38"] = 24,["39"] = 24,["40"] = 46,["41"] = 51,["42"] = 51,["43"] = 51,["44"] = 51,["45"] = 51,["46"] = 56,["47"] = 56,["48"] = 56,["49"] = 56,["50"] = 56,["51"] = 61,["52"] = 62,["53"] = 63,["54"] = 64,["55"] = 66,["57"] = 69,["60"] = 70,["61"] = 71,["62"] = 72,["63"] = 73,["64"] = 74,["65"] = 76,["66"] = 81,["67"] = 84,["68"] = 84,["69"] = 84,["70"] = 84,["71"] = 84,["72"] = 84,["73"] = 84,["74"] = 86,["75"] = 87,["76"] = 88,["77"] = 89,["78"] = 90,["79"] = 92,["80"] = 93,["81"] = 94,["82"] = 95,["83"] = 83,["84"] = 99,["85"] = 100,["86"] = 101,["87"] = 102,["88"] = 103,["89"] = 104,["90"] = 105,["91"] = 106,["92"] = 107,["93"] = 108,["94"] = 109,["95"] = 111,["96"] = 112,["97"] = 113,["98"] = 114,["99"] = 115,["100"] = 116,["101"] = 118,["102"] = 119,["103"] = 120,["104"] = 122,["105"] = 123,["106"] = 124,["107"] = 125,["109"] = 99,["110"] = 129,["111"] = 130,["112"] = 129,["115"] = 134,["116"] = 134,["119"] = 135,["120"] = 135,["123"] = 136,["124"] = 136,["127"] = 137,["128"] = 137,["130"] = 139,["131"] = 140,["132"] = 141,["133"] = 142,["135"] = 145,["136"] = 145,["137"] = 145,["138"] = 146,["139"] = 145,["140"] = 145,["142"] = 150,["143"] = 151,["144"] = 152,["145"] = 153,["146"] = 155,["147"] = 156,["148"] = 157,["149"] = 159,["150"] = 159,["151"] = 159,["152"] = 160,["153"] = 161,["155"] = 163,["156"] = 164,["158"] = 167,["159"] = 168,["161"] = 159,["162"] = 159,["163"] = 150,["164"] = 173,["165"] = 174,["166"] = 175,["167"] = 177,["168"] = 177,["169"] = 177,["170"] = 178,["171"] = 179,["173"] = 177,["174"] = 177,["175"] = 173,["177"] = 185,["178"] = 186,["180"] = 188,["181"] = 190,["182"] = 191,["183"] = 191,["184"] = 191,["185"] = 192,["186"] = 193,["187"] = 194,["189"] = 191,["190"] = 191,["192"] = 199,["194"] = 202,["195"] = 203,["196"] = 204,["197"] = 205,["198"] = 206,["199"] = 207,["200"] = 208,["201"] = 209,["202"] = 210,["203"] = 211,["204"] = 212,["205"] = 213,["206"] = 215,["207"] = 216,["208"] = 217,["209"] = 218,["211"] = 220,["212"] = 202,["214"] = 224,["215"] = 225,["216"] = 226,["217"] = 227,["218"] = 228,["221"] = 232,["222"] = 233,["223"] = 234,["224"] = 235,["226"] = 238,["227"] = 239,["228"] = 239,["229"] = 239,["230"] = 239,["231"] = 239,["232"] = 240,["233"] = 240,["234"] = 240,["235"] = 240,["236"] = 240,["237"] = 241,["238"] = 241,["239"] = 241,["240"] = 241,["241"] = 241,["242"] = 242,["243"] = 242,["244"] = 242,["245"] = 242,["246"] = 242,["247"] = 243,["248"] = 243,["249"] = 243,["250"] = 243,["251"] = 243,["252"] = 244,["253"] = 244,["254"] = 244,["255"] = 244,["256"] = 244,["257"] = 246,["258"] = 238,["259"] = 249,["260"] = 250,["261"] = 250,["262"] = 250,["263"] = 251,["264"] = 252,["265"] = 253,["266"] = 254,["267"] = 255,["269"] = 250,["270"] = 250,["271"] = 259,["272"] = 259,["273"] = 259,["274"] = 259,["275"] = 259,["276"] = 263,["277"] = 263,["278"] = 263,["279"] = 264,["280"] = 265,["281"] = 267,["282"] = 268,["283"] = 270,["284"] = 271,["285"] = 273,["286"] = 274,["287"] = 275,["288"] = 276,["289"] = 278,["290"] = 279,["292"] = 282,["293"] = 283,["294"] = 284,["297"] = 263,["298"] = 263,["299"] = 289,["300"] = 289,["301"] = 289,["302"] = 290,["303"] = 291,["304"] = 293,["305"] = 294,["306"] = 296,["308"] = 297,["309"] = 297,["310"] = 298,["311"] = 299,["312"] = 300,["313"] = 301,["316"] = 297,["319"] = 306,["320"] = 307,["323"] = 311,["324"] = 312,["325"] = 312,["326"] = 312,["328"] = 289,["329"] = 289,["330"] = 316,["331"] = 316,["332"] = 316,["333"] = 317,["334"] = 318,["335"] = 320,["336"] = 321,["337"] = 322,["338"] = 323,["339"] = 324,["340"] = 325,["343"] = 316,["344"] = 316,["345"] = 249,["346"] = 331,["347"] = 332,["348"] = 333,["349"] = 334,["350"] = 335,["351"] = 336,["352"] = 337,["353"] = 338,["354"] = 331,["356"] = 342,["357"] = 343,["358"] = 344,["359"] = 345,["360"] = 346,["361"] = 347,["362"] = 348,["363"] = 349,["364"] = 350,["365"] = 351,["366"] = 352,["367"] = 354,["368"] = 355,["369"] = 356,["370"] = 357,["371"] = 358,["372"] = 359,["373"] = 360,["374"] = 361,["375"] = 362,["376"] = 363,["377"] = 364,["378"] = 366,["379"] = 367,["380"] = 368,["381"] = 369,["382"] = 370,["383"] = 371,["384"] = 372,["385"] = 373,["386"] = 375,["387"] = 377,["389"] = 380,["390"] = 381,["391"] = 380,["392"] = 384,["393"] = 385,["394"] = 385,["395"] = 385,["396"] = 385,["397"] = 385,["398"] = 391,["399"] = 384,["400"] = 394,["401"] = 395,["402"] = 397,["403"] = 397,["404"] = 397,["405"] = 398,["406"] = 398,["407"] = 398,["408"] = 399,["409"] = 400,["411"] = 398,["412"] = 398,["413"] = 397,["414"] = 397,["415"] = 405,["416"] = 394,["417"] = 408,["418"] = 409,["419"] = 410,["420"] = 411,["421"] = 413,["422"] = 414,["423"] = 415,["424"] = 415,["425"] = 415,["426"] = 415,["427"] = 415,["428"] = 416,["430"] = 418,["431"] = 419,["432"] = 420,["433"] = 421,["434"] = 422,["435"] = 424,["436"] = 425,["437"] = 426,["439"] = 429,["440"] = 430,["441"] = 431,["442"] = 433,["444"] = 436,["446"] = 408,["447"] = 440,["448"] = 441,["449"] = 440,["450"] = 444,["451"] = 445,["452"] = 446,["453"] = 447,["454"] = 448,["455"] = 449,["456"] = 444,["457"] = 452,["458"] = 453,["459"] = 454,["460"] = 455,["461"] = 457,["462"] = 458,["463"] = 459,["464"] = 461,["465"] = 462,["466"] = 463,["468"] = 452,["469"] = 467,["470"] = 468,["471"] = 469,["472"] = 471,["473"] = 471,["474"] = 471,["475"] = 472,["476"] = 472,["477"] = 472,["478"] = 472,["479"] = 472,["480"] = 472,["481"] = 471,["482"] = 471,["483"] = 475,["484"] = 467,["485"] = 478,["486"] = 479,["487"] = 480,["488"] = 488,["489"] = 489,["490"] = 490,["491"] = 490,["492"] = 490,["493"] = 490,["494"] = 490,["495"] = 490,["496"] = 490,["497"] = 490,["498"] = 491,["500"] = 494,["501"] = 495,["502"] = 496,["503"] = 497,["505"] = 494,["506"] = 501,["507"] = 502,["508"] = 501,["509"] = 505,["510"] = 506,["511"] = 508,["512"] = 513,["513"] = 514,["514"] = 515,["515"] = 516,["516"] = 518,["517"] = 519,["518"] = 520,["520"] = 523,["521"] = 524,["522"] = 529,["523"] = 529,["524"] = 529,["525"] = 530,["526"] = 530,["527"] = 530,["528"] = 531,["529"] = 531,["530"] = 531,["531"] = 531,["532"] = 533,["533"] = 534,["535"] = 537,["536"] = 538,["537"] = 538,["538"] = 538,["539"] = 539,["540"] = 540,["542"] = 543,["545"] = 547,["546"] = 548,["547"] = 549,["548"] = 550,["549"] = 551,["550"] = 552,["554"] = 556,["555"] = 557,["557"] = 559,["558"] = 560,["560"] = 563,["562"] = 566,["563"] = 567,["564"] = 566,["565"] = 570,["566"] = 571,["567"] = 574,["568"] = 575,["569"] = 576,["570"] = 577,["571"] = 578,["573"] = 580,["575"] = 583,["576"] = 584,["577"] = 584,["578"] = 584,["579"] = 585,["580"] = 584,["581"] = 584,["582"] = 588,["583"] = 589,["584"] = 591,["585"] = 592,["586"] = 592,["587"] = 592,["588"] = 593,["589"] = 592,["590"] = 592,["593"] = 623,["594"] = 570,["595"] = 626,["596"] = 627,["597"] = 628,["598"] = 630,["599"] = 634,["600"] = 635,["602"] = 638,["603"] = 639,["604"] = 639,["605"] = 639,["606"] = 639,["607"] = 640,["608"] = 641,["610"] = 644,["611"] = 645,["612"] = 645,["613"] = 645,["614"] = 646,["615"] = 645,["616"] = 645,["617"] = 649,["618"] = 650,["619"] = 652,["620"] = 653,["621"] = 653,["622"] = 653,["623"] = 654,["624"] = 653,["625"] = 653,["628"] = 659,["629"] = 626,["631"] = 664,["632"] = 666,["633"] = 667,["636"] = 671,["637"] = 672,["638"] = 673,["639"] = 674,["640"] = 676,["641"] = 677,["642"] = 678,["643"] = 679,["647"] = 684,["650"] = 688,["651"] = 689,["653"] = 692,["654"] = 693,["655"] = 694,["657"] = 697,["658"] = 698,["660"] = 671,["661"] = 702,["662"] = 703,["663"] = 704,["664"] = 706,["665"] = 707,["666"] = 709,["667"] = 710,["668"] = 711,["669"] = 711,["670"] = 711,["671"] = 712,["672"] = 713,["673"] = 714,["674"] = 715,["677"] = 711,["678"] = 711,["679"] = 720,["680"] = 721,["681"] = 722,["682"] = 723,["686"] = 728,["689"] = 702,["690"] = 733,["691"] = 734,["692"] = 733,["693"] = 737,["694"] = 738,["695"] = 739,["696"] = 740,["698"] = 743,["699"] = 744,["700"] = 745,["701"] = 747,["702"] = 748,["703"] = 749,["704"] = 750,["705"] = 751,["710"] = 757,["711"] = 737,["712"] = 760,["713"] = 761,["714"] = 762,["715"] = 763,["718"] = 766,["720"] = 769,["721"] = 770,["722"] = 771,["724"] = 773,["725"] = 769,["726"] = 776,["727"] = 777,["728"] = 779,["730"] = 783,["731"] = 784,["732"] = 785,["733"] = 786,["735"] = 788,["736"] = 789,["737"] = 790,["741"] = 776,["742"] = 796,["743"] = 796,["744"] = 813,["745"] = 814,["746"] = 815,["747"] = 816,["748"] = 817,["750"] = 813,["751"] = 821,["752"] = 822,["753"] = 823,["754"] = 824,["756"] = 821,["757"] = 828,["758"] = 829,["759"] = 829,["760"] = 829,["761"] = 830,["762"] = 831,["763"] = 831,["764"] = 831,["765"] = 831,["766"] = 832,["768"] = 829,["769"] = 829,["770"] = 828,["771"] = 837,["772"] = 838,["773"] = 838,["774"] = 838,["775"] = 839,["776"] = 840,["777"] = 841,["778"] = 843,["779"] = 844,["780"] = 844,["781"] = 844,["782"] = 844,["783"] = 845,["785"] = 847,["786"] = 848,["787"] = 849,["788"] = 849,["789"] = 849,["790"] = 849,["791"] = 850,["795"] = 838,["796"] = 838,["797"] = 837,["798"] = 857,["799"] = 858,["800"] = 858,["801"] = 858,["802"] = 858,["803"] = 859,["804"] = 860,["806"] = 862,["807"] = 857,["808"] = 865,["809"] = 866,["810"] = 866,["811"] = 866,["812"] = 866,["813"] = 867,["814"] = 868,["816"] = 870,["817"] = 865,["818"] = 873,["819"] = 874,["820"] = 874,["821"] = 874,["822"] = 874,["823"] = 873,["824"] = 877,["825"] = 878,["826"] = 877,["827"] = 881,["828"] = 882,["829"] = 884,["830"] = 885,["832"] = 888,["833"] = 881,["834"] = 891,["835"] = 892,["836"] = 893,["837"] = 894,["838"] = 895,["839"] = 895,["840"] = 895,["841"] = 895,["842"] = 895,["843"] = 895,["844"] = 897,["845"] = 904,["846"] = 905,["847"] = 891,["848"] = 908,["849"] = 909,["850"] = 908,["851"] = 913,["852"] = 913,["853"] = 68,["854"] = 917,["855"] = 917,["856"] = 917,["857"] = 917,["858"] = 922,["859"] = 923});
local ____exports = {}
local ____alliance = require("clases.alliance")
local Alliance = ____alliance.default
local ____game_state = require("clases.game_state")
local CustomGameState = ____game_state.CustomGameState
local ____warmup = require("clases.warmup")
local Warmup = ____warmup.default
local ____tstl_2Dutils = require("lib.tstl-utils")
local reloadable = ____tstl_2Dutils.reloadable
require("wrappers.abilities")
require("wrappers.modifiers")
require("util.custom_abilities")
require("util.custom_entities")
require("util.math")
require("util.util")
require("settings")
require("constructors")
require("abilities_meta")
require("libraries.timers")
require("libraries.projectiles")
require("overrides.abilities")
local ____player = require("clases.player")
local Player = ____player.default
local ____pre_round = require("clases.pre_round")
local PreRound = ____pre_round.default
local ____round = require("clases.round")
local Round = ____round.default
local ____custom_items = require("util.custom_items")
local CustomItems = ____custom_items.CustomItems
local ____pickup = require("clases.pickup")
local Pickup = ____pickup.default
local PickupTypes = ____pickup.PickupTypes
local ____pve_round = require("clases.pve_round")
local PveRound = ____pve_round.default
local ____settings = require("settings")
local settings = ____settings.default
local Custom_MapNames = {PVP = "pvp", PVE = "pve"}
local Custom_ActionTypes = {}
Custom_ActionTypes.MOVEMENT = 0
Custom_ActionTypes[Custom_ActionTypes.MOVEMENT] = "MOVEMENT"
Custom_ActionTypes.ABILITY = 1
Custom_ActionTypes[Custom_ActionTypes.ABILITY] = "ABILITY"
local Custom_ActionModes = {}
Custom_ActionModes.START = 0
Custom_ActionModes[Custom_ActionModes.START] = "START"
Custom_ActionModes.STOP = 1
Custom_ActionModes[Custom_ActionModes.STOP] = "STOP"
local DOTA_ALLIANCE_RADIANT = 1
local DOTA_ALLIANCE_DIRE = 2
local DOTA_ALLIANCE_LEGION = 3
local DOTA_ALLIANCE_VOID = 4
local THINK_PERIOD = 0.01
____exports.GameMode = __TS__Class()
local GameMode = ____exports.GameMode
GameMode.name = "GameMode"
function GameMode.prototype.____constructor(self)
    self.players = {}
    self.state = CustomGameState.NONE
    self.thinkers = {}
    self.wtf = false
    self.units = {}
    self.alliances = {}
    self.max_treshold = 30
    GameRules:GetGameModeEntity():SetContextThink(
        "OnThink",
        function()
            return self:OnThink()
        end,
        THINK_PERIOD
    )
    self:SetupEventHooks()
    self:SetupPanoramaEventHooks()
    self:SetupRules()
    self:LinkModifiers()
    self:SetupFilters()
    local mode = GameRules:GetGameModeEntity()
    mode:SetBuybackEnabled(false)
    mode:SetDaynightCycleDisabled(true)
    mode:SetCameraDistanceOverride(1350)
end
function GameMode.Precache(context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_oracle.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_silencer.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_furion.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_phoenix.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_sven.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_abaddon.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_doombringer.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context)
    PrecacheResource("particle", "particles/units/heroes/hero_chen/chen_hand_of_god.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf", context)
    PrecacheResource("particle", "particles/base_attacks/ranged_badguy_persistent_glow_green.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_wisp/wisp_overcharge_c.vpcf", context)
    PrecacheResource("particle", "models/items/rubick/rubick_arcana/sfm/particles/rubick_arcana_temp_2_rocks_glow.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_omniknight/omniknight_purification_cast_b.vpcf", context)
    PrecacheResource("particle", "particles/items_fx/arcane_boots_recipient.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf", context)
    local heroes = LoadKeyValues("scripts/npc/npc_heroes_custom.txt")
    for key in pairs(heroes) do
        local hero = heroes[key]
        PrecacheUnitByNameSync(hero.override_hero, context)
    end
end
function GameMode.Activate()
    GameRules.Addon = __TS__New(____exports.GameMode)
end
function GameMode.prototype.Start(self)
    __TS__ArrayPush(
        self.alliances,
        __TS__New(Alliance, DOTA_ALLIANCE_RADIANT, {DOTA_TEAM_GOODGUYS, DOTA_TEAM_BADGUYS})
    )
    __TS__ArrayPush(
        self.alliances,
        __TS__New(Alliance, DOTA_ALLIANCE_DIRE, {DOTA_TEAM_CUSTOM_1, DOTA_TEAM_CUSTOM_2, DOTA_TEAM_NEUTRALS})
    )
    __TS__ArrayPush(
        self.alliances,
        __TS__New(Alliance, DOTA_ALLIANCE_LEGION, {DOTA_TEAM_CUSTOM_3, DOTA_TEAM_CUSTOM_4})
    )
    __TS__ArrayPush(
        self.alliances,
        __TS__New(Alliance, DOTA_ALLIANCE_VOID, {DOTA_TEAM_CUSTOM_5, DOTA_TEAM_CUSTOM_6})
    )
    if GetMapName() == Custom_MapNames.PVP then
        self:StartPVPMap()
    elseif GetMapName() == Custom_MapNames.PVE then
        self:StartPVEMap()
    end
    self:RegisterThinker(
        0.01,
        function(self)
            CustomGameEventManager:Send_ServerToAllClients("get_mouse_position", {})
        end
    )
end
function GameMode.prototype.StartPVPMap(self)
    self:CreateBarrels()
    self:SetState(CustomGameState.WARMUP_IN_PROGRESS)
    self.warmup = __TS__New(Warmup, self.alliances, settings.FirstWarmupDuration)
    local tableName = "main"
    local data = {max_score = settings.RoundsDifferenceToWin}
    CustomNetTables:SetTableValue(tableName, "maxScore", data)
    self:RegisterThinker(
        0.01,
        function()
            if (self.state == CustomGameState.WARMUP_IN_PROGRESS) and self.warmup then
                self.warmup:Update()
            end
            if (self.state == CustomGameState.PRE_ROUND) and self.pre_round then
                self.pre_round:Update()
            end
            if (self.state == CustomGameState.ROUND_IN_PROGRESS) and self.round then
                self.round:Update()
            end
        end
    )
end
function GameMode.prototype.StartPVEMap(self)
    self:SetState(CustomGameState.PVE_ROUND_IN_PROGRESS)
    self.pve_round = __TS__New(PveRound, self.alliances, -1)
    self:RegisterThinker(
        0.01,
        function()
            if (self.state == CustomGameState.PVE_ROUND_IN_PROGRESS) and self.pve_round then
                self.pve_round:Update()
            end
        end
    )
end
function GameMode.prototype.OnThink(self)
    if GameRules:IsGamePaused() then
        return THINK_PERIOD
    end
    local now = Time()
    if GameRules:State_Get() >= DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
        __TS__ArrayForEach(
            self.thinkers,
            function(____, thinker)
                if now >= thinker.next then
                    thinker.next = math.max(thinker.next + thinker.period, now)
                    thinker:callback()
                end
            end
        )
    end
    return THINK_PERIOD
end
function GameMode.prototype.SetupRules(self)
    GameRules:SetSameHeroSelectionEnabled(true)
    GameRules:SetPreGameTime(0)
    GameRules:SetGoldPerTick(0)
    GameRules:SetGoldTickTime(0)
    GameRules:SetStartingGold(0)
    GameRules:SetCustomGameSetupAutoLaunchDelay(10)
    GameRules:SetStrategyTime(0)
    GameRules:SetShowcaseTime(0)
    GameRules:SetUseBaseGoldBountyOnHeroes(false)
    GameRules:GetGameModeEntity():SetLoseGoldOnDeath(false)
    GameRules:SetTimeOfDay(0.5)
    if GetMapName() == Custom_MapNames.PVP then
        self:SetupRulesPVP()
    elseif GetMapName() == Custom_MapNames.PVE then
        self:SetupRulesPVE()
    end
    print("[AMETHYST] GameRules set")
end
function GameMode.prototype.SetupRulesPVP(self)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_GOODGUYS, 1)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, 1)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_1, 1)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_2, 1)
    GameRules:SetHeroRespawnEnabled(false)
end
function GameMode.prototype.SetupRulesPVE(self)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_GOODGUYS, 2)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, 2)
    GameRules:SetHeroRespawnEnabled(true)
    GameRules:GetGameModeEntity():SetFixedRespawnTime(5)
end
function GameMode.prototype.SetupEventHooks(self)
    ListenToGameEvent(
        "npc_spawned",
        function(event) return self:OnHeroInGame(event) end,
        nil
    )
    ListenToGameEvent(
        "game_rules_state_change",
        function() return self:OnGameRulesStateChange() end,
        nil
    )
    ListenToGameEvent(
        "dota_player_learned_ability",
        function(event) return self:OnLearnedAbilityEvent(event) end,
        nil
    )
    ListenToGameEvent(
        "player_chat",
        function(event) return self:OnPlayerChat(event) end,
        nil
    )
    ListenToGameEvent(
        "entity_killed",
        function(event) return self:OnEntityKilled(event) end,
        nil
    )
    ListenToGameEvent(
        "entity_hurt",
        function(event) return self:OnEntityHurt(event) end,
        nil
    )
    print("[AMETHYST] Event hooks set")
end
function GameMode.prototype.SetupPanoramaEventHooks(self)
    CustomGameEventManager:RegisterListener(
        "update_mouse_position",
        function(eventSourceIndex, args)
            local position = Vector(args.x, args.y, args.z)
            local playerId = args.playerId
            local player = self:FindPlayerById(playerId)
            if player then
                player:UpdateCursorPosition(position)
            end
        end
    )
    CustomGameEventManager:RegisterListener(
        "key_released",
        function(eventSourceIndex, args)
        end
    )
    CustomGameEventManager:RegisterListener(
        "custom_action",
        function(eventSourceIndex, event)
            local playerId = event.playerIndex
            local player = self:FindPlayerById(playerId)
            if player then
                local hero = player.hero
                local ____type = event.payload.type
                local mode = event.payload.mode
                if (____type == Custom_ActionTypes.MOVEMENT) and hero then
                    local currentDirection = CustomEntities:GetRawDirection(hero)
                    local incomingDirection = event.payload.direction
                    local vector = Vector(incomingDirection["0"], incomingDirection["1"], 0)
                    if mode == Custom_ActionModes.STOP then
                        vector = vector:__mul(-1)
                    end
                    local newDirection = currentDirection:__add(vector)
                    newDirection.z = hero:GetForwardVector().z
                    CustomEntities:SetDirection(hero, newDirection.x, newDirection.y)
                end
            end
        end
    )
    CustomGameEventManager:RegisterListener(
        "refund_points",
        function(eventSourceIndex, event)
            local playerId = event.playerIndex
            local player = self:FindPlayerById(playerId)
            if player then
                local hero = player.hero
                if hero then
                    do
                        local i = 0
                        while i <= 23 do
                            local ability = hero:GetAbilityByIndex(i)
                            if ability then
                                if ability:GetAbilityType() ~= 2 then
                                    ability:SetLevel(1)
                                end
                            end
                            i = i + 1
                        end
                    end
                    hero:SetAbilityPoints(settings.AbilityPoints)
                    CustomEntities:SendDataToClient(hero)
                end
            end
            if self.warmup then
                self.warmup:SetDuration(
                    self.warmup:GetDuration() + 10
                )
            end
        end
    )
    CustomGameEventManager:RegisterListener(
        "swap_r_f",
        function(eventSourceIndex, event)
            local playerId = event.playerIndex
            local player = self:FindPlayerById(playerId)
            if player then
                local hero = player.hero
                if hero then
                    local ability_name_one = hero:GetAbilityByIndex(5):GetName()
                    local ability_name_two = hero:GetAbilityByIndex(6):GetName()
                    hero:SwapAbilities(ability_name_one, ability_name_two, true, true)
                end
            end
        end
    )
end
function GameMode.prototype.SetupFilters(self)
    local mode = GameRules:GetGameModeEntity()
    mode:SetModifyGoldFilter(self.ModifyGoldFilter, self)
    mode:SetExecuteOrderFilter(self.ExecuteOrderFilter, self)
    mode:SetModifyExperienceFilter(self.ModifyExperienceFilter, self)
    mode:SetHealingFilter(self.HealingFilter, self)
    mode:SetDamageFilter(self.DamageFilter, self)
    print("[AMETHYST] Filters set")
end
function GameMode.prototype.LinkModifiers(self)
    LinkLuaModifier("modifier_death_zone", "modifiers/modifier_death_zone.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("wall_base", "modifiers/wall_base.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_adrenaline", "modifiers/modifier_adrenaline.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("radius_marker_thinker", "modifiers/radius_marker_thinker.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_ruby", "modifiers/modifier_ruby.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_ruby_attack", "modifiers/modifier_ruby.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_sapphire", "modifiers/modifier_sapphire.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_emerald", "modifiers/modifier_emerald.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_amethyst", "modifiers/modifier_amethyst.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_miss", "modifiers/modifier_miss.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_restricted", "modifiers/modifier_restricted.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_silence", "abilities/generic/modifier_generic_silence", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_fading_slow", "abilities/generic/modifier_generic_fading_slow", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_fading_haste", "abilities/generic/modifier_generic_fading_haste", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_stunned", "abilities/generic/modifier_generic_stunned", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_provides_vision", "abilities/generic/modifier_generic_provides_vision", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_knockback", "abilities/generic/modifier_generic_knockback", LUA_MODIFIER_MOTION_BOTH)
    LinkLuaModifier("modifier_generic_root", "abilities/generic/modifier_generic_root", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_invencible", "abilities/generic/modifier_generic_invencible", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_confuse", "abilities/generic/modifier_generic_confuse", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_sleep", "abilities/generic/modifier_generic_sleep", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_fear", "abilities/generic/modifier_generic_fear", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_visible", "abilities/base/modifier_visible", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_casting", "abilities/base/modifier_casting", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_damage_fx", "abilities/base/modifier_damage_fx", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hero_base", "abilities/base/modifier_hero_base", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_shield", "abilities/base/modifier_shield", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hide_bar", "abilities/base/modifier_hide_bar", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hidden", "abilities/base/modifier_hidden", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_banish", "abilities/base/modifier_banish", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_mount", "abilities/heroes/common/mount/modifier_mount.lua", LUA_MODIFIER_MOTION_NONE)
    print("[AMETHYST] Useful modifiers linked")
end
function GameMode.prototype.IsInWTFMode(self)
    return self.wtf
end
function GameMode.prototype.RegisterThinker(self, period, callback)
    local thinker = {
        period = period,
        callback = callback,
        next = Time() + period
    }
    __TS__ArrayPush(self.thinkers, thinker)
end
function GameMode.prototype.FindAllianceByTeam(self, team)
    local found = nil
    __TS__ArrayForEach(
        self.alliances,
        function(____, alliance)
            __TS__ArrayForEach(
                alliance.teams,
                function(____, allianceTeam)
                    if allianceTeam == team then
                        found = alliance
                    end
                end
            )
        end
    )
    return found
end
function GameMode.prototype.RegisterPlayer(self, hero)
    local team = hero:GetTeamNumber()
    local playerID = hero:GetPlayerOwnerID()
    local userID = playerID + 1
    if playerID == -1 then
        hero:Destroy()
        print(
            (((("ERROR: TRYING TO CREATE AN UNIT ON AN INVALID PLAYER: \n\t playerID: " .. tostring(playerID)) .. "\n\t hero: ") .. tostring(
                hero:GetName()
            )) .. "\n\t team: ") .. tostring(team)
        )
        return false
    else
        local player = self:FindPlayerById(playerID)
        if not player then
            player = __TS__New(Player, playerID, userID)
            __TS__ArrayPush(self.players, player)
            local alliance = self:FindAllianceByTeam(team)
            if not alliance then
                print("ERROR: THE PLAYER TEAM IS NOT PART OF ANY ALLIANCE!")
                return false
            end
            player:SetTeam(team)
            player:SetAlliance(alliance)
            player:SetHero(hero)
            alliance:AddPlayer(player)
        end
        return true
    end
end
function GameMode.prototype.RegisterUnit(self, unit)
    __TS__ArrayPush(self.units, unit)
end
function GameMode.prototype.SetState(self, state)
    self:OnStateEnd(self.state)
    self.state = state
    local tableName = "main"
    local data = {gameState = state}
    CustomNetTables:SetTableValue(tableName, "gameState", data)
end
function GameMode.prototype.OnStateEnd(self, state)
    if state == CustomGameState.ROUND_IN_PROGRESS then
        self.round = nil
        self.warmup = __TS__New(Warmup, self.alliances, settings.WarmupDuration)
    elseif state == CustomGameState.WARMUP_IN_PROGRESS then
        self.warmup = nil
        self.pre_round = __TS__New(PreRound, self.alliances, settings.PreRoundDuration)
    elseif state == CustomGameState.PRE_ROUND then
        self.pre_round = nil
        self.round = __TS__New(Round, self.alliances, settings.RoundDuration)
    end
end
function GameMode.prototype.CreateBarrels(self)
    local barrelEnts = Entities:FindAllByName("wall_spawn")
    local barrels = {}
    __TS__ArrayForEach(
        barrelEnts,
        function(____, entity)
            __TS__ArrayPush(
                barrels,
                self:CreateBarrel(
                    entity:GetAbsOrigin()
                )
            )
        end
    )
    return barrels
end
function GameMode.prototype.CreateBarrel(self, origin)
    local fowBlocker = SpawnEntityFromTableSynchronous("point_simple_obstruction", {origin = origin, block_fow = true})
    local barrel = CreateUnitByName("npc_dota_creature_wall", origin, false, nil, nil, DOTA_TEAM_NOTEAM)
    barrel:Attribute_SetIntValue("barrel", 1)
    barrel:SetHullRadius(65)
    barrel:AddNewModifier(
        barrel,
        nil,
        "wall_base",
        {
            fow_blocker = fowBlocker:GetEntityIndex()
        }
    )
    return barrel
end
function GameMode.prototype.OnPickedUp(self, item)
    local parent = CustomItems:GetInstance():GetParent(item)
    if parent then
        parent:OnPickedUp()
    end
end
function GameMode.prototype.ModifyExperienceFilter(self)
    return false
end
function GameMode.prototype.ExecuteOrderFilter(self, event)
    local orderType = event.order_type
    if (((orderType == DOTA_UNIT_ORDER_CAST_POSITION) or (orderType == DOTA_UNIT_ORDER_CAST_TARGET)) or (orderType == DOTA_UNIT_ORDER_CAST_TARGET_TREE)) or (orderType == DOTA_UNIT_ORDER_CAST_NO_TARGET) then
        local ability = EntIndexToHScript(event.entindex_ability)
        local caster = EntIndexToHScript(event.units["0"])
        local energyCost = CustomAbilities:GetEnergyCost(ability)
        local energy = CustomEntities:GetEnergy(caster)
        if energyCost > energy then
            CustomGameEventManager:Send_ServerToAllClients("not_enough_energy", {})
            return false
        end
        if orderType == DOTA_UNIT_ORDER_CAST_POSITION then
            local point = Vector(event.position_x, event.position_y, event.position_z)
            local current_range = point:__sub(
                caster:GetAbsOrigin()
            ):Length2D()
            local direction = point:__sub(
                caster:GetAbsOrigin()
            ):Normalized()
            local max_range = ability:GetCastRange(
                Vector(0, 0, 0),
                nil
            )
            if not CustomAbilities:HasBehavior(ability, DOTA_ABILITY_BEHAVIOR_IMMEDIATE) then
                CustomEntities:FullyFaceTowards(caster, direction)
            end
            if current_range > max_range then
                local new_point = caster:GetAbsOrigin():__add(
                    direction:__mul(max_range - 10)
                )
                event.position_x = new_point.x
                event.position_y = new_point.y
            end
            return true
        end
    end
    if (orderType == DOTA_UNIT_ORDER_STOP) or (orderType == DOTA_UNIT_ORDER_HOLD_POSITION) then
        local caster = EntIndexToHScript(event.units["0"])
        local ability = caster:GetCurrentActiveAbility()
        if ability then
            if ability:GetAbilityType() == 1 then
                return false
            end
        end
    end
    if orderType == DOTA_UNIT_ORDER_HOLD_POSITION then
        print("YOU ARE HOLDING POSITION; PROBABLY YOU WANT TO STOP INSTEAD")
    end
    if (orderType == DOTA_UNIT_ORDER_MOVE_TO_POSITION) or (orderType == DOTA_UNIT_ORDER_MOVE_TO_TARGET) then
        return false
    end
    return true
end
function GameMode.prototype.ModifyGoldFilter(self)
    return false
end
function GameMode.prototype.HealingFilter(self, event)
    local target = EntIndexToHScript(event.entindex_target_const)
    if target:IsRealHero() then
        local new_treshold = CustomEntities:GetTreshold(target) + event.heal
        if new_treshold > self.max_treshold then
            event.heal = self.max_treshold - CustomEntities:GetTreshold(target)
            CustomEntities:SetTreshold(target, self.max_treshold)
        else
            CustomEntities:SetTreshold(target, new_treshold)
        end
        SendOverheadHealMessage(target, event.heal)
        Timers:CreateTimer(
            0.05,
            function()
                CustomEntities:SendDataToClient(target)
            end
        )
        local healing_team = target:GetTeam()
        local healing_alliance = self:FindAllianceByTeam(healing_team)
        if healing_alliance then
            Timers:CreateTimer(
                0.05,
                function()
                    healing_alliance:SendDataToClient()
                end
            )
        end
    end
    return true
end
function GameMode.prototype.DamageFilter(self, event)
    local attacker = EntIndexToHScript(event.entindex_attacker_const)
    local victim = EntIndexToHScript(event.entindex_victim_const)
    local damage_after_reductions = math.floor(event.damage)
    if (attacker and attacker:IsNull()) or (victim and victim:IsNull()) then
        return false
    end
    if victim and victim:IsRealHero() then
        CustomEntities:SetTreshold(
            victim,
            CustomEntities:GetTreshold(victim) - damage_after_reductions
        )
        if CustomEntities:GetTreshold(victim) < 0 then
            CustomEntities:SetTreshold(victim, 0)
        end
        victim:AddNewModifier(victim, nil, "modifier_damage_fx", {duration = 0.1})
        Timers:CreateTimer(
            0.05,
            function()
                CustomEntities:SendDataToClient(victim)
            end
        )
        local victim_team = victim:GetTeam()
        local victim_alliance = self:FindAllianceByTeam(victim_team)
        if victim_alliance then
            Timers:CreateTimer(
                0.05,
                function()
                    victim_alliance:SendDataToClient()
                end
            )
        end
    end
    return true
end
function GameMode.prototype.OnGameRulesStateChange(self)
    local state = GameRules:State_Get()
    if state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        self:OnGameInProgress()
    end
end
function GameMode.prototype.OnPlayerChat(self, event)
    if event.text == "-unstuck" then
        local playerId = event.playerid
        local player = self:FindPlayerById(playerId)
        if player then
            local hero = player.hero
            if hero then
                CustomEntities:SetDirection(hero, 0, 0)
            end
        end
    end
    if (not GameRules:IsCheatMode()) and (not IsInToolsMode()) then
        return
    end
    if event.text == "-refresh" then
        self:RefreshHeroes()
    end
    if event.text == "-wtf" then
        self:RefreshHeroes()
        self.wtf = true
    end
    if event.text == "-unwtf" then
        self.wtf = false
    end
end
function GameMode.prototype.OnLearnedAbilityEvent(self, event)
    local playerId = event.PlayerID
    local player = self:FindPlayerById(playerId)
    if player then
        local hero = player.hero
        if hero then
            local ready = true
            __TS__ArrayForEach(
                self.players,
                function(____, _player)
                    local _hero = _player.hero
                    if _hero then
                        if _hero:GetAbilityPoints() > 0 then
                            ready = false
                        end
                    end
                end
            )
            if ready then
                if self.warmup then
                    if self.warmup:GetDuration() > 3 then
                        self.warmup:SetDuration(3)
                    end
                end
            end
            CustomEntities:SendDataToClient(hero)
        end
    end
end
function GameMode.prototype.OnGameInProgress(self)
    self:Start()
end
function GameMode.prototype.OnHeroInGame(self, event)
    local npc = EntIndexToHScript(event.entindex)
    if (npc == nil) or npc:IsNull() then
        return false
    end
    if not CustomEntities:IsInitialized(npc) then
        if not (npc:GetName() == "npc_dota_thinker") then
            CustomEntities:Initialize(npc)
            if npc:IsRealHero() then
                if GetMapName() == Custom_MapNames.PVP then
                    return self:OnHeroInGamePVP(npc)
                elseif GetMapName() == Custom_MapNames.PVE then
                    return self:OnHeroInGamePVE(npc)
                end
            end
        end
    end
    return true
end
function GameMode.prototype.OnHeroInGamePVE(self, hero)
    if hero:GetTeamNumber() ~= DOTA_TEAM_CUSTOM_1 then
        if not self:RegisterPlayer(hero) then
            return false
        end
    end
    return true
end
function GameMode.prototype.OnHeroInGamePVP(self, hero)
    if not self:RegisterPlayer(hero) then
        return false
    end
    return true
end
function GameMode.prototype.OnEntityKilled(self, event)
    local killed = EntIndexToHScript(event.entindex_killed)
    if GetMapName() == Custom_MapNames.PVE then
    end
    local parent = CustomEntities:GetParent(killed)
    if parent then
        local killer = EntIndexToHScript(event.entindex_attacker)
        parent:OnDeath({killer = killer})
    else
        if killed:IsRealHero() then
            if GetMapName() == Custom_MapNames.PVP then
                self:OnEntityKilledPVP(killed)
            end
        end
    end
end
function GameMode.prototype.OnEntityKilledPVE(self, killed)
end
function GameMode.prototype.OnEntityKilledPVP(self, killed)
    if self.round then
        self.round.hero_died = true
        self:CreateDeathOrb(killed)
        self:UpdateCameras()
    end
end
function GameMode.prototype.OnEntityHurt(self, event)
    if (event.entindex_attacker ~= nil) and (event.entindex_killed ~= nil) then
        local victim = EntIndexToHScript(event.entindex_killed)
        SendOverheadDamageMessage(victim, event.damage)
    end
end
function GameMode.prototype.RefreshHeroes(self)
    __TS__ArrayForEach(
        self.players,
        function(____, player)
            if (player.hero and (not player.hero:IsNull())) and player.hero:IsAlive() then
                CustomEntities:GiveEnergy(
                    player.hero,
                    CustomEntities:GetMaxEnergy(player.hero)
                )
                CustomEntities:SendDataToClient(player.hero)
            end
        end
    )
end
function GameMode.prototype.UpdateCameras(self)
    __TS__ArrayForEach(
        self.players,
        function(____, player)
            local hero = player.hero
            if (hero and (not hero:IsAlive())) and player.alliance then
                local aliveAlly = self:FindNextAliveAlly(player.alliance)
                if aliveAlly then
                    PlayerResource:SetCameraTarget(
                        hero:GetPlayerID(),
                        aliveAlly
                    )
                    aliveAlly:AddNewModifier(hero, nil, "modifier_generic_provides_vision", {})
                else
                    local aliveHero = self:FindNextAliveHero()
                    if aliveHero then
                        PlayerResource:SetCameraTarget(
                            hero:GetPlayerID(),
                            aliveHero
                        )
                        aliveHero:AddNewModifier(hero, nil, "modifier_generic_provides_vision", {})
                    end
                end
            end
        end
    )
end
function GameMode.prototype.FindNextAliveAlly(self, alliance)
    local player = __TS__ArrayFilter(
        alliance.players,
        function(____, _player) return _player.hero and _player.hero:IsAlive() end
    )[1]
    if player then
        return player.hero
    end
    return nil
end
function GameMode.prototype.FindNextAliveHero(self)
    local player = __TS__ArrayFilter(
        self.players,
        function(____, player) return player.hero and player.hero:IsAlive() end
    )[1]
    if player then
        return player.hero
    end
    return nil
end
function GameMode.prototype.FindPlayerById(self, playerId)
    return __TS__ArrayFilter(
        self.players,
        function(____, player) return player:GetId() == playerId end
    )[1]
end
function GameMode.prototype.SetRespawnTime(self, team, victim, time)
    victim:SetTimeUntilRespawn(time)
end
function GameMode.prototype.GetCursorPositionForPlayer(self, playerId)
    local player = self:FindPlayerById(playerId)
    if player then
        return player:GetCursorPosition()
    end
    return Vector(0, 0)
end
function GameMode.prototype.CreateDeathOrb(self, hero)
    local current_mana = hero:GetMana()
    local origin = hero:GetAbsOrigin()
    local mana_given = NearestValue({25, 50, 75, 100}, current_mana)
    local entity = __TS__New(
        Pickup,
        PickupTypes.DEATH,
        hero:GetOrigin(),
        (mana_given / 100) + 0.25
    )
    __TS__ArrayPush(self.round.pickupWrappers, {origin = origin, type = PickupTypes.DEATH, timer = -1, entity = entity})
    entity:GetItem():SetCurrentCharges(mana_given)
    entity:GetItem():SetPurchaser(hero)
end
function GameMode.prototype.EndGame(self, victoryTeam)
    GameRules:SetGameWinner(victoryTeam)
end
function GameMode.prototype.Reload(self)
end
____exports.GameMode = __TS__Decorate({reloadable}, ____exports.GameMode)
__TS__ObjectAssign(
    getfenv(),
    {Activate = ____exports.GameMode.Activate, Precache = ____exports.GameMode.Precache}
)
if GameRules.Addon then
    GameRules.Addon:Reload()
end
return ____exports
