--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 19,["30"] = 19,["31"] = 20,["32"] = 20,["33"] = 20,["34"] = 20,["35"] = 21,["36"] = 21,["37"] = 22,["38"] = 22,["39"] = 22,["40"] = 23,["41"] = 23,["42"] = 24,["43"] = 24,["44"] = 25,["45"] = 25,["46"] = 26,["47"] = 26,["48"] = 27,["49"] = 27,["50"] = 49,["51"] = 54,["52"] = 54,["53"] = 54,["54"] = 54,["55"] = 54,["56"] = 59,["57"] = 59,["58"] = 59,["59"] = 59,["60"] = 59,["61"] = 64,["62"] = 65,["63"] = 66,["64"] = 67,["65"] = 68,["66"] = 70,["67"] = 72,["68"] = 73,["69"] = 72,["71"] = 74,["72"] = 75,["73"] = 76,["74"] = 77,["75"] = 78,["76"] = 80,["77"] = 83,["78"] = 87,["79"] = 88,["80"] = 91,["81"] = 91,["82"] = 91,["83"] = 91,["84"] = 91,["85"] = 91,["86"] = 91,["87"] = 93,["88"] = 94,["89"] = 95,["90"] = 96,["91"] = 97,["92"] = 99,["93"] = 100,["94"] = 101,["95"] = 102,["96"] = 90,["97"] = 106,["98"] = 107,["99"] = 108,["100"] = 109,["101"] = 110,["102"] = 111,["103"] = 112,["104"] = 113,["105"] = 114,["106"] = 115,["107"] = 116,["108"] = 118,["109"] = 119,["110"] = 120,["111"] = 121,["112"] = 122,["113"] = 123,["114"] = 125,["115"] = 126,["116"] = 127,["117"] = 129,["118"] = 130,["119"] = 131,["120"] = 132,["122"] = 106,["123"] = 136,["124"] = 137,["125"] = 136,["126"] = 140,["127"] = 141,["128"] = 141,["129"] = 141,["130"] = 141,["131"] = 142,["132"] = 142,["133"] = 142,["134"] = 142,["135"] = 143,["136"] = 143,["137"] = 143,["138"] = 143,["139"] = 144,["140"] = 144,["141"] = 144,["142"] = 144,["143"] = 145,["144"] = 145,["145"] = 145,["146"] = 145,["147"] = 147,["148"] = 148,["149"] = 149,["150"] = 150,["152"] = 153,["153"] = 153,["154"] = 153,["155"] = 154,["156"] = 155,["157"] = 155,["158"] = 155,["159"] = 156,["160"] = 155,["161"] = 155,["162"] = 153,["163"] = 153,["164"] = 140,["165"] = 161,["166"] = 162,["167"] = 163,["168"] = 164,["169"] = 166,["170"] = 167,["171"] = 168,["172"] = 170,["173"] = 170,["174"] = 170,["175"] = 171,["176"] = 172,["178"] = 174,["179"] = 175,["181"] = 178,["182"] = 179,["184"] = 170,["185"] = 170,["186"] = 161,["187"] = 184,["188"] = 185,["189"] = 186,["190"] = 187,["191"] = 189,["192"] = 189,["193"] = 189,["194"] = 190,["195"] = 191,["197"] = 193,["198"] = 194,["200"] = 189,["201"] = 189,["202"] = 184,["203"] = 199,["204"] = 200,["205"] = 201,["206"] = 210,["208"] = 212,["209"] = 212,["210"] = 213,["211"] = 213,["212"] = 213,["213"] = 213,["214"] = 214,["215"] = 215,["216"] = 216,["217"] = 217,["218"] = 218,["219"] = 212,["222"] = 199,["223"] = 226,["224"] = 227,["226"] = 228,["227"] = 228,["228"] = 229,["229"] = 229,["230"] = 229,["231"] = 229,["232"] = 228,["235"] = 232,["236"] = 226,["237"] = 235,["238"] = 236,["239"] = 237,["240"] = 238,["241"] = 240,["242"] = 241,["243"] = 242,["244"] = 244,["245"] = 249,["246"] = 249,["247"] = 249,["248"] = 249,["249"] = 250,["251"] = 253,["252"] = 235,["253"] = 256,["254"] = 257,["255"] = 258,["257"] = 260,["258"] = 262,["259"] = 263,["260"] = 263,["261"] = 263,["262"] = 264,["263"] = 265,["264"] = 266,["266"] = 263,["267"] = 263,["269"] = 271,["270"] = 256,["271"] = 274,["272"] = 275,["273"] = 276,["274"] = 277,["275"] = 278,["276"] = 279,["277"] = 280,["278"] = 281,["279"] = 282,["280"] = 283,["281"] = 284,["282"] = 285,["283"] = 287,["284"] = 288,["285"] = 289,["286"] = 290,["288"] = 292,["289"] = 274,["290"] = 295,["291"] = 296,["292"] = 297,["293"] = 298,["294"] = 299,["295"] = 300,["296"] = 295,["297"] = 303,["298"] = 304,["299"] = 305,["300"] = 306,["301"] = 307,["302"] = 303,["303"] = 310,["304"] = 311,["305"] = 311,["306"] = 311,["307"] = 311,["308"] = 311,["309"] = 312,["310"] = 312,["311"] = 312,["312"] = 312,["313"] = 312,["314"] = 313,["315"] = 313,["316"] = 313,["317"] = 313,["318"] = 313,["319"] = 314,["320"] = 314,["321"] = 314,["322"] = 314,["323"] = 314,["324"] = 315,["325"] = 315,["326"] = 315,["327"] = 315,["328"] = 315,["329"] = 316,["330"] = 316,["331"] = 316,["332"] = 316,["333"] = 316,["334"] = 317,["335"] = 317,["336"] = 317,["337"] = 317,["338"] = 317,["339"] = 318,["340"] = 310,["341"] = 321,["342"] = 322,["343"] = 322,["344"] = 322,["345"] = 323,["346"] = 324,["347"] = 325,["348"] = 326,["349"] = 327,["351"] = 322,["352"] = 322,["353"] = 331,["354"] = 331,["355"] = 331,["356"] = 331,["357"] = 331,["358"] = 335,["359"] = 335,["360"] = 335,["361"] = 336,["362"] = 337,["363"] = 339,["364"] = 340,["365"] = 342,["366"] = 343,["367"] = 345,["368"] = 346,["369"] = 347,["370"] = 348,["371"] = 350,["372"] = 351,["374"] = 354,["375"] = 355,["376"] = 356,["379"] = 335,["380"] = 335,["381"] = 361,["382"] = 361,["383"] = 361,["384"] = 362,["385"] = 363,["386"] = 365,["387"] = 366,["388"] = 368,["390"] = 369,["391"] = 369,["392"] = 370,["393"] = 371,["394"] = 372,["395"] = 373,["398"] = 369,["401"] = 378,["402"] = 379,["405"] = 383,["406"] = 384,["407"] = 384,["408"] = 384,["410"] = 361,["411"] = 361,["412"] = 388,["413"] = 388,["414"] = 388,["415"] = 389,["416"] = 390,["417"] = 392,["418"] = 393,["419"] = 394,["420"] = 395,["421"] = 396,["422"] = 397,["425"] = 388,["426"] = 388,["427"] = 402,["428"] = 402,["429"] = 402,["430"] = 403,["431"] = 404,["432"] = 406,["433"] = 407,["434"] = 408,["435"] = 409,["436"] = 409,["437"] = 409,["438"] = 409,["439"] = 410,["440"] = 411,["441"] = 412,["442"] = 413,["447"] = 402,["448"] = 402,["449"] = 321,["450"] = 421,["451"] = 422,["452"] = 423,["453"] = 424,["454"] = 425,["455"] = 426,["456"] = 427,["457"] = 428,["458"] = 421,["459"] = 431,["460"] = 432,["461"] = 433,["462"] = 434,["463"] = 435,["464"] = 436,["465"] = 437,["466"] = 439,["467"] = 440,["468"] = 441,["469"] = 442,["470"] = 443,["471"] = 445,["472"] = 446,["473"] = 447,["474"] = 448,["475"] = 449,["476"] = 450,["477"] = 451,["478"] = 452,["479"] = 453,["480"] = 454,["481"] = 455,["482"] = 456,["483"] = 457,["484"] = 458,["485"] = 459,["486"] = 460,["487"] = 461,["488"] = 462,["489"] = 463,["490"] = 464,["491"] = 465,["492"] = 466,["493"] = 467,["494"] = 468,["495"] = 470,["496"] = 471,["497"] = 472,["498"] = 473,["499"] = 474,["500"] = 475,["501"] = 476,["502"] = 477,["503"] = 478,["504"] = 479,["505"] = 480,["506"] = 481,["507"] = 482,["508"] = 483,["509"] = 484,["510"] = 485,["512"] = 488,["513"] = 431,["514"] = 491,["515"] = 492,["516"] = 491,["517"] = 495,["518"] = 496,["519"] = 496,["520"] = 496,["521"] = 496,["522"] = 496,["523"] = 502,["524"] = 495,["525"] = 505,["526"] = 506,["527"] = 508,["528"] = 508,["529"] = 508,["530"] = 509,["531"] = 509,["532"] = 509,["533"] = 510,["534"] = 511,["536"] = 509,["537"] = 509,["538"] = 508,["539"] = 508,["540"] = 516,["541"] = 505,["542"] = 519,["543"] = 520,["544"] = 521,["545"] = 522,["546"] = 524,["547"] = 525,["548"] = 526,["549"] = 526,["550"] = 526,["551"] = 526,["552"] = 526,["553"] = 527,["555"] = 529,["556"] = 530,["557"] = 531,["558"] = 532,["559"] = 533,["560"] = 535,["561"] = 536,["562"] = 537,["564"] = 540,["565"] = 541,["566"] = 542,["567"] = 543,["568"] = 545,["570"] = 548,["572"] = 519,["573"] = 552,["574"] = 554,["575"] = 555,["576"] = 556,["577"] = 557,["578"] = 558,["579"] = 552,["580"] = 561,["581"] = 562,["582"] = 563,["583"] = 564,["584"] = 566,["585"] = 567,["586"] = 568,["587"] = 570,["588"] = 571,["589"] = 572,["590"] = 574,["591"] = 575,["592"] = 576,["593"] = 578,["594"] = 579,["595"] = 580,["597"] = 582,["599"] = 585,["600"] = 586,["601"] = 587,["603"] = 561,["604"] = 591,["605"] = 592,["606"] = 593,["607"] = 595,["608"] = 595,["609"] = 595,["610"] = 596,["611"] = 596,["612"] = 596,["613"] = 596,["614"] = 596,["615"] = 596,["616"] = 595,["617"] = 595,["618"] = 599,["619"] = 591,["620"] = 602,["621"] = 603,["622"] = 604,["623"] = 612,["624"] = 613,["625"] = 614,["626"] = 614,["627"] = 614,["628"] = 614,["629"] = 614,["630"] = 614,["631"] = 614,["632"] = 614,["633"] = 615,["634"] = 602,["635"] = 618,["636"] = 619,["637"] = 620,["638"] = 621,["640"] = 618,["641"] = 625,["642"] = 626,["643"] = 625,["644"] = 629,["645"] = 630,["646"] = 632,["647"] = 637,["648"] = 638,["649"] = 639,["650"] = 640,["651"] = 642,["652"] = 643,["653"] = 644,["655"] = 647,["656"] = 648,["657"] = 653,["658"] = 653,["659"] = 653,["660"] = 654,["661"] = 654,["662"] = 654,["663"] = 655,["664"] = 655,["665"] = 655,["666"] = 655,["667"] = 657,["668"] = 658,["670"] = 661,["671"] = 662,["672"] = 662,["673"] = 662,["674"] = 663,["675"] = 664,["677"] = 667,["680"] = 671,["681"] = 672,["682"] = 673,["683"] = 674,["684"] = 675,["685"] = 676,["689"] = 680,["690"] = 681,["692"] = 683,["693"] = 684,["695"] = 687,["696"] = 629,["697"] = 690,["698"] = 691,["699"] = 690,["700"] = 694,["701"] = 695,["702"] = 698,["703"] = 699,["704"] = 700,["705"] = 701,["706"] = 702,["708"] = 704,["710"] = 707,["711"] = 708,["712"] = 710,["713"] = 711,["714"] = 711,["715"] = 711,["716"] = 712,["717"] = 711,["718"] = 711,["721"] = 717,["722"] = 718,["723"] = 718,["724"] = 718,["725"] = 719,["726"] = 718,["727"] = 718,["728"] = 747,["729"] = 694,["730"] = 750,["731"] = 751,["732"] = 752,["733"] = 754,["734"] = 758,["735"] = 759,["737"] = 762,["738"] = 763,["739"] = 763,["740"] = 763,["741"] = 763,["742"] = 764,["743"] = 765,["745"] = 768,["746"] = 769,["747"] = 769,["748"] = 769,["749"] = 770,["750"] = 769,["751"] = 769,["752"] = 773,["753"] = 774,["754"] = 776,["755"] = 777,["756"] = 777,["757"] = 777,["758"] = 778,["759"] = 777,["760"] = 777,["763"] = 783,["764"] = 750,["765"] = 786,["766"] = 787,["767"] = 788,["769"] = 786,["770"] = 792,["771"] = 793,["772"] = 795,["773"] = 796,["775"] = 792,["776"] = 800,["777"] = 801,["778"] = 802,["779"] = 803,["780"] = 805,["781"] = 806,["782"] = 807,["783"] = 808,["787"] = 813,["790"] = 817,["791"] = 818,["793"] = 821,["794"] = 822,["795"] = 823,["797"] = 826,["798"] = 827,["800"] = 830,["801"] = 831,["802"] = 832,["803"] = 833,["807"] = 838,["808"] = 839,["811"] = 842,["812"] = 843,["813"] = 843,["814"] = 843,["815"] = 843,["816"] = 844,["817"] = 844,["818"] = 844,["821"] = 847,["822"] = 848,["825"] = 851,["826"] = 852,["827"] = 853,["831"] = 859,["832"] = 860,["833"] = 861,["834"] = 862,["835"] = 864,["836"] = 865,["837"] = 866,["838"] = 867,["843"] = 800,["844"] = 874,["845"] = 875,["846"] = 876,["847"] = 878,["848"] = 879,["849"] = 881,["850"] = 882,["851"] = 883,["852"] = 883,["853"] = 883,["854"] = 884,["855"] = 885,["856"] = 886,["857"] = 887,["860"] = 883,["861"] = 883,["862"] = 892,["863"] = 893,["864"] = 894,["865"] = 895,["869"] = 900,["872"] = 874,["873"] = 905,["874"] = 906,["875"] = 905,["876"] = 909,["877"] = 910,["878"] = 911,["879"] = 912,["881"] = 915,["882"] = 916,["884"] = 919,["885"] = 920,["887"] = 923,["888"] = 924,["889"] = 925,["890"] = 926,["891"] = 927,["892"] = 928,["893"] = 929,["897"] = 934,["898"] = 909,["899"] = 937,["900"] = 938,["901"] = 939,["902"] = 937,["903"] = 942,["904"] = 943,["905"] = 942,["906"] = 946,["907"] = 947,["908"] = 946,["909"] = 950,["910"] = 951,["911"] = 950,["912"] = 954,["913"] = 955,["914"] = 957,["915"] = 958,["916"] = 959,["918"] = 961,["921"] = 964,["923"] = 966,["924"] = 967,["925"] = 954,["926"] = 970,["927"] = 971,["928"] = 971,["929"] = 971,["930"] = 971,["931"] = 970,["932"] = 974,["933"] = 975,["934"] = 976,["935"] = 978,["936"] = 979,["937"] = 980,["939"] = 983,["940"] = 984,["942"] = 987,["943"] = 988,["944"] = 989,["946"] = 991,["947"] = 992,["948"] = 992,["949"] = 992,["950"] = 992,["951"] = 992,["952"] = 993,["955"] = 996,["957"] = 974,["958"] = 1000,["959"] = 1001,["960"] = 1002,["961"] = 1003,["962"] = 1004,["964"] = 1000,["965"] = 1008,["966"] = 1009,["967"] = 1010,["968"] = 1012,["969"] = 1013,["971"] = 1016,["972"] = 1017,["975"] = 1008,["976"] = 1022,["977"] = 1023,["978"] = 1023,["979"] = 1023,["980"] = 1024,["981"] = 1025,["982"] = 1025,["983"] = 1025,["984"] = 1025,["985"] = 1026,["987"] = 1023,["988"] = 1023,["989"] = 1022,["990"] = 1031,["991"] = 1032,["992"] = 1032,["993"] = 1032,["994"] = 1033,["995"] = 1034,["996"] = 1035,["997"] = 1037,["998"] = 1038,["999"] = 1038,["1000"] = 1038,["1001"] = 1038,["1002"] = 1039,["1004"] = 1041,["1005"] = 1042,["1006"] = 1043,["1007"] = 1043,["1008"] = 1043,["1009"] = 1043,["1010"] = 1044,["1014"] = 1032,["1015"] = 1032,["1016"] = 1031,["1017"] = 1051,["1018"] = 1052,["1019"] = 1052,["1020"] = 1052,["1021"] = 1052,["1022"] = 1053,["1023"] = 1054,["1025"] = 1056,["1026"] = 1051,["1027"] = 1059,["1028"] = 1060,["1029"] = 1060,["1030"] = 1060,["1031"] = 1060,["1032"] = 1061,["1033"] = 1062,["1035"] = 1064,["1036"] = 1059,["1037"] = 1067,["1038"] = 1068,["1039"] = 1068,["1040"] = 1068,["1041"] = 1068,["1042"] = 1067,["1043"] = 1071,["1044"] = 1072,["1045"] = 1071,["1046"] = 1075,["1047"] = 1076,["1048"] = 1078,["1049"] = 1079,["1051"] = 1082,["1052"] = 1075,["1053"] = 1085,["1054"] = 1086,["1055"] = 1087,["1056"] = 1088,["1057"] = 1089,["1058"] = 1089,["1059"] = 1089,["1060"] = 1089,["1061"] = 1089,["1062"] = 1089,["1063"] = 1091,["1064"] = 1098,["1065"] = 1099,["1066"] = 1085,["1067"] = 1102,["1068"] = 1103,["1069"] = 1102,["1070"] = 1107,["1071"] = 1107,["1072"] = 72,["1073"] = 1111,["1074"] = 1111,["1075"] = 1111,["1076"] = 1111,["1077"] = 1116,["1078"] = 1117});
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
local ____room = require("clases.pve.room")
local Level = ____room.default
local ____settings = require("settings")
local settings = ____settings.default
local ____pre_room = require("clases.pve.pre_room")
local PreLevel = ____pre_room.default
local ____custom_ai = require("clases.pve.custom_ai")
local NPCNames = ____custom_ai.NPCNames
local ____upgrades = require("upgrades.upgrades")
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
    self.pre_level = __TS__New(PreLevel, self.alliances, -1)
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
    local npcs = {NPCNames.DIRE_TOWER, NPCNames.RADIANT_ZOMBIE_MEELE, NPCNames.RADIANT_ZOMBIE_HEALER, NPCNames.DIRE_ZOMBIE, NPCNames.DIRE_ZOMBIE_RAGER, NPCNames.DIRE_ZOMBIE_MEELE, NPCNames.FLYING_SKULL}
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
    ListenToGameEvent(
        "dota_player_learned_ability",
        function(event) return self:OnHeroLearnedAbility(event) end,
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
                        if self.pre_level then
                            self.pre_level:OnHeroUpgrade()
                        end
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
        self.pre_round = __TS__New(PreRound, self.alliances, 1)
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
        self.pre_level = __TS__New(PreLevel, self.alliances, -1)
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
function GameMode.prototype.OnHeroLearnedAbility(self, event)
    if self.pre_level then
        self.pre_level:OnAbilityLearned()
    end
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
            level = level - 1
            if not self.levelsData[level + 1] then
                return
            end
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
