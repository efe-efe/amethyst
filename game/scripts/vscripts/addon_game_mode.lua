--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 2,["7"] = 2,["8"] = 3,["9"] = 3,["10"] = 4,["11"] = 4,["12"] = 5,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 19,["30"] = 19,["31"] = 20,["32"] = 20,["33"] = 20,["34"] = 20,["35"] = 21,["36"] = 21,["37"] = 22,["38"] = 22,["39"] = 22,["40"] = 23,["41"] = 23,["42"] = 24,["43"] = 24,["44"] = 25,["45"] = 25,["46"] = 26,["47"] = 26,["48"] = 48,["49"] = 53,["50"] = 53,["51"] = 53,["52"] = 53,["53"] = 53,["54"] = 58,["55"] = 58,["56"] = 58,["57"] = 58,["58"] = 58,["59"] = 63,["60"] = 64,["61"] = 65,["62"] = 66,["63"] = 67,["64"] = 69,["65"] = 71,["66"] = 72,["67"] = 71,["69"] = 73,["70"] = 74,["71"] = 75,["72"] = 76,["73"] = 77,["74"] = 79,["75"] = 85,["76"] = 86,["77"] = 89,["78"] = 89,["79"] = 89,["80"] = 89,["81"] = 89,["82"] = 89,["83"] = 89,["84"] = 91,["85"] = 92,["86"] = 93,["87"] = 94,["88"] = 95,["89"] = 97,["90"] = 98,["91"] = 99,["92"] = 100,["93"] = 88,["94"] = 104,["95"] = 105,["96"] = 106,["97"] = 107,["98"] = 108,["99"] = 109,["100"] = 110,["101"] = 111,["102"] = 112,["103"] = 113,["104"] = 114,["105"] = 116,["106"] = 117,["107"] = 118,["108"] = 119,["109"] = 120,["110"] = 121,["111"] = 123,["112"] = 124,["113"] = 125,["114"] = 127,["115"] = 128,["116"] = 129,["117"] = 130,["119"] = 104,["120"] = 134,["121"] = 135,["122"] = 134,["123"] = 138,["124"] = 139,["125"] = 139,["126"] = 139,["127"] = 139,["128"] = 140,["129"] = 140,["130"] = 140,["131"] = 140,["132"] = 141,["133"] = 141,["134"] = 141,["135"] = 141,["136"] = 142,["137"] = 142,["138"] = 142,["139"] = 142,["140"] = 143,["141"] = 143,["142"] = 143,["143"] = 143,["144"] = 145,["145"] = 146,["146"] = 147,["147"] = 148,["149"] = 151,["150"] = 151,["151"] = 151,["152"] = 152,["153"] = 153,["154"] = 153,["155"] = 153,["156"] = 154,["157"] = 153,["158"] = 153,["159"] = 151,["160"] = 151,["161"] = 138,["162"] = 159,["163"] = 160,["164"] = 161,["165"] = 162,["166"] = 164,["167"] = 165,["168"] = 166,["169"] = 168,["170"] = 168,["171"] = 168,["172"] = 169,["173"] = 170,["175"] = 172,["176"] = 173,["178"] = 175,["179"] = 176,["181"] = 168,["182"] = 168,["183"] = 159,["184"] = 181,["185"] = 182,["186"] = 183,["187"] = 185,["188"] = 185,["189"] = 185,["190"] = 186,["191"] = 187,["193"] = 189,["194"] = 190,["196"] = 185,["197"] = 185,["198"] = 181,["199"] = 195,["200"] = 196,["201"] = 197,["203"] = 199,["204"] = 201,["205"] = 202,["206"] = 202,["207"] = 202,["208"] = 203,["209"] = 204,["210"] = 205,["212"] = 202,["213"] = 202,["215"] = 210,["216"] = 195,["217"] = 213,["218"] = 214,["219"] = 215,["220"] = 216,["221"] = 217,["222"] = 218,["223"] = 219,["224"] = 220,["225"] = 221,["226"] = 222,["227"] = 223,["228"] = 224,["229"] = 226,["230"] = 227,["231"] = 228,["232"] = 229,["234"] = 231,["235"] = 213,["236"] = 234,["237"] = 235,["238"] = 236,["239"] = 237,["240"] = 238,["241"] = 239,["242"] = 234,["243"] = 242,["244"] = 243,["245"] = 244,["246"] = 245,["247"] = 246,["248"] = 242,["249"] = 249,["250"] = 250,["251"] = 250,["252"] = 250,["253"] = 250,["254"] = 250,["255"] = 251,["256"] = 251,["257"] = 251,["258"] = 251,["259"] = 251,["260"] = 252,["261"] = 252,["262"] = 252,["263"] = 252,["264"] = 252,["265"] = 253,["266"] = 253,["267"] = 253,["268"] = 253,["269"] = 253,["270"] = 254,["271"] = 254,["272"] = 254,["273"] = 254,["274"] = 254,["275"] = 255,["276"] = 255,["277"] = 255,["278"] = 255,["279"] = 255,["280"] = 256,["281"] = 249,["282"] = 259,["283"] = 260,["284"] = 260,["285"] = 260,["286"] = 261,["287"] = 262,["288"] = 263,["289"] = 264,["290"] = 265,["292"] = 260,["293"] = 260,["294"] = 269,["295"] = 269,["296"] = 269,["297"] = 269,["298"] = 269,["299"] = 273,["300"] = 273,["301"] = 273,["302"] = 274,["303"] = 275,["304"] = 277,["305"] = 278,["306"] = 280,["307"] = 281,["308"] = 283,["309"] = 284,["310"] = 285,["311"] = 286,["312"] = 288,["313"] = 289,["315"] = 292,["316"] = 293,["317"] = 294,["320"] = 273,["321"] = 273,["322"] = 299,["323"] = 299,["324"] = 299,["325"] = 300,["326"] = 301,["327"] = 303,["328"] = 304,["329"] = 306,["331"] = 307,["332"] = 307,["333"] = 308,["334"] = 309,["335"] = 310,["336"] = 311,["339"] = 307,["342"] = 316,["343"] = 317,["346"] = 321,["347"] = 322,["348"] = 322,["349"] = 322,["351"] = 299,["352"] = 299,["353"] = 326,["354"] = 326,["355"] = 326,["356"] = 327,["357"] = 328,["358"] = 330,["359"] = 331,["360"] = 332,["361"] = 333,["362"] = 334,["363"] = 335,["366"] = 326,["367"] = 326,["368"] = 259,["369"] = 341,["370"] = 342,["371"] = 343,["372"] = 344,["373"] = 345,["374"] = 346,["375"] = 347,["376"] = 348,["377"] = 341,["378"] = 351,["379"] = 352,["380"] = 353,["381"] = 354,["382"] = 355,["383"] = 356,["384"] = 357,["385"] = 359,["386"] = 360,["387"] = 361,["388"] = 362,["389"] = 363,["390"] = 365,["391"] = 366,["392"] = 367,["393"] = 368,["394"] = 369,["395"] = 370,["396"] = 371,["397"] = 372,["398"] = 373,["399"] = 374,["400"] = 375,["401"] = 376,["402"] = 377,["403"] = 378,["404"] = 379,["405"] = 380,["406"] = 381,["407"] = 382,["408"] = 383,["409"] = 384,["410"] = 385,["411"] = 386,["412"] = 387,["413"] = 388,["414"] = 390,["415"] = 391,["416"] = 392,["417"] = 393,["418"] = 394,["419"] = 395,["420"] = 396,["421"] = 397,["422"] = 398,["423"] = 399,["424"] = 400,["425"] = 401,["426"] = 402,["427"] = 403,["428"] = 404,["429"] = 405,["431"] = 408,["432"] = 351,["433"] = 411,["434"] = 412,["435"] = 411,["436"] = 415,["437"] = 416,["438"] = 416,["439"] = 416,["440"] = 416,["441"] = 416,["442"] = 422,["443"] = 415,["444"] = 425,["445"] = 426,["446"] = 428,["447"] = 428,["448"] = 428,["449"] = 429,["450"] = 429,["451"] = 429,["452"] = 430,["453"] = 431,["455"] = 429,["456"] = 429,["457"] = 428,["458"] = 428,["459"] = 436,["460"] = 425,["461"] = 439,["462"] = 440,["463"] = 441,["464"] = 442,["465"] = 444,["466"] = 445,["467"] = 446,["468"] = 446,["469"] = 446,["470"] = 446,["471"] = 446,["472"] = 447,["474"] = 449,["475"] = 450,["476"] = 451,["477"] = 452,["478"] = 453,["479"] = 455,["480"] = 456,["481"] = 457,["483"] = 460,["484"] = 461,["485"] = 462,["486"] = 463,["487"] = 465,["489"] = 468,["491"] = 439,["492"] = 472,["493"] = 473,["494"] = 474,["495"] = 475,["496"] = 476,["497"] = 477,["498"] = 472,["499"] = 480,["500"] = 481,["501"] = 482,["502"] = 483,["503"] = 485,["504"] = 486,["505"] = 487,["506"] = 489,["507"] = 490,["508"] = 491,["509"] = 493,["510"] = 494,["511"] = 495,["512"] = 516,["513"] = 517,["514"] = 518,["516"] = 480,["517"] = 522,["518"] = 523,["519"] = 524,["520"] = 526,["521"] = 526,["522"] = 526,["523"] = 527,["524"] = 527,["525"] = 527,["526"] = 527,["527"] = 527,["528"] = 527,["529"] = 526,["530"] = 526,["531"] = 530,["532"] = 522,["533"] = 533,["534"] = 534,["535"] = 535,["536"] = 543,["537"] = 544,["538"] = 545,["539"] = 545,["540"] = 545,["541"] = 545,["542"] = 545,["543"] = 545,["544"] = 545,["545"] = 545,["546"] = 546,["547"] = 533,["548"] = 549,["549"] = 550,["550"] = 551,["551"] = 552,["553"] = 549,["554"] = 556,["555"] = 557,["556"] = 556,["557"] = 560,["558"] = 561,["559"] = 563,["560"] = 568,["561"] = 569,["562"] = 570,["563"] = 571,["564"] = 573,["565"] = 574,["566"] = 575,["568"] = 578,["569"] = 579,["570"] = 584,["571"] = 584,["572"] = 584,["573"] = 585,["574"] = 585,["575"] = 585,["576"] = 586,["577"] = 586,["578"] = 586,["579"] = 586,["580"] = 588,["581"] = 589,["583"] = 592,["584"] = 593,["585"] = 593,["586"] = 593,["587"] = 594,["588"] = 595,["590"] = 598,["593"] = 602,["594"] = 603,["595"] = 604,["596"] = 605,["597"] = 606,["598"] = 607,["602"] = 611,["603"] = 612,["605"] = 614,["606"] = 615,["608"] = 618,["609"] = 560,["610"] = 621,["611"] = 622,["612"] = 621,["613"] = 625,["614"] = 626,["615"] = 629,["616"] = 630,["617"] = 631,["618"] = 632,["619"] = 633,["621"] = 635,["623"] = 638,["624"] = 639,["625"] = 641,["626"] = 642,["627"] = 642,["628"] = 642,["629"] = 643,["630"] = 642,["631"] = 642,["634"] = 648,["635"] = 649,["636"] = 649,["637"] = 649,["638"] = 650,["639"] = 649,["640"] = 649,["641"] = 678,["642"] = 625,["643"] = 681,["644"] = 682,["645"] = 683,["646"] = 685,["647"] = 689,["648"] = 690,["650"] = 693,["651"] = 694,["652"] = 694,["653"] = 694,["654"] = 694,["655"] = 695,["656"] = 696,["658"] = 699,["659"] = 700,["660"] = 700,["661"] = 700,["662"] = 701,["663"] = 700,["664"] = 700,["665"] = 704,["666"] = 705,["667"] = 707,["668"] = 708,["669"] = 708,["670"] = 708,["671"] = 709,["672"] = 708,["673"] = 708,["676"] = 714,["677"] = 681,["678"] = 717,["679"] = 718,["680"] = 720,["681"] = 721,["683"] = 717,["684"] = 725,["685"] = 726,["686"] = 727,["687"] = 728,["688"] = 730,["689"] = 731,["690"] = 732,["691"] = 733,["695"] = 738,["698"] = 742,["699"] = 743,["701"] = 746,["702"] = 747,["703"] = 748,["705"] = 751,["706"] = 752,["708"] = 785,["709"] = 786,["710"] = 787,["711"] = 788,["712"] = 790,["713"] = 791,["714"] = 792,["715"] = 793,["720"] = 725,["721"] = 800,["722"] = 801,["723"] = 802,["724"] = 804,["725"] = 805,["726"] = 807,["727"] = 808,["728"] = 809,["729"] = 809,["730"] = 809,["731"] = 810,["732"] = 811,["733"] = 812,["734"] = 813,["737"] = 809,["738"] = 809,["739"] = 818,["740"] = 819,["741"] = 820,["742"] = 821,["746"] = 826,["749"] = 800,["750"] = 831,["751"] = 832,["752"] = 831,["753"] = 835,["754"] = 836,["755"] = 837,["756"] = 838,["758"] = 841,["759"] = 842,["761"] = 845,["762"] = 846,["764"] = 849,["765"] = 850,["766"] = 851,["767"] = 852,["768"] = 853,["769"] = 854,["770"] = 855,["774"] = 860,["775"] = 835,["776"] = 863,["777"] = 864,["778"] = 865,["779"] = 863,["780"] = 868,["781"] = 869,["782"] = 868,["783"] = 872,["784"] = 873,["785"] = 872,["786"] = 876,["787"] = 877,["788"] = 876,["789"] = 880,["790"] = 881,["791"] = 883,["792"] = 884,["793"] = 885,["795"] = 887,["798"] = 890,["800"] = 892,["801"] = 893,["802"] = 880,["803"] = 896,["804"] = 897,["805"] = 897,["806"] = 897,["807"] = 897,["808"] = 896,["809"] = 900,["810"] = 901,["811"] = 902,["812"] = 904,["813"] = 905,["814"] = 906,["816"] = 909,["817"] = 910,["819"] = 913,["820"] = 914,["821"] = 915,["823"] = 917,["824"] = 918,["825"] = 918,["826"] = 918,["827"] = 918,["828"] = 918,["829"] = 919,["832"] = 922,["834"] = 900,["835"] = 926,["836"] = 927,["837"] = 928,["838"] = 929,["839"] = 930,["841"] = 926,["842"] = 934,["843"] = 935,["844"] = 936,["845"] = 938,["846"] = 939,["848"] = 942,["849"] = 943,["852"] = 934,["853"] = 948,["854"] = 949,["855"] = 949,["856"] = 949,["857"] = 950,["858"] = 951,["859"] = 951,["860"] = 951,["861"] = 951,["862"] = 952,["864"] = 949,["865"] = 949,["866"] = 948,["867"] = 957,["868"] = 958,["869"] = 958,["870"] = 958,["871"] = 959,["872"] = 960,["873"] = 961,["874"] = 963,["875"] = 964,["876"] = 964,["877"] = 964,["878"] = 964,["879"] = 965,["881"] = 967,["882"] = 968,["883"] = 969,["884"] = 969,["885"] = 969,["886"] = 969,["887"] = 970,["891"] = 958,["892"] = 958,["893"] = 957,["894"] = 977,["895"] = 978,["896"] = 978,["897"] = 978,["898"] = 978,["899"] = 979,["900"] = 980,["902"] = 982,["903"] = 977,["904"] = 985,["905"] = 986,["906"] = 986,["907"] = 986,["908"] = 986,["909"] = 987,["910"] = 988,["912"] = 990,["913"] = 985,["914"] = 993,["915"] = 994,["916"] = 994,["917"] = 994,["918"] = 994,["919"] = 993,["920"] = 997,["921"] = 998,["922"] = 997,["923"] = 1001,["924"] = 1002,["925"] = 1004,["926"] = 1005,["928"] = 1008,["929"] = 1001,["930"] = 1011,["931"] = 1012,["932"] = 1013,["933"] = 1014,["934"] = 1015,["935"] = 1015,["936"] = 1015,["937"] = 1015,["938"] = 1015,["939"] = 1015,["940"] = 1017,["941"] = 1024,["942"] = 1025,["943"] = 1011,["944"] = 1028,["945"] = 1029,["946"] = 1028,["947"] = 1033,["948"] = 1033,["949"] = 71,["950"] = 1037,["951"] = 1037,["952"] = 1037,["953"] = 1037,["954"] = 1042,["955"] = 1043});
local ____exports = {}
require("abilities_meta")
local ____alliance = require("clases.alliance")
local Alliance = ____alliance.default
local ____game_state = require("clases.game_state")
local CustomGameState = ____game_state.CustomGameState
local ____warmup = require("clases.pvp.warmup")
local Warmup = ____warmup.default
local ____tstl_2Dutils = require("lib.tstl-utils")
local reloadable = ____tstl_2Dutils.reloadable
require("wrappers.abilities")
require("wrappers.modifiers")
require("util.custom_abilities_legacy")
require("util.custom_entities_legacy")
require("util.math_legacy")
require("util.util")
require("settings")
require("constructors")
require("libraries.timers")
require("libraries.projectiles")
require("overrides.abilities")
local ____player = require("clases.player")
local Player = ____player.default
local ____pre_round = require("clases.pvp.pre_round")
local PreRound = ____pre_round.default
local ____round = require("clases.pvp.round")
local Round = ____round.default
local ____custom_npc = require("clases.pve.custom_npc")
local CustomNPC = ____custom_npc.default
local CustomNonPlayerHeroNPC = ____custom_npc.CustomNonPlayerHeroNPC
local CustomPlayerHeroNPC = ____custom_npc.CustomPlayerHeroNPC
local ____custom_items = require("util.custom_items")
local CustomItems = ____custom_items.CustomItems
local ____pickup = require("clases.pickup")
local Pickup = ____pickup.default
local PickupTypes = ____pickup.PickupTypes
local ____settings = require("settings")
local settings = ____settings.default
local ____pre_run = require("clases.pve.pre_run")
local PreRun = ____pre_run.default
local ____custom_ai = require("clases.pve.custom_ai")
local NPCNames = ____custom_ai.NPCNames
local ____run = require("clases.pve.run")
local Run = ____run.default
local Custom_MapNames = {PVP = "pvp", PVE = "pve"}
local Custom_ActionTypes = Custom_ActionTypes or ({})
Custom_ActionTypes.MOVEMENT = 0
Custom_ActionTypes[Custom_ActionTypes.MOVEMENT] = "MOVEMENT"
Custom_ActionTypes.ABILITY = 1
Custom_ActionTypes[Custom_ActionTypes.ABILITY] = "ABILITY"
local Custom_ActionModes = Custom_ActionModes or ({})
Custom_ActionModes.START = 0
Custom_ActionModes[Custom_ActionModes.START] = "START"
Custom_ActionModes.STOP = 1
Custom_ActionModes[Custom_ActionModes.STOP] = "STOP"
local DOTA_ALIANCE_NO_ALLIANCE = 0
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
    self.units = {}
    self.state = CustomGameState.NONE
    self.thinkers = {}
    self.wtf = false
    self.alliances = {}
    self.max_treshold = 30
    self.currentRoom = -1
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
        __TS__New(Alliance, DOTA_ALIANCE_NO_ALLIANCE, {})
    )
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
                self.units,
                function(____, unit)
                    unit:Update()
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
            if (self.state == CustomGameState.PRE_ROUND) and self.preRound then
                self.preRound:Update()
            end
            if (self.state == CustomGameState.ROUND_IN_PROGRESS) and self.round then
                self.round:Update()
            end
        end
    )
