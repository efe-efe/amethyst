--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 19,["30"] = 19,["31"] = 20,["32"] = 20,["33"] = 21,["34"] = 21,["35"] = 22,["36"] = 22,["37"] = 22,["38"] = 23,["39"] = 23,["40"] = 23,["41"] = 24,["42"] = 24,["43"] = 25,["44"] = 25,["45"] = 47,["46"] = 52,["47"] = 52,["48"] = 52,["49"] = 52,["50"] = 52,["51"] = 57,["52"] = 57,["53"] = 57,["54"] = 57,["55"] = 57,["56"] = 62,["57"] = 63,["58"] = 64,["59"] = 65,["60"] = 67,["62"] = 70,["65"] = 71,["66"] = 72,["67"] = 73,["68"] = 74,["69"] = 75,["70"] = 76,["71"] = 78,["72"] = 81,["73"] = 85,["74"] = 86,["75"] = 89,["76"] = 89,["77"] = 89,["78"] = 89,["79"] = 89,["80"] = 89,["81"] = 89,["82"] = 91,["83"] = 92,["84"] = 93,["85"] = 94,["86"] = 95,["87"] = 97,["88"] = 98,["89"] = 99,["90"] = 100,["91"] = 88,["92"] = 104,["93"] = 105,["94"] = 106,["95"] = 107,["96"] = 108,["97"] = 109,["98"] = 110,["99"] = 111,["100"] = 112,["101"] = 113,["102"] = 114,["103"] = 116,["104"] = 117,["105"] = 118,["106"] = 119,["107"] = 120,["108"] = 121,["109"] = 123,["110"] = 124,["111"] = 125,["112"] = 127,["113"] = 128,["114"] = 129,["115"] = 130,["117"] = 104,["118"] = 134,["119"] = 135,["120"] = 134,["123"] = 139,["124"] = 139,["127"] = 140,["128"] = 140,["131"] = 141,["132"] = 141,["135"] = 142,["136"] = 142,["138"] = 144,["139"] = 145,["140"] = 146,["141"] = 147,["143"] = 150,["144"] = 150,["145"] = 150,["146"] = 151,["147"] = 152,["148"] = 152,["149"] = 152,["150"] = 153,["151"] = 152,["152"] = 152,["153"] = 150,["154"] = 150,["156"] = 158,["157"] = 159,["158"] = 160,["159"] = 161,["160"] = 163,["161"] = 164,["162"] = 165,["163"] = 167,["164"] = 167,["165"] = 167,["166"] = 168,["167"] = 169,["169"] = 171,["170"] = 172,["172"] = 175,["173"] = 176,["175"] = 167,["176"] = 167,["177"] = 158,["178"] = 181,["179"] = 182,["180"] = 183,["181"] = 202,["182"] = 204,["183"] = 204,["184"] = 204,["185"] = 205,["186"] = 206,["188"] = 208,["189"] = 209,["191"] = 204,["192"] = 204,["193"] = 181,["195"] = 215,["196"] = 216,["198"] = 218,["199"] = 220,["200"] = 221,["201"] = 221,["202"] = 221,["203"] = 222,["204"] = 223,["205"] = 224,["207"] = 221,["208"] = 221,["210"] = 229,["212"] = 232,["213"] = 233,["214"] = 234,["215"] = 235,["216"] = 236,["217"] = 237,["218"] = 238,["219"] = 239,["220"] = 240,["221"] = 241,["222"] = 242,["223"] = 243,["224"] = 245,["225"] = 246,["226"] = 247,["227"] = 248,["229"] = 250,["230"] = 232,["232"] = 254,["233"] = 255,["234"] = 256,["235"] = 257,["236"] = 258,["239"] = 262,["240"] = 263,["241"] = 264,["242"] = 265,["244"] = 268,["245"] = 269,["246"] = 269,["247"] = 269,["248"] = 269,["249"] = 269,["250"] = 270,["251"] = 270,["252"] = 270,["253"] = 270,["254"] = 270,["255"] = 271,["256"] = 271,["257"] = 271,["258"] = 271,["259"] = 271,["260"] = 272,["261"] = 272,["262"] = 272,["263"] = 272,["264"] = 272,["265"] = 273,["266"] = 273,["267"] = 273,["268"] = 273,["269"] = 273,["270"] = 274,["271"] = 274,["272"] = 274,["273"] = 274,["274"] = 274,["275"] = 276,["276"] = 268,["277"] = 279,["278"] = 280,["279"] = 280,["280"] = 280,["281"] = 281,["282"] = 282,["283"] = 283,["284"] = 284,["285"] = 285,["287"] = 280,["288"] = 280,["289"] = 289,["290"] = 289,["291"] = 289,["292"] = 289,["293"] = 289,["294"] = 293,["295"] = 293,["296"] = 293,["297"] = 294,["298"] = 295,["299"] = 297,["300"] = 298,["301"] = 300,["302"] = 301,["303"] = 303,["304"] = 304,["305"] = 305,["306"] = 306,["307"] = 308,["308"] = 309,["310"] = 312,["311"] = 313,["312"] = 314,["315"] = 293,["316"] = 293,["317"] = 319,["318"] = 319,["319"] = 319,["320"] = 320,["321"] = 321,["322"] = 323,["323"] = 324,["324"] = 326,["326"] = 327,["327"] = 327,["328"] = 328,["329"] = 329,["330"] = 330,["331"] = 331,["334"] = 327,["337"] = 336,["338"] = 337,["341"] = 341,["342"] = 342,["343"] = 342,["344"] = 342,["346"] = 319,["347"] = 319,["348"] = 346,["349"] = 346,["350"] = 346,["351"] = 347,["352"] = 348,["353"] = 350,["354"] = 351,["355"] = 352,["356"] = 353,["357"] = 354,["358"] = 355,["361"] = 346,["362"] = 346,["363"] = 279,["364"] = 361,["365"] = 362,["366"] = 363,["367"] = 364,["368"] = 365,["369"] = 366,["370"] = 367,["371"] = 368,["372"] = 361,["374"] = 372,["375"] = 373,["376"] = 374,["377"] = 375,["378"] = 376,["379"] = 377,["380"] = 378,["381"] = 379,["382"] = 380,["383"] = 381,["384"] = 382,["385"] = 384,["386"] = 385,["387"] = 386,["388"] = 387,["389"] = 388,["390"] = 389,["391"] = 390,["392"] = 391,["393"] = 392,["394"] = 393,["395"] = 394,["396"] = 396,["397"] = 397,["398"] = 398,["399"] = 399,["400"] = 400,["401"] = 401,["402"] = 402,["403"] = 403,["404"] = 404,["405"] = 406,["406"] = 408,["408"] = 411,["409"] = 412,["410"] = 411,["411"] = 415,["412"] = 416,["413"] = 416,["414"] = 416,["415"] = 416,["416"] = 416,["417"] = 422,["418"] = 415,["419"] = 425,["420"] = 426,["421"] = 428,["422"] = 428,["423"] = 428,["424"] = 429,["425"] = 429,["426"] = 429,["427"] = 430,["428"] = 431,["430"] = 429,["431"] = 429,["432"] = 428,["433"] = 428,["434"] = 436,["435"] = 425,["436"] = 439,["437"] = 440,["438"] = 441,["439"] = 442,["440"] = 444,["441"] = 445,["442"] = 446,["443"] = 446,["444"] = 446,["445"] = 446,["446"] = 446,["447"] = 447,["449"] = 449,["450"] = 450,["451"] = 451,["452"] = 452,["453"] = 453,["454"] = 455,["455"] = 456,["456"] = 457,["458"] = 460,["459"] = 461,["460"] = 462,["461"] = 464,["463"] = 467,["465"] = 439,["466"] = 471,["467"] = 472,["468"] = 471,["469"] = 475,["470"] = 476,["471"] = 477,["472"] = 478,["473"] = 479,["474"] = 480,["475"] = 475,["476"] = 483,["477"] = 484,["478"] = 485,["479"] = 486,["480"] = 488,["481"] = 489,["482"] = 490,["483"] = 492,["484"] = 493,["485"] = 494,["486"] = 496,["487"] = 497,["488"] = 498,["489"] = 500,["490"] = 501,["491"] = 502,["493"] = 504,["495"] = 507,["496"] = 508,["497"] = 509,["499"] = 483,["500"] = 513,["501"] = 514,["502"] = 515,["503"] = 517,["504"] = 517,["505"] = 517,["506"] = 518,["507"] = 518,["508"] = 518,["509"] = 518,["510"] = 518,["511"] = 518,["512"] = 517,["513"] = 517,["514"] = 521,["515"] = 513,["516"] = 524,["517"] = 525,["518"] = 526,["519"] = 534,["520"] = 535,["521"] = 536,["522"] = 536,["523"] = 536,["524"] = 536,["525"] = 536,["526"] = 536,["527"] = 536,["528"] = 536,["529"] = 537,["531"] = 540,["532"] = 541,["533"] = 542,["534"] = 543,["536"] = 540,["537"] = 547,["538"] = 548,["539"] = 547,["540"] = 551,["541"] = 552,["542"] = 554,["543"] = 559,["544"] = 560,["545"] = 561,["546"] = 562,["547"] = 564,["548"] = 565,["549"] = 566,["551"] = 569,["552"] = 570,["553"] = 575,["554"] = 575,["555"] = 575,["556"] = 576,["557"] = 576,["558"] = 576,["559"] = 577,["560"] = 577,["561"] = 577,["562"] = 577,["563"] = 579,["564"] = 580,["566"] = 583,["567"] = 584,["568"] = 584,["569"] = 584,["570"] = 585,["571"] = 586,["573"] = 589,["576"] = 593,["577"] = 594,["578"] = 595,["579"] = 596,["580"] = 597,["581"] = 598,["585"] = 602,["586"] = 603,["588"] = 605,["589"] = 606,["591"] = 609,["593"] = 612,["594"] = 613,["595"] = 612,["596"] = 616,["597"] = 617,["598"] = 620,["599"] = 621,["600"] = 622,["601"] = 623,["602"] = 624,["604"] = 626,["606"] = 629,["607"] = 630,["608"] = 630,["609"] = 630,["610"] = 631,["611"] = 630,["612"] = 630,["613"] = 634,["614"] = 635,["615"] = 637,["616"] = 638,["617"] = 638,["618"] = 638,["619"] = 639,["620"] = 638,["621"] = 638,["624"] = 669,["625"] = 616,["626"] = 672,["627"] = 673,["628"] = 674,["629"] = 676,["630"] = 680,["631"] = 681,["633"] = 684,["634"] = 685,["635"] = 685,["636"] = 685,["637"] = 685,["638"] = 686,["639"] = 687,["641"] = 690,["642"] = 691,["643"] = 691,["644"] = 691,["645"] = 692,["646"] = 691,["647"] = 691,["648"] = 695,["649"] = 696,["650"] = 698,["651"] = 699,["652"] = 699,["653"] = 699,["654"] = 700,["655"] = 699,["656"] = 699,["659"] = 705,["660"] = 672,["662"] = 710,["663"] = 712,["664"] = 713,["667"] = 717,["668"] = 718,["669"] = 719,["670"] = 720,["671"] = 722,["672"] = 723,["673"] = 724,["674"] = 725,["678"] = 730,["681"] = 734,["682"] = 735,["684"] = 738,["685"] = 739,["686"] = 740,["688"] = 743,["689"] = 744,["691"] = 747,["692"] = 748,["693"] = 749,["694"] = 750,["695"] = 750,["696"] = 750,["697"] = 751,["698"] = 752,["700"] = 750,["701"] = 750,["705"] = 717,["706"] = 760,["707"] = 761,["708"] = 762,["709"] = 764,["710"] = 765,["711"] = 767,["712"] = 768,["713"] = 769,["714"] = 769,["715"] = 769,["716"] = 770,["717"] = 771,["718"] = 772,["719"] = 773,["722"] = 769,["723"] = 769,["724"] = 778,["725"] = 779,["726"] = 780,["727"] = 781,["731"] = 786,["734"] = 760,["735"] = 791,["736"] = 792,["737"] = 791,["738"] = 795,["739"] = 796,["740"] = 797,["741"] = 798,["743"] = 801,["744"] = 802,["745"] = 803,["746"] = 804,["747"] = 804,["748"] = 804,["749"] = 804,["750"] = 805,["751"] = 806,["752"] = 807,["753"] = 808,["754"] = 809,["757"] = 812,["758"] = 813,["759"] = 814,["760"] = 815,["761"] = 816,["762"] = 817,["767"] = 823,["768"] = 795,["769"] = 826,["770"] = 827,["771"] = 826,["772"] = 830,["773"] = 831,["774"] = 830,["775"] = 834,["776"] = 835,["777"] = 834,["778"] = 838,["779"] = 839,["780"] = 840,["781"] = 841,["784"] = 844,["786"] = 847,["787"] = 848,["788"] = 849,["790"] = 851,["791"] = 847,["792"] = 854,["793"] = 855,["794"] = 857,["796"] = 861,["797"] = 862,["798"] = 863,["799"] = 864,["800"] = 865,["801"] = 866,["804"] = 869,["805"] = 870,["806"] = 871,["810"] = 854,["811"] = 877,["812"] = 877,["813"] = 894,["814"] = 895,["815"] = 896,["816"] = 897,["817"] = 898,["819"] = 894,["820"] = 902,["821"] = 903,["822"] = 904,["823"] = 905,["825"] = 902,["826"] = 909,["827"] = 910,["828"] = 910,["829"] = 910,["830"] = 911,["831"] = 912,["832"] = 912,["833"] = 912,["834"] = 912,["835"] = 913,["837"] = 910,["838"] = 910,["839"] = 909,["840"] = 918,["841"] = 919,["842"] = 919,["843"] = 919,["844"] = 920,["845"] = 921,["846"] = 922,["847"] = 924,["848"] = 925,["849"] = 925,["850"] = 925,["851"] = 925,["852"] = 926,["854"] = 928,["855"] = 929,["856"] = 930,["857"] = 930,["858"] = 930,["859"] = 930,["860"] = 931,["864"] = 919,["865"] = 919,["866"] = 918,["867"] = 938,["868"] = 939,["869"] = 939,["870"] = 939,["871"] = 939,["872"] = 940,["873"] = 941,["875"] = 943,["876"] = 938,["877"] = 946,["878"] = 947,["879"] = 947,["880"] = 947,["881"] = 947,["882"] = 948,["883"] = 949,["885"] = 951,["886"] = 946,["887"] = 954,["888"] = 955,["889"] = 955,["890"] = 955,["891"] = 955,["892"] = 954,["893"] = 958,["894"] = 959,["895"] = 958,["896"] = 962,["897"] = 963,["898"] = 965,["899"] = 966,["901"] = 969,["902"] = 962,["903"] = 972,["904"] = 973,["905"] = 974,["906"] = 975,["907"] = 976,["908"] = 976,["909"] = 976,["910"] = 976,["911"] = 976,["912"] = 976,["913"] = 978,["914"] = 985,["915"] = 986,["916"] = 972,["917"] = 989,["918"] = 990,["919"] = 989,["920"] = 994,["921"] = 994,["922"] = 69,["923"] = 998,["924"] = 998,["925"] = 998,["926"] = 998,["927"] = 1003,["928"] = 1004});
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
require("util.custom_entities_legacy")
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
local ____hero = require("clases.hero")
local Hero = ____hero.default
local ____custom_items = require("util.custom_items")
local CustomItems = ____custom_items.CustomItems
local ____pickup = require("clases.pickup")
local Pickup = ____pickup.default
local PickupTypes = ____pickup.PickupTypes
local ____wave = require("clases.wave")
local Wave = ____wave.default
local NPCNames = ____wave.NPCNames
local ____settings = require("settings")
local settings = ____settings.default
local ____pre_wave = require("clases.pre_wave")
local PreWave = ____pre_wave.default
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
    self.heroes = {}
    self.state = CustomGameState.NONE
    self.thinkers = {}
    self.wtf = false
    self.units = {}
    self.alliances = {}
    self.waveGroups = {}
    self.max_treshold = 30
    self.currentWave = 0
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
    if self:IsPVP() then
        self:StartPVPMap()
    elseif self:IsPVE() then
        self:StartPVEMap()
    end
    self:RegisterThinker(
        0.01,
        function()
            CustomGameEventManager:Send_ServerToAllClients("get_mouse_position", {})
            __TS__ArrayForEach(
                self.heroes,
                function(____, hero)
                    hero:Update()
                end
            )
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
    self:SetState(CustomGameState.WAVE_IN_PROGRESS)
    self.waveGroups = {{name = NPCNames.DIRE_ZOMBIE, ammount = 10}, {name = NPCNames.QUEEN, ammount = 1}, {name = NPCNames.DIRE_ZOMBIE, ammount = 40}, {name = NPCNames.CENTAUR, ammount = 1}}
    self.wave = __TS__New(Wave, self.alliances, -1, {self.waveGroups[self.currentWave + 1]})
    self:RegisterThinker(
        0.01,
        function()
            if (self.state == CustomGameState.WAVE_IN_PROGRESS) and self.wave then
                self.wave:Update()
            end
            if (self.state == CustomGameState.PRE_WAVE) and self.pre_wave then
                self.pre_wave:Update()
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
    if self:IsPVP() then
        self:SetupRulesPVP()
    elseif self:IsPVE() then
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
        function(event) return self:OnNPCInGame(event) end,
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
                    local currentDirection = CustomEntitiesLegacy:GetRawDirection(hero)
                    local incomingDirection = event.payload.direction
                    local vector = Vector(incomingDirection["0"], incomingDirection["1"], 0)
                    if mode == Custom_ActionModes.STOP then
                        vector = vector:__mul(-1)
                    end
                    local newDirection = currentDirection:__add(vector)
                    newDirection.z = hero:GetForwardVector().z
                    CustomEntitiesLegacy:SetDirection(hero, newDirection.x, newDirection.y)
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
                    CustomEntitiesLegacy:SendDataToClient(hero)
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
    LinkLuaModifier("modifier_hero_movement", "abilities/base/modifier_hero_movement", LUA_MODIFIER_MOTION_NONE)
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
    elseif state == CustomGameState.PRE_WAVE then
        self.pre_wave = nil
        self:IncrementWave()
        local waveGroup = self.waveGroups[self.currentWave + 1]
        if waveGroup then
            self.wave = __TS__New(Wave, self.alliances, -1, {waveGroup})
        else
            self:EndGame(0)
        end
    elseif state == CustomGameState.WAVE_IN_PROGRESS then
        self.wave = nil
        self.pre_wave = __TS__New(PreWave, self.alliances, settings.PreRoundDuration)
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
        local energy = CustomEntitiesLegacy:GetEnergy(caster)
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
                CustomEntitiesLegacy:FullyFaceTowards(caster, direction)
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
        local new_treshold = CustomEntitiesLegacy:GetTreshold(target) + event.heal
        if new_treshold > self.max_treshold then
            event.heal = self.max_treshold - CustomEntitiesLegacy:GetTreshold(target)
            CustomEntitiesLegacy:SetTreshold(target, self.max_treshold)
        else
            CustomEntitiesLegacy:SetTreshold(target, new_treshold)
        end
        SendOverheadHealMessage(target, event.heal)
        Timers:CreateTimer(
            0.05,
            function()
                CustomEntitiesLegacy:SendDataToClient(target)
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
        CustomEntitiesLegacy:SetTreshold(
            victim,
            CustomEntitiesLegacy:GetTreshold(victim) - damage_after_reductions
        )
        if CustomEntitiesLegacy:GetTreshold(victim) < 0 then
            CustomEntitiesLegacy:SetTreshold(victim, 0)
        end
        victim:AddNewModifier(victim, nil, "modifier_damage_fx", {duration = 0.1})
        Timers:CreateTimer(
            0.05,
            function()
                CustomEntitiesLegacy:SendDataToClient(victim)
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
                CustomEntitiesLegacy:SetDirection(hero, 0, 0)
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
    if event.text == "-skip" then
        if self:IsPVE() then
            if self.wave then
                __TS__ArrayForEach(
                    self.wave.npcs,
                    function(____, npc)
                        if npc:GetUnit():IsAlive() then
                            npc:GetUnit():ForceKill(false)
                        end
                    end
                )
            end
        end
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
            CustomEntitiesLegacy:SendDataToClient(hero)
        end
    end
end
function GameMode.prototype.OnGameInProgress(self)
    self:Start()
end
function GameMode.prototype.OnNPCInGame(self, event)
    local npc = EntIndexToHScript(event.entindex)
    if (npc == nil) or npc:IsNull() then
        return false
    end
    if not CustomEntitiesLegacy:IsInitialized(npc) then
        if not (npc:GetName() == "npc_dota_thinker") then
            if npc:IsRealHero() then
                __TS__ArrayPush(
                    self.heroes,
                    __TS__New(Hero, npc)
                )
                CustomEntitiesLegacy:Initialize(npc)
                if self:IsPVP() then
                    return self:OnHeroInGamePVP(npc)
                elseif self:IsPVE() then
                    return self:OnHeroInGamePVE(npc)
                end
            else
                if self:IsPVP() then
                    CustomEntitiesLegacy:Initialize(npc)
                    return true
                elseif self:IsPVE() then
                    CustomEntitiesLegacy:Initialize(npc, true)
                    return true
                end
            end
        end
    end
    return true
end
function GameMode.prototype.IncrementWave(self)
    self.currentWave = self.currentWave + 1
end
function GameMode.prototype.IsPVP(self)
    return GetMapName() == Custom_MapNames.PVP
end
function GameMode.prototype.IsPVE(self)
    return GetMapName() == Custom_MapNames.PVE
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
    local parent = CustomEntitiesLegacy:GetParent(killed)
    if parent then
        local killer = EntIndexToHScript(event.entindex_attacker)
        parent:OnDeath({killer = killer})
        if self:IsPVE() and self.wave then
            self.wave.aliveNpcs = self.wave.aliveNpcs - 1
        end
    else
        if killed:IsRealHero() then
            if self:IsPVP() then
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
                CustomEntitiesLegacy:GiveEnergy(
                    player.hero,
                    CustomEntitiesLegacy:GetMaxEnergy(player.hero)
                )
                CustomEntitiesLegacy:SendDataToClient(player.hero)
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
