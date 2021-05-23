--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 19,["30"] = 19,["31"] = 20,["32"] = 20,["33"] = 20,["34"] = 20,["35"] = 21,["36"] = 21,["37"] = 22,["38"] = 22,["39"] = 22,["40"] = 23,["41"] = 23,["42"] = 24,["43"] = 24,["44"] = 25,["45"] = 25,["46"] = 26,["47"] = 26,["48"] = 27,["49"] = 27,["50"] = 49,["51"] = 54,["52"] = 54,["53"] = 54,["54"] = 54,["55"] = 54,["56"] = 59,["57"] = 59,["58"] = 59,["59"] = 59,["60"] = 59,["61"] = 64,["62"] = 65,["63"] = 66,["64"] = 67,["65"] = 69,["66"] = 71,["67"] = 72,["68"] = 71,["70"] = 73,["71"] = 74,["72"] = 75,["73"] = 76,["74"] = 77,["75"] = 79,["76"] = 82,["77"] = 86,["78"] = 87,["79"] = 90,["80"] = 90,["81"] = 90,["82"] = 90,["83"] = 90,["84"] = 90,["85"] = 90,["86"] = 92,["87"] = 93,["88"] = 94,["89"] = 95,["90"] = 96,["91"] = 98,["92"] = 99,["93"] = 100,["94"] = 101,["95"] = 89,["96"] = 105,["97"] = 106,["98"] = 107,["99"] = 108,["100"] = 109,["101"] = 110,["102"] = 111,["103"] = 112,["104"] = 113,["105"] = 114,["106"] = 115,["107"] = 117,["108"] = 118,["109"] = 119,["110"] = 120,["111"] = 121,["112"] = 122,["113"] = 124,["114"] = 125,["115"] = 126,["116"] = 128,["117"] = 129,["118"] = 130,["119"] = 131,["121"] = 105,["122"] = 135,["123"] = 136,["124"] = 135,["125"] = 139,["126"] = 140,["127"] = 140,["128"] = 140,["129"] = 140,["130"] = 141,["131"] = 141,["132"] = 141,["133"] = 141,["134"] = 142,["135"] = 142,["136"] = 142,["137"] = 142,["138"] = 143,["139"] = 143,["140"] = 143,["141"] = 143,["142"] = 145,["143"] = 146,["144"] = 147,["145"] = 148,["147"] = 151,["148"] = 151,["149"] = 151,["150"] = 152,["151"] = 153,["152"] = 153,["153"] = 153,["154"] = 154,["155"] = 153,["156"] = 153,["157"] = 151,["158"] = 151,["159"] = 139,["160"] = 159,["161"] = 160,["162"] = 161,["163"] = 162,["164"] = 164,["165"] = 165,["166"] = 166,["167"] = 168,["168"] = 168,["169"] = 168,["170"] = 169,["171"] = 170,["173"] = 172,["174"] = 173,["176"] = 176,["177"] = 177,["179"] = 168,["180"] = 168,["181"] = 159,["182"] = 182,["183"] = 183,["184"] = 184,["185"] = 185,["186"] = 187,["187"] = 187,["188"] = 187,["189"] = 188,["190"] = 189,["192"] = 191,["193"] = 192,["195"] = 187,["196"] = 187,["197"] = 182,["198"] = 197,["199"] = 198,["200"] = 199,["201"] = 200,["203"] = 202,["204"] = 202,["205"] = 203,["206"] = 203,["207"] = 203,["208"] = 203,["209"] = 204,["210"] = 205,["211"] = 206,["212"] = 207,["213"] = 208,["214"] = 202,["217"] = 197,["218"] = 216,["219"] = 217,["221"] = 218,["222"] = 218,["223"] = 219,["224"] = 219,["225"] = 219,["226"] = 219,["227"] = 218,["230"] = 222,["231"] = 216,["232"] = 225,["233"] = 226,["234"] = 227,["235"] = 228,["236"] = 230,["237"] = 231,["238"] = 232,["239"] = 234,["240"] = 239,["241"] = 239,["242"] = 239,["243"] = 239,["244"] = 240,["246"] = 243,["247"] = 225,["248"] = 246,["249"] = 247,["250"] = 248,["252"] = 250,["253"] = 252,["254"] = 253,["255"] = 253,["256"] = 253,["257"] = 254,["258"] = 255,["259"] = 256,["261"] = 253,["262"] = 253,["264"] = 261,["265"] = 246,["266"] = 264,["267"] = 265,["268"] = 266,["269"] = 267,["270"] = 268,["271"] = 269,["272"] = 270,["273"] = 271,["274"] = 272,["275"] = 273,["276"] = 274,["277"] = 275,["278"] = 277,["279"] = 278,["280"] = 279,["281"] = 280,["283"] = 282,["284"] = 264,["285"] = 285,["286"] = 286,["287"] = 287,["288"] = 288,["289"] = 289,["290"] = 290,["291"] = 285,["292"] = 293,["293"] = 294,["294"] = 295,["295"] = 296,["296"] = 297,["297"] = 293,["298"] = 300,["299"] = 301,["300"] = 301,["301"] = 301,["302"] = 301,["303"] = 301,["304"] = 302,["305"] = 302,["306"] = 302,["307"] = 302,["308"] = 302,["309"] = 303,["310"] = 303,["311"] = 303,["312"] = 303,["313"] = 303,["314"] = 304,["315"] = 304,["316"] = 304,["317"] = 304,["318"] = 304,["319"] = 305,["320"] = 305,["321"] = 305,["322"] = 305,["323"] = 305,["324"] = 306,["325"] = 306,["326"] = 306,["327"] = 306,["328"] = 306,["329"] = 308,["330"] = 300,["331"] = 311,["332"] = 312,["333"] = 312,["334"] = 312,["335"] = 313,["336"] = 314,["337"] = 315,["338"] = 316,["339"] = 317,["341"] = 312,["342"] = 312,["343"] = 321,["344"] = 321,["345"] = 321,["346"] = 321,["347"] = 321,["348"] = 325,["349"] = 325,["350"] = 325,["351"] = 326,["352"] = 327,["353"] = 329,["354"] = 330,["355"] = 332,["356"] = 333,["357"] = 335,["358"] = 336,["359"] = 337,["360"] = 338,["361"] = 340,["362"] = 341,["364"] = 344,["365"] = 345,["366"] = 346,["369"] = 325,["370"] = 325,["371"] = 351,["372"] = 351,["373"] = 351,["374"] = 352,["375"] = 353,["376"] = 355,["377"] = 356,["378"] = 358,["380"] = 359,["381"] = 359,["382"] = 360,["383"] = 361,["384"] = 362,["385"] = 363,["388"] = 359,["391"] = 368,["392"] = 369,["395"] = 373,["396"] = 374,["397"] = 374,["398"] = 374,["400"] = 351,["401"] = 351,["402"] = 378,["403"] = 378,["404"] = 378,["405"] = 379,["406"] = 380,["407"] = 382,["408"] = 383,["409"] = 384,["410"] = 385,["411"] = 386,["412"] = 387,["415"] = 378,["416"] = 378,["417"] = 392,["418"] = 392,["419"] = 392,["420"] = 393,["421"] = 394,["422"] = 396,["423"] = 397,["424"] = 398,["425"] = 399,["426"] = 399,["427"] = 399,["428"] = 399,["429"] = 400,["430"] = 401,["434"] = 392,["435"] = 392,["436"] = 311,["437"] = 408,["438"] = 409,["439"] = 410,["440"] = 411,["441"] = 412,["442"] = 413,["443"] = 414,["444"] = 415,["445"] = 408,["446"] = 418,["447"] = 419,["448"] = 420,["449"] = 421,["450"] = 422,["451"] = 423,["452"] = 424,["453"] = 426,["454"] = 427,["455"] = 428,["456"] = 429,["457"] = 430,["458"] = 432,["459"] = 433,["460"] = 434,["461"] = 435,["462"] = 436,["463"] = 437,["464"] = 438,["465"] = 439,["466"] = 440,["467"] = 441,["468"] = 442,["469"] = 443,["470"] = 444,["471"] = 445,["472"] = 446,["473"] = 447,["474"] = 448,["475"] = 449,["476"] = 450,["477"] = 451,["478"] = 452,["479"] = 453,["480"] = 454,["481"] = 456,["482"] = 457,["483"] = 458,["485"] = 461,["486"] = 418,["487"] = 464,["488"] = 465,["489"] = 464,["490"] = 468,["491"] = 469,["492"] = 469,["493"] = 469,["494"] = 469,["495"] = 469,["496"] = 475,["497"] = 468,["498"] = 478,["499"] = 479,["500"] = 481,["501"] = 481,["502"] = 481,["503"] = 482,["504"] = 482,["505"] = 482,["506"] = 483,["507"] = 484,["509"] = 482,["510"] = 482,["511"] = 481,["512"] = 481,["513"] = 489,["514"] = 478,["515"] = 492,["516"] = 493,["517"] = 494,["518"] = 495,["519"] = 497,["520"] = 498,["521"] = 499,["522"] = 499,["523"] = 499,["524"] = 499,["525"] = 499,["526"] = 500,["528"] = 502,["529"] = 503,["530"] = 504,["531"] = 505,["532"] = 506,["533"] = 508,["534"] = 509,["535"] = 510,["537"] = 513,["538"] = 514,["539"] = 515,["540"] = 516,["541"] = 518,["543"] = 521,["545"] = 492,["546"] = 525,["547"] = 526,["548"] = 527,["549"] = 528,["550"] = 529,["551"] = 530,["552"] = 525,["553"] = 533,["554"] = 534,["555"] = 535,["556"] = 536,["557"] = 538,["558"] = 539,["559"] = 540,["560"] = 542,["561"] = 543,["562"] = 544,["563"] = 546,["564"] = 547,["565"] = 548,["566"] = 550,["567"] = 551,["568"] = 552,["570"] = 554,["572"] = 557,["573"] = 558,["574"] = 559,["576"] = 533,["577"] = 563,["578"] = 564,["579"] = 565,["580"] = 567,["581"] = 567,["582"] = 567,["583"] = 568,["584"] = 568,["585"] = 568,["586"] = 568,["587"] = 568,["588"] = 568,["589"] = 567,["590"] = 567,["591"] = 571,["592"] = 563,["593"] = 574,["594"] = 575,["595"] = 576,["596"] = 584,["597"] = 585,["598"] = 586,["599"] = 586,["600"] = 586,["601"] = 586,["602"] = 586,["603"] = 586,["604"] = 586,["605"] = 586,["606"] = 587,["607"] = 574,["608"] = 590,["609"] = 591,["610"] = 592,["611"] = 593,["613"] = 590,["614"] = 597,["615"] = 598,["616"] = 597,["617"] = 601,["618"] = 602,["619"] = 604,["620"] = 609,["621"] = 610,["622"] = 611,["623"] = 612,["624"] = 614,["625"] = 615,["626"] = 616,["628"] = 619,["629"] = 620,["630"] = 625,["631"] = 625,["632"] = 625,["633"] = 626,["634"] = 626,["635"] = 626,["636"] = 627,["637"] = 627,["638"] = 627,["639"] = 627,["640"] = 629,["641"] = 630,["643"] = 633,["644"] = 634,["645"] = 634,["646"] = 634,["647"] = 635,["648"] = 636,["650"] = 639,["653"] = 643,["654"] = 644,["655"] = 645,["656"] = 646,["657"] = 647,["658"] = 648,["662"] = 652,["663"] = 653,["665"] = 655,["666"] = 656,["668"] = 659,["669"] = 601,["670"] = 662,["671"] = 663,["672"] = 662,["673"] = 666,["674"] = 667,["675"] = 670,["676"] = 671,["677"] = 672,["678"] = 673,["679"] = 674,["681"] = 676,["683"] = 679,["684"] = 680,["685"] = 682,["686"] = 683,["687"] = 683,["688"] = 683,["689"] = 684,["690"] = 683,["691"] = 683,["694"] = 689,["695"] = 690,["696"] = 690,["697"] = 690,["698"] = 691,["699"] = 690,["700"] = 690,["701"] = 719,["702"] = 666,["703"] = 722,["704"] = 723,["705"] = 724,["706"] = 726,["707"] = 730,["708"] = 731,["710"] = 734,["711"] = 735,["712"] = 735,["713"] = 735,["714"] = 735,["715"] = 736,["716"] = 737,["718"] = 740,["719"] = 741,["720"] = 741,["721"] = 741,["722"] = 742,["723"] = 741,["724"] = 741,["725"] = 745,["726"] = 746,["727"] = 748,["728"] = 749,["729"] = 749,["730"] = 749,["731"] = 750,["732"] = 749,["733"] = 749,["736"] = 755,["737"] = 722,["738"] = 758,["739"] = 759,["740"] = 761,["741"] = 762,["743"] = 758,["744"] = 766,["745"] = 767,["746"] = 768,["747"] = 769,["748"] = 771,["749"] = 772,["750"] = 773,["751"] = 774,["755"] = 779,["758"] = 783,["759"] = 784,["761"] = 787,["762"] = 788,["763"] = 789,["765"] = 792,["766"] = 793,["768"] = 796,["769"] = 797,["770"] = 798,["771"] = 799,["772"] = 799,["773"] = 799,["774"] = 800,["775"] = 801,["777"] = 799,["778"] = 799,["782"] = 808,["783"] = 809,["784"] = 810,["785"] = 811,["786"] = 813,["787"] = 814,["788"] = 815,["789"] = 816,["794"] = 766,["795"] = 823,["796"] = 824,["797"] = 825,["798"] = 827,["799"] = 828,["800"] = 830,["801"] = 831,["802"] = 832,["803"] = 832,["804"] = 832,["805"] = 833,["806"] = 834,["807"] = 835,["808"] = 836,["811"] = 832,["812"] = 832,["813"] = 841,["814"] = 842,["815"] = 843,["816"] = 844,["820"] = 849,["823"] = 823,["824"] = 854,["825"] = 855,["826"] = 854,["827"] = 858,["828"] = 859,["829"] = 860,["830"] = 861,["832"] = 864,["833"] = 865,["835"] = 868,["836"] = 869,["838"] = 872,["839"] = 873,["840"] = 874,["841"] = 875,["842"] = 876,["843"] = 877,["844"] = 878,["848"] = 883,["849"] = 858,["850"] = 886,["851"] = 887,["852"] = 888,["853"] = 886,["854"] = 891,["855"] = 892,["856"] = 891,["857"] = 895,["858"] = 896,["859"] = 895,["860"] = 899,["861"] = 900,["862"] = 899,["863"] = 903,["864"] = 904,["865"] = 906,["866"] = 907,["867"] = 908,["869"] = 910,["872"] = 913,["874"] = 915,["875"] = 916,["876"] = 903,["877"] = 919,["878"] = 920,["879"] = 920,["880"] = 920,["881"] = 920,["882"] = 919,["883"] = 923,["884"] = 924,["885"] = 925,["886"] = 927,["887"] = 928,["888"] = 929,["890"] = 932,["891"] = 933,["893"] = 936,["894"] = 937,["895"] = 938,["897"] = 940,["898"] = 941,["899"] = 941,["900"] = 941,["901"] = 941,["902"] = 941,["903"] = 942,["906"] = 945,["908"] = 923,["909"] = 949,["910"] = 950,["911"] = 951,["912"] = 952,["913"] = 953,["915"] = 949,["916"] = 957,["917"] = 958,["918"] = 959,["919"] = 961,["920"] = 962,["922"] = 965,["923"] = 966,["926"] = 957,["927"] = 971,["928"] = 972,["929"] = 972,["930"] = 972,["931"] = 973,["932"] = 974,["933"] = 974,["934"] = 974,["935"] = 974,["936"] = 975,["938"] = 972,["939"] = 972,["940"] = 971,["941"] = 980,["942"] = 981,["943"] = 981,["944"] = 981,["945"] = 982,["946"] = 983,["947"] = 984,["948"] = 986,["949"] = 987,["950"] = 987,["951"] = 987,["952"] = 987,["953"] = 988,["955"] = 990,["956"] = 991,["957"] = 992,["958"] = 992,["959"] = 992,["960"] = 992,["961"] = 993,["965"] = 981,["966"] = 981,["967"] = 980,["968"] = 1000,["969"] = 1001,["970"] = 1001,["971"] = 1001,["972"] = 1001,["973"] = 1002,["974"] = 1003,["976"] = 1005,["977"] = 1000,["978"] = 1008,["979"] = 1009,["980"] = 1009,["981"] = 1009,["982"] = 1009,["983"] = 1010,["984"] = 1011,["986"] = 1013,["987"] = 1008,["988"] = 1016,["989"] = 1017,["990"] = 1017,["991"] = 1017,["992"] = 1017,["993"] = 1016,["994"] = 1020,["995"] = 1021,["996"] = 1020,["997"] = 1024,["998"] = 1025,["999"] = 1027,["1000"] = 1028,["1002"] = 1031,["1003"] = 1024,["1004"] = 1034,["1005"] = 1035,["1006"] = 1036,["1007"] = 1037,["1008"] = 1038,["1009"] = 1038,["1010"] = 1038,["1011"] = 1038,["1012"] = 1038,["1013"] = 1038,["1014"] = 1040,["1015"] = 1047,["1016"] = 1048,["1017"] = 1034,["1018"] = 1051,["1019"] = 1052,["1020"] = 1051,["1021"] = 1056,["1022"] = 1056,["1023"] = 71,["1024"] = 1060,["1025"] = 1060,["1026"] = 1060,["1027"] = 1060,["1028"] = 1065,["1029"] = 1066});
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
require("util.custom_abilities_legacy")
require("util.custom_entities_legacy")
require("util.math_legacy")
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
local ____custom_npc = require("clases.custom_npc")
local CustomNPC = ____custom_npc.default
local CustomNonPlayerHeroNPC = ____custom_npc.CustomNonPlayerHeroNPC
local CustomPlayerHeroNPC = ____custom_npc.CustomPlayerHeroNPC
local ____custom_items = require("util.custom_items")
local CustomItems = ____custom_items.CustomItems
local ____pickup = require("clases.pickup")
local Pickup = ____pickup.default
local PickupTypes = ____pickup.PickupTypes
local ____level = require("clases.level")
local Level = ____level.default
local ____settings = require("settings")
local settings = ____settings.default
local ____pre_level = require("clases.pre_level")
local PreLevel = ____pre_level.default
local ____custom_ai = require("clases.custom_ai")
local NPCNames = ____custom_ai.NPCNames
local ____upgrades = require("upgrades")
local Upgrades = ____upgrades.default
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
    self.levelsData = {}
    self.max_treshold = 30
    self.currentLevel = -1
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
    self:SetState(CustomGameState.PRE_LEVEL)
    self:GenerateLevelData()
    self.pre_level = __TS__New(PreLevel, self.alliances, settings.PreWaveDuration)
    self:RegisterThinker(
        0.01,
        function()
            if (self.state == CustomGameState.LEVEL_IN_PROGRESS) and self.level then
                self.level:Update()
            end
            if (self.state == CustomGameState.PRE_LEVEL) and self.pre_level then
                self.pre_level:Update()
            end
        end
    )