end
function GameMode.prototype.StartPVEMap(self)
    self:SetState(CustomGameState.PRE_RUN)
    self.preRun = __TS__New(PreRun, self.alliances, -1)
    self:RegisterThinker(
        0.01,
        function()
            if (self.state == CustomGameState.RUN_IN_PROGRESS) and self.run then
                self.run:Update()
            end
            if (self.state == CustomGameState.PRE_RUN) and self.preRun then
                self.preRun:Update()
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
    LinkLuaModifier("modifier_miss", "modifiers/modifier_miss.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_restricted", "modifiers/modifier_restricted.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_ruby", "modifiers/gems/modifier_ruby.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_ruby_attack", "modifiers/gems/modifier_ruby.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_sapphire", "modifiers/gems/modifier_sapphire.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_emerald", "modifiers/gems/modifier_emerald.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_amethyst", "modifiers/gems/modifier_amethyst.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_silence", "modifiers/generic/modifier_generic_silence", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_fading_slow", "modifiers/generic/modifier_generic_fading_slow", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_fading_haste", "modifiers/generic/modifier_generic_fading_haste", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_stunned", "modifiers/generic/modifier_generic_stunned", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_provides_vision", "modifiers/generic/modifier_generic_provides_vision", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_knockback", "modifiers/generic/modifier_generic_knockback", LUA_MODIFIER_MOTION_BOTH)
    LinkLuaModifier("modifier_generic_root", "modifiers/generic/modifier_generic_root", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_invencible", "modifiers/generic/modifier_generic_invencible", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_confuse", "modifiers/generic/modifier_generic_confuse", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_sleep", "modifiers/generic/modifier_generic_sleep", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_fear", "modifiers/generic/modifier_generic_fear", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_meele_npc", "modifiers/generic/modifier_generic_meele_npc", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_phased", "modifiers/generic/modifier_generic_phased", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_flying", "modifiers/generic/modifier_generic_flying", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_ignore_ms_limit", "modifiers/generic/modifier_generic_ignore_ms_limit", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_visible", "modifiers/generic/modifier_visible", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_casting", "modifiers/generic/modifier_casting", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_damage_fx", "modifiers/generic/modifier_damage_fx", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_shield", "modifiers/generic/modifier_shield", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hide_bar", "modifiers/generic/modifier_hide_bar", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hidden", "modifiers/generic/modifier_hidden", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_banish", "modifiers/generic/modifier_banish", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hero_movement", "modifiers/generic/modifier_hero_movement", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_tower_idle", "modifiers/generic/modifier_tower_idle", LUA_MODIFIER_MOTION_NONE)
    if self:IsPVE() then
        LinkLuaModifier("modifier_upgrade_meele_extra_radius", "modifiers/upgrades/modifier_upgrade_meele_extra_radius", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_phantom_extra_daggers", "modifiers/upgrades/modifier_upgrade_phantom_extra_daggers", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_extra_base_damage", "modifiers/upgrades/modifier_upgrade_extra_base_damage", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_juggernaut_refresh_dagger", "modifiers/upgrades/modifier_upgrade_juggernaut_refresh_dagger", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_lightining_attack", "modifiers/upgrades/modifier_upgrade_lightining_attack", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_lightining_attack_attack", "modifiers/upgrades/modifier_upgrade_lightining_attack", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_phantom_dash_damage", "modifiers/upgrades/modifier_upgrade_phantom_dash_damage", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_phantom_dash_invulnerability", "modifiers/upgrades/modifier_upgrade_phantom_dash_invulnerability", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_phantom_coup_cast_fast", "modifiers/upgrades/modifier_upgrade_phantom_coup_cast_fast", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_juggernaut_fury_attack", "modifiers/upgrades/modifier_upgrade_juggernaut_fury_attack", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_storm_ranged_remnant", "modifiers/upgrades/modifier_upgrade_storm_ranged_remnant", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_storm_unleashed_knockback", "modifiers/upgrades/modifier_upgrade_storm_unleashed_knockback", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_extra_speed", "modifiers/upgrades/modifier_upgrade_extra_speed", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_stun_attack", "modifiers/upgrades/modifier_upgrade_stun_attack", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_stun_attack_attack", "modifiers/upgrades/modifier_upgrade_stun_attack", LUA_MODIFIER_MOTION_NONE)
    end
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
function GameMode.prototype.RegisterPlayer(self, hero, customNpc)
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
            player:SetCustomNPC(customNpc)
            alliance:AddPlayer(player)
        end
        return true
    end
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
        self.preRound = __TS__New(PreRound, self.alliances, 1)
    elseif state == CustomGameState.PRE_ROUND then
        self.preRound = nil
        self.round = __TS__New(Round, self.alliances, settings.RoundDuration)
    elseif state == CustomGameState.PRE_RUN then
        self.preRun = nil
        self.run = __TS__New(Run, self.alliances, {{possibleNPCs = {NPCNames.DIRE_ZOMBIE, NPCNames.DIRE_ZOMBIE_MEELE, NPCNames.DIRE_ZOMBIE_RAGER, NPCNames.FLYING_SKULL, NPCNames.DIRE_TOWER, NPCNames.QUEEN}}, {possibleNPCs = {NPCNames.RADIANT_ZOMBIE_HEALER, NPCNames.RADIANT_ZOMBIE_MEELE, NPCNames.FLYING_SKULL, NPCNames.CENTAUR}}})
    elseif state == CustomGameState.RUN_IN_PROGRESS then
        self.run = nil
        self:EndGame(0)
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
        local energyCost = CustomAbilitiesLegacy:GetEnergyCost(ability)
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
            if not CustomAbilitiesLegacy:HasBehavior(ability, DOTA_ABILITY_BEHAVIOR_IMMEDIATE) then
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
    SendOverheadHealMessage(target, event.heal)
    Timers:CreateTimer(
        0.05,
        function()
            CustomEntitiesLegacy:SendDataToClient(target)
        end
    )
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
    if event.text == "-upgrade" then
        if self:IsPVE() then
            local playerId = event.playerid
            local player = self:FindPlayerById(playerId)
            if player then
                local customNpc = player.customNpc
                if customNpc then
                    customNpc:RequestFavors()
                end
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
    if (npc:GetName() == "npc_dota_thinker") or (npc:GetName() == "npc_dota_base") then
        return true
    end
    if CustomEntitiesLegacy:IsInitialized(npc) then
        return true
    end
    local customNpc = self:RegisterUnit(npc)
    if npc:IsRealHero() then
        if self:IsPVP() then
            return self:RegisterPlayer(npc, customNpc)
        elseif self:IsPVE() then
            if npc:GetTeamNumber() ~= DOTA_TEAM_CUSTOM_1 then
                return self:RegisterPlayer(npc, customNpc)
            end
        end
    end
    return true
end
function GameMode.prototype.IsPlayerHero(self, hero)
    local playerID = hero:GetPlayerOwnerID()
    return playerID ~= -1
end
function GameMode.prototype.IncrementWave(self)
    self.currentRoom = self.currentRoom + 1
end
function GameMode.prototype.IsPVP(self)
    return GetMapName() == Custom_MapNames.PVP
end
function GameMode.prototype.IsPVE(self)
    return GetMapName() == Custom_MapNames.PVE
end
function GameMode.prototype.RegisterUnit(self, unit)
    local customNpc = nil
    if unit:IsRealHero() then
        if self:IsPlayerHero(unit) then
            customNpc = __TS__New(CustomPlayerHeroNPC, unit)
        else
            customNpc = __TS__New(CustomNonPlayerHeroNPC, unit)
        end
    else
        customNpc = __TS__New(CustomNPC, unit)
    end
    __TS__ArrayPush(self.units, customNpc)
    return customNpc
end
function GameMode.prototype.RemoveUnit(self, unit)
    self.units = __TS__ArrayFilter(
        self.units,
        function(____, unitEntity) return unitEntity:GetUnit() ~= unit end
    )
end
function GameMode.prototype.OnEntityKilled(self, event)
    local killed = EntIndexToHScript(event.entindex_killed)
    local killer = EntIndexToHScript(event.entindex_attacker)
    local parent = CustomEntitiesLegacy:GetParent(killed)
    if parent then
        parent:OnDeath({killer = killer})
    end
    if self.run then
        self.run:OnUnitDies(killed)
    end
    if killed:IsRealHero() then
        if self:IsPVP() then
            self:OnHeroKilledPVP(killed)
        end
        if not self:IsPlayerHero(killed) then
            self:SetRespawnTime(
                killed:GetTeam(),
                killed,
                999
            )
            self:RemoveUnit(killed)
        end
    else
        self:RemoveUnit(killed)
    end
end
function GameMode.prototype.OnHeroKilledPVP(self, killed)
    if self.round then
        self.round.hero_died = true
        self:CreateDeathOrb(killed)
        self:UpdateCameras()
    end
end
function GameMode.prototype.OnEntityHurt(self, event)
    if event.entindex_killed ~= nil then
        local victim = EntIndexToHScript(event.entindex_killed)
        if self.run then
            self.run:OnUnitHurt(victim)
        end
        if event.entindex_attacker ~= nil then
            SendOverheadDamageMessage(victim, event.damage)
        end
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
GameMode = __TS__Decorate({reloadable}, GameMode)
__TS__ObjectAssign(
    getfenv(),
    {Activate = ____exports.GameMode.Activate, Precache = ____exports.GameMode.Precache}
)
if GameRules.Addon then
    GameRules.Addon:Reload()
end
return ____exports
