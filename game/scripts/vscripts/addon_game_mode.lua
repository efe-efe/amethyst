--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 2,["7"] = 2,["8"] = 3,["9"] = 3,["10"] = 4,["11"] = 4,["12"] = 5,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 19,["30"] = 19,["31"] = 20,["32"] = 20,["33"] = 20,["34"] = 20,["35"] = 21,["36"] = 21,["37"] = 22,["38"] = 22,["39"] = 22,["40"] = 23,["41"] = 23,["42"] = 24,["43"] = 24,["44"] = 25,["45"] = 25,["46"] = 26,["47"] = 26,["48"] = 27,["49"] = 27,["50"] = 28,["51"] = 28,["52"] = 50,["53"] = 55,["54"] = 55,["55"] = 55,["56"] = 55,["57"] = 55,["58"] = 60,["59"] = 60,["60"] = 60,["61"] = 60,["62"] = 60,["63"] = 65,["64"] = 66,["65"] = 67,["66"] = 68,["67"] = 69,["68"] = 71,["69"] = 73,["70"] = 74,["71"] = 73,["73"] = 75,["74"] = 76,["75"] = 77,["76"] = 78,["77"] = 79,["78"] = 81,["79"] = 87,["80"] = 88,["81"] = 91,["82"] = 91,["83"] = 91,["84"] = 91,["85"] = 91,["86"] = 91,["87"] = 91,["88"] = 93,["89"] = 94,["90"] = 95,["91"] = 96,["92"] = 97,["93"] = 99,["94"] = 100,["95"] = 101,["96"] = 102,["97"] = 90,["98"] = 106,["99"] = 107,["100"] = 108,["101"] = 109,["102"] = 110,["103"] = 111,["104"] = 112,["105"] = 113,["106"] = 114,["107"] = 115,["108"] = 116,["109"] = 118,["110"] = 119,["111"] = 120,["112"] = 121,["113"] = 122,["114"] = 123,["115"] = 125,["116"] = 126,["117"] = 127,["118"] = 129,["119"] = 130,["120"] = 131,["121"] = 132,["123"] = 106,["124"] = 136,["125"] = 137,["126"] = 136,["127"] = 140,["128"] = 141,["129"] = 141,["130"] = 141,["131"] = 141,["132"] = 142,["133"] = 142,["134"] = 142,["135"] = 142,["136"] = 143,["137"] = 143,["138"] = 143,["139"] = 143,["140"] = 144,["141"] = 144,["142"] = 144,["143"] = 144,["144"] = 145,["145"] = 145,["146"] = 145,["147"] = 145,["148"] = 147,["149"] = 148,["150"] = 149,["151"] = 150,["153"] = 153,["154"] = 153,["155"] = 153,["156"] = 154,["157"] = 155,["158"] = 155,["159"] = 155,["160"] = 156,["161"] = 155,["162"] = 155,["163"] = 153,["164"] = 153,["165"] = 140,["166"] = 161,["167"] = 162,["168"] = 163,["169"] = 164,["170"] = 166,["171"] = 167,["172"] = 168,["173"] = 170,["174"] = 170,["175"] = 170,["176"] = 171,["177"] = 172,["179"] = 174,["180"] = 175,["182"] = 177,["183"] = 178,["185"] = 170,["186"] = 170,["187"] = 161,["188"] = 183,["189"] = 184,["190"] = 185,["191"] = 187,["192"] = 187,["193"] = 187,["194"] = 188,["195"] = 189,["197"] = 191,["198"] = 192,["200"] = 187,["201"] = 187,["202"] = 183,["203"] = 197,["204"] = 198,["205"] = 199,["207"] = 201,["208"] = 203,["209"] = 204,["210"] = 204,["211"] = 204,["212"] = 205,["213"] = 206,["214"] = 207,["216"] = 204,["217"] = 204,["219"] = 212,["220"] = 197,["221"] = 215,["222"] = 216,["223"] = 217,["224"] = 218,["225"] = 219,["226"] = 220,["227"] = 221,["228"] = 222,["229"] = 223,["230"] = 224,["231"] = 225,["232"] = 226,["233"] = 228,["234"] = 229,["235"] = 230,["236"] = 231,["238"] = 233,["239"] = 215,["240"] = 236,["241"] = 237,["242"] = 238,["243"] = 239,["244"] = 240,["245"] = 241,["246"] = 236,["247"] = 244,["248"] = 245,["249"] = 246,["250"] = 247,["251"] = 248,["252"] = 244,["253"] = 251,["254"] = 252,["255"] = 252,["256"] = 252,["257"] = 252,["258"] = 252,["259"] = 253,["260"] = 253,["261"] = 253,["262"] = 253,["263"] = 253,["264"] = 254,["265"] = 254,["266"] = 254,["267"] = 254,["268"] = 254,["269"] = 255,["270"] = 255,["271"] = 255,["272"] = 255,["273"] = 255,["274"] = 256,["275"] = 256,["276"] = 256,["277"] = 256,["278"] = 256,["279"] = 257,["280"] = 257,["281"] = 257,["282"] = 257,["283"] = 257,["284"] = 258,["285"] = 251,["286"] = 261,["287"] = 262,["288"] = 262,["289"] = 262,["290"] = 263,["291"] = 264,["292"] = 265,["293"] = 266,["294"] = 267,["296"] = 262,["297"] = 262,["298"] = 271,["299"] = 271,["300"] = 271,["301"] = 272,["302"] = 273,["303"] = 275,["304"] = 276,["305"] = 277,["306"] = 279,["307"] = 280,["308"] = 282,["309"] = 283,["310"] = 284,["311"] = 285,["312"] = 287,["313"] = 288,["315"] = 291,["316"] = 292,["317"] = 293,["319"] = 296,["320"] = 297,["321"] = 298,["322"] = 299,["323"] = 300,["324"] = 300,["325"] = 300,["330"] = 271,["331"] = 271,["332"] = 308,["333"] = 308,["334"] = 308,["335"] = 309,["336"] = 310,["337"] = 312,["338"] = 313,["339"] = 315,["341"] = 316,["342"] = 316,["343"] = 317,["344"] = 318,["345"] = 319,["346"] = 320,["349"] = 316,["352"] = 325,["353"] = 326,["356"] = 330,["357"] = 331,["358"] = 331,["359"] = 331,["361"] = 308,["362"] = 308,["363"] = 335,["364"] = 335,["365"] = 335,["366"] = 336,["367"] = 337,["368"] = 339,["369"] = 340,["370"] = 341,["371"] = 342,["372"] = 343,["373"] = 344,["376"] = 335,["377"] = 335,["378"] = 261,["379"] = 350,["380"] = 351,["381"] = 352,["382"] = 353,["383"] = 354,["384"] = 355,["385"] = 356,["386"] = 357,["387"] = 350,["388"] = 360,["389"] = 361,["390"] = 362,["391"] = 363,["392"] = 364,["393"] = 365,["394"] = 366,["395"] = 368,["396"] = 369,["397"] = 370,["398"] = 371,["399"] = 372,["400"] = 374,["401"] = 375,["402"] = 376,["403"] = 377,["404"] = 378,["405"] = 379,["406"] = 380,["407"] = 381,["408"] = 382,["409"] = 383,["410"] = 384,["411"] = 385,["412"] = 386,["413"] = 387,["414"] = 388,["415"] = 389,["416"] = 390,["417"] = 391,["418"] = 392,["419"] = 394,["420"] = 395,["421"] = 396,["422"] = 397,["423"] = 398,["424"] = 400,["425"] = 401,["426"] = 402,["427"] = 403,["428"] = 405,["429"] = 406,["430"] = 407,["431"] = 409,["432"] = 409,["433"] = 409,["434"] = 410,["435"] = 411,["436"] = 412,["437"] = 412,["438"] = 412,["439"] = 412,["440"] = 412,["442"] = 414,["443"] = 415,["444"] = 415,["445"] = 415,["446"] = 415,["447"] = 415,["449"] = 417,["450"] = 418,["451"] = 418,["452"] = 418,["453"] = 418,["454"] = 418,["457"] = 409,["458"] = 409,["459"] = 422,["460"] = 423,["461"] = 423,["462"] = 423,["463"] = 423,["464"] = 423,["465"] = 424,["466"] = 424,["467"] = 424,["468"] = 424,["469"] = 424,["471"] = 427,["472"] = 360,["473"] = 430,["474"] = 431,["475"] = 430,["476"] = 434,["477"] = 435,["478"] = 435,["479"] = 435,["480"] = 435,["481"] = 435,["482"] = 441,["483"] = 434,["484"] = 444,["485"] = 445,["486"] = 447,["487"] = 447,["488"] = 447,["489"] = 448,["490"] = 448,["491"] = 448,["492"] = 449,["493"] = 450,["495"] = 448,["496"] = 448,["497"] = 447,["498"] = 447,["499"] = 455,["500"] = 444,["501"] = 458,["502"] = 459,["503"] = 460,["504"] = 461,["505"] = 463,["506"] = 464,["507"] = 465,["508"] = 465,["509"] = 465,["510"] = 465,["511"] = 465,["512"] = 466,["514"] = 468,["515"] = 469,["516"] = 470,["517"] = 471,["518"] = 472,["519"] = 474,["520"] = 475,["521"] = 476,["523"] = 479,["524"] = 480,["525"] = 481,["526"] = 482,["527"] = 484,["529"] = 487,["531"] = 458,["532"] = 491,["533"] = 492,["534"] = 493,["535"] = 494,["536"] = 495,["537"] = 496,["538"] = 491,["539"] = 499,["540"] = 500,["541"] = 501,["542"] = 502,["543"] = 504,["544"] = 505,["545"] = 506,["546"] = 508,["547"] = 509,["548"] = 510,["549"] = 512,["550"] = 513,["551"] = 514,["552"] = 535,["553"] = 536,["554"] = 537,["556"] = 499,["557"] = 541,["558"] = 542,["559"] = 543,["560"] = 545,["561"] = 545,["562"] = 545,["563"] = 546,["564"] = 546,["565"] = 546,["566"] = 546,["567"] = 546,["568"] = 546,["569"] = 545,["570"] = 545,["571"] = 549,["572"] = 541,["573"] = 552,["574"] = 553,["575"] = 554,["576"] = 562,["577"] = 563,["578"] = 564,["579"] = 564,["580"] = 564,["581"] = 564,["582"] = 564,["583"] = 564,["584"] = 564,["585"] = 564,["586"] = 565,["587"] = 552,["588"] = 568,["589"] = 569,["590"] = 570,["591"] = 571,["593"] = 568,["594"] = 575,["595"] = 576,["596"] = 575,["597"] = 579,["598"] = 580,["599"] = 582,["600"] = 587,["601"] = 588,["602"] = 589,["603"] = 590,["604"] = 592,["605"] = 593,["606"] = 594,["608"] = 597,["609"] = 598,["610"] = 603,["611"] = 603,["612"] = 603,["613"] = 604,["614"] = 604,["615"] = 604,["616"] = 605,["617"] = 605,["618"] = 605,["619"] = 605,["620"] = 607,["621"] = 608,["623"] = 611,["624"] = 612,["625"] = 612,["626"] = 612,["627"] = 613,["628"] = 614,["630"] = 617,["633"] = 621,["634"] = 622,["635"] = 623,["636"] = 624,["637"] = 625,["638"] = 626,["642"] = 630,["643"] = 631,["645"] = 633,["646"] = 634,["648"] = 637,["649"] = 579,["650"] = 640,["651"] = 641,["652"] = 640,["653"] = 644,["654"] = 645,["655"] = 648,["656"] = 649,["657"] = 650,["658"] = 651,["659"] = 652,["661"] = 654,["663"] = 657,["664"] = 658,["665"] = 660,["666"] = 661,["667"] = 661,["668"] = 661,["669"] = 662,["670"] = 661,["671"] = 661,["674"] = 667,["675"] = 668,["676"] = 668,["677"] = 668,["678"] = 669,["679"] = 668,["680"] = 668,["681"] = 697,["682"] = 644,["683"] = 700,["684"] = 701,["685"] = 702,["686"] = 704,["687"] = 708,["688"] = 709,["690"] = 712,["691"] = 713,["692"] = 714,["693"] = 714,["694"] = 714,["695"] = 715,["696"] = 714,["697"] = 714,["698"] = 718,["699"] = 719,["700"] = 719,["701"] = 719,["702"] = 719,["703"] = 720,["704"] = 721,["706"] = 724,["707"] = 725,["708"] = 727,["709"] = 728,["710"] = 728,["711"] = 728,["712"] = 729,["713"] = 728,["714"] = 728,["718"] = 735,["719"] = 700,["720"] = 738,["721"] = 739,["722"] = 741,["723"] = 742,["725"] = 738,["726"] = 746,["727"] = 747,["728"] = 748,["729"] = 750,["730"] = 751,["731"] = 752,["732"] = 753,["733"] = 754,["737"] = 759,["740"] = 763,["741"] = 764,["743"] = 767,["744"] = 768,["745"] = 769,["747"] = 772,["748"] = 773,["750"] = 776,["751"] = 777,["754"] = 781,["755"] = 783,["758"] = 787,["759"] = 788,["761"] = 791,["762"] = 792,["764"] = 795,["765"] = 796,["767"] = 799,["768"] = 800,["770"] = 803,["771"] = 804,["773"] = 807,["774"] = 808,["777"] = 812,["778"] = 813,["779"] = 814,["780"] = 815,["784"] = 820,["785"] = 821,["788"] = 824,["789"] = 825,["790"] = 825,["791"] = 825,["792"] = 825,["793"] = 826,["794"] = 826,["795"] = 826,["798"] = 829,["799"] = 831,["800"] = 832,["803"] = 835,["807"] = 746,["808"] = 841,["809"] = 842,["810"] = 843,["811"] = 845,["812"] = 846,["813"] = 848,["814"] = 849,["815"] = 850,["816"] = 850,["817"] = 850,["818"] = 851,["819"] = 852,["820"] = 853,["821"] = 854,["824"] = 850,["825"] = 850,["826"] = 859,["827"] = 860,["828"] = 861,["829"] = 862,["833"] = 867,["836"] = 841,["837"] = 872,["838"] = 873,["839"] = 872,["840"] = 876,["841"] = 877,["842"] = 878,["843"] = 879,["845"] = 882,["846"] = 883,["848"] = 886,["849"] = 887,["851"] = 890,["852"] = 891,["853"] = 892,["854"] = 893,["855"] = 894,["856"] = 895,["857"] = 896,["861"] = 901,["862"] = 876,["863"] = 904,["864"] = 905,["865"] = 906,["866"] = 904,["867"] = 909,["868"] = 910,["869"] = 909,["870"] = 913,["871"] = 914,["872"] = 913,["873"] = 917,["874"] = 918,["875"] = 917,["876"] = 921,["877"] = 922,["878"] = 924,["879"] = 925,["880"] = 926,["882"] = 928,["885"] = 931,["887"] = 933,["888"] = 934,["889"] = 921,["890"] = 937,["891"] = 938,["892"] = 938,["893"] = 938,["894"] = 938,["895"] = 937,["896"] = 941,["897"] = 942,["898"] = 943,["899"] = 945,["900"] = 946,["901"] = 947,["903"] = 950,["904"] = 951,["906"] = 954,["907"] = 955,["908"] = 956,["910"] = 958,["911"] = 959,["912"] = 959,["913"] = 959,["914"] = 959,["915"] = 959,["916"] = 960,["919"] = 963,["921"] = 941,["922"] = 967,["923"] = 968,["924"] = 969,["925"] = 970,["926"] = 971,["928"] = 967,["929"] = 975,["930"] = 976,["931"] = 977,["932"] = 979,["933"] = 980,["935"] = 983,["936"] = 984,["939"] = 975,["940"] = 989,["941"] = 990,["942"] = 990,["943"] = 990,["944"] = 991,["945"] = 992,["946"] = 992,["947"] = 992,["948"] = 992,["949"] = 993,["951"] = 990,["952"] = 990,["953"] = 989,["954"] = 998,["955"] = 999,["956"] = 999,["957"] = 999,["958"] = 1000,["959"] = 1001,["960"] = 1002,["961"] = 1004,["962"] = 1005,["963"] = 1005,["964"] = 1005,["965"] = 1005,["966"] = 1006,["968"] = 1008,["969"] = 1009,["970"] = 1010,["971"] = 1010,["972"] = 1010,["973"] = 1010,["974"] = 1011,["978"] = 999,["979"] = 999,["980"] = 998,["981"] = 1018,["982"] = 1019,["983"] = 1019,["984"] = 1019,["985"] = 1019,["986"] = 1020,["987"] = 1021,["989"] = 1023,["990"] = 1018,["991"] = 1026,["992"] = 1027,["993"] = 1027,["994"] = 1027,["995"] = 1027,["996"] = 1028,["997"] = 1029,["999"] = 1031,["1000"] = 1026,["1001"] = 1034,["1002"] = 1035,["1003"] = 1035,["1004"] = 1035,["1005"] = 1035,["1006"] = 1034,["1007"] = 1038,["1008"] = 1039,["1009"] = 1038,["1010"] = 1042,["1011"] = 1043,["1012"] = 1045,["1013"] = 1046,["1015"] = 1049,["1016"] = 1042,["1017"] = 1052,["1018"] = 1053,["1019"] = 1054,["1020"] = 1055,["1021"] = 1056,["1022"] = 1056,["1023"] = 1056,["1024"] = 1056,["1025"] = 1056,["1026"] = 1056,["1027"] = 1058,["1028"] = 1065,["1029"] = 1066,["1030"] = 1052,["1031"] = 1069,["1032"] = 1070,["1033"] = 1069,["1034"] = 1074,["1035"] = 1074,["1036"] = 73,["1037"] = 1078,["1038"] = 1078,["1039"] = 1078,["1040"] = 1078,["1041"] = 1083,["1042"] = 1084});
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
            "modifier_upgrade_maelstrom_attack",
            tostring(itemsPath) .. "modifier_upgrade_maelstrom",
            LUA_MODIFIER_MOTION_NONE
        )
        LinkLuaModifier(
            "modifier_upgrade_basher_attack",
            tostring(itemsPath) .. "modifier_upgrade_basher",
            LUA_MODIFIER_MOTION_NONE
        )
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
            customNpc:RequestFavors()
        end
        if event.text == "-shard" then
            customNpc:RequestShards()
        end
        if event.text == "-tome" then
            customNpc:RequestKnowledge()
        end
        if event.text == "-item" then
            customNpc:RequestItems()
        end
        if event.text == "-reward" then
            customNpc:RequestRewards()
        end
        if event.text == "-vitality" then
            customNpc:ApplyTarrasque()
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
                if self.run.stage.rooms > room then
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