end
function GameMode.prototype.GenerateLevelData(self)
    local bossLevels = {4, 9, 14, 19}
    local npcs = {NPCNames.RADIANT_ZOMBIE_HEALER, NPCNames.DIRE_ZOMBIE, NPCNames.DIRE_ZOMBIE_RAGER, NPCNames.DIRE_ZOMBIE_MEELE, NPCNames.FLYING_SKULL}
    local bosses = {NPCNames.QUEEN, NPCNames.CENTAUR}
    do
        local i = 0
        while i < 20 do
            local isBossLevel = __TS__ArrayFilter(
                bossLevels,
                function(____, level) return level == i end
            )[1]
            local amount = (isBossLevel and 1) or (i + 3)
            local npcsToUse = (isBossLevel and bosses) or npcs
            local wavesNumber = (isBossLevel and 1) or 3
            local waves = self:GenerateWaves(npcsToUse, wavesNumber, amount)
            __TS__ArrayPush(self.levelsData, {waves = waves, currentLevel = i, totalNpcs = amount * wavesNumber})
            i = i + 1
        end
    end
end
function GameMode.prototype.GenerateWaves(self, possibleNPCs, wavesNumber, npcsPerWave)
    local waves = {}
    do
        local i = 0
        while i < wavesNumber do
            __TS__ArrayPush(
                waves,
                self:GenerateWave(possibleNPCs, npcsPerWave)
            )
            i = i + 1
        end
    end
    return waves
