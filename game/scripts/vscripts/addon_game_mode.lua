--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 19,["30"] = 19,["31"] = 20,["32"] = 20,["33"] = 20,["34"] = 20,["35"] = 21,["36"] = 21,["37"] = 22,["38"] = 22,["39"] = 22,["40"] = 23,["41"] = 23,["42"] = 24,["43"] = 24,["44"] = 25,["45"] = 25,["46"] = 26,["47"] = 26,["48"] = 27,["49"] = 27,["50"] = 49,["51"] = 54,["52"] = 54,["53"] = 54,["54"] = 54,["55"] = 54,["56"] = 59,["57"] = 59,["58"] = 59,["59"] = 59,["60"] = 59,["61"] = 64,["62"] = 65,["63"] = 66,["64"] = 67,["65"] = 68,["66"] = 70,["67"] = 72,["68"] = 73,["69"] = 72,["71"] = 74,["72"] = 75,["73"] = 76,["74"] = 77,["75"] = 78,["76"] = 80,["77"] = 83,["78"] = 87,["79"] = 88,["80"] = 91,["81"] = 91,["82"] = 91,["83"] = 91,["84"] = 91,["85"] = 91,["86"] = 91,["87"] = 93,["88"] = 94,["89"] = 95,["90"] = 96,["91"] = 97,["92"] = 99,["93"] = 100,["94"] = 101,["95"] = 102,["96"] = 90,["97"] = 106,["98"] = 107,["99"] = 108,["100"] = 109,["101"] = 110,["102"] = 111,["103"] = 112,["104"] = 113,["105"] = 114,["106"] = 115,["107"] = 116,["108"] = 118,["109"] = 119,["110"] = 120,["111"] = 121,["112"] = 122,["113"] = 123,["114"] = 125,["115"] = 126,["116"] = 127,["117"] = 129,["118"] = 130,["119"] = 131,["120"] = 132,["122"] = 106,["123"] = 136,["124"] = 137,["125"] = 136,["126"] = 140,["127"] = 141,["128"] = 141,["129"] = 141,["130"] = 141,["131"] = 142,["132"] = 142,["133"] = 142,["134"] = 142,["135"] = 143,["136"] = 143,["137"] = 143,["138"] = 143,["139"] = 144,["140"] = 144,["141"] = 144,["142"] = 144,["143"] = 145,["144"] = 145,["145"] = 145,["146"] = 145,["147"] = 147,["148"] = 148,["149"] = 149,["150"] = 150,["152"] = 153,["153"] = 153,["154"] = 153,["155"] = 154,["156"] = 155,["157"] = 155,["158"] = 155,["159"] = 156,["160"] = 155,["161"] = 155,["162"] = 153,["163"] = 153,["164"] = 140,["165"] = 161,["166"] = 162,["167"] = 163,["168"] = 164,["169"] = 166,["170"] = 167,["171"] = 168,["172"] = 170,["173"] = 170,["174"] = 170,["175"] = 171,["176"] = 172,["178"] = 174,["179"] = 175,["181"] = 178,["182"] = 179,["184"] = 170,["185"] = 170,["186"] = 161,["187"] = 184,["188"] = 185,["189"] = 186,["190"] = 187,["191"] = 189,["192"] = 189,["193"] = 189,["194"] = 190,["195"] = 191,["197"] = 193,["198"] = 194,["200"] = 189,["201"] = 189,["202"] = 184,["203"] = 199,["204"] = 200,["205"] = 201,["206"] = 202,["208"] = 204,["209"] = 204,["210"] = 205,["211"] = 205,["212"] = 205,["213"] = 205,["214"] = 206,["215"] = 207,["216"] = 208,["217"] = 209,["218"] = 210,["219"] = 204,["222"] = 199,["223"] = 218,["224"] = 219,["226"] = 220,["227"] = 220,["228"] = 221,["229"] = 221,["230"] = 221,["231"] = 221,["232"] = 220,["235"] = 224,["236"] = 218,["237"] = 227,["238"] = 228,["239"] = 229,["240"] = 230,["241"] = 232,["242"] = 233,["243"] = 234,["244"] = 236,["245"] = 241,["246"] = 241,["247"] = 241,["248"] = 241,["249"] = 242,["251"] = 245,["252"] = 227,["253"] = 248,["254"] = 249,["255"] = 250,["257"] = 252,["258"] = 254,["259"] = 255,["260"] = 255,["261"] = 255,["262"] = 256,["263"] = 257,["264"] = 258,["266"] = 255,["267"] = 255,["269"] = 263,["270"] = 248,["271"] = 266,["272"] = 267,["273"] = 268,["274"] = 269,["275"] = 270,["276"] = 271,["277"] = 272,["278"] = 273,["279"] = 274,["280"] = 275,["281"] = 276,["282"] = 277,["283"] = 279,["284"] = 280,["285"] = 281,["286"] = 282,["288"] = 284,["289"] = 266,["290"] = 287,["291"] = 288,["292"] = 289,["293"] = 290,["294"] = 291,["295"] = 292,["296"] = 287,["297"] = 295,["298"] = 296,["299"] = 297,["300"] = 298,["301"] = 299,["302"] = 295,["303"] = 302,["304"] = 303,["305"] = 303,["306"] = 303,["307"] = 303,["308"] = 303,["309"] = 304,["310"] = 304,["311"] = 304,["312"] = 304,["313"] = 304,["314"] = 305,["315"] = 305,["316"] = 305,["317"] = 305,["318"] = 305,["319"] = 306,["320"] = 306,["321"] = 306,["322"] = 306,["323"] = 306,["324"] = 307,["325"] = 307,["326"] = 307,["327"] = 307,["328"] = 307,["329"] = 308,["330"] = 308,["331"] = 308,["332"] = 308,["333"] = 308,["334"] = 310,["335"] = 302,["336"] = 313,["337"] = 314,["338"] = 314,["339"] = 314,["340"] = 315,["341"] = 316,["342"] = 317,["343"] = 318,["344"] = 319,["346"] = 314,["347"] = 314,["348"] = 323,["349"] = 323,["350"] = 323,["351"] = 323,["352"] = 323,["353"] = 327,["354"] = 327,["355"] = 327,["356"] = 328,["357"] = 329,["358"] = 331,["359"] = 332,["360"] = 334,["361"] = 335,["362"] = 337,["363"] = 338,["364"] = 339,["365"] = 340,["366"] = 342,["367"] = 343,["369"] = 346,["370"] = 347,["371"] = 348,["374"] = 327,["375"] = 327,["376"] = 353,["377"] = 353,["378"] = 353,["379"] = 354,["380"] = 355,["381"] = 357,["382"] = 358,["383"] = 360,["385"] = 361,["386"] = 361,["387"] = 362,["388"] = 363,["389"] = 364,["390"] = 365,["393"] = 361,["396"] = 370,["397"] = 371,["400"] = 375,["401"] = 376,["402"] = 376,["403"] = 376,["405"] = 353,["406"] = 353,["407"] = 380,["408"] = 380,["409"] = 380,["410"] = 381,["411"] = 382,["412"] = 384,["413"] = 385,["414"] = 386,["415"] = 387,["416"] = 388,["417"] = 389,["420"] = 380,["421"] = 380,["422"] = 394,["423"] = 394,["424"] = 394,["425"] = 395,["426"] = 396,["427"] = 398,["428"] = 399,["429"] = 400,["430"] = 401,["431"] = 401,["432"] = 401,["433"] = 401,["434"] = 402,["435"] = 403,["439"] = 394,["440"] = 394,["441"] = 313,["442"] = 410,["443"] = 411,["444"] = 412,["445"] = 413,["446"] = 414,["447"] = 415,["448"] = 416,["449"] = 417,["450"] = 410,["451"] = 420,["452"] = 421,["453"] = 422,["454"] = 423,["455"] = 424,["456"] = 425,["457"] = 426,["458"] = 428,["459"] = 429,["460"] = 430,["461"] = 431,["462"] = 432,["463"] = 434,["464"] = 435,["465"] = 436,["466"] = 437,["467"] = 438,["468"] = 439,["469"] = 440,["470"] = 441,["471"] = 442,["472"] = 443,["473"] = 444,["474"] = 445,["475"] = 446,["476"] = 447,["477"] = 448,["478"] = 449,["479"] = 450,["480"] = 451,["481"] = 452,["482"] = 453,["483"] = 454,["484"] = 455,["485"] = 456,["486"] = 458,["487"] = 459,["488"] = 460,["489"] = 461,["490"] = 462,["491"] = 463,["492"] = 464,["493"] = 465,["494"] = 466,["495"] = 467,["496"] = 468,["497"] = 469,["498"] = 470,["499"] = 471,["501"] = 474,["502"] = 420,["503"] = 477,["504"] = 478,["505"] = 477,["506"] = 481,["507"] = 482,["508"] = 482,["509"] = 482,["510"] = 482,["511"] = 482,["512"] = 488,["513"] = 481,["514"] = 491,["515"] = 492,["516"] = 494,["517"] = 494,["518"] = 494,["519"] = 495,["520"] = 495,["521"] = 495,["522"] = 496,["523"] = 497,["525"] = 495,["526"] = 495,["527"] = 494,["528"] = 494,["529"] = 502,["530"] = 491,["531"] = 505,["532"] = 506,["533"] = 507,["534"] = 508,["535"] = 510,["536"] = 511,["537"] = 512,["538"] = 512,["539"] = 512,["540"] = 512,["541"] = 512,["542"] = 513,["544"] = 515,["545"] = 516,["546"] = 517,["547"] = 518,["548"] = 519,["549"] = 521,["550"] = 522,["551"] = 523,["553"] = 526,["554"] = 527,["555"] = 528,["556"] = 529,["557"] = 531,["559"] = 534,["561"] = 505,["562"] = 538,["563"] = 539,["564"] = 540,["565"] = 541,["566"] = 542,["567"] = 543,["568"] = 538,["569"] = 546,["570"] = 547,["571"] = 548,["572"] = 549,["573"] = 551,["574"] = 552,["575"] = 553,["576"] = 555,["577"] = 556,["578"] = 557,["579"] = 559,["580"] = 560,["581"] = 561,["582"] = 563,["583"] = 564,["584"] = 565,["586"] = 567,["588"] = 570,["589"] = 571,["590"] = 572,["592"] = 546,["593"] = 576,["594"] = 577,["595"] = 578,["596"] = 580,["597"] = 580,["598"] = 580,["599"] = 581,["600"] = 581,["601"] = 581,["602"] = 581,["603"] = 581,["604"] = 581,["605"] = 580,["606"] = 580,["607"] = 584,["608"] = 576,["609"] = 587,["610"] = 588,["611"] = 589,["612"] = 597,["613"] = 598,["614"] = 599,["615"] = 599,["616"] = 599,["617"] = 599,["618"] = 599,["619"] = 599,["620"] = 599,["621"] = 599,["622"] = 600,["623"] = 587,["624"] = 603,["625"] = 604,["626"] = 605,["627"] = 606,["629"] = 603,["630"] = 610,["631"] = 611,["632"] = 610,["633"] = 614,["634"] = 615,["635"] = 617,["636"] = 622,["637"] = 623,["638"] = 624,["639"] = 625,["640"] = 627,["641"] = 628,["642"] = 629,["644"] = 632,["645"] = 633,["646"] = 638,["647"] = 638,["648"] = 638,["649"] = 639,["650"] = 639,["651"] = 639,["652"] = 640,["653"] = 640,["654"] = 640,["655"] = 640,["656"] = 642,["657"] = 643,["659"] = 646,["660"] = 647,["661"] = 647,["662"] = 647,["663"] = 648,["664"] = 649,["666"] = 652,["669"] = 656,["670"] = 657,["671"] = 658,["672"] = 659,["673"] = 660,["674"] = 661,["678"] = 665,["679"] = 666,["681"] = 668,["682"] = 669,["684"] = 672,["685"] = 614,["686"] = 675,["687"] = 676,["688"] = 675,["689"] = 679,["690"] = 680,["691"] = 683,["692"] = 684,["693"] = 685,["694"] = 686,["695"] = 687,["697"] = 689,["699"] = 692,["700"] = 693,["701"] = 695,["702"] = 696,["703"] = 696,["704"] = 696,["705"] = 697,["706"] = 696,["707"] = 696,["710"] = 702,["711"] = 703,["712"] = 703,["713"] = 703,["714"] = 704,["715"] = 703,["716"] = 703,["717"] = 732,["718"] = 679,["719"] = 735,["720"] = 736,["721"] = 737,["722"] = 739,["723"] = 743,["724"] = 744,["726"] = 747,["727"] = 748,["728"] = 748,["729"] = 748,["730"] = 748,["731"] = 749,["732"] = 750,["734"] = 753,["735"] = 754,["736"] = 754,["737"] = 754,["738"] = 755,["739"] = 754,["740"] = 754,["741"] = 758,["742"] = 759,["743"] = 761,["744"] = 762,["745"] = 762,["746"] = 762,["747"] = 763,["748"] = 762,["749"] = 762,["752"] = 768,["753"] = 735,["754"] = 771,["755"] = 772,["756"] = 774,["757"] = 775,["759"] = 771,["760"] = 779,["761"] = 780,["762"] = 781,["763"] = 782,["764"] = 784,["765"] = 785,["766"] = 786,["767"] = 787,["771"] = 792,["774"] = 796,["775"] = 797,["777"] = 800,["778"] = 801,["779"] = 802,["781"] = 805,["782"] = 806,["784"] = 809,["785"] = 810,["786"] = 811,["787"] = 812,["791"] = 817,["792"] = 818,["795"] = 821,["796"] = 822,["797"] = 822,["798"] = 822,["799"] = 822,["800"] = 823,["801"] = 823,["802"] = 823,["805"] = 826,["808"] = 829,["809"] = 830,["810"] = 831,["811"] = 832,["815"] = 838,["816"] = 839,["817"] = 840,["818"] = 841,["819"] = 843,["820"] = 844,["821"] = 845,["822"] = 846,["827"] = 779,["828"] = 853,["829"] = 854,["830"] = 855,["831"] = 857,["832"] = 858,["833"] = 860,["834"] = 861,["835"] = 862,["836"] = 862,["837"] = 862,["838"] = 863,["839"] = 864,["840"] = 865,["841"] = 866,["844"] = 862,["845"] = 862,["846"] = 871,["847"] = 872,["848"] = 873,["849"] = 874,["853"] = 879,["856"] = 853,["857"] = 884,["858"] = 885,["859"] = 884,["860"] = 888,["861"] = 889,["862"] = 890,["863"] = 891,["865"] = 894,["866"] = 895,["868"] = 898,["869"] = 899,["871"] = 902,["872"] = 903,["873"] = 904,["874"] = 905,["875"] = 906,["876"] = 907,["877"] = 908,["881"] = 913,["882"] = 888,["883"] = 916,["884"] = 917,["885"] = 918,["886"] = 916,["887"] = 921,["888"] = 922,["889"] = 921,["890"] = 925,["891"] = 926,["892"] = 925,["893"] = 929,["894"] = 930,["895"] = 929,["896"] = 933,["897"] = 934,["898"] = 936,["899"] = 937,["900"] = 938,["902"] = 940,["905"] = 943,["907"] = 945,["908"] = 946,["909"] = 933,["910"] = 949,["911"] = 950,["912"] = 950,["913"] = 950,["914"] = 950,["915"] = 949,["916"] = 953,["917"] = 954,["918"] = 955,["919"] = 957,["920"] = 958,["921"] = 959,["923"] = 962,["924"] = 963,["926"] = 966,["927"] = 967,["928"] = 968,["930"] = 970,["931"] = 971,["932"] = 971,["933"] = 971,["934"] = 971,["935"] = 971,["936"] = 972,["939"] = 975,["941"] = 953,["942"] = 979,["943"] = 980,["944"] = 981,["945"] = 982,["946"] = 983,["948"] = 979,["949"] = 987,["950"] = 988,["951"] = 989,["952"] = 991,["953"] = 992,["955"] = 995,["956"] = 996,["959"] = 987,["960"] = 1001,["961"] = 1002,["962"] = 1002,["963"] = 1002,["964"] = 1003,["965"] = 1004,["966"] = 1004,["967"] = 1004,["968"] = 1004,["969"] = 1005,["971"] = 1002,["972"] = 1002,["973"] = 1001,["974"] = 1010,["975"] = 1011,["976"] = 1011,["977"] = 1011,["978"] = 1012,["979"] = 1013,["980"] = 1014,["981"] = 1016,["982"] = 1017,["983"] = 1017,["984"] = 1017,["985"] = 1017,["986"] = 1018,["988"] = 1020,["989"] = 1021,["990"] = 1022,["991"] = 1022,["992"] = 1022,["993"] = 1022,["994"] = 1023,["998"] = 1011,["999"] = 1011,["1000"] = 1010,["1001"] = 1030,["1002"] = 1031,["1003"] = 1031,["1004"] = 1031,["1005"] = 1031,["1006"] = 1032,["1007"] = 1033,["1009"] = 1035,["1010"] = 1030,["1011"] = 1038,["1012"] = 1039,["1013"] = 1039,["1014"] = 1039,["1015"] = 1039,["1016"] = 1040,["1017"] = 1041,["1019"] = 1043,["1020"] = 1038,["1021"] = 1046,["1022"] = 1047,["1023"] = 1047,["1024"] = 1047,["1025"] = 1047,["1026"] = 1046,["1027"] = 1050,["1028"] = 1051,["1029"] = 1050,["1030"] = 1054,["1031"] = 1055,["1032"] = 1057,["1033"] = 1058,["1035"] = 1061,["1036"] = 1054,["1037"] = 1064,["1038"] = 1065,["1039"] = 1066,["1040"] = 1067,["1041"] = 1068,["1042"] = 1068,["1043"] = 1068,["1044"] = 1068,["1045"] = 1068,["1046"] = 1068,["1047"] = 1070,["1048"] = 1077,["1049"] = 1078,["1050"] = 1064,["1051"] = 1081,["1052"] = 1082,["1053"] = 1081,["1054"] = 1086,["1055"] = 1086,["1056"] = 72,["1057"] = 1090,["1058"] = 1090,["1059"] = 1090,["1060"] = 1090,["1061"] = 1095,["1062"] = 1096});
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
        LinkLuaModifier("modifier_upgrade_extra_movement_speed", "modifiers/upgrades/modifier_upgrade_extra_movement_speed", LUA_MODIFIER_MOTION_NONE)
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
                self.level:SkipWave()
            end
        end
    end
    if __TS__StringSplit(event.text, " ")[1] == "-level" then
        if not __TS__StringSplit(event.text, " ")[2] then
            return
        end
        if self:IsPVE() then
            local level = __TS__ParseInt(
                __TS__StringSplit(event.text, " ")[2],
                10
            )
            if __TS__NumberIsNaN(
                __TS__Number(level)
            ) then
                return
            end
            if not self.levelsData[level + 1] then
                return
            end
            print(level)
            self.currentLevel = level - 1
            if self.level then
                self.level:SkipLevel()
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
