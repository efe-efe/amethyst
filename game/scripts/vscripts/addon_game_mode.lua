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
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["16"] = 1,["17"] = 2,["18"] = 2,["19"] = 3,["20"] = 3,["21"] = 4,["22"] = 4,["23"] = 5,["24"] = 5,["25"] = 6,["26"] = 7,["27"] = 8,["28"] = 9,["29"] = 10,["30"] = 11,["31"] = 12,["32"] = 13,["33"] = 14,["34"] = 15,["35"] = 16,["36"] = 17,["37"] = 17,["38"] = 18,["39"] = 18,["40"] = 19,["41"] = 19,["42"] = 20,["43"] = 20,["44"] = 20,["45"] = 20,["46"] = 21,["47"] = 21,["48"] = 22,["49"] = 22,["50"] = 22,["51"] = 23,["52"] = 23,["53"] = 24,["54"] = 24,["55"] = 25,["56"] = 25,["57"] = 26,["58"] = 26,["59"] = 27,["60"] = 27,["61"] = 28,["62"] = 28,["63"] = 29,["64"] = 29,["65"] = 51,["66"] = 56,["67"] = 56,["68"] = 56,["69"] = 56,["70"] = 56,["71"] = 61,["72"] = 61,["73"] = 61,["74"] = 61,["75"] = 61,["76"] = 66,["77"] = 67,["78"] = 68,["79"] = 69,["80"] = 70,["81"] = 72,["82"] = 74,["83"] = 75,["84"] = 74,["86"] = 76,["87"] = 77,["88"] = 78,["89"] = 79,["90"] = 80,["91"] = 82,["92"] = 88,["93"] = 89,["94"] = 92,["95"] = 92,["96"] = 94,["97"] = 95,["98"] = 92,["99"] = 92,["100"] = 92,["101"] = 100,["102"] = 101,["103"] = 102,["104"] = 103,["105"] = 104,["106"] = 106,["107"] = 107,["108"] = 108,["109"] = 109,["110"] = 91,["111"] = 113,["112"] = 114,["113"] = 115,["114"] = 116,["115"] = 117,["116"] = 118,["117"] = 119,["118"] = 120,["119"] = 121,["120"] = 122,["121"] = 123,["122"] = 125,["123"] = 126,["124"] = 127,["125"] = 128,["126"] = 129,["127"] = 130,["128"] = 132,["129"] = 133,["130"] = 134,["131"] = 136,["132"] = 137,["133"] = 138,["134"] = 139,["136"] = 113,["137"] = 143,["138"] = 144,["139"] = 143,["140"] = 147,["141"] = 148,["142"] = 148,["143"] = 149,["144"] = 149,["145"] = 150,["146"] = 150,["147"] = 151,["148"] = 151,["149"] = 152,["150"] = 152,["151"] = 154,["152"] = 155,["153"] = 156,["154"] = 157,["156"] = 160,["157"] = 160,["158"] = 160,["159"] = 161,["160"] = 162,["161"] = 162,["162"] = 162,["163"] = 163,["164"] = 162,["165"] = 162,["166"] = 160,["167"] = 160,["168"] = 147,["169"] = 168,["170"] = 169,["171"] = 170,["172"] = 171,["173"] = 173,["174"] = 174,["175"] = 175,["176"] = 177,["177"] = 177,["178"] = 177,["179"] = 178,["180"] = 179,["182"] = 181,["183"] = 182,["185"] = 184,["186"] = 185,["188"] = 177,["189"] = 177,["190"] = 168,["191"] = 190,["192"] = 191,["193"] = 192,["194"] = 194,["195"] = 194,["196"] = 194,["197"] = 195,["198"] = 196,["200"] = 198,["201"] = 199,["203"] = 194,["204"] = 194,["205"] = 190,["206"] = 204,["207"] = 205,["208"] = 206,["210"] = 208,["211"] = 210,["212"] = 211,["213"] = 211,["214"] = 211,["215"] = 212,["216"] = 213,["217"] = 214,["219"] = 211,["220"] = 211,["222"] = 219,["223"] = 204,["224"] = 222,["225"] = 223,["226"] = 224,["227"] = 225,["228"] = 226,["229"] = 227,["230"] = 228,["231"] = 229,["232"] = 230,["233"] = 231,["234"] = 232,["235"] = 233,["236"] = 235,["237"] = 236,["238"] = 237,["239"] = 238,["241"] = 240,["242"] = 222,["243"] = 243,["244"] = 244,["245"] = 245,["246"] = 246,["247"] = 247,["248"] = 248,["249"] = 243,["250"] = 251,["251"] = 252,["252"] = 253,["253"] = 254,["254"] = 255,["255"] = 251,["256"] = 258,["257"] = 259,["258"] = 259,["259"] = 259,["260"] = 259,["261"] = 259,["262"] = 260,["263"] = 260,["264"] = 260,["265"] = 260,["266"] = 260,["267"] = 261,["268"] = 261,["269"] = 261,["270"] = 261,["271"] = 261,["272"] = 262,["273"] = 262,["274"] = 262,["275"] = 262,["276"] = 262,["277"] = 263,["278"] = 263,["279"] = 263,["280"] = 263,["281"] = 263,["282"] = 264,["283"] = 264,["284"] = 264,["285"] = 264,["286"] = 264,["287"] = 265,["288"] = 258,["289"] = 268,["290"] = 269,["291"] = 269,["292"] = 269,["293"] = 270,["294"] = 271,["295"] = 272,["296"] = 273,["297"] = 274,["299"] = 269,["300"] = 269,["301"] = 278,["302"] = 278,["303"] = 278,["304"] = 279,["305"] = 280,["306"] = 282,["307"] = 283,["308"] = 284,["309"] = 286,["310"] = 287,["311"] = 289,["312"] = 290,["313"] = 291,["314"] = 292,["315"] = 294,["316"] = 295,["318"] = 298,["319"] = 299,["320"] = 300,["322"] = 303,["323"] = 304,["324"] = 305,["325"] = 306,["326"] = 307,["331"] = 278,["332"] = 278,["333"] = 314,["334"] = 314,["335"] = 314,["336"] = 315,["337"] = 316,["338"] = 318,["339"] = 319,["340"] = 321,["342"] = 322,["343"] = 322,["344"] = 323,["345"] = 324,["346"] = 325,["347"] = 326,["350"] = 322,["353"] = 331,["354"] = 332,["357"] = 336,["358"] = 337,["360"] = 314,["361"] = 314,["362"] = 341,["363"] = 341,["364"] = 341,["365"] = 342,["366"] = 343,["367"] = 345,["368"] = 346,["369"] = 347,["370"] = 348,["371"] = 349,["372"] = 350,["375"] = 341,["376"] = 341,["377"] = 268,["378"] = 356,["379"] = 357,["380"] = 358,["381"] = 359,["382"] = 360,["383"] = 361,["384"] = 362,["385"] = 363,["386"] = 356,["387"] = 366,["388"] = 367,["389"] = 368,["390"] = 369,["391"] = 370,["392"] = 371,["393"] = 372,["394"] = 374,["395"] = 375,["396"] = 376,["397"] = 377,["398"] = 378,["399"] = 380,["400"] = 381,["401"] = 382,["402"] = 383,["403"] = 384,["404"] = 389,["405"] = 390,["406"] = 391,["407"] = 392,["408"] = 393,["409"] = 394,["410"] = 395,["411"] = 396,["412"] = 397,["413"] = 402,["414"] = 403,["415"] = 404,["416"] = 405,["417"] = 406,["418"] = 408,["419"] = 409,["420"] = 410,["421"] = 411,["422"] = 412,["423"] = 414,["424"] = 415,["425"] = 416,["426"] = 417,["427"] = 423,["428"] = 424,["429"] = 425,["430"] = 427,["431"] = 427,["432"] = 427,["433"] = 428,["434"] = 429,["435"] = 430,["437"] = 432,["438"] = 433,["440"] = 435,["441"] = 436,["444"] = 427,["445"] = 427,["446"] = 440,["447"] = 441,["448"] = 446,["449"] = 447,["450"] = 452,["452"] = 455,["453"] = 366,["454"] = 458,["455"] = 459,["456"] = 458,["457"] = 462,["458"] = 463,["459"] = 463,["460"] = 463,["461"] = 463,["462"] = 463,["463"] = 469,["464"] = 469,["465"] = 462,["466"] = 472,["467"] = 473,["468"] = 475,["469"] = 475,["470"] = 475,["471"] = 476,["472"] = 476,["473"] = 476,["474"] = 477,["475"] = 478,["477"] = 476,["478"] = 476,["479"] = 475,["480"] = 475,["481"] = 483,["482"] = 472,["483"] = 486,["484"] = 487,["485"] = 488,["486"] = 489,["487"] = 491,["488"] = 492,["489"] = 493,["490"] = 501,["492"] = 503,["493"] = 504,["494"] = 505,["495"] = 506,["496"] = 506,["497"] = 507,["498"] = 509,["499"] = 510,["500"] = 511,["502"] = 514,["503"] = 515,["504"] = 516,["505"] = 517,["506"] = 519,["508"] = 522,["510"] = 486,["511"] = 526,["512"] = 527,["513"] = 528,["514"] = 529,["515"] = 530,["516"] = 531,["517"] = 526,["518"] = 534,["519"] = 535,["520"] = 536,["521"] = 537,["522"] = 538,["523"] = 539,["524"] = 540,["525"] = 541,["526"] = 542,["527"] = 543,["528"] = 544,["529"] = 545,["530"] = 546,["531"] = 548,["532"] = 548,["533"] = 548,["534"] = 548,["535"] = 548,["536"] = 548,["537"] = 546,["538"] = 566,["539"] = 567,["540"] = 568,["542"] = 534,["543"] = 572,["544"] = 573,["545"] = 574,["546"] = 576,["547"] = 576,["548"] = 576,["549"] = 577,["550"] = 576,["551"] = 576,["552"] = 580,["553"] = 572,["554"] = 583,["555"] = 584,["556"] = 585,["557"] = 585,["558"] = 585,["559"] = 585,["560"] = 585,["561"] = 585,["562"] = 585,["563"] = 585,["564"] = 586,["565"] = 587,["566"] = 588,["567"] = 588,["568"] = 588,["569"] = 588,["570"] = 588,["571"] = 588,["572"] = 591,["573"] = 583,["574"] = 594,["575"] = 595,["576"] = 596,["577"] = 597,["579"] = 594,["580"] = 601,["581"] = 602,["582"] = 601,["583"] = 605,["584"] = 606,["585"] = 609,["586"] = 614,["587"] = 615,["588"] = 616,["589"] = 617,["590"] = 619,["591"] = 620,["592"] = 621,["594"] = 624,["595"] = 625,["596"] = 626,["597"] = 627,["598"] = 628,["599"] = 628,["600"] = 628,["601"] = 628,["602"] = 630,["603"] = 631,["605"] = 634,["606"] = 635,["607"] = 636,["608"] = 637,["610"] = 640,["613"] = 644,["614"] = 645,["615"] = 646,["616"] = 647,["617"] = 648,["618"] = 649,["622"] = 653,["623"] = 654,["625"] = 656,["626"] = 657,["628"] = 660,["629"] = 605,["630"] = 663,["631"] = 664,["632"] = 663,["633"] = 667,["634"] = 668,["635"] = 671,["636"] = 672,["637"] = 673,["638"] = 674,["639"] = 675,["641"] = 677,["643"] = 680,["644"] = 681,["645"] = 683,["646"] = 684,["647"] = 684,["648"] = 684,["649"] = 685,["650"] = 684,["651"] = 684,["654"] = 690,["655"] = 691,["656"] = 691,["657"] = 691,["658"] = 692,["659"] = 691,["660"] = 691,["661"] = 720,["662"] = 667,["663"] = 723,["664"] = 724,["665"] = 725,["666"] = 727,["667"] = 731,["668"] = 732,["670"] = 735,["671"] = 736,["672"] = 739,["673"] = 739,["674"] = 739,["675"] = 740,["676"] = 739,["677"] = 739,["678"] = 743,["679"] = 744,["680"] = 744,["681"] = 744,["682"] = 744,["683"] = 745,["684"] = 746,["686"] = 749,["687"] = 750,["688"] = 752,["689"] = 753,["690"] = 753,["691"] = 753,["692"] = 754,["693"] = 753,["694"] = 753,["698"] = 760,["699"] = 723,["700"] = 763,["701"] = 764,["702"] = 766,["703"] = 767,["705"] = 763,["706"] = 771,["707"] = 772,["708"] = 773,["709"] = 775,["710"] = 776,["711"] = 777,["712"] = 778,["713"] = 779,["717"] = 784,["720"] = 788,["721"] = 789,["723"] = 792,["724"] = 793,["725"] = 794,["727"] = 797,["728"] = 798,["730"] = 801,["731"] = 802,["734"] = 806,["735"] = 808,["738"] = 812,["739"] = 813,["741"] = 816,["742"] = 817,["744"] = 820,["745"] = 821,["747"] = 824,["748"] = 825,["750"] = 828,["751"] = 829,["752"] = 832,["754"] = 835,["755"] = 836,["758"] = 840,["759"] = 841,["760"] = 842,["761"] = 843,["765"] = 848,["766"] = 849,["769"] = 852,["770"] = 853,["771"] = 853,["772"] = 853,["773"] = 853,["774"] = 854,["777"] = 857,["778"] = 859,["779"] = 860,["782"] = 863,["786"] = 771,["787"] = 869,["788"] = 870,["789"] = 871,["790"] = 873,["791"] = 874,["792"] = 876,["793"] = 877,["794"] = 878,["795"] = 878,["796"] = 878,["797"] = 879,["798"] = 880,["799"] = 881,["800"] = 882,["803"] = 878,["804"] = 878,["805"] = 887,["806"] = 888,["807"] = 889,["808"] = 890,["812"] = 895,["815"] = 869,["816"] = 900,["817"] = 901,["818"] = 900,["819"] = 904,["820"] = 905,["821"] = 906,["822"] = 907,["824"] = 910,["825"] = 911,["827"] = 914,["828"] = 915,["830"] = 918,["831"] = 919,["832"] = 920,["833"] = 921,["834"] = 922,["835"] = 923,["836"] = 924,["840"] = 929,["841"] = 904,["842"] = 932,["843"] = 933,["844"] = 934,["845"] = 932,["846"] = 937,["847"] = 938,["848"] = 937,["849"] = 941,["850"] = 942,["851"] = 941,["852"] = 945,["853"] = 946,["854"] = 945,["855"] = 949,["856"] = 950,["857"] = 952,["858"] = 953,["859"] = 954,["861"] = 956,["864"] = 959,["866"] = 961,["867"] = 961,["868"] = 962,["869"] = 949,["870"] = 965,["871"] = 966,["872"] = 966,["873"] = 966,["874"] = 966,["875"] = 965,["876"] = 969,["877"] = 970,["878"] = 972,["879"] = 973,["880"] = 974,["882"] = 976,["883"] = 977,["884"] = 977,["885"] = 977,["886"] = 977,["887"] = 977,["888"] = 978,["891"] = 981,["893"] = 969,["894"] = 985,["895"] = 986,["896"] = 987,["897"] = 988,["898"] = 989,["900"] = 985,["901"] = 993,["902"] = 994,["903"] = 995,["904"] = 996,["905"] = 997,["907"] = 999,["909"] = 993,["910"] = 1003,["911"] = 1004,["912"] = 1004,["913"] = 1004,["914"] = 1005,["915"] = 1006,["916"] = 1006,["917"] = 1006,["918"] = 1006,["919"] = 1007,["921"] = 1004,["922"] = 1004,["923"] = 1003,["924"] = 1012,["925"] = 1013,["926"] = 1013,["927"] = 1013,["928"] = 1014,["929"] = 1015,["930"] = 1016,["931"] = 1018,["932"] = 1019,["933"] = 1019,["934"] = 1019,["935"] = 1019,["936"] = 1020,["938"] = 1022,["939"] = 1023,["940"] = 1024,["941"] = 1024,["942"] = 1024,["943"] = 1024,["944"] = 1025,["948"] = 1013,["949"] = 1013,["950"] = 1012,["951"] = 1032,["952"] = 1033,["953"] = 1033,["954"] = 1033,["955"] = 1033,["956"] = 1033,["957"] = 1033,["958"] = 1033,["959"] = 1033,["960"] = 1032,["961"] = 1036,["962"] = 1037,["963"] = 1037,["964"] = 1037,["965"] = 1037,["966"] = 1038,["967"] = 1039,["969"] = 1041,["970"] = 1036,["971"] = 1044,["972"] = 1045,["973"] = 1045,["974"] = 1045,["975"] = 1045,["976"] = 1044,["977"] = 1048,["978"] = 1049,["979"] = 1048,["980"] = 1052,["981"] = 1053,["982"] = 1055,["983"] = 1056,["985"] = 1059,["986"] = 1052,["987"] = 1062,["988"] = 1063,["989"] = 1064,["990"] = 1065,["991"] = 1066,["992"] = 1066,["993"] = 1066,["994"] = 1066,["995"] = 1066,["996"] = 1066,["997"] = 1068,["998"] = 1068,["999"] = 1075,["1000"] = 1076,["1001"] = 1062,["1002"] = 1079,["1003"] = 1080,["1004"] = 1079,["1005"] = 1084,["1006"] = 1084,["1007"] = 74,["1008"] = 75,["1009"] = 1087,["1010"] = 1087,["1011"] = 1087,["1012"] = 1087,["1013"] = 1092,["1014"] = 1093});
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
    LinkLuaModifier("modifier_casting", "modifiers/generic/modifier_casting", LUA_MODIFIER_MOTION_NONE)
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
        mana_given / 100 + 0.25
    )
    local ____self_round_pickupWrappers_12 = self.round.pickupWrappers
    ____self_round_pickupWrappers_12[#____self_round_pickupWrappers_12 + 1] = {origin = origin, type = PickupTypes.DEATH, timer = -1, entity = entity}
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
if GameRules.Addon then
    GameRules.Addon:Reload()
end
return ____exports
