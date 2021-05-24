--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 19,["30"] = 19,["31"] = 20,["32"] = 20,["33"] = 20,["34"] = 20,["35"] = 21,["36"] = 21,["37"] = 22,["38"] = 22,["39"] = 22,["40"] = 23,["41"] = 23,["42"] = 24,["43"] = 24,["44"] = 25,["45"] = 25,["46"] = 26,["47"] = 26,["48"] = 27,["49"] = 27,["50"] = 49,["51"] = 54,["52"] = 54,["53"] = 54,["54"] = 54,["55"] = 54,["56"] = 59,["57"] = 59,["58"] = 59,["59"] = 59,["60"] = 59,["61"] = 64,["62"] = 65,["63"] = 66,["64"] = 67,["65"] = 68,["66"] = 70,["67"] = 72,["68"] = 73,["69"] = 72,["71"] = 74,["72"] = 75,["73"] = 76,["74"] = 77,["75"] = 78,["76"] = 80,["77"] = 83,["78"] = 87,["79"] = 88,["80"] = 91,["81"] = 91,["82"] = 91,["83"] = 91,["84"] = 91,["85"] = 91,["86"] = 91,["87"] = 93,["88"] = 94,["89"] = 95,["90"] = 96,["91"] = 97,["92"] = 99,["93"] = 100,["94"] = 101,["95"] = 102,["96"] = 90,["97"] = 106,["98"] = 107,["99"] = 108,["100"] = 109,["101"] = 110,["102"] = 111,["103"] = 112,["104"] = 113,["105"] = 114,["106"] = 115,["107"] = 116,["108"] = 118,["109"] = 119,["110"] = 120,["111"] = 121,["112"] = 122,["113"] = 123,["114"] = 125,["115"] = 126,["116"] = 127,["117"] = 129,["118"] = 130,["119"] = 131,["120"] = 132,["122"] = 106,["123"] = 136,["124"] = 137,["125"] = 136,["126"] = 140,["127"] = 141,["128"] = 141,["129"] = 141,["130"] = 141,["131"] = 142,["132"] = 142,["133"] = 142,["134"] = 142,["135"] = 143,["136"] = 143,["137"] = 143,["138"] = 143,["139"] = 144,["140"] = 144,["141"] = 144,["142"] = 144,["143"] = 145,["144"] = 145,["145"] = 145,["146"] = 145,["147"] = 147,["148"] = 148,["149"] = 149,["150"] = 150,["152"] = 153,["153"] = 153,["154"] = 153,["155"] = 154,["156"] = 155,["157"] = 155,["158"] = 155,["159"] = 156,["160"] = 155,["161"] = 155,["162"] = 153,["163"] = 153,["164"] = 140,["165"] = 161,["166"] = 162,["167"] = 163,["168"] = 164,["169"] = 166,["170"] = 167,["171"] = 168,["172"] = 170,["173"] = 170,["174"] = 170,["175"] = 171,["176"] = 172,["178"] = 174,["179"] = 175,["181"] = 178,["182"] = 179,["184"] = 170,["185"] = 170,["186"] = 161,["187"] = 184,["188"] = 185,["189"] = 186,["190"] = 187,["191"] = 189,["192"] = 189,["193"] = 189,["194"] = 190,["195"] = 191,["197"] = 193,["198"] = 194,["200"] = 189,["201"] = 189,["202"] = 184,["203"] = 199,["204"] = 200,["205"] = 201,["206"] = 202,["208"] = 204,["209"] = 204,["210"] = 205,["211"] = 205,["212"] = 205,["213"] = 205,["214"] = 206,["215"] = 207,["216"] = 208,["217"] = 209,["218"] = 210,["219"] = 204,["222"] = 199,["223"] = 218,["224"] = 219,["226"] = 220,["227"] = 220,["228"] = 221,["229"] = 221,["230"] = 221,["231"] = 221,["232"] = 220,["235"] = 224,["236"] = 218,["237"] = 227,["238"] = 228,["239"] = 229,["240"] = 230,["241"] = 232,["242"] = 233,["243"] = 234,["244"] = 236,["245"] = 241,["246"] = 241,["247"] = 241,["248"] = 241,["249"] = 242,["251"] = 245,["252"] = 227,["253"] = 248,["254"] = 249,["255"] = 250,["257"] = 252,["258"] = 254,["259"] = 255,["260"] = 255,["261"] = 255,["262"] = 256,["263"] = 257,["264"] = 258,["266"] = 255,["267"] = 255,["269"] = 263,["270"] = 248,["271"] = 266,["272"] = 267,["273"] = 268,["274"] = 269,["275"] = 270,["276"] = 271,["277"] = 272,["278"] = 273,["279"] = 274,["280"] = 275,["281"] = 276,["282"] = 277,["283"] = 279,["284"] = 280,["285"] = 281,["286"] = 282,["288"] = 284,["289"] = 266,["290"] = 287,["291"] = 288,["292"] = 289,["293"] = 290,["294"] = 291,["295"] = 292,["296"] = 287,["297"] = 295,["298"] = 296,["299"] = 297,["300"] = 298,["301"] = 299,["302"] = 295,["303"] = 302,["304"] = 303,["305"] = 303,["306"] = 303,["307"] = 303,["308"] = 303,["309"] = 304,["310"] = 304,["311"] = 304,["312"] = 304,["313"] = 304,["314"] = 305,["315"] = 305,["316"] = 305,["317"] = 305,["318"] = 305,["319"] = 306,["320"] = 306,["321"] = 306,["322"] = 306,["323"] = 306,["324"] = 307,["325"] = 307,["326"] = 307,["327"] = 307,["328"] = 307,["329"] = 308,["330"] = 308,["331"] = 308,["332"] = 308,["333"] = 308,["334"] = 310,["335"] = 302,["336"] = 313,["337"] = 314,["338"] = 314,["339"] = 314,["340"] = 315,["341"] = 316,["342"] = 317,["343"] = 318,["344"] = 319,["346"] = 314,["347"] = 314,["348"] = 323,["349"] = 323,["350"] = 323,["351"] = 323,["352"] = 323,["353"] = 327,["354"] = 327,["355"] = 327,["356"] = 328,["357"] = 329,["358"] = 331,["359"] = 332,["360"] = 334,["361"] = 335,["362"] = 337,["363"] = 338,["364"] = 339,["365"] = 340,["366"] = 342,["367"] = 343,["369"] = 346,["370"] = 347,["371"] = 348,["374"] = 327,["375"] = 327,["376"] = 353,["377"] = 353,["378"] = 353,["379"] = 354,["380"] = 355,["381"] = 357,["382"] = 358,["383"] = 360,["385"] = 361,["386"] = 361,["387"] = 362,["388"] = 363,["389"] = 364,["390"] = 365,["393"] = 361,["396"] = 370,["397"] = 371,["400"] = 375,["401"] = 376,["402"] = 376,["403"] = 376,["405"] = 353,["406"] = 353,["407"] = 380,["408"] = 380,["409"] = 380,["410"] = 381,["411"] = 382,["412"] = 384,["413"] = 385,["414"] = 386,["415"] = 387,["416"] = 388,["417"] = 389,["420"] = 380,["421"] = 380,["422"] = 394,["423"] = 394,["424"] = 394,["425"] = 395,["426"] = 396,["427"] = 398,["428"] = 399,["429"] = 400,["430"] = 401,["431"] = 401,["432"] = 401,["433"] = 401,["434"] = 402,["435"] = 403,["439"] = 394,["440"] = 394,["441"] = 313,["442"] = 410,["443"] = 411,["444"] = 412,["445"] = 413,["446"] = 414,["447"] = 415,["448"] = 416,["449"] = 417,["450"] = 410,["451"] = 420,["452"] = 421,["453"] = 422,["454"] = 423,["455"] = 424,["456"] = 425,["457"] = 426,["458"] = 428,["459"] = 429,["460"] = 430,["461"] = 431,["462"] = 432,["463"] = 434,["464"] = 435,["465"] = 436,["466"] = 437,["467"] = 438,["468"] = 439,["469"] = 440,["470"] = 441,["471"] = 442,["472"] = 443,["473"] = 444,["474"] = 445,["475"] = 446,["476"] = 447,["477"] = 448,["478"] = 449,["479"] = 450,["480"] = 451,["481"] = 452,["482"] = 453,["483"] = 454,["484"] = 455,["485"] = 456,["486"] = 458,["487"] = 459,["488"] = 460,["489"] = 461,["490"] = 462,["491"] = 463,["492"] = 464,["493"] = 465,["494"] = 466,["495"] = 467,["496"] = 468,["497"] = 469,["499"] = 472,["500"] = 420,["501"] = 475,["502"] = 476,["503"] = 475,["504"] = 479,["505"] = 480,["506"] = 480,["507"] = 480,["508"] = 480,["509"] = 480,["510"] = 486,["511"] = 479,["512"] = 489,["513"] = 490,["514"] = 492,["515"] = 492,["516"] = 492,["517"] = 493,["518"] = 493,["519"] = 493,["520"] = 494,["521"] = 495,["523"] = 493,["524"] = 493,["525"] = 492,["526"] = 492,["527"] = 500,["528"] = 489,["529"] = 503,["530"] = 504,["531"] = 505,["532"] = 506,["533"] = 508,["534"] = 509,["535"] = 510,["536"] = 510,["537"] = 510,["538"] = 510,["539"] = 510,["540"] = 511,["542"] = 513,["543"] = 514,["544"] = 515,["545"] = 516,["546"] = 517,["547"] = 519,["548"] = 520,["549"] = 521,["551"] = 524,["552"] = 525,["553"] = 526,["554"] = 527,["555"] = 529,["557"] = 532,["559"] = 503,["560"] = 536,["561"] = 537,["562"] = 538,["563"] = 539,["564"] = 540,["565"] = 541,["566"] = 536,["567"] = 544,["568"] = 545,["569"] = 546,["570"] = 547,["571"] = 549,["572"] = 550,["573"] = 551,["574"] = 553,["575"] = 554,["576"] = 555,["577"] = 557,["578"] = 558,["579"] = 559,["580"] = 561,["581"] = 562,["582"] = 563,["584"] = 565,["586"] = 568,["587"] = 569,["588"] = 570,["590"] = 544,["591"] = 574,["592"] = 575,["593"] = 576,["594"] = 578,["595"] = 578,["596"] = 578,["597"] = 579,["598"] = 579,["599"] = 579,["600"] = 579,["601"] = 579,["602"] = 579,["603"] = 578,["604"] = 578,["605"] = 582,["606"] = 574,["607"] = 585,["608"] = 586,["609"] = 587,["610"] = 595,["611"] = 596,["612"] = 597,["613"] = 597,["614"] = 597,["615"] = 597,["616"] = 597,["617"] = 597,["618"] = 597,["619"] = 597,["620"] = 598,["621"] = 585,["622"] = 601,["623"] = 602,["624"] = 603,["625"] = 604,["627"] = 601,["628"] = 608,["629"] = 609,["630"] = 608,["631"] = 612,["632"] = 613,["633"] = 615,["634"] = 620,["635"] = 621,["636"] = 622,["637"] = 623,["638"] = 625,["639"] = 626,["640"] = 627,["642"] = 630,["643"] = 631,["644"] = 636,["645"] = 636,["646"] = 636,["647"] = 637,["648"] = 637,["649"] = 637,["650"] = 638,["651"] = 638,["652"] = 638,["653"] = 638,["654"] = 640,["655"] = 641,["657"] = 644,["658"] = 645,["659"] = 645,["660"] = 645,["661"] = 646,["662"] = 647,["664"] = 650,["667"] = 654,["668"] = 655,["669"] = 656,["670"] = 657,["671"] = 658,["672"] = 659,["676"] = 663,["677"] = 664,["679"] = 666,["680"] = 667,["682"] = 670,["683"] = 612,["684"] = 673,["685"] = 674,["686"] = 673,["687"] = 677,["688"] = 678,["689"] = 681,["690"] = 682,["691"] = 683,["692"] = 684,["693"] = 685,["695"] = 687,["697"] = 690,["698"] = 691,["699"] = 693,["700"] = 694,["701"] = 694,["702"] = 694,["703"] = 695,["704"] = 694,["705"] = 694,["708"] = 700,["709"] = 701,["710"] = 701,["711"] = 701,["712"] = 702,["713"] = 701,["714"] = 701,["715"] = 730,["716"] = 677,["717"] = 733,["718"] = 734,["719"] = 735,["720"] = 737,["721"] = 741,["722"] = 742,["724"] = 745,["725"] = 746,["726"] = 746,["727"] = 746,["728"] = 746,["729"] = 747,["730"] = 748,["732"] = 751,["733"] = 752,["734"] = 752,["735"] = 752,["736"] = 753,["737"] = 752,["738"] = 752,["739"] = 756,["740"] = 757,["741"] = 759,["742"] = 760,["743"] = 760,["744"] = 760,["745"] = 761,["746"] = 760,["747"] = 760,["750"] = 766,["751"] = 733,["752"] = 769,["753"] = 770,["754"] = 772,["755"] = 773,["757"] = 769,["758"] = 777,["759"] = 778,["760"] = 779,["761"] = 780,["762"] = 782,["763"] = 783,["764"] = 784,["765"] = 785,["769"] = 790,["772"] = 794,["773"] = 795,["775"] = 798,["776"] = 799,["777"] = 800,["779"] = 803,["780"] = 804,["782"] = 807,["783"] = 808,["784"] = 809,["785"] = 810,["789"] = 815,["790"] = 816,["793"] = 819,["794"] = 820,["795"] = 820,["796"] = 820,["797"] = 820,["798"] = 821,["799"] = 821,["800"] = 821,["803"] = 824,["806"] = 827,["807"] = 828,["808"] = 829,["809"] = 830,["813"] = 836,["814"] = 837,["815"] = 838,["816"] = 839,["817"] = 841,["818"] = 842,["819"] = 843,["820"] = 844,["825"] = 777,["826"] = 851,["827"] = 852,["828"] = 853,["829"] = 855,["830"] = 856,["831"] = 858,["832"] = 859,["833"] = 860,["834"] = 860,["835"] = 860,["836"] = 861,["837"] = 862,["838"] = 863,["839"] = 864,["842"] = 860,["843"] = 860,["844"] = 869,["845"] = 870,["846"] = 871,["847"] = 872,["851"] = 877,["854"] = 851,["855"] = 882,["856"] = 883,["857"] = 882,["858"] = 886,["859"] = 887,["860"] = 888,["861"] = 889,["863"] = 892,["864"] = 893,["866"] = 896,["867"] = 897,["869"] = 900,["870"] = 901,["871"] = 902,["872"] = 903,["873"] = 904,["874"] = 905,["875"] = 906,["879"] = 911,["880"] = 886,["881"] = 914,["882"] = 915,["883"] = 916,["884"] = 914,["885"] = 919,["886"] = 920,["887"] = 919,["888"] = 923,["889"] = 924,["890"] = 923,["891"] = 927,["892"] = 928,["893"] = 927,["894"] = 931,["895"] = 932,["896"] = 934,["897"] = 935,["898"] = 936,["900"] = 938,["903"] = 941,["905"] = 943,["906"] = 944,["907"] = 931,["908"] = 947,["909"] = 948,["910"] = 948,["911"] = 948,["912"] = 948,["913"] = 947,["914"] = 951,["915"] = 952,["916"] = 953,["917"] = 955,["918"] = 956,["919"] = 957,["921"] = 960,["922"] = 961,["924"] = 964,["925"] = 965,["926"] = 966,["928"] = 968,["929"] = 969,["930"] = 969,["931"] = 969,["932"] = 969,["933"] = 969,["934"] = 970,["937"] = 973,["939"] = 951,["940"] = 977,["941"] = 978,["942"] = 979,["943"] = 980,["944"] = 981,["946"] = 977,["947"] = 985,["948"] = 986,["949"] = 987,["950"] = 989,["951"] = 990,["953"] = 993,["954"] = 994,["957"] = 985,["958"] = 999,["959"] = 1000,["960"] = 1000,["961"] = 1000,["962"] = 1001,["963"] = 1002,["964"] = 1002,["965"] = 1002,["966"] = 1002,["967"] = 1003,["969"] = 1000,["970"] = 1000,["971"] = 999,["972"] = 1008,["973"] = 1009,["974"] = 1009,["975"] = 1009,["976"] = 1010,["977"] = 1011,["978"] = 1012,["979"] = 1014,["980"] = 1015,["981"] = 1015,["982"] = 1015,["983"] = 1015,["984"] = 1016,["986"] = 1018,["987"] = 1019,["988"] = 1020,["989"] = 1020,["990"] = 1020,["991"] = 1020,["992"] = 1021,["996"] = 1009,["997"] = 1009,["998"] = 1008,["999"] = 1028,["1000"] = 1029,["1001"] = 1029,["1002"] = 1029,["1003"] = 1029,["1004"] = 1030,["1005"] = 1031,["1007"] = 1033,["1008"] = 1028,["1009"] = 1036,["1010"] = 1037,["1011"] = 1037,["1012"] = 1037,["1013"] = 1037,["1014"] = 1038,["1015"] = 1039,["1017"] = 1041,["1018"] = 1036,["1019"] = 1044,["1020"] = 1045,["1021"] = 1045,["1022"] = 1045,["1023"] = 1045,["1024"] = 1044,["1025"] = 1048,["1026"] = 1049,["1027"] = 1048,["1028"] = 1052,["1029"] = 1053,["1030"] = 1055,["1031"] = 1056,["1033"] = 1059,["1034"] = 1052,["1035"] = 1062,["1036"] = 1063,["1037"] = 1064,["1038"] = 1065,["1039"] = 1066,["1040"] = 1066,["1041"] = 1066,["1042"] = 1066,["1043"] = 1066,["1044"] = 1066,["1045"] = 1068,["1046"] = 1075,["1047"] = 1076,["1048"] = 1062,["1049"] = 1079,["1050"] = 1080,["1051"] = 1079,["1052"] = 1084,["1053"] = 1084,["1054"] = 72,["1055"] = 1088,["1056"] = 1088,["1057"] = 1088,["1058"] = 1088,["1059"] = 1093,["1060"] = 1094});
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
