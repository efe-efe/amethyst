--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 2,["7"] = 2,["8"] = 3,["9"] = 3,["10"] = 4,["11"] = 4,["12"] = 5,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 19,["30"] = 19,["31"] = 20,["32"] = 20,["33"] = 20,["34"] = 20,["35"] = 21,["36"] = 21,["37"] = 22,["38"] = 22,["39"] = 22,["40"] = 23,["41"] = 23,["42"] = 24,["43"] = 24,["44"] = 25,["45"] = 25,["46"] = 26,["47"] = 26,["48"] = 48,["49"] = 53,["50"] = 53,["51"] = 53,["52"] = 53,["53"] = 53,["54"] = 58,["55"] = 58,["56"] = 58,["57"] = 58,["58"] = 58,["59"] = 63,["60"] = 64,["61"] = 65,["62"] = 66,["63"] = 67,["64"] = 69,["65"] = 71,["66"] = 72,["67"] = 71,["69"] = 73,["70"] = 74,["71"] = 75,["72"] = 76,["73"] = 77,["74"] = 79,["75"] = 85,["76"] = 86,["77"] = 89,["78"] = 89,["79"] = 89,["80"] = 89,["81"] = 89,["82"] = 89,["83"] = 89,["84"] = 91,["85"] = 92,["86"] = 93,["87"] = 94,["88"] = 95,["89"] = 97,["90"] = 98,["91"] = 99,["92"] = 100,["93"] = 88,["94"] = 104,["95"] = 105,["96"] = 106,["97"] = 107,["98"] = 108,["99"] = 109,["100"] = 110,["101"] = 111,["102"] = 112,["103"] = 113,["104"] = 114,["105"] = 116,["106"] = 117,["107"] = 118,["108"] = 119,["109"] = 120,["110"] = 121,["111"] = 123,["112"] = 124,["113"] = 125,["114"] = 127,["115"] = 128,["116"] = 129,["117"] = 130,["119"] = 104,["120"] = 134,["121"] = 135,["122"] = 134,["123"] = 138,["124"] = 139,["125"] = 139,["126"] = 139,["127"] = 139,["128"] = 140,["129"] = 140,["130"] = 140,["131"] = 140,["132"] = 141,["133"] = 141,["134"] = 141,["135"] = 141,["136"] = 142,["137"] = 142,["138"] = 142,["139"] = 142,["140"] = 143,["141"] = 143,["142"] = 143,["143"] = 143,["144"] = 145,["145"] = 146,["146"] = 147,["147"] = 148,["149"] = 151,["150"] = 151,["151"] = 151,["152"] = 152,["153"] = 153,["154"] = 153,["155"] = 153,["156"] = 154,["157"] = 153,["158"] = 153,["159"] = 151,["160"] = 151,["161"] = 138,["162"] = 159,["163"] = 160,["164"] = 161,["165"] = 162,["166"] = 164,["167"] = 165,["168"] = 166,["169"] = 168,["170"] = 168,["171"] = 168,["172"] = 169,["173"] = 170,["175"] = 172,["176"] = 173,["178"] = 175,["179"] = 176,["181"] = 168,["182"] = 168,["183"] = 159,["184"] = 181,["185"] = 182,["186"] = 183,["187"] = 185,["188"] = 185,["189"] = 185,["190"] = 186,["191"] = 187,["193"] = 189,["194"] = 190,["196"] = 185,["197"] = 185,["198"] = 181,["199"] = 195,["200"] = 196,["201"] = 197,["203"] = 199,["204"] = 201,["205"] = 202,["206"] = 202,["207"] = 202,["208"] = 203,["209"] = 204,["210"] = 205,["212"] = 202,["213"] = 202,["215"] = 210,["216"] = 195,["217"] = 213,["218"] = 214,["219"] = 215,["220"] = 216,["221"] = 217,["222"] = 218,["223"] = 219,["224"] = 220,["225"] = 221,["226"] = 222,["227"] = 223,["228"] = 224,["229"] = 226,["230"] = 227,["231"] = 228,["232"] = 229,["234"] = 231,["235"] = 213,["236"] = 234,["237"] = 235,["238"] = 236,["239"] = 237,["240"] = 238,["241"] = 239,["242"] = 234,["243"] = 242,["244"] = 243,["245"] = 244,["246"] = 245,["247"] = 246,["248"] = 242,["249"] = 249,["250"] = 250,["251"] = 250,["252"] = 250,["253"] = 250,["254"] = 250,["255"] = 251,["256"] = 251,["257"] = 251,["258"] = 251,["259"] = 251,["260"] = 252,["261"] = 252,["262"] = 252,["263"] = 252,["264"] = 252,["265"] = 253,["266"] = 253,["267"] = 253,["268"] = 253,["269"] = 253,["270"] = 254,["271"] = 254,["272"] = 254,["273"] = 254,["274"] = 254,["275"] = 255,["276"] = 255,["277"] = 255,["278"] = 255,["279"] = 255,["280"] = 256,["281"] = 249,["282"] = 259,["283"] = 260,["284"] = 260,["285"] = 260,["286"] = 261,["287"] = 262,["288"] = 263,["289"] = 264,["290"] = 265,["292"] = 260,["293"] = 260,["294"] = 269,["295"] = 269,["296"] = 269,["297"] = 269,["298"] = 269,["299"] = 273,["300"] = 273,["301"] = 273,["302"] = 274,["303"] = 275,["304"] = 277,["305"] = 278,["306"] = 280,["307"] = 281,["308"] = 283,["309"] = 284,["310"] = 285,["311"] = 286,["312"] = 288,["313"] = 289,["315"] = 292,["316"] = 293,["317"] = 294,["320"] = 273,["321"] = 273,["322"] = 299,["323"] = 299,["324"] = 299,["325"] = 300,["326"] = 301,["327"] = 303,["328"] = 304,["329"] = 306,["331"] = 307,["332"] = 307,["333"] = 308,["334"] = 309,["335"] = 310,["336"] = 311,["339"] = 307,["342"] = 316,["343"] = 317,["346"] = 321,["347"] = 322,["348"] = 322,["349"] = 322,["351"] = 299,["352"] = 299,["353"] = 326,["354"] = 326,["355"] = 326,["356"] = 327,["357"] = 328,["358"] = 330,["359"] = 331,["360"] = 332,["361"] = 333,["362"] = 334,["363"] = 335,["366"] = 326,["367"] = 326,["368"] = 259,["369"] = 341,["370"] = 342,["371"] = 343,["372"] = 344,["373"] = 345,["374"] = 346,["375"] = 347,["376"] = 348,["377"] = 341,["378"] = 351,["379"] = 352,["380"] = 353,["381"] = 354,["382"] = 355,["383"] = 356,["384"] = 357,["385"] = 359,["386"] = 360,["387"] = 361,["388"] = 362,["389"] = 363,["390"] = 365,["391"] = 366,["392"] = 367,["393"] = 368,["394"] = 369,["395"] = 370,["396"] = 371,["397"] = 372,["398"] = 373,["399"] = 374,["400"] = 375,["401"] = 376,["402"] = 377,["403"] = 378,["404"] = 379,["405"] = 380,["406"] = 381,["407"] = 382,["408"] = 383,["409"] = 384,["410"] = 385,["411"] = 386,["412"] = 387,["413"] = 388,["414"] = 389,["415"] = 391,["416"] = 392,["417"] = 393,["418"] = 394,["419"] = 395,["420"] = 396,["421"] = 397,["422"] = 398,["423"] = 399,["424"] = 400,["425"] = 401,["426"] = 402,["427"] = 403,["428"] = 404,["429"] = 405,["430"] = 406,["431"] = 407,["432"] = 408,["433"] = 409,["435"] = 412,["436"] = 351,["437"] = 415,["438"] = 416,["439"] = 415,["440"] = 419,["441"] = 420,["442"] = 420,["443"] = 420,["444"] = 420,["445"] = 420,["446"] = 426,["447"] = 419,["448"] = 429,["449"] = 430,["450"] = 432,["451"] = 432,["452"] = 432,["453"] = 433,["454"] = 433,["455"] = 433,["456"] = 434,["457"] = 435,["459"] = 433,["460"] = 433,["461"] = 432,["462"] = 432,["463"] = 440,["464"] = 429,["465"] = 443,["466"] = 444,["467"] = 445,["468"] = 446,["469"] = 448,["470"] = 449,["471"] = 450,["472"] = 450,["473"] = 450,["474"] = 450,["475"] = 450,["476"] = 451,["478"] = 453,["479"] = 454,["480"] = 455,["481"] = 456,["482"] = 457,["483"] = 459,["484"] = 460,["485"] = 461,["487"] = 464,["488"] = 465,["489"] = 466,["490"] = 467,["491"] = 469,["493"] = 472,["495"] = 443,["496"] = 476,["497"] = 477,["498"] = 478,["499"] = 479,["500"] = 480,["501"] = 481,["502"] = 476,["503"] = 484,["504"] = 485,["505"] = 486,["506"] = 487,["507"] = 489,["508"] = 490,["509"] = 491,["510"] = 493,["511"] = 494,["512"] = 495,["513"] = 497,["514"] = 498,["515"] = 499,["516"] = 520,["517"] = 521,["518"] = 522,["520"] = 484,["521"] = 526,["522"] = 527,["523"] = 528,["524"] = 530,["525"] = 530,["526"] = 530,["527"] = 531,["528"] = 531,["529"] = 531,["530"] = 531,["531"] = 531,["532"] = 531,["533"] = 530,["534"] = 530,["535"] = 534,["536"] = 526,["537"] = 537,["538"] = 538,["539"] = 539,["540"] = 547,["541"] = 548,["542"] = 549,["543"] = 549,["544"] = 549,["545"] = 549,["546"] = 549,["547"] = 549,["548"] = 549,["549"] = 549,["550"] = 550,["551"] = 537,["552"] = 553,["553"] = 554,["554"] = 555,["555"] = 556,["557"] = 553,["558"] = 560,["559"] = 561,["560"] = 560,["561"] = 564,["562"] = 565,["563"] = 567,["564"] = 572,["565"] = 573,["566"] = 574,["567"] = 575,["568"] = 577,["569"] = 578,["570"] = 579,["572"] = 582,["573"] = 583,["574"] = 588,["575"] = 588,["576"] = 588,["577"] = 589,["578"] = 589,["579"] = 589,["580"] = 590,["581"] = 590,["582"] = 590,["583"] = 590,["584"] = 592,["585"] = 593,["587"] = 596,["588"] = 597,["589"] = 597,["590"] = 597,["591"] = 598,["592"] = 599,["594"] = 602,["597"] = 606,["598"] = 607,["599"] = 608,["600"] = 609,["601"] = 610,["602"] = 611,["606"] = 615,["607"] = 616,["609"] = 618,["610"] = 619,["612"] = 622,["613"] = 564,["614"] = 625,["615"] = 626,["616"] = 625,["617"] = 629,["618"] = 630,["619"] = 633,["620"] = 634,["621"] = 635,["622"] = 636,["623"] = 637,["625"] = 639,["627"] = 642,["628"] = 643,["629"] = 645,["630"] = 646,["631"] = 646,["632"] = 646,["633"] = 647,["634"] = 646,["635"] = 646,["638"] = 652,["639"] = 653,["640"] = 653,["641"] = 653,["642"] = 654,["643"] = 653,["644"] = 653,["645"] = 682,["646"] = 629,["647"] = 685,["648"] = 686,["649"] = 687,["650"] = 689,["651"] = 693,["652"] = 694,["654"] = 697,["655"] = 698,["656"] = 698,["657"] = 698,["658"] = 698,["659"] = 699,["660"] = 700,["662"] = 703,["663"] = 704,["664"] = 704,["665"] = 704,["666"] = 705,["667"] = 704,["668"] = 704,["669"] = 708,["670"] = 709,["671"] = 711,["672"] = 712,["673"] = 712,["674"] = 712,["675"] = 713,["676"] = 712,["677"] = 712,["680"] = 718,["681"] = 685,["682"] = 721,["683"] = 722,["684"] = 724,["685"] = 725,["687"] = 721,["688"] = 729,["689"] = 730,["690"] = 731,["691"] = 733,["692"] = 734,["693"] = 735,["694"] = 736,["695"] = 737,["699"] = 742,["702"] = 746,["703"] = 747,["705"] = 750,["706"] = 751,["707"] = 752,["709"] = 755,["710"] = 756,["712"] = 759,["713"] = 760,["716"] = 764,["717"] = 766,["720"] = 770,["721"] = 771,["723"] = 774,["724"] = 775,["726"] = 778,["727"] = 779,["729"] = 782,["730"] = 783,["732"] = 786,["733"] = 787,["735"] = 790,["736"] = 791,["739"] = 729,["740"] = 826,["741"] = 827,["742"] = 828,["743"] = 830,["744"] = 831,["745"] = 833,["746"] = 834,["747"] = 835,["748"] = 835,["749"] = 835,["750"] = 836,["751"] = 837,["752"] = 838,["753"] = 839,["756"] = 835,["757"] = 835,["758"] = 844,["759"] = 845,["760"] = 846,["761"] = 847,["765"] = 852,["768"] = 826,["769"] = 857,["770"] = 858,["771"] = 857,["772"] = 861,["773"] = 862,["774"] = 863,["775"] = 864,["777"] = 867,["778"] = 868,["780"] = 871,["781"] = 872,["783"] = 875,["784"] = 876,["785"] = 877,["786"] = 878,["787"] = 879,["788"] = 880,["789"] = 881,["793"] = 886,["794"] = 861,["795"] = 889,["796"] = 890,["797"] = 891,["798"] = 889,["799"] = 894,["800"] = 895,["801"] = 894,["802"] = 898,["803"] = 899,["804"] = 898,["805"] = 902,["806"] = 903,["807"] = 902,["808"] = 906,["809"] = 907,["810"] = 909,["811"] = 910,["812"] = 911,["814"] = 913,["817"] = 916,["819"] = 918,["820"] = 919,["821"] = 906,["822"] = 922,["823"] = 923,["824"] = 923,["825"] = 923,["826"] = 923,["827"] = 922,["828"] = 926,["829"] = 927,["830"] = 928,["831"] = 930,["832"] = 931,["833"] = 932,["835"] = 935,["836"] = 936,["838"] = 939,["839"] = 940,["840"] = 941,["842"] = 943,["843"] = 944,["844"] = 944,["845"] = 944,["846"] = 944,["847"] = 944,["848"] = 945,["851"] = 948,["853"] = 926,["854"] = 952,["855"] = 953,["856"] = 954,["857"] = 955,["858"] = 956,["860"] = 952,["861"] = 960,["862"] = 961,["863"] = 962,["864"] = 964,["865"] = 965,["867"] = 968,["868"] = 969,["871"] = 960,["872"] = 974,["873"] = 975,["874"] = 975,["875"] = 975,["876"] = 976,["877"] = 977,["878"] = 977,["879"] = 977,["880"] = 977,["881"] = 978,["883"] = 975,["884"] = 975,["885"] = 974,["886"] = 983,["887"] = 984,["888"] = 984,["889"] = 984,["890"] = 985,["891"] = 986,["892"] = 987,["893"] = 989,["894"] = 990,["895"] = 990,["896"] = 990,["897"] = 990,["898"] = 991,["900"] = 993,["901"] = 994,["902"] = 995,["903"] = 995,["904"] = 995,["905"] = 995,["906"] = 996,["910"] = 984,["911"] = 984,["912"] = 983,["913"] = 1003,["914"] = 1004,["915"] = 1004,["916"] = 1004,["917"] = 1004,["918"] = 1005,["919"] = 1006,["921"] = 1008,["922"] = 1003,["923"] = 1011,["924"] = 1012,["925"] = 1012,["926"] = 1012,["927"] = 1012,["928"] = 1013,["929"] = 1014,["931"] = 1016,["932"] = 1011,["933"] = 1019,["934"] = 1020,["935"] = 1020,["936"] = 1020,["937"] = 1020,["938"] = 1019,["939"] = 1023,["940"] = 1024,["941"] = 1023,["942"] = 1027,["943"] = 1028,["944"] = 1030,["945"] = 1031,["947"] = 1034,["948"] = 1027,["949"] = 1037,["950"] = 1038,["951"] = 1039,["952"] = 1040,["953"] = 1041,["954"] = 1041,["955"] = 1041,["956"] = 1041,["957"] = 1041,["958"] = 1041,["959"] = 1043,["960"] = 1050,["961"] = 1051,["962"] = 1037,["963"] = 1054,["964"] = 1055,["965"] = 1054,["966"] = 1059,["967"] = 1059,["968"] = 71,["969"] = 1063,["970"] = 1063,["971"] = 1063,["972"] = 1063,["973"] = 1068,["974"] = 1069});
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
        LinkLuaModifier("modifier_upgrade_meele_extra_radius", "modifiers/upgrades/modifier_upgrade_meele_extra_radius", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_phantom_extra_daggers", "modifiers/upgrades/modifier_upgrade_phantom_extra_daggers", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_extra_base_damage", "modifiers/upgrades/modifier_upgrade_extra_base_damage", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_juggernaut_refresh_dagger", "modifiers/upgrades/modifier_upgrade_juggernaut_refresh_dagger", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_lightining_attack", "modifiers/upgrades/modifier_upgrade_lightining_attack", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_lightining_attack_attack", "modifiers/upgrades/modifier_upgrade_lightining_attack", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_phantom_dash_damage", "modifiers/upgrades/modifier_upgrade_phantom_dash_damage", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_phantom_dash_shield", "modifiers/upgrades/modifier_upgrade_phantom_dash_shield", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_phantom_coup_cast_fast", "modifiers/upgrades/modifier_upgrade_phantom_coup_cast_fast", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_juggernaut_fury_attack", "modifiers/upgrades/modifier_upgrade_juggernaut_fury_attack", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_storm_ranged_remnant", "modifiers/upgrades/modifier_upgrade_storm_ranged_remnant", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_storm_unleashed_knockback", "modifiers/upgrades/modifier_upgrade_storm_unleashed_knockback", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_extra_speed", "modifiers/upgrades/modifier_upgrade_extra_speed", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_stun_attack", "modifiers/upgrades/modifier_upgrade_stun_attack", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_stun_attack_attack", "modifiers/upgrades/modifier_upgrade_stun_attack", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_tarrasque", "modifiers/upgrades/modifier_upgrade_tarrasque", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_phantom_act_while_countering", "modifiers/upgrades/modifier_upgrade_phantom_act_while_countering", LUA_MODIFIER_MOTION_NONE)
        LinkLuaModifier("modifier_upgrade_sniper_snipe_cast_fast", "modifiers/upgrades/modifier_upgrade_sniper_snipe_cast_fast", LUA_MODIFIER_MOTION_NONE)
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