end
function GameMode.prototype.GenerateWave(self, possibleNPCs, amount)
    local npcGroups = {}
    local remainingNpcs = amount
    local remainingPossibleNPCs = possibleNPCs
    while remainingNpcs > 0 do
        local currentNPC = RandomInt(remainingPossibleNPCs[1], remainingPossibleNPCs[#remainingPossibleNPCs])
        local currentAmmountToGenerate = ((#remainingPossibleNPCs == 1) and remainingNpcs) or RandomInt(1, remainingNpcs)
        __TS__ArrayPush(npcGroups, {name = currentNPC, ammount = currentAmmountToGenerate})
        remainingPossibleNPCs = __TS__ArrayFilter(
            remainingPossibleNPCs,
            function(____, npc) return npc ~= currentNPC end
        )
        remainingNpcs = remainingNpcs - currentAmmountToGenerate
    end
    return {totalNpcs = amount, npcGroups = npcGroups}
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
    CustomGameEventManager:RegisterListener(
        "custom_npc:apply_upgrade",
        function(eventSourceIndex, event)
            local playerId = event.playerIndex
            local player = self:FindPlayerById(playerId)
            if player then
                local customNpc = player.customNpc
                if customNpc then
                    local upgrade = __TS__ArrayFilter(
                        Upgrades,
                        function(____, currentUpgrade) return currentUpgrade.id == event.payload.upgradeId end
                    )[1]
                    if upgrade then
                        customNpc:ApplyUpgrade(upgrade)
                    end
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
    if self:IsPVE() then
        LinkLuaModifier("modifier_upgrade_meele_extra_radius", "modifiers/upgrades/modifier_upgrade_meele_extra_radius", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_phantom_extra_daggers", "modifiers/upgrades/modifier_upgrade_phantom_extra_daggers", LUA_MODIFIER_MOTION_NONE)
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
        self.pre_round = __TS__New(PreRound, self.alliances, settings.PreRoundDuration)
    elseif state == CustomGameState.PRE_ROUND then
        self.pre_round = nil
        self.round = __TS__New(Round, self.alliances, settings.RoundDuration)
    elseif state == CustomGameState.PRE_LEVEL then
        self.pre_level = nil
        self:IncrementWave()
        local levelsData = self.levelsData[self.currentLevel + 1]
        if levelsData then
            self.level = __TS__New(Level, self.alliances, -1, levelsData)
        else
            self:EndGame(0)
        end
    elseif state == CustomGameState.LEVEL_IN_PROGRESS then
        self.level = nil
        self.pre_level = __TS__New(PreLevel, self.alliances, settings.PreWaveDuration)
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
    if event.text == "-skip" then
        if self:IsPVE() then
            if self.level then
                __TS__ArrayForEach(
                    self.level.ais,
                    function(____, ai)
                        if ai.unit:IsAlive() then
                            ai.unit:ForceKill(false)
                        end
                    end
                )
            end
        end
    end
    if event.text == "-upgrade" then
        if self:IsPVE() then
            local playerId = event.playerid
            local player = self:FindPlayerById(playerId)
            if player then
                local customNpc = player.customNpc
                if customNpc then
                    customNpc:RequestUpgrades()
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
    if npc:GetName() == "npc_dota_thinker" then
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
    self.currentLevel = self.currentLevel + 1
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
    if self.level then
        self.level:OnUnitDies(killed)
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
        if self.level then
            self.level:OnUnitHurt(victim)
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
