--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 2,["7"] = 2,["8"] = 3,["9"] = 3,["10"] = 4,["11"] = 4,["12"] = 5,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 19,["30"] = 19,["31"] = 20,["32"] = 20,["33"] = 20,["34"] = 20,["35"] = 21,["36"] = 21,["37"] = 22,["38"] = 22,["39"] = 22,["40"] = 23,["41"] = 23,["42"] = 24,["43"] = 24,["44"] = 25,["45"] = 25,["46"] = 26,["47"] = 26,["48"] = 27,["49"] = 27,["50"] = 28,["51"] = 28,["52"] = 29,["53"] = 29,["54"] = 51,["55"] = 56,["56"] = 56,["57"] = 56,["58"] = 56,["59"] = 56,["60"] = 61,["61"] = 61,["62"] = 61,["63"] = 61,["64"] = 61,["65"] = 66,["66"] = 67,["67"] = 68,["68"] = 69,["69"] = 70,["70"] = 72,["71"] = 74,["72"] = 75,["73"] = 74,["75"] = 76,["76"] = 77,["77"] = 78,["78"] = 79,["79"] = 80,["80"] = 82,["81"] = 88,["82"] = 89,["83"] = 92,["84"] = 92,["85"] = 92,["86"] = 92,["87"] = 92,["88"] = 92,["89"] = 92,["90"] = 94,["91"] = 95,["92"] = 96,["93"] = 97,["94"] = 98,["95"] = 100,["96"] = 101,["97"] = 102,["98"] = 103,["99"] = 91,["100"] = 107,["101"] = 108,["102"] = 109,["103"] = 110,["104"] = 111,["105"] = 112,["106"] = 113,["107"] = 114,["108"] = 115,["109"] = 116,["110"] = 117,["111"] = 119,["112"] = 120,["113"] = 121,["114"] = 122,["115"] = 123,["116"] = 124,["117"] = 126,["118"] = 127,["119"] = 128,["120"] = 130,["121"] = 131,["122"] = 132,["123"] = 133,["125"] = 107,["126"] = 137,["127"] = 138,["128"] = 137,["129"] = 141,["130"] = 142,["131"] = 142,["132"] = 142,["133"] = 142,["134"] = 143,["135"] = 143,["136"] = 143,["137"] = 143,["138"] = 144,["139"] = 144,["140"] = 144,["141"] = 144,["142"] = 145,["143"] = 145,["144"] = 145,["145"] = 145,["146"] = 146,["147"] = 146,["148"] = 146,["149"] = 146,["150"] = 148,["151"] = 149,["152"] = 150,["153"] = 151,["155"] = 154,["156"] = 154,["157"] = 154,["158"] = 155,["159"] = 156,["160"] = 156,["161"] = 156,["162"] = 157,["163"] = 156,["164"] = 156,["165"] = 154,["166"] = 154,["167"] = 141,["168"] = 162,["169"] = 163,["170"] = 164,["171"] = 165,["172"] = 167,["173"] = 168,["174"] = 169,["175"] = 171,["176"] = 171,["177"] = 171,["178"] = 172,["179"] = 173,["181"] = 175,["182"] = 176,["184"] = 178,["185"] = 179,["187"] = 171,["188"] = 171,["189"] = 162,["190"] = 184,["191"] = 185,["192"] = 186,["193"] = 188,["194"] = 188,["195"] = 188,["196"] = 189,["197"] = 190,["199"] = 192,["200"] = 193,["202"] = 188,["203"] = 188,["204"] = 184,["205"] = 198,["206"] = 199,["207"] = 200,["209"] = 202,["210"] = 204,["211"] = 205,["212"] = 205,["213"] = 205,["214"] = 206,["215"] = 207,["216"] = 208,["218"] = 205,["219"] = 205,["221"] = 213,["222"] = 198,["223"] = 216,["224"] = 217,["225"] = 218,["226"] = 219,["227"] = 220,["228"] = 221,["229"] = 222,["230"] = 223,["231"] = 224,["232"] = 225,["233"] = 226,["234"] = 227,["235"] = 229,["236"] = 230,["237"] = 231,["238"] = 232,["240"] = 234,["241"] = 216,["242"] = 237,["243"] = 238,["244"] = 239,["245"] = 240,["246"] = 241,["247"] = 242,["248"] = 237,["249"] = 245,["250"] = 246,["251"] = 247,["252"] = 248,["253"] = 249,["254"] = 245,["255"] = 252,["256"] = 253,["257"] = 253,["258"] = 253,["259"] = 253,["260"] = 253,["261"] = 254,["262"] = 254,["263"] = 254,["264"] = 254,["265"] = 254,["266"] = 255,["267"] = 255,["268"] = 255,["269"] = 255,["270"] = 255,["271"] = 256,["272"] = 256,["273"] = 256,["274"] = 256,["275"] = 256,["276"] = 257,["277"] = 257,["278"] = 257,["279"] = 257,["280"] = 257,["281"] = 258,["282"] = 258,["283"] = 258,["284"] = 258,["285"] = 258,["286"] = 259,["287"] = 252,["288"] = 262,["289"] = 263,["290"] = 263,["291"] = 263,["292"] = 264,["293"] = 265,["294"] = 266,["295"] = 267,["296"] = 268,["298"] = 263,["299"] = 263,["300"] = 272,["301"] = 272,["302"] = 272,["303"] = 273,["304"] = 274,["305"] = 276,["306"] = 277,["307"] = 278,["308"] = 280,["309"] = 281,["310"] = 283,["311"] = 284,["312"] = 285,["313"] = 286,["314"] = 288,["315"] = 289,["317"] = 292,["318"] = 293,["319"] = 294,["321"] = 297,["322"] = 298,["323"] = 299,["324"] = 300,["325"] = 301,["326"] = 301,["327"] = 301,["332"] = 272,["333"] = 272,["334"] = 309,["335"] = 309,["336"] = 309,["337"] = 310,["338"] = 311,["339"] = 313,["340"] = 314,["341"] = 316,["343"] = 317,["344"] = 317,["345"] = 318,["346"] = 319,["347"] = 320,["348"] = 321,["351"] = 317,["354"] = 326,["355"] = 327,["358"] = 331,["359"] = 332,["360"] = 332,["361"] = 332,["363"] = 309,["364"] = 309,["365"] = 336,["366"] = 336,["367"] = 336,["368"] = 337,["369"] = 338,["370"] = 340,["371"] = 341,["372"] = 342,["373"] = 343,["374"] = 344,["375"] = 345,["378"] = 336,["379"] = 336,["380"] = 262,["381"] = 351,["382"] = 352,["383"] = 353,["384"] = 354,["385"] = 355,["386"] = 356,["387"] = 357,["388"] = 358,["389"] = 351,["390"] = 361,["391"] = 362,["392"] = 363,["393"] = 364,["394"] = 365,["395"] = 366,["396"] = 367,["397"] = 369,["398"] = 370,["399"] = 371,["400"] = 372,["401"] = 373,["402"] = 375,["403"] = 376,["404"] = 377,["405"] = 378,["406"] = 379,["407"] = 380,["408"] = 381,["409"] = 382,["410"] = 383,["411"] = 384,["412"] = 385,["413"] = 386,["414"] = 387,["415"] = 388,["416"] = 389,["417"] = 390,["418"] = 391,["419"] = 392,["420"] = 393,["421"] = 395,["422"] = 396,["423"] = 397,["424"] = 398,["425"] = 399,["426"] = 401,["427"] = 402,["428"] = 403,["429"] = 404,["430"] = 406,["431"] = 407,["432"] = 408,["433"] = 410,["434"] = 410,["435"] = 410,["436"] = 411,["437"] = 412,["438"] = 413,["439"] = 413,["440"] = 413,["441"] = 413,["442"] = 413,["444"] = 415,["445"] = 416,["446"] = 416,["447"] = 416,["448"] = 416,["449"] = 416,["451"] = 418,["452"] = 419,["453"] = 419,["454"] = 419,["455"] = 419,["456"] = 419,["459"] = 410,["460"] = 410,["461"] = 423,["462"] = 424,["463"] = 424,["464"] = 424,["465"] = 424,["466"] = 424,["467"] = 425,["468"] = 425,["469"] = 425,["470"] = 425,["471"] = 425,["472"] = 426,["473"] = 426,["474"] = 426,["475"] = 426,["476"] = 426,["477"] = 427,["479"] = 430,["480"] = 361,["481"] = 433,["482"] = 434,["483"] = 433,["484"] = 437,["485"] = 438,["486"] = 438,["487"] = 438,["488"] = 438,["489"] = 438,["490"] = 444,["491"] = 437,["492"] = 447,["493"] = 448,["494"] = 450,["495"] = 450,["496"] = 450,["497"] = 451,["498"] = 451,["499"] = 451,["500"] = 452,["501"] = 453,["503"] = 451,["504"] = 451,["505"] = 450,["506"] = 450,["507"] = 458,["508"] = 447,["509"] = 461,["510"] = 462,["511"] = 463,["512"] = 464,["513"] = 466,["514"] = 467,["515"] = 468,["516"] = 468,["517"] = 468,["518"] = 468,["519"] = 468,["520"] = 469,["522"] = 471,["523"] = 472,["524"] = 473,["525"] = 474,["526"] = 475,["527"] = 477,["528"] = 478,["529"] = 479,["531"] = 482,["532"] = 483,["533"] = 484,["534"] = 485,["535"] = 487,["537"] = 490,["539"] = 461,["540"] = 494,["541"] = 495,["542"] = 496,["543"] = 497,["544"] = 498,["545"] = 499,["546"] = 494,["547"] = 502,["548"] = 503,["549"] = 504,["550"] = 505,["551"] = 507,["552"] = 508,["553"] = 509,["554"] = 511,["555"] = 512,["556"] = 513,["557"] = 515,["558"] = 516,["559"] = 517,["560"] = 538,["561"] = 539,["562"] = 540,["564"] = 502,["565"] = 544,["566"] = 545,["567"] = 546,["568"] = 548,["569"] = 548,["570"] = 548,["571"] = 549,["572"] = 549,["573"] = 549,["574"] = 549,["575"] = 549,["576"] = 549,["577"] = 548,["578"] = 548,["579"] = 552,["580"] = 544,["581"] = 555,["582"] = 556,["583"] = 557,["584"] = 565,["585"] = 566,["586"] = 567,["587"] = 567,["588"] = 567,["589"] = 567,["590"] = 567,["591"] = 567,["592"] = 567,["593"] = 567,["594"] = 568,["595"] = 555,["596"] = 571,["597"] = 572,["598"] = 573,["599"] = 574,["601"] = 571,["602"] = 578,["603"] = 579,["604"] = 578,["605"] = 582,["606"] = 583,["607"] = 585,["608"] = 590,["609"] = 591,["610"] = 592,["611"] = 593,["612"] = 595,["613"] = 596,["614"] = 597,["616"] = 600,["617"] = 601,["618"] = 606,["619"] = 606,["620"] = 606,["621"] = 607,["622"] = 607,["623"] = 607,["624"] = 608,["625"] = 608,["626"] = 608,["627"] = 608,["628"] = 610,["629"] = 611,["631"] = 614,["632"] = 615,["633"] = 615,["634"] = 615,["635"] = 616,["636"] = 617,["638"] = 620,["641"] = 624,["642"] = 625,["643"] = 626,["644"] = 627,["645"] = 628,["646"] = 629,["650"] = 633,["651"] = 634,["653"] = 636,["654"] = 637,["656"] = 640,["657"] = 582,["658"] = 643,["659"] = 644,["660"] = 643,["661"] = 647,["662"] = 648,["663"] = 651,["664"] = 652,["665"] = 653,["666"] = 654,["667"] = 655,["669"] = 657,["671"] = 660,["672"] = 661,["673"] = 663,["674"] = 664,["675"] = 664,["676"] = 664,["677"] = 665,["678"] = 664,["679"] = 664,["682"] = 670,["683"] = 671,["684"] = 671,["685"] = 671,["686"] = 672,["687"] = 671,["688"] = 671,["689"] = 700,["690"] = 647,["691"] = 703,["692"] = 704,["693"] = 705,["694"] = 707,["695"] = 711,["696"] = 712,["698"] = 715,["699"] = 716,["700"] = 717,["701"] = 717,["702"] = 717,["703"] = 718,["704"] = 717,["705"] = 717,["706"] = 721,["707"] = 722,["708"] = 722,["709"] = 722,["710"] = 722,["711"] = 723,["712"] = 724,["714"] = 727,["715"] = 728,["716"] = 730,["717"] = 731,["718"] = 731,["719"] = 731,["720"] = 732,["721"] = 731,["722"] = 731,["726"] = 738,["727"] = 703,["728"] = 741,["729"] = 742,["730"] = 744,["731"] = 745,["733"] = 741,["734"] = 749,["735"] = 750,["736"] = 751,["737"] = 753,["738"] = 754,["739"] = 755,["740"] = 756,["741"] = 757,["745"] = 762,["748"] = 766,["749"] = 767,["751"] = 770,["752"] = 771,["753"] = 772,["755"] = 775,["756"] = 776,["758"] = 779,["759"] = 780,["762"] = 784,["763"] = 786,["766"] = 790,["767"] = 791,["769"] = 794,["770"] = 795,["772"] = 798,["773"] = 799,["775"] = 802,["776"] = 803,["778"] = 806,["779"] = 807,["780"] = 808,["782"] = 811,["783"] = 812,["786"] = 816,["787"] = 817,["788"] = 818,["789"] = 819,["793"] = 824,["794"] = 825,["797"] = 828,["798"] = 829,["799"] = 829,["800"] = 829,["801"] = 829,["802"] = 830,["803"] = 830,["804"] = 830,["807"] = 833,["808"] = 835,["809"] = 836,["812"] = 839,["816"] = 749,["817"] = 845,["818"] = 846,["819"] = 847,["820"] = 849,["821"] = 850,["822"] = 852,["823"] = 853,["824"] = 854,["825"] = 854,["826"] = 854,["827"] = 855,["828"] = 856,["829"] = 857,["830"] = 858,["833"] = 854,["834"] = 854,["835"] = 863,["836"] = 864,["837"] = 865,["838"] = 866,["842"] = 871,["845"] = 845,["846"] = 876,["847"] = 877,["848"] = 876,["849"] = 880,["850"] = 881,["851"] = 882,["852"] = 883,["854"] = 886,["855"] = 887,["857"] = 890,["858"] = 891,["860"] = 894,["861"] = 895,["862"] = 896,["863"] = 897,["864"] = 898,["865"] = 899,["866"] = 900,["870"] = 905,["871"] = 880,["872"] = 908,["873"] = 909,["874"] = 910,["875"] = 908,["876"] = 913,["877"] = 914,["878"] = 913,["879"] = 917,["880"] = 918,["881"] = 917,["882"] = 921,["883"] = 922,["884"] = 921,["885"] = 925,["886"] = 926,["887"] = 928,["888"] = 929,["889"] = 930,["891"] = 932,["894"] = 935,["896"] = 937,["897"] = 938,["898"] = 925,["899"] = 941,["900"] = 942,["901"] = 942,["902"] = 942,["903"] = 942,["904"] = 941,["905"] = 945,["906"] = 946,["907"] = 948,["908"] = 949,["909"] = 950,["911"] = 952,["912"] = 953,["913"] = 953,["914"] = 953,["915"] = 953,["916"] = 953,["917"] = 954,["920"] = 957,["922"] = 945,["923"] = 961,["924"] = 962,["925"] = 963,["926"] = 964,["927"] = 965,["929"] = 961,["930"] = 969,["931"] = 970,["932"] = 971,["933"] = 972,["934"] = 973,["937"] = 969,["938"] = 978,["939"] = 979,["940"] = 979,["941"] = 979,["942"] = 980,["943"] = 981,["944"] = 981,["945"] = 981,["946"] = 981,["947"] = 982,["949"] = 979,["950"] = 979,["951"] = 978,["952"] = 987,["953"] = 988,["954"] = 988,["955"] = 988,["956"] = 989,["957"] = 990,["958"] = 991,["959"] = 993,["960"] = 994,["961"] = 994,["962"] = 994,["963"] = 994,["964"] = 995,["966"] = 997,["967"] = 998,["968"] = 999,["969"] = 999,["970"] = 999,["971"] = 999,["972"] = 1000,["976"] = 988,["977"] = 988,["978"] = 987,["979"] = 1007,["980"] = 1008,["981"] = 1008,["982"] = 1008,["983"] = 1008,["984"] = 1009,["985"] = 1010,["987"] = 1012,["988"] = 1007,["989"] = 1015,["990"] = 1016,["991"] = 1016,["992"] = 1016,["993"] = 1016,["994"] = 1017,["995"] = 1018,["997"] = 1020,["998"] = 1015,["999"] = 1023,["1000"] = 1024,["1001"] = 1024,["1002"] = 1024,["1003"] = 1024,["1004"] = 1023,["1005"] = 1027,["1006"] = 1028,["1007"] = 1027,["1008"] = 1031,["1009"] = 1032,["1010"] = 1034,["1011"] = 1035,["1013"] = 1038,["1014"] = 1031,["1015"] = 1041,["1016"] = 1042,["1017"] = 1043,["1018"] = 1044,["1019"] = 1045,["1020"] = 1045,["1021"] = 1045,["1022"] = 1045,["1023"] = 1045,["1024"] = 1045,["1025"] = 1047,["1026"] = 1054,["1027"] = 1055,["1028"] = 1041,["1029"] = 1058,["1030"] = 1059,["1031"] = 1058,["1032"] = 1063,["1033"] = 1063,["1034"] = 74,["1035"] = 1067,["1036"] = 1067,["1037"] = 1067,["1038"] = 1067,["1039"] = 1072,["1040"] = 1073});
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
        "custom_action",
        function(eventSourceIndex, event)
            local playerId = event.playerIndex
            local player = self:FindPlayerById(playerId)
            if player then
                local customNpc = player.customNpc
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
                if (____type == Custom_ActionTypes.ABILITY) and hero then
                    if mode == Custom_ActionModes.STOP then
                        local ability = EntIndexToHScript(event.payload.abilityEntityIndex)
                        if customNpc and ability then
                            customNpc:ReleaseAbility(
                                ability:GetName()
                            )
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
                        LinkLuaModifier(
                            upgrade.modifier.name,
                            tostring(favorsPath) .. tostring(upgrade.modifier.name),
                            LUA_MODIFIER_MOTION_NONE
                        )
                    end
                    if upgrade.type == UpgradeTypes.SHARD then
                        LinkLuaModifier(
                            upgrade.modifier.name,
                            tostring(shardsPath) .. tostring(upgrade.modifier.name),
                            LUA_MODIFIER_MOTION_NONE
                        )
                    end
                    if upgrade.type == UpgradeTypes.ITEM then
                        LinkLuaModifier(
                            upgrade.modifier.name,
                            tostring(itemsPath) .. tostring(upgrade.modifier.name),
                            LUA_MODIFIER_MOTION_NONE
                        )
                    end
                end
            end
        )
        LinkLuaModifier("modifier_combine_util", "modifiers/modifier_combine_util", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier(
            "modifier_upgrade_item_maelstrom_attack",
            tostring(itemsPath) .. "modifier_upgrade_item_maelstrom",
            LUA_MODIFIER_MOTION_NONE
        )
        LinkLuaModifier(
            "modifier_upgrade_item_basher_attack",
            tostring(itemsPath) .. "modifier_upgrade_item_basher",
            LUA_MODIFIER_MOTION_NONE
        )
        LinkLuaModifier(
            "modifier_upgrade_item_javelin_attack",
            tostring(itemsPath) .. "modifier_upgrade_item_javelin",
            LUA_MODIFIER_MOTION_NONE
        )
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
        self.run = __TS__New(Run, self.alliances, {{possibleNPCs = {NPCNames.DIRE_ZOMBIE_RANGE, NPCNames.DIRE_ZOMBIE_MEELE_MEGA, NPCNames.DIRE_ZOMBIE_RANGE_MEGA, NPCNames.FLYING_SKULL, NPCNames.DIRE_TOWER, NPCNames.QUEEN}}, {possibleNPCs = {NPCNames.RADIANT_ZOMBIE_RANGE_MEGA, NPCNames.RADIANT_ZOMBIE_MEELE_MEGA, NPCNames.FLYING_SKULL, NPCNames.CENTAUR}}})
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
    if victim then
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
            if (self.run and self.run.stage) and self.run.stage.room then
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
            if __TS__NumberIsNaN(
                __TS__Number(room)
            ) then
                return
            end
            room = room - 1
            if (self.run and self.run.stage) and self.run.stage.room then
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
