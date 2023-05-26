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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["17"] = 1,["18"] = 2,["19"] = 2,["20"] = 3,["21"] = 3,["22"] = 4,["23"] = 4,["24"] = 5,["25"] = 5,["26"] = 6,["27"] = 7,["28"] = 8,["29"] = 9,["30"] = 10,["31"] = 11,["32"] = 12,["33"] = 13,["34"] = 14,["35"] = 15,["36"] = 16,["37"] = 17,["38"] = 17,["39"] = 18,["40"] = 18,["41"] = 19,["42"] = 19,["43"] = 20,["44"] = 20,["45"] = 20,["46"] = 20,["47"] = 21,["48"] = 21,["49"] = 22,["50"] = 22,["51"] = 22,["52"] = 23,["53"] = 23,["54"] = 24,["55"] = 24,["56"] = 25,["57"] = 25,["58"] = 26,["59"] = 26,["60"] = 27,["61"] = 27,["62"] = 28,["63"] = 28,["64"] = 29,["65"] = 29,["66"] = 30,["67"] = 30,["68"] = 31,["69"] = 31,["70"] = 53,["71"] = 58,["72"] = 58,["73"] = 58,["74"] = 58,["75"] = 58,["76"] = 63,["77"] = 63,["78"] = 63,["79"] = 63,["80"] = 63,["81"] = 68,["82"] = 69,["83"] = 70,["84"] = 71,["85"] = 72,["86"] = 74,["87"] = 76,["88"] = 77,["89"] = 76,["91"] = 78,["92"] = 79,["93"] = 80,["94"] = 81,["95"] = 82,["96"] = 84,["97"] = 90,["98"] = 91,["99"] = 94,["100"] = 96,["101"] = 96,["102"] = 98,["103"] = 99,["104"] = 96,["105"] = 96,["106"] = 96,["107"] = 104,["108"] = 105,["109"] = 106,["110"] = 107,["111"] = 108,["112"] = 110,["113"] = 111,["114"] = 112,["115"] = 113,["116"] = 93,["117"] = 117,["118"] = 118,["119"] = 119,["120"] = 120,["121"] = 121,["122"] = 122,["123"] = 123,["124"] = 124,["125"] = 125,["126"] = 126,["127"] = 127,["128"] = 129,["129"] = 130,["130"] = 131,["131"] = 132,["132"] = 133,["133"] = 134,["134"] = 136,["135"] = 137,["136"] = 138,["137"] = 140,["138"] = 141,["139"] = 142,["140"] = 143,["142"] = 117,["143"] = 147,["144"] = 148,["145"] = 147,["146"] = 151,["147"] = 152,["148"] = 152,["149"] = 153,["150"] = 153,["151"] = 154,["152"] = 154,["153"] = 155,["154"] = 155,["155"] = 156,["156"] = 156,["157"] = 158,["158"] = 159,["159"] = 160,["160"] = 161,["162"] = 164,["163"] = 164,["164"] = 164,["165"] = 165,["166"] = 166,["167"] = 166,["168"] = 166,["169"] = 167,["170"] = 166,["171"] = 166,["172"] = 164,["173"] = 164,["174"] = 151,["175"] = 172,["176"] = 173,["177"] = 174,["178"] = 175,["179"] = 177,["180"] = 178,["181"] = 179,["182"] = 181,["183"] = 181,["184"] = 181,["185"] = 182,["186"] = 183,["188"] = 185,["189"] = 186,["191"] = 188,["192"] = 189,["194"] = 181,["195"] = 181,["196"] = 172,["197"] = 194,["198"] = 195,["199"] = 196,["200"] = 198,["201"] = 198,["202"] = 198,["203"] = 199,["204"] = 200,["206"] = 202,["207"] = 203,["209"] = 198,["210"] = 198,["211"] = 194,["212"] = 208,["213"] = 209,["214"] = 210,["216"] = 212,["217"] = 214,["218"] = 215,["219"] = 215,["220"] = 215,["221"] = 216,["222"] = 217,["223"] = 218,["225"] = 215,["226"] = 215,["228"] = 223,["229"] = 208,["230"] = 226,["231"] = 227,["232"] = 228,["233"] = 229,["234"] = 230,["235"] = 231,["236"] = 232,["237"] = 233,["238"] = 234,["239"] = 235,["240"] = 236,["241"] = 237,["242"] = 239,["243"] = 240,["244"] = 241,["245"] = 242,["247"] = 244,["248"] = 226,["249"] = 247,["250"] = 248,["251"] = 249,["252"] = 250,["253"] = 251,["254"] = 252,["255"] = 247,["256"] = 255,["257"] = 256,["258"] = 257,["259"] = 258,["260"] = 259,["261"] = 255,["262"] = 262,["263"] = 263,["264"] = 263,["265"] = 263,["266"] = 263,["267"] = 263,["268"] = 264,["269"] = 264,["270"] = 264,["271"] = 264,["272"] = 264,["273"] = 265,["274"] = 265,["275"] = 265,["276"] = 265,["277"] = 265,["278"] = 266,["279"] = 266,["280"] = 266,["281"] = 266,["282"] = 266,["283"] = 267,["284"] = 267,["285"] = 267,["286"] = 267,["287"] = 267,["288"] = 268,["289"] = 268,["290"] = 268,["291"] = 268,["292"] = 268,["293"] = 269,["294"] = 262,["295"] = 272,["296"] = 273,["297"] = 273,["298"] = 273,["299"] = 274,["300"] = 275,["301"] = 276,["302"] = 277,["303"] = 278,["305"] = 273,["306"] = 273,["307"] = 282,["308"] = 282,["309"] = 282,["310"] = 283,["311"] = 284,["312"] = 286,["313"] = 287,["314"] = 288,["315"] = 290,["316"] = 291,["317"] = 293,["318"] = 294,["319"] = 295,["320"] = 296,["321"] = 298,["322"] = 299,["324"] = 302,["325"] = 303,["326"] = 304,["328"] = 307,["329"] = 308,["330"] = 309,["331"] = 310,["332"] = 311,["337"] = 282,["338"] = 282,["339"] = 318,["340"] = 318,["341"] = 318,["342"] = 319,["343"] = 320,["344"] = 322,["345"] = 323,["346"] = 325,["348"] = 326,["349"] = 326,["350"] = 327,["351"] = 328,["352"] = 329,["353"] = 330,["356"] = 326,["359"] = 335,["360"] = 336,["363"] = 340,["364"] = 341,["366"] = 318,["367"] = 318,["368"] = 345,["369"] = 345,["370"] = 345,["371"] = 346,["372"] = 347,["373"] = 349,["374"] = 350,["375"] = 351,["376"] = 352,["377"] = 353,["378"] = 354,["381"] = 345,["382"] = 345,["383"] = 272,["384"] = 360,["385"] = 361,["386"] = 362,["387"] = 363,["388"] = 364,["389"] = 365,["390"] = 366,["391"] = 367,["392"] = 360,["393"] = 370,["394"] = 371,["395"] = 372,["396"] = 373,["397"] = 374,["398"] = 375,["399"] = 376,["400"] = 378,["401"] = 379,["402"] = 380,["403"] = 381,["404"] = 382,["405"] = 384,["406"] = 385,["407"] = 386,["408"] = 387,["409"] = 388,["410"] = 393,["411"] = 394,["412"] = 395,["413"] = 396,["414"] = 397,["415"] = 398,["416"] = 399,["417"] = 400,["418"] = 401,["419"] = 406,["420"] = 407,["421"] = 408,["422"] = 409,["423"] = 410,["424"] = 412,["425"] = 413,["426"] = 414,["427"] = 415,["428"] = 416,["429"] = 418,["430"] = 419,["431"] = 420,["432"] = 421,["433"] = 427,["434"] = 428,["435"] = 429,["436"] = 431,["437"] = 431,["438"] = 431,["439"] = 432,["440"] = 433,["441"] = 434,["443"] = 436,["444"] = 437,["446"] = 439,["447"] = 440,["450"] = 431,["451"] = 431,["452"] = 444,["453"] = 445,["454"] = 450,["455"] = 451,["456"] = 456,["458"] = 459,["459"] = 370,["460"] = 462,["461"] = 463,["462"] = 462,["463"] = 466,["464"] = 467,["465"] = 467,["466"] = 467,["467"] = 467,["468"] = 467,["469"] = 473,["470"] = 473,["471"] = 466,["472"] = 476,["473"] = 477,["474"] = 479,["475"] = 479,["476"] = 479,["477"] = 480,["478"] = 480,["479"] = 480,["480"] = 481,["481"] = 482,["483"] = 480,["484"] = 480,["485"] = 479,["486"] = 479,["487"] = 487,["488"] = 476,["489"] = 490,["490"] = 491,["491"] = 492,["492"] = 493,["493"] = 495,["494"] = 496,["495"] = 497,["496"] = 505,["498"] = 507,["499"] = 508,["500"] = 509,["501"] = 510,["502"] = 510,["503"] = 511,["504"] = 513,["505"] = 514,["506"] = 515,["508"] = 518,["509"] = 519,["510"] = 520,["511"] = 521,["512"] = 523,["514"] = 526,["516"] = 490,["517"] = 530,["518"] = 531,["519"] = 532,["520"] = 533,["521"] = 534,["522"] = 535,["523"] = 530,["524"] = 538,["525"] = 539,["526"] = 540,["527"] = 541,["528"] = 542,["529"] = 543,["530"] = 544,["531"] = 545,["532"] = 546,["533"] = 547,["534"] = 548,["535"] = 549,["536"] = 550,["537"] = 552,["538"] = 552,["539"] = 552,["540"] = 552,["541"] = 552,["542"] = 552,["543"] = 550,["544"] = 570,["545"] = 571,["546"] = 572,["548"] = 538,["549"] = 576,["550"] = 577,["551"] = 578,["552"] = 580,["553"] = 580,["554"] = 580,["555"] = 581,["556"] = 580,["557"] = 580,["558"] = 584,["559"] = 576,["560"] = 587,["561"] = 588,["562"] = 589,["563"] = 589,["564"] = 589,["565"] = 589,["566"] = 589,["567"] = 589,["568"] = 589,["569"] = 589,["570"] = 590,["571"] = 591,["572"] = 592,["573"] = 593,["574"] = 593,["575"] = 593,["576"] = 593,["577"] = 593,["578"] = 593,["579"] = 596,["580"] = 587,["581"] = 599,["582"] = 600,["583"] = 601,["584"] = 602,["586"] = 599,["587"] = 606,["588"] = 607,["589"] = 606,["590"] = 610,["591"] = 611,["592"] = 614,["593"] = 619,["594"] = 620,["595"] = 621,["596"] = 622,["597"] = 624,["598"] = 625,["599"] = 626,["601"] = 629,["602"] = 630,["603"] = 631,["604"] = 632,["605"] = 633,["606"] = 633,["607"] = 633,["608"] = 633,["609"] = 635,["610"] = 636,["612"] = 639,["613"] = 640,["614"] = 641,["615"] = 642,["617"] = 645,["620"] = 649,["621"] = 650,["622"] = 651,["623"] = 652,["624"] = 653,["625"] = 654,["629"] = 658,["630"] = 659,["632"] = 661,["633"] = 662,["635"] = 665,["636"] = 610,["637"] = 668,["638"] = 669,["639"] = 668,["640"] = 672,["641"] = 673,["642"] = 676,["643"] = 677,["644"] = 678,["645"] = 679,["646"] = 680,["648"] = 682,["650"] = 685,["651"] = 686,["652"] = 688,["653"] = 689,["654"] = 689,["655"] = 689,["656"] = 690,["657"] = 689,["658"] = 689,["661"] = 695,["662"] = 696,["663"] = 696,["664"] = 696,["665"] = 697,["666"] = 696,["667"] = 696,["668"] = 725,["669"] = 672,["670"] = 728,["671"] = 729,["672"] = 730,["673"] = 732,["674"] = 736,["675"] = 737,["677"] = 740,["678"] = 741,["679"] = 744,["680"] = 744,["681"] = 744,["682"] = 745,["683"] = 744,["684"] = 744,["685"] = 748,["686"] = 749,["687"] = 749,["688"] = 749,["689"] = 749,["690"] = 750,["691"] = 751,["693"] = 754,["694"] = 755,["695"] = 757,["696"] = 758,["697"] = 758,["698"] = 758,["699"] = 759,["700"] = 758,["701"] = 758,["705"] = 765,["706"] = 728,["707"] = 768,["708"] = 769,["709"] = 771,["710"] = 772,["712"] = 768,["713"] = 776,["714"] = 777,["715"] = 778,["716"] = 780,["717"] = 781,["718"] = 782,["719"] = 783,["720"] = 784,["724"] = 789,["727"] = 793,["728"] = 794,["730"] = 797,["731"] = 798,["732"] = 799,["734"] = 802,["735"] = 803,["737"] = 806,["738"] = 807,["741"] = 811,["742"] = 813,["745"] = 817,["746"] = 818,["748"] = 821,["749"] = 822,["751"] = 825,["752"] = 826,["754"] = 829,["755"] = 830,["757"] = 833,["758"] = 834,["759"] = 837,["761"] = 840,["762"] = 841,["765"] = 845,["766"] = 846,["767"] = 847,["768"] = 848,["772"] = 853,["773"] = 854,["776"] = 857,["777"] = 858,["778"] = 858,["779"] = 858,["780"] = 858,["781"] = 859,["784"] = 862,["785"] = 864,["786"] = 865,["789"] = 868,["793"] = 776,["794"] = 874,["795"] = 875,["796"] = 876,["797"] = 878,["798"] = 879,["799"] = 881,["800"] = 882,["801"] = 883,["802"] = 883,["803"] = 883,["804"] = 884,["805"] = 885,["806"] = 886,["807"] = 887,["810"] = 883,["811"] = 883,["812"] = 892,["813"] = 893,["814"] = 894,["815"] = 895,["819"] = 900,["822"] = 874,["823"] = 905,["824"] = 906,["825"] = 905,["826"] = 909,["827"] = 910,["828"] = 911,["829"] = 912,["831"] = 915,["832"] = 916,["834"] = 919,["835"] = 920,["837"] = 923,["838"] = 924,["839"] = 925,["840"] = 926,["841"] = 927,["842"] = 928,["843"] = 929,["847"] = 934,["848"] = 909,["849"] = 937,["850"] = 938,["851"] = 939,["852"] = 937,["853"] = 942,["854"] = 943,["855"] = 942,["856"] = 946,["857"] = 947,["858"] = 946,["859"] = 950,["860"] = 951,["861"] = 950,["862"] = 954,["863"] = 955,["864"] = 957,["865"] = 958,["866"] = 959,["868"] = 961,["871"] = 964,["873"] = 966,["874"] = 966,["875"] = 967,["876"] = 954,["877"] = 970,["878"] = 971,["879"] = 971,["880"] = 971,["881"] = 971,["882"] = 970,["883"] = 974,["884"] = 975,["885"] = 977,["886"] = 978,["887"] = 979,["889"] = 981,["890"] = 982,["891"] = 982,["892"] = 982,["893"] = 982,["894"] = 982,["895"] = 983,["898"] = 986,["900"] = 974,["901"] = 990,["902"] = 991,["903"] = 992,["904"] = 993,["905"] = 994,["907"] = 990,["908"] = 998,["909"] = 999,["910"] = 1000,["911"] = 1001,["912"] = 1002,["914"] = 1004,["916"] = 998,["917"] = 1008,["918"] = 1009,["919"] = 1009,["920"] = 1009,["921"] = 1010,["922"] = 1011,["923"] = 1011,["924"] = 1011,["925"] = 1011,["926"] = 1012,["928"] = 1009,["929"] = 1009,["930"] = 1008,["931"] = 1017,["932"] = 1018,["933"] = 1018,["934"] = 1018,["935"] = 1019,["936"] = 1020,["937"] = 1021,["938"] = 1023,["939"] = 1024,["940"] = 1024,["941"] = 1024,["942"] = 1024,["943"] = 1025,["945"] = 1027,["946"] = 1028,["947"] = 1029,["948"] = 1029,["949"] = 1029,["950"] = 1029,["951"] = 1030,["955"] = 1018,["956"] = 1018,["957"] = 1017,["958"] = 1037,["959"] = 1038,["960"] = 1038,["961"] = 1038,["962"] = 1038,["963"] = 1038,["964"] = 1038,["965"] = 1038,["966"] = 1038,["967"] = 1037,["968"] = 1041,["969"] = 1042,["970"] = 1042,["971"] = 1042,["972"] = 1042,["973"] = 1042,["974"] = 1042,["975"] = 1042,["976"] = 1041,["977"] = 1045,["978"] = 1046,["979"] = 1046,["980"] = 1046,["981"] = 1046,["982"] = 1045,["983"] = 1049,["984"] = 1050,["985"] = 1049,["986"] = 1053,["987"] = 1054,["988"] = 1056,["989"] = 1057,["991"] = 1060,["992"] = 1053,["993"] = 1063,["994"] = 1064,["995"] = 1065,["996"] = 1066,["997"] = 1067,["998"] = 1067,["999"] = 1067,["1000"] = 1067,["1001"] = 1067,["1002"] = 1067,["1003"] = 1069,["1004"] = 1069,["1005"] = 1076,["1006"] = 1077,["1007"] = 1063,["1008"] = 1080,["1009"] = 1081,["1010"] = 1080,["1011"] = 1085,["1012"] = 1085,["1013"] = 76,["1014"] = 77,["1015"] = 1088,["1016"] = 1088,["1017"] = 1088,["1018"] = 1088,["1019"] = 1093,["1020"] = 1094});
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
local ____projectiles = require("projectiles")
local updateProjectiles = ____projectiles.updateProjectiles
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
    updateProjectiles(nil)
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
