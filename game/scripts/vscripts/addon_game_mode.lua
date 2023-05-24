local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ParseInt = ____lualib.__TS__ParseInt
local __TS__Number = ____lualib.__TS__Number
local __TS__NumberIsNaN = ____lualib.__TS__NumberIsNaN
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["17"] = 1,["18"] = 2,["19"] = 2,["20"] = 3,["21"] = 3,["22"] = 4,["23"] = 4,["24"] = 5,["25"] = 5,["26"] = 6,["27"] = 7,["28"] = 8,["29"] = 9,["30"] = 10,["31"] = 11,["32"] = 12,["33"] = 13,["34"] = 14,["35"] = 15,["36"] = 16,["37"] = 17,["38"] = 17,["39"] = 18,["40"] = 18,["41"] = 19,["42"] = 19,["43"] = 20,["44"] = 20,["45"] = 20,["46"] = 20,["47"] = 21,["48"] = 21,["49"] = 22,["50"] = 22,["51"] = 22,["52"] = 23,["53"] = 23,["54"] = 24,["55"] = 24,["56"] = 25,["57"] = 25,["58"] = 26,["59"] = 26,["60"] = 27,["61"] = 27,["62"] = 28,["63"] = 28,["64"] = 29,["65"] = 29,["66"] = 30,["67"] = 30,["68"] = 52,["69"] = 57,["70"] = 57,["71"] = 57,["72"] = 57,["73"] = 57,["74"] = 62,["75"] = 62,["76"] = 62,["77"] = 62,["78"] = 62,["79"] = 67,["80"] = 68,["81"] = 69,["82"] = 70,["83"] = 71,["84"] = 73,["85"] = 75,["86"] = 76,["87"] = 75,["89"] = 77,["90"] = 78,["91"] = 79,["92"] = 80,["93"] = 81,["94"] = 83,["95"] = 89,["96"] = 90,["97"] = 93,["98"] = 93,["99"] = 95,["100"] = 96,["101"] = 93,["102"] = 93,["103"] = 93,["104"] = 101,["105"] = 102,["106"] = 103,["107"] = 104,["108"] = 105,["109"] = 107,["110"] = 108,["111"] = 109,["112"] = 110,["113"] = 92,["114"] = 114,["115"] = 115,["116"] = 116,["117"] = 117,["118"] = 118,["119"] = 119,["120"] = 120,["121"] = 121,["122"] = 122,["123"] = 123,["124"] = 124,["125"] = 126,["126"] = 127,["127"] = 128,["128"] = 129,["129"] = 130,["130"] = 131,["131"] = 133,["132"] = 134,["133"] = 135,["134"] = 137,["135"] = 138,["136"] = 139,["137"] = 140,["139"] = 114,["140"] = 144,["141"] = 145,["142"] = 144,["143"] = 148,["144"] = 149,["145"] = 149,["146"] = 150,["147"] = 150,["148"] = 151,["149"] = 151,["150"] = 152,["151"] = 152,["152"] = 153,["153"] = 153,["154"] = 155,["155"] = 156,["156"] = 157,["157"] = 158,["159"] = 161,["160"] = 161,["161"] = 161,["162"] = 162,["163"] = 163,["164"] = 163,["165"] = 163,["166"] = 164,["167"] = 163,["168"] = 163,["169"] = 161,["170"] = 161,["171"] = 148,["172"] = 169,["173"] = 170,["174"] = 171,["175"] = 172,["176"] = 174,["177"] = 175,["178"] = 176,["179"] = 178,["180"] = 178,["181"] = 178,["182"] = 179,["183"] = 180,["185"] = 182,["186"] = 183,["188"] = 185,["189"] = 186,["191"] = 178,["192"] = 178,["193"] = 169,["194"] = 191,["195"] = 192,["196"] = 193,["197"] = 195,["198"] = 195,["199"] = 195,["200"] = 196,["201"] = 197,["203"] = 199,["204"] = 200,["206"] = 195,["207"] = 195,["208"] = 191,["209"] = 205,["210"] = 206,["211"] = 207,["213"] = 209,["214"] = 211,["215"] = 212,["216"] = 212,["217"] = 212,["218"] = 213,["219"] = 214,["220"] = 215,["222"] = 212,["223"] = 212,["225"] = 220,["226"] = 205,["227"] = 223,["228"] = 224,["229"] = 225,["230"] = 226,["231"] = 227,["232"] = 228,["233"] = 229,["234"] = 230,["235"] = 231,["236"] = 232,["237"] = 233,["238"] = 234,["239"] = 236,["240"] = 237,["241"] = 238,["242"] = 239,["244"] = 241,["245"] = 223,["246"] = 244,["247"] = 245,["248"] = 246,["249"] = 247,["250"] = 248,["251"] = 249,["252"] = 244,["253"] = 252,["254"] = 253,["255"] = 254,["256"] = 255,["257"] = 256,["258"] = 252,["259"] = 259,["260"] = 260,["261"] = 260,["262"] = 260,["263"] = 260,["264"] = 260,["265"] = 261,["266"] = 261,["267"] = 261,["268"] = 261,["269"] = 261,["270"] = 262,["271"] = 262,["272"] = 262,["273"] = 262,["274"] = 262,["275"] = 263,["276"] = 263,["277"] = 263,["278"] = 263,["279"] = 263,["280"] = 264,["281"] = 264,["282"] = 264,["283"] = 264,["284"] = 264,["285"] = 265,["286"] = 265,["287"] = 265,["288"] = 265,["289"] = 265,["290"] = 266,["291"] = 259,["292"] = 269,["293"] = 270,["294"] = 270,["295"] = 270,["296"] = 271,["297"] = 272,["298"] = 273,["299"] = 274,["300"] = 275,["302"] = 270,["303"] = 270,["304"] = 279,["305"] = 279,["306"] = 279,["307"] = 280,["308"] = 281,["309"] = 283,["310"] = 284,["311"] = 285,["312"] = 287,["313"] = 288,["314"] = 290,["315"] = 291,["316"] = 292,["317"] = 293,["318"] = 295,["319"] = 296,["321"] = 299,["322"] = 300,["323"] = 301,["325"] = 304,["326"] = 305,["327"] = 306,["328"] = 307,["329"] = 308,["334"] = 279,["335"] = 279,["336"] = 315,["337"] = 315,["338"] = 315,["339"] = 316,["340"] = 317,["341"] = 319,["342"] = 320,["343"] = 322,["345"] = 323,["346"] = 323,["347"] = 324,["348"] = 325,["349"] = 326,["350"] = 327,["353"] = 323,["356"] = 332,["357"] = 333,["360"] = 337,["361"] = 338,["363"] = 315,["364"] = 315,["365"] = 342,["366"] = 342,["367"] = 342,["368"] = 343,["369"] = 344,["370"] = 346,["371"] = 347,["372"] = 348,["373"] = 349,["374"] = 350,["375"] = 351,["378"] = 342,["379"] = 342,["380"] = 269,["381"] = 357,["382"] = 358,["383"] = 359,["384"] = 360,["385"] = 361,["386"] = 362,["387"] = 363,["388"] = 364,["389"] = 357,["390"] = 367,["391"] = 368,["392"] = 369,["393"] = 370,["394"] = 371,["395"] = 372,["396"] = 373,["397"] = 375,["398"] = 376,["399"] = 377,["400"] = 378,["401"] = 379,["402"] = 381,["403"] = 382,["404"] = 383,["405"] = 384,["406"] = 385,["407"] = 390,["408"] = 391,["409"] = 392,["410"] = 393,["411"] = 394,["412"] = 395,["413"] = 396,["414"] = 397,["415"] = 398,["416"] = 403,["417"] = 404,["418"] = 405,["419"] = 406,["420"] = 407,["421"] = 409,["422"] = 410,["423"] = 411,["424"] = 412,["425"] = 413,["426"] = 415,["427"] = 416,["428"] = 417,["429"] = 418,["430"] = 424,["431"] = 425,["432"] = 426,["433"] = 428,["434"] = 428,["435"] = 428,["436"] = 429,["437"] = 430,["438"] = 431,["440"] = 433,["441"] = 434,["443"] = 436,["444"] = 437,["447"] = 428,["448"] = 428,["449"] = 441,["450"] = 442,["451"] = 447,["452"] = 448,["453"] = 453,["455"] = 456,["456"] = 367,["457"] = 459,["458"] = 460,["459"] = 459,["460"] = 463,["461"] = 464,["462"] = 464,["463"] = 464,["464"] = 464,["465"] = 464,["466"] = 470,["467"] = 470,["468"] = 463,["469"] = 473,["470"] = 474,["471"] = 476,["472"] = 476,["473"] = 476,["474"] = 477,["475"] = 477,["476"] = 477,["477"] = 478,["478"] = 479,["480"] = 477,["481"] = 477,["482"] = 476,["483"] = 476,["484"] = 484,["485"] = 473,["486"] = 487,["487"] = 488,["488"] = 489,["489"] = 490,["490"] = 492,["491"] = 493,["492"] = 494,["493"] = 502,["495"] = 504,["496"] = 505,["497"] = 506,["498"] = 507,["499"] = 507,["500"] = 508,["501"] = 510,["502"] = 511,["503"] = 512,["505"] = 515,["506"] = 516,["507"] = 517,["508"] = 518,["509"] = 520,["511"] = 523,["513"] = 487,["514"] = 527,["515"] = 528,["516"] = 529,["517"] = 530,["518"] = 531,["519"] = 532,["520"] = 527,["521"] = 535,["522"] = 536,["523"] = 537,["524"] = 538,["525"] = 539,["526"] = 540,["527"] = 541,["528"] = 542,["529"] = 543,["530"] = 544,["531"] = 545,["532"] = 546,["533"] = 547,["534"] = 549,["535"] = 549,["536"] = 549,["537"] = 549,["538"] = 549,["539"] = 549,["540"] = 547,["541"] = 567,["542"] = 568,["543"] = 569,["545"] = 535,["546"] = 573,["547"] = 574,["548"] = 575,["549"] = 577,["550"] = 577,["551"] = 577,["552"] = 578,["553"] = 577,["554"] = 577,["555"] = 581,["556"] = 573,["557"] = 584,["558"] = 585,["559"] = 586,["560"] = 586,["561"] = 586,["562"] = 586,["563"] = 586,["564"] = 586,["565"] = 586,["566"] = 586,["567"] = 587,["568"] = 588,["569"] = 589,["570"] = 590,["571"] = 590,["572"] = 590,["573"] = 590,["574"] = 590,["575"] = 590,["576"] = 593,["577"] = 584,["578"] = 596,["579"] = 597,["580"] = 598,["581"] = 599,["583"] = 596,["584"] = 603,["585"] = 604,["586"] = 603,["587"] = 607,["588"] = 608,["589"] = 611,["590"] = 616,["591"] = 617,["592"] = 618,["593"] = 619,["594"] = 621,["595"] = 622,["596"] = 623,["598"] = 626,["599"] = 627,["600"] = 628,["601"] = 629,["602"] = 630,["603"] = 630,["604"] = 630,["605"] = 630,["606"] = 632,["607"] = 633,["609"] = 636,["610"] = 637,["611"] = 638,["612"] = 639,["614"] = 642,["617"] = 646,["618"] = 647,["619"] = 648,["620"] = 649,["621"] = 650,["622"] = 651,["626"] = 655,["627"] = 656,["629"] = 658,["630"] = 659,["632"] = 662,["633"] = 607,["634"] = 665,["635"] = 666,["636"] = 665,["637"] = 669,["638"] = 670,["639"] = 673,["640"] = 674,["641"] = 675,["642"] = 676,["643"] = 677,["645"] = 679,["647"] = 682,["648"] = 683,["649"] = 685,["650"] = 686,["651"] = 686,["652"] = 686,["653"] = 687,["654"] = 686,["655"] = 686,["658"] = 692,["659"] = 693,["660"] = 693,["661"] = 693,["662"] = 694,["663"] = 693,["664"] = 693,["665"] = 722,["666"] = 669,["667"] = 725,["668"] = 726,["669"] = 727,["670"] = 729,["671"] = 733,["672"] = 734,["674"] = 737,["675"] = 738,["676"] = 741,["677"] = 741,["678"] = 741,["679"] = 742,["680"] = 741,["681"] = 741,["682"] = 745,["683"] = 746,["684"] = 746,["685"] = 746,["686"] = 746,["687"] = 747,["688"] = 748,["690"] = 751,["691"] = 752,["692"] = 754,["693"] = 755,["694"] = 755,["695"] = 755,["696"] = 756,["697"] = 755,["698"] = 755,["702"] = 762,["703"] = 725,["704"] = 765,["705"] = 766,["706"] = 768,["707"] = 769,["709"] = 765,["710"] = 773,["711"] = 774,["712"] = 775,["713"] = 777,["714"] = 778,["715"] = 779,["716"] = 780,["717"] = 781,["721"] = 786,["724"] = 790,["725"] = 791,["727"] = 794,["728"] = 795,["729"] = 796,["731"] = 799,["732"] = 800,["734"] = 803,["735"] = 804,["738"] = 808,["739"] = 810,["742"] = 814,["743"] = 815,["745"] = 818,["746"] = 819,["748"] = 822,["749"] = 823,["751"] = 826,["752"] = 827,["754"] = 830,["755"] = 831,["756"] = 834,["758"] = 837,["759"] = 838,["762"] = 842,["763"] = 843,["764"] = 844,["765"] = 845,["769"] = 850,["770"] = 851,["773"] = 854,["774"] = 855,["775"] = 855,["776"] = 855,["777"] = 855,["778"] = 856,["781"] = 859,["782"] = 861,["783"] = 862,["786"] = 865,["790"] = 773,["791"] = 871,["792"] = 872,["793"] = 873,["794"] = 875,["795"] = 876,["796"] = 878,["797"] = 879,["798"] = 880,["799"] = 880,["800"] = 880,["801"] = 881,["802"] = 882,["803"] = 883,["804"] = 884,["807"] = 880,["808"] = 880,["809"] = 889,["810"] = 890,["811"] = 891,["812"] = 892,["816"] = 897,["819"] = 871,["820"] = 902,["821"] = 903,["822"] = 902,["823"] = 906,["824"] = 907,["825"] = 908,["826"] = 909,["828"] = 912,["829"] = 913,["831"] = 916,["832"] = 917,["834"] = 920,["835"] = 921,["836"] = 922,["837"] = 923,["838"] = 924,["839"] = 925,["840"] = 926,["844"] = 931,["845"] = 906,["846"] = 934,["847"] = 935,["848"] = 936,["849"] = 934,["850"] = 939,["851"] = 940,["852"] = 939,["853"] = 943,["854"] = 944,["855"] = 943,["856"] = 947,["857"] = 948,["858"] = 947,["859"] = 951,["860"] = 952,["861"] = 954,["862"] = 955,["863"] = 956,["865"] = 958,["868"] = 961,["870"] = 963,["871"] = 963,["872"] = 964,["873"] = 951,["874"] = 967,["875"] = 968,["876"] = 968,["877"] = 968,["878"] = 968,["879"] = 967,["880"] = 971,["881"] = 972,["882"] = 974,["883"] = 975,["884"] = 976,["886"] = 978,["887"] = 979,["888"] = 979,["889"] = 979,["890"] = 979,["891"] = 979,["892"] = 980,["895"] = 983,["897"] = 971,["898"] = 987,["899"] = 988,["900"] = 989,["901"] = 990,["902"] = 991,["904"] = 987,["905"] = 995,["906"] = 996,["907"] = 997,["908"] = 998,["909"] = 999,["911"] = 1001,["913"] = 995,["914"] = 1005,["915"] = 1006,["916"] = 1006,["917"] = 1006,["918"] = 1007,["919"] = 1008,["920"] = 1008,["921"] = 1008,["922"] = 1008,["923"] = 1009,["925"] = 1006,["926"] = 1006,["927"] = 1005,["928"] = 1014,["929"] = 1015,["930"] = 1015,["931"] = 1015,["932"] = 1016,["933"] = 1017,["934"] = 1018,["935"] = 1020,["936"] = 1021,["937"] = 1021,["938"] = 1021,["939"] = 1021,["940"] = 1022,["942"] = 1024,["943"] = 1025,["944"] = 1026,["945"] = 1026,["946"] = 1026,["947"] = 1026,["948"] = 1027,["952"] = 1015,["953"] = 1015,["954"] = 1014,["955"] = 1034,["956"] = 1035,["957"] = 1035,["958"] = 1035,["959"] = 1035,["960"] = 1035,["961"] = 1035,["962"] = 1035,["963"] = 1035,["964"] = 1034,["965"] = 1038,["966"] = 1039,["967"] = 1039,["968"] = 1039,["969"] = 1039,["970"] = 1039,["971"] = 1039,["972"] = 1039,["973"] = 1038,["974"] = 1042,["975"] = 1043,["976"] = 1043,["977"] = 1043,["978"] = 1043,["979"] = 1042,["980"] = 1046,["981"] = 1047,["982"] = 1046,["983"] = 1050,["984"] = 1051,["985"] = 1053,["986"] = 1054,["988"] = 1057,["989"] = 1050,["990"] = 1060,["991"] = 1061,["992"] = 1062,["993"] = 1063,["994"] = 1064,["995"] = 1064,["996"] = 1064,["997"] = 1064,["998"] = 1064,["999"] = 1064,["1000"] = 1066,["1001"] = 1066,["1002"] = 1073,["1003"] = 1074,["1004"] = 1060,["1005"] = 1077,["1006"] = 1078,["1007"] = 1077,["1008"] = 1082,["1009"] = 1082,["1010"] = 75,["1011"] = 76,["1012"] = 1085,["1013"] = 1085,["1014"] = 1085,["1015"] = 1085,["1016"] = 1090,["1017"] = 1091});
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
local ____upgrades = require("upgrades.upgrades")
local Upgrades = ____upgrades.default
local ____common = require("upgrades.common")
local UpgradeTypes = ____common.UpgradeTypes
local ____rewards = require("rewards.rewards")
local RewardsManager = ____rewards.RewardsManager
local ____modifier_obstacle = require("modifiers.modifier_obstacle")
local ModifierObstacle = ____modifier_obstacle.ModifierObstacle
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
    local ____self_alliances_0 = self.alliances
    ____self_alliances_0[#____self_alliances_0 + 1] = __TS__New(Alliance, DOTA_ALIANCE_NO_ALLIANCE, {})
    local ____self_alliances_1 = self.alliances
    ____self_alliances_1[#____self_alliances_1 + 1] = __TS__New(Alliance, DOTA_ALLIANCE_RADIANT, {DOTA_TEAM_GOODGUYS, DOTA_TEAM_BADGUYS})
    local ____self_alliances_2 = self.alliances
    ____self_alliances_2[#____self_alliances_2 + 1] = __TS__New(Alliance, DOTA_ALLIANCE_DIRE, {DOTA_TEAM_CUSTOM_1, DOTA_TEAM_CUSTOM_2, DOTA_TEAM_NEUTRALS})
    local ____self_alliances_3 = self.alliances
    ____self_alliances_3[#____self_alliances_3 + 1] = __TS__New(Alliance, DOTA_ALLIANCE_LEGION, {DOTA_TEAM_CUSTOM_3, DOTA_TEAM_CUSTOM_4})
    local ____self_alliances_4 = self.alliances
    ____self_alliances_4[#____self_alliances_4 + 1] = __TS__New(Alliance, DOTA_ALLIANCE_VOID, {DOTA_TEAM_CUSTOM_5, DOTA_TEAM_CUSTOM_6})
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
            if self.state == CustomGameState.WARMUP_IN_PROGRESS and self.warmup then
                self.warmup:Update()
            end
            if self.state == CustomGameState.PRE_ROUND and self.preRound then
                self.preRound:Update()
            end
            if self.state == CustomGameState.ROUND_IN_PROGRESS and self.round then
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
            if self.state == CustomGameState.RUN_IN_PROGRESS and self.run then
                self.run:Update()
            end
            if self.state == CustomGameState.PRE_RUN and self.preRun then
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
        "custom_action",
        function(eventSourceIndex, event)
            local playerId = event.playerIndex
            local player = self:FindPlayerById(playerId)
            if player then
                local customNpc = player.customNpc
                local hero = player.hero
                local ____type = event.payload.type
                local mode = event.payload.mode
                if ____type == Custom_ActionTypes.MOVEMENT and hero then
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
                if ____type == Custom_ActionTypes.ABILITY and hero then
                    if mode == Custom_ActionModes.STOP then
                        local ability = EntIndexToHScript(event.payload.abilityEntityIndex)
                        if customNpc and ability then
                            customNpc:ReleaseAbility(ability:GetName())
                        end
                    end
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
                self.warmup:SetDuration(self.warmup:GetDuration() + 10)
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
    LinkLuaModifier("modifier_generic_phased", "modifiers/generic/modifier_generic_phased", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_flying", "modifiers/generic/modifier_generic_flying", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_ignore_ms_limit", "modifiers/generic/modifier_generic_ignore_ms_limit", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_change_ms", "modifiers/generic/modifier_generic_change_ms", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_visible", "modifiers/generic/modifier_visible", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_casting", "modifiers/modifier_casting", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_damage_fx", "modifiers/generic/modifier_damage_fx", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_shield", "modifiers/generic/modifier_shield", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hide_bar", "modifiers/generic/modifier_hide_bar", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hidden", "modifiers/generic/modifier_hidden", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_banish", "modifiers/generic/modifier_banish", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hero_movement", "modifiers/generic/modifier_hero_movement", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_tower_idle", "modifiers/generic/modifier_tower_idle", LUA_MODIFIER_MOTION_NONE)
    if self:IsPVE() then
        LinkLuaModifier("modifier_combine_util", "modifiers/modifier_combine_util", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_generic_npc_shield", "modifiers/generic/modifier_generic_npc_shield", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_generic_npc_mini_stun", "modifiers/generic/modifier_generic_npc_mini_stun", LUA_MODIFIER_MOTION_NONE)
        local favorsPath = "modifiers/upgrades/favors/"
        local itemsPath = "modifiers/upgrades/items/"
        local shardsPath = "modifiers/upgrades/shards/"
        __TS__ArrayForEach(
            Upgrades,
            function(____, upgrade)
                if upgrade.modifier then
                    if upgrade.type == UpgradeTypes.FAVOR then
                        LinkLuaModifier(upgrade.modifier.name, favorsPath .. upgrade.modifier.name, LUA_MODIFIER_MOTION_NONE)
                    end
                    if upgrade.type == UpgradeTypes.SHARD then
                        LinkLuaModifier(upgrade.modifier.name, shardsPath .. upgrade.modifier.name, LUA_MODIFIER_MOTION_NONE)
                    end
                    if upgrade.type == UpgradeTypes.ITEM then
                        LinkLuaModifier(upgrade.modifier.name, itemsPath .. upgrade.modifier.name, LUA_MODIFIER_MOTION_NONE)
                    end
                end
            end
        )
        LinkLuaModifier("modifier_combine_util", "modifiers/modifier_combine_util", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_item_maelstrom_attack", itemsPath .. "modifier_upgrade_item_maelstrom", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_item_basher_attack", itemsPath .. "modifier_upgrade_item_basher", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_item_javelin_attack", itemsPath .. "modifier_upgrade_item_javelin", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_tarrasque", "modifiers/upgrades/modifier_upgrade_tarrasque", LUA_MODIFIER_MOTION_NONE)
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
    local ____self_thinkers_5 = self.thinkers
    ____self_thinkers_5[#____self_thinkers_5 + 1] = thinker
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
        print((((("ERROR: TRYING TO CREATE AN UNIT ON AN INVALID PLAYER: \n\t playerID: " .. tostring(playerID)) .. "\n\t hero: ") .. hero:GetName()) .. "\n\t team: ") .. tostring(team))
        return false
    else
        local player = self:FindPlayerById(playerID)
        if not player then
            player = __TS__New(Player, playerID, userID)
            local ____self_players_6 = self.players
            ____self_players_6[#____self_players_6 + 1] = player
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
        self.run = __TS__New(Run, self.alliances, {{possibleNPCs = {
            NPCNames.DIRE_ZOMBIE_RANGE,
            NPCNames.DIRE_ZOMBIE_MEELE_MEGA,
            NPCNames.DIRE_ZOMBIE_RANGE_MEGA,
            NPCNames.FLYING_SKULL,
            NPCNames.DIRE_TOWER,
            NPCNames.QUEEN
        }}, {possibleNPCs = {NPCNames.RADIANT_ZOMBIE_RANGE_MEGA, NPCNames.RADIANT_ZOMBIE_MEELE_MEGA, NPCNames.FLYING_SKULL, NPCNames.CENTAUR}}})
    elseif state == CustomGameState.RUN_IN_PROGRESS then
        self.run = nil
        self:EndGame(DOTA_TEAM_GOODGUYS)
    end
end
function GameMode.prototype.CreateBarrels(self)
    local barrelEnts = Entities:FindAllByName("wall_spawn")
    local barrels = {}
    __TS__ArrayForEach(
        barrelEnts,
        function(____, entity)
            barrels[#barrels + 1] = self:CreateBarrel(entity:GetAbsOrigin())
        end
    )
    return barrels
end
function GameMode.prototype.CreateBarrel(self, origin)
    local fowBlocker = SpawnEntityFromTableSynchronous("point_simple_obstruction", {origin = origin, block_fow = true})
    local barrel = CreateUnitByName(
        "npc_dota_creature_wall",
        origin,
        false,
        nil,
        nil,
        DOTA_TEAM_NOTEAM
    )
    barrel:Attribute_SetIntValue("barrel", 1)
    ModifierObstacle:apply(barrel, barrel, nil, {})
    barrel:SetHullRadius(65)
    barrel:AddNewModifier(
        barrel,
        nil,
        "wall_base",
        {fow_blocker = fowBlocker:GetEntityIndex()}
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
    if orderType == DOTA_UNIT_ORDER_CAST_POSITION or orderType == DOTA_UNIT_ORDER_CAST_TARGET or orderType == DOTA_UNIT_ORDER_CAST_TARGET_TREE or orderType == DOTA_UNIT_ORDER_CAST_NO_TARGET then
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
            local current_range = point:__sub(caster:GetAbsOrigin()):Length2D()
            local direction = point:__sub(caster:GetAbsOrigin()):Normalized()
            local max_range = ability:GetCastRange(
                Vector(0, 0, 0),
                nil
            )
            if not CustomAbilitiesLegacy:HasBehavior(ability, DOTA_ABILITY_BEHAVIOR_IMMEDIATE) then
                CustomEntitiesLegacy:FullyFaceTowards(caster, direction)
            end
            if current_range > max_range then
                local new_point = caster:GetAbsOrigin():__add(direction:__mul(max_range - 10))
                event.position_x = new_point.x
                event.position_y = new_point.y
            end
            return true
        end
    end
    if orderType == DOTA_UNIT_ORDER_STOP or orderType == DOTA_UNIT_ORDER_HOLD_POSITION then
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
    if orderType == DOTA_UNIT_ORDER_MOVE_TO_POSITION or orderType == DOTA_UNIT_ORDER_MOVE_TO_TARGET then
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
    if attacker and attacker:IsNull() or victim and victim:IsNull() then
        return false
    end
    if victim and victim:IsBaseNPC() then
        victim:AddNewModifier(victim, nil, "modifier_damage_fx", {duration = 0.1})
        Timers:CreateTimer(
            0.05,
            function()
                CustomEntitiesLegacy:SendDataToClient(victim)
            end
        )
        if victim:IsRealHero() then
            CustomEntitiesLegacy:SetTreshold(
                victim,
                CustomEntitiesLegacy:GetTreshold(victim) - damage_after_reductions
            )
            if CustomEntitiesLegacy:GetTreshold(victim) < 0 then
                CustomEntitiesLegacy:SetTreshold(victim, 0)
            end
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
    local playerId = event.playerid
    local player = self:FindPlayerById(playerId)
    if event.text == "-unstuck" then
        if player then
            local hero = player.hero
            if hero then
                CustomEntitiesLegacy:SetDirection(hero, 0, 0)
            end
        end
    end
    if not GameRules:IsCheatMode() and not IsInToolsMode() then
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
    if self:IsPVE() then
        if not player then
            return
        end
        local customNpc = player.customNpc
        if not customNpc then
            return
        end
        if event.text == "-favor" then
            RewardsManager:OfferFavorsForHero(customNpc)
        end
        if event.text == "-shard" then
            RewardsManager:ClaimShards(customNpc)
        end
        if event.text == "-tome" then
            RewardsManager:ClaimKnowledge(customNpc)
        end
        if event.text == "-item" then
            RewardsManager:ClaimItems(customNpc)
        end
        if event.text == "-reward" then
            local rewards = RewardsManager:GenerateRewards(customNpc, {amount = 3})
            RewardsManager:OfferRewardsForHero(customNpc, rewards)
        end
        if event.text == "-vitality" then
            RewardsManager:ClaimVitality(customNpc)
        end
    end
    if event.text == "-skip" then
        if self:IsPVE() then
            if self.run and self.run.stage and self.run.stage.room then
                self.run.stage.room:SkipWave()
            end
        end
    end
    if __TS__StringSplit(event.text, " ")[1] == "-room" then
        if not __TS__StringSplit(event.text, " ")[2] then
            return
        end
        if self:IsPVE() then
            local room = __TS__ParseInt(
                __TS__StringSplit(event.text, " ")[2],
                10
            )
            if __TS__NumberIsNaN(__TS__Number(room)) then
                return
            end
            room = room - 1
            if self.run and self.run.stage and self.run.stage.room then
                if self.run.stage.totalNpcRooms > room then
                    return
                end
                self.run.stage.room:SkipRoom()
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
    if npc == nil or npc:IsNull() then
        return false
    end
    if npc:GetName() == "npc_dota_thinker" or npc:GetName() == "npc_dota_base" then
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
    local ____self_units_7 = self.units
    ____self_units_7[#____self_units_7 + 1] = customNpc
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
        self.round.heroDied = true
        self:CreateDeathOrb(killed)
        self:UpdateCameras()
    end
end
function GameMode.prototype.OnEntityHurt(self, event)
    if event.entindex_killed ~= nil then
        local victim = EntIndexToHScript(event.entindex_killed)
        if event.entindex_attacker ~= nil then
            SendOverheadDamageMessage(victim, event.damage)
        end
        CustomEntitiesLegacy:SetBeenHurt(victim, true)
    end
end
function GameMode.prototype.RefreshHeroes(self)
    __TS__ArrayForEach(
        self.players,
        function(____, player)
            if player.hero and not player.hero:IsNull() and player.hero:IsAlive() then
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
            if hero and not hero:IsAlive() and player.alliance then
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
    local ____opt_8 = __TS__ArrayFind(
        alliance.players,
        function(____, player)
            local ____opt_10 = player.hero
            return ____opt_10 and ____opt_10:IsAlive()
        end
    )
    return ____opt_8 and ____opt_8.hero
end
function GameMode.prototype.FindNextAliveHero(self)
    return __TS__ArrayFind(
        __TS__ArrayMap(
            self.players,
            function(____, player) return player.hero end
        ),
        function(____, hero) return hero and hero:IsAlive() end
    )
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
        mana_given / 100 + 0.25
    )
    local ____self_round_pickupWrappers_14 = self.round.pickupWrappers
    ____self_round_pickupWrappers_14[#____self_round_pickupWrappers_14 + 1] = {origin = origin, type = PickupTypes.DEATH, timer = -1, entity = entity}
    entity:GetItem():SetCurrentCharges(mana_given)
    entity:GetItem():SetPurchaser(hero)
end
function GameMode.prototype.EndGame(self, victoryTeam)
    GameRules:SetGameWinner(victoryTeam)
end
function GameMode.prototype.Reload(self)
end
GameMode = __TS__Decorate({reloadable}, GameMode)
____exports.GameMode = GameMode
__TS__ObjectAssign(
    getfenv(),
    {Activate = ____exports.GameMode.Activate, Precache = ____exports.GameMode.Precache}
)
if GameRules.Addon ~= nil then
    GameRules.Addon:Reload()
end
return ____exports
