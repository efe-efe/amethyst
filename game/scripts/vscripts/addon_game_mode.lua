--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 19,["30"] = 19,["31"] = 20,["32"] = 20,["33"] = 20,["34"] = 20,["35"] = 21,["36"] = 21,["37"] = 22,["38"] = 22,["39"] = 22,["40"] = 23,["41"] = 23,["42"] = 24,["43"] = 24,["44"] = 25,["45"] = 25,["46"] = 26,["47"] = 26,["48"] = 48,["49"] = 53,["50"] = 53,["51"] = 53,["52"] = 53,["53"] = 53,["54"] = 58,["55"] = 58,["56"] = 58,["57"] = 58,["58"] = 58,["59"] = 63,["60"] = 64,["61"] = 65,["62"] = 66,["63"] = 68,["64"] = 70,["65"] = 71,["66"] = 70,["68"] = 72,["69"] = 73,["70"] = 74,["71"] = 75,["72"] = 76,["73"] = 78,["74"] = 81,["75"] = 85,["76"] = 86,["77"] = 89,["78"] = 89,["79"] = 89,["80"] = 89,["81"] = 89,["82"] = 89,["83"] = 89,["84"] = 91,["85"] = 92,["86"] = 93,["87"] = 94,["88"] = 95,["89"] = 97,["90"] = 98,["91"] = 99,["92"] = 100,["93"] = 88,["94"] = 104,["95"] = 105,["96"] = 106,["97"] = 107,["98"] = 108,["99"] = 109,["100"] = 110,["101"] = 111,["102"] = 112,["103"] = 113,["104"] = 114,["105"] = 116,["106"] = 117,["107"] = 118,["108"] = 119,["109"] = 120,["110"] = 121,["111"] = 123,["112"] = 124,["113"] = 125,["114"] = 127,["115"] = 128,["116"] = 129,["117"] = 130,["119"] = 104,["120"] = 134,["121"] = 135,["122"] = 134,["123"] = 138,["124"] = 139,["125"] = 139,["126"] = 139,["127"] = 139,["128"] = 140,["129"] = 140,["130"] = 140,["131"] = 140,["132"] = 141,["133"] = 141,["134"] = 141,["135"] = 141,["136"] = 142,["137"] = 142,["138"] = 142,["139"] = 142,["140"] = 144,["141"] = 145,["142"] = 146,["143"] = 147,["145"] = 150,["146"] = 150,["147"] = 150,["148"] = 151,["149"] = 152,["150"] = 152,["151"] = 152,["152"] = 153,["153"] = 152,["154"] = 152,["155"] = 150,["156"] = 150,["157"] = 138,["158"] = 158,["159"] = 159,["160"] = 160,["161"] = 161,["162"] = 163,["163"] = 164,["164"] = 165,["165"] = 167,["166"] = 167,["167"] = 167,["168"] = 168,["169"] = 169,["171"] = 171,["172"] = 172,["174"] = 175,["175"] = 176,["177"] = 167,["178"] = 167,["179"] = 158,["180"] = 181,["181"] = 182,["182"] = 183,["183"] = 184,["184"] = 186,["185"] = 186,["186"] = 186,["187"] = 187,["188"] = 188,["190"] = 190,["191"] = 191,["193"] = 186,["194"] = 186,["195"] = 181,["196"] = 196,["197"] = 197,["198"] = 198,["199"] = 199,["201"] = 201,["202"] = 201,["203"] = 202,["204"] = 202,["205"] = 202,["206"] = 202,["207"] = 203,["208"] = 204,["209"] = 205,["210"] = 205,["211"] = 205,["212"] = 205,["213"] = 201,["216"] = 196,["217"] = 209,["218"] = 210,["219"] = 211,["220"] = 212,["221"] = 214,["222"] = 215,["223"] = 216,["224"] = 218,["225"] = 223,["226"] = 223,["227"] = 223,["228"] = 223,["229"] = 224,["231"] = 227,["232"] = 209,["233"] = 230,["234"] = 231,["235"] = 232,["237"] = 234,["238"] = 236,["239"] = 237,["240"] = 237,["241"] = 237,["242"] = 238,["243"] = 239,["244"] = 240,["246"] = 237,["247"] = 237,["249"] = 245,["250"] = 230,["251"] = 248,["252"] = 249,["253"] = 250,["254"] = 251,["255"] = 252,["256"] = 253,["257"] = 254,["258"] = 255,["259"] = 256,["260"] = 257,["261"] = 258,["262"] = 259,["263"] = 261,["264"] = 262,["265"] = 263,["266"] = 264,["268"] = 266,["269"] = 248,["270"] = 269,["271"] = 270,["272"] = 271,["273"] = 272,["274"] = 273,["275"] = 274,["276"] = 269,["277"] = 277,["278"] = 278,["279"] = 279,["280"] = 280,["281"] = 281,["282"] = 277,["283"] = 284,["284"] = 285,["285"] = 285,["286"] = 285,["287"] = 285,["288"] = 285,["289"] = 286,["290"] = 286,["291"] = 286,["292"] = 286,["293"] = 286,["294"] = 287,["295"] = 287,["296"] = 287,["297"] = 287,["298"] = 287,["299"] = 288,["300"] = 288,["301"] = 288,["302"] = 288,["303"] = 288,["304"] = 289,["305"] = 289,["306"] = 289,["307"] = 289,["308"] = 289,["309"] = 290,["310"] = 290,["311"] = 290,["312"] = 290,["313"] = 290,["314"] = 292,["315"] = 284,["316"] = 295,["317"] = 296,["318"] = 296,["319"] = 296,["320"] = 297,["321"] = 298,["322"] = 299,["323"] = 300,["324"] = 301,["326"] = 296,["327"] = 296,["328"] = 305,["329"] = 305,["330"] = 305,["331"] = 305,["332"] = 305,["333"] = 309,["334"] = 309,["335"] = 309,["336"] = 310,["337"] = 311,["338"] = 313,["339"] = 314,["340"] = 316,["341"] = 317,["342"] = 319,["343"] = 320,["344"] = 321,["345"] = 322,["346"] = 324,["347"] = 325,["349"] = 328,["350"] = 329,["351"] = 330,["354"] = 309,["355"] = 309,["356"] = 335,["357"] = 335,["358"] = 335,["359"] = 336,["360"] = 337,["361"] = 339,["362"] = 340,["363"] = 342,["365"] = 343,["366"] = 343,["367"] = 344,["368"] = 345,["369"] = 346,["370"] = 347,["373"] = 343,["376"] = 352,["377"] = 353,["380"] = 357,["381"] = 358,["382"] = 358,["383"] = 358,["385"] = 335,["386"] = 335,["387"] = 362,["388"] = 362,["389"] = 362,["390"] = 363,["391"] = 364,["392"] = 366,["393"] = 367,["394"] = 368,["395"] = 369,["396"] = 370,["397"] = 371,["400"] = 362,["401"] = 362,["402"] = 295,["403"] = 377,["404"] = 378,["405"] = 379,["406"] = 380,["407"] = 381,["408"] = 382,["409"] = 383,["410"] = 384,["411"] = 377,["412"] = 387,["413"] = 388,["414"] = 389,["415"] = 390,["416"] = 391,["417"] = 392,["418"] = 393,["419"] = 395,["420"] = 396,["421"] = 397,["422"] = 398,["423"] = 399,["424"] = 401,["425"] = 402,["426"] = 403,["427"] = 404,["428"] = 405,["429"] = 406,["430"] = 407,["431"] = 408,["432"] = 409,["433"] = 410,["434"] = 411,["435"] = 412,["436"] = 413,["437"] = 414,["438"] = 415,["439"] = 416,["440"] = 417,["441"] = 418,["442"] = 419,["443"] = 420,["444"] = 421,["445"] = 422,["446"] = 423,["447"] = 425,["448"] = 387,["449"] = 428,["450"] = 429,["451"] = 428,["452"] = 432,["453"] = 433,["454"] = 433,["455"] = 433,["456"] = 433,["457"] = 433,["458"] = 439,["459"] = 432,["460"] = 442,["461"] = 443,["462"] = 445,["463"] = 445,["464"] = 445,["465"] = 446,["466"] = 446,["467"] = 446,["468"] = 447,["469"] = 448,["471"] = 446,["472"] = 446,["473"] = 445,["474"] = 445,["475"] = 453,["476"] = 442,["477"] = 456,["478"] = 457,["479"] = 458,["480"] = 459,["481"] = 461,["482"] = 462,["483"] = 463,["484"] = 463,["485"] = 463,["486"] = 463,["487"] = 463,["488"] = 464,["490"] = 466,["491"] = 467,["492"] = 468,["493"] = 469,["494"] = 470,["495"] = 472,["496"] = 473,["497"] = 474,["499"] = 477,["500"] = 478,["501"] = 479,["502"] = 481,["504"] = 484,["506"] = 456,["507"] = 488,["508"] = 489,["509"] = 490,["510"] = 491,["511"] = 492,["512"] = 493,["513"] = 488,["514"] = 496,["515"] = 497,["516"] = 498,["517"] = 499,["518"] = 501,["519"] = 502,["520"] = 503,["521"] = 505,["522"] = 506,["523"] = 507,["524"] = 509,["525"] = 510,["526"] = 511,["527"] = 513,["528"] = 514,["529"] = 515,["531"] = 517,["533"] = 520,["534"] = 521,["535"] = 522,["537"] = 496,["538"] = 526,["539"] = 527,["540"] = 528,["541"] = 530,["542"] = 530,["543"] = 530,["544"] = 531,["545"] = 531,["546"] = 531,["547"] = 531,["548"] = 531,["549"] = 531,["550"] = 530,["551"] = 530,["552"] = 534,["553"] = 526,["554"] = 537,["555"] = 538,["556"] = 539,["557"] = 547,["558"] = 548,["559"] = 549,["560"] = 549,["561"] = 549,["562"] = 549,["563"] = 549,["564"] = 549,["565"] = 549,["566"] = 549,["567"] = 550,["568"] = 537,["569"] = 553,["570"] = 554,["571"] = 555,["572"] = 556,["574"] = 553,["575"] = 560,["576"] = 561,["577"] = 560,["578"] = 564,["579"] = 565,["580"] = 567,["581"] = 572,["582"] = 573,["583"] = 574,["584"] = 575,["585"] = 577,["586"] = 578,["587"] = 579,["589"] = 582,["590"] = 583,["591"] = 588,["592"] = 588,["593"] = 588,["594"] = 589,["595"] = 589,["596"] = 589,["597"] = 590,["598"] = 590,["599"] = 590,["600"] = 590,["601"] = 592,["602"] = 593,["604"] = 596,["605"] = 597,["606"] = 597,["607"] = 597,["608"] = 598,["609"] = 599,["611"] = 602,["614"] = 606,["615"] = 607,["616"] = 608,["617"] = 609,["618"] = 610,["619"] = 611,["623"] = 615,["624"] = 616,["626"] = 618,["627"] = 619,["629"] = 622,["630"] = 564,["631"] = 625,["632"] = 626,["633"] = 625,["634"] = 629,["635"] = 630,["636"] = 633,["637"] = 634,["638"] = 635,["639"] = 636,["640"] = 637,["642"] = 639,["644"] = 642,["645"] = 643,["646"] = 643,["647"] = 643,["648"] = 644,["649"] = 643,["650"] = 643,["651"] = 647,["652"] = 648,["653"] = 650,["654"] = 651,["655"] = 651,["656"] = 651,["657"] = 652,["658"] = 651,["659"] = 651,["662"] = 682,["663"] = 629,["664"] = 685,["665"] = 686,["666"] = 687,["667"] = 689,["668"] = 693,["669"] = 694,["671"] = 697,["672"] = 698,["673"] = 698,["674"] = 698,["675"] = 698,["676"] = 699,["677"] = 700,["679"] = 703,["680"] = 704,["681"] = 704,["682"] = 704,["683"] = 705,["684"] = 704,["685"] = 704,["686"] = 708,["687"] = 709,["688"] = 711,["689"] = 712,["690"] = 712,["691"] = 712,["692"] = 713,["693"] = 712,["694"] = 712,["697"] = 718,["698"] = 685,["699"] = 721,["700"] = 722,["701"] = 724,["702"] = 725,["704"] = 721,["705"] = 729,["706"] = 730,["707"] = 731,["708"] = 732,["709"] = 734,["710"] = 735,["711"] = 736,["712"] = 737,["716"] = 742,["719"] = 746,["720"] = 747,["722"] = 750,["723"] = 751,["724"] = 752,["726"] = 755,["727"] = 756,["729"] = 759,["730"] = 760,["731"] = 761,["732"] = 762,["733"] = 762,["734"] = 762,["735"] = 763,["736"] = 764,["738"] = 762,["739"] = 762,["743"] = 729,["744"] = 772,["745"] = 773,["746"] = 774,["747"] = 776,["748"] = 777,["749"] = 779,["750"] = 780,["751"] = 781,["752"] = 781,["753"] = 781,["754"] = 782,["755"] = 783,["756"] = 784,["757"] = 785,["760"] = 781,["761"] = 781,["762"] = 790,["763"] = 791,["764"] = 792,["765"] = 793,["769"] = 798,["772"] = 772,["773"] = 803,["774"] = 804,["775"] = 803,["776"] = 807,["777"] = 808,["778"] = 809,["779"] = 810,["781"] = 813,["782"] = 814,["784"] = 817,["785"] = 818,["787"] = 821,["788"] = 822,["789"] = 823,["790"] = 824,["791"] = 825,["792"] = 826,["795"] = 830,["796"] = 807,["797"] = 833,["798"] = 834,["799"] = 835,["800"] = 833,["801"] = 838,["802"] = 839,["803"] = 838,["804"] = 842,["805"] = 843,["806"] = 842,["807"] = 846,["808"] = 847,["809"] = 846,["810"] = 850,["811"] = 851,["812"] = 852,["814"] = 854,["815"] = 850,["816"] = 857,["817"] = 858,["818"] = 857,["819"] = 861,["820"] = 862,["821"] = 863,["822"] = 864,["823"] = 864,["824"] = 864,["825"] = 864,["827"] = 866,["828"] = 866,["829"] = 866,["830"] = 866,["833"] = 869,["834"] = 869,["835"] = 869,["836"] = 869,["838"] = 861,["839"] = 873,["840"] = 874,["841"] = 874,["842"] = 874,["843"] = 874,["844"] = 873,["845"] = 877,["846"] = 878,["847"] = 879,["848"] = 881,["849"] = 882,["850"] = 883,["852"] = 886,["853"] = 887,["855"] = 890,["856"] = 891,["857"] = 892,["859"] = 894,["860"] = 895,["861"] = 895,["862"] = 895,["863"] = 895,["864"] = 895,["865"] = 896,["868"] = 899,["870"] = 877,["871"] = 903,["872"] = 904,["873"] = 905,["874"] = 906,["875"] = 907,["877"] = 903,["878"] = 911,["879"] = 912,["880"] = 913,["881"] = 915,["882"] = 916,["884"] = 919,["885"] = 920,["888"] = 911,["889"] = 925,["890"] = 926,["891"] = 926,["892"] = 926,["893"] = 927,["894"] = 928,["895"] = 928,["896"] = 928,["897"] = 928,["898"] = 929,["900"] = 926,["901"] = 926,["902"] = 925,["903"] = 934,["904"] = 935,["905"] = 935,["906"] = 935,["907"] = 936,["908"] = 937,["909"] = 938,["910"] = 940,["911"] = 941,["912"] = 941,["913"] = 941,["914"] = 941,["915"] = 942,["917"] = 944,["918"] = 945,["919"] = 946,["920"] = 946,["921"] = 946,["922"] = 946,["923"] = 947,["927"] = 935,["928"] = 935,["929"] = 934,["930"] = 954,["931"] = 955,["932"] = 955,["933"] = 955,["934"] = 955,["935"] = 956,["936"] = 957,["938"] = 959,["939"] = 954,["940"] = 962,["941"] = 963,["942"] = 963,["943"] = 963,["944"] = 963,["945"] = 964,["946"] = 965,["948"] = 967,["949"] = 962,["950"] = 970,["951"] = 971,["952"] = 971,["953"] = 971,["954"] = 971,["955"] = 970,["956"] = 974,["957"] = 975,["958"] = 974,["959"] = 978,["960"] = 979,["961"] = 981,["962"] = 982,["964"] = 985,["965"] = 978,["966"] = 988,["967"] = 989,["968"] = 990,["969"] = 991,["970"] = 992,["971"] = 992,["972"] = 992,["973"] = 992,["974"] = 992,["975"] = 992,["976"] = 994,["977"] = 1001,["978"] = 1002,["979"] = 988,["980"] = 1005,["981"] = 1006,["982"] = 1005,["983"] = 1010,["984"] = 1010,["985"] = 70,["986"] = 1014,["987"] = 1014,["988"] = 1014,["989"] = 1014,["990"] = 1019,["991"] = 1020});
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
local ____wave = require("clases.wave")
local Wave = ____wave.default
local ____settings = require("settings")
local settings = ____settings.default
local ____pre_wave = require("clases.pre_wave")
local PreWave = ____pre_wave.default
local ____custom_ai = require("clases.custom_ai")
local NPCNames = ____custom_ai.NPCNames
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
    self.waveGroups = {}
    self.max_treshold = 30
    self.currentWave = -1
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
    self:SetState(CustomGameState.PRE_WAVE)
    self:GenerateWaveGroups()
    self.pre_wave = __TS__New(PreWave, self.alliances, settings.PreWaveDuration)
    self:RegisterThinker(
        0.01,
        function()
            if (self.state == CustomGameState.WAVE_IN_PROGRESS) and self.wave then
                self.wave:Update()
            end
            if (self.state == CustomGameState.PRE_WAVE) and self.pre_wave then
                self.pre_wave:Update()
            end
        end
    )
end
function GameMode.prototype.GenerateWaveGroups(self)
    local bossLevels = {7, 15}
    local npcs = {NPCNames.DIRE_ZOMBIE, NPCNames.DIRE_ZOMBIE_RAGER, NPCNames.DIRE_ZOMBIE_MEELE, NPCNames.FLYING_SKULL}
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
            __TS__ArrayPush(
                self.waveGroups,
                self:GenerateWaveGroup(npcsToUse, amount)
            )
            i = i + 1
        end
    end
end
function GameMode.prototype.GenerateWaveGroup(self, possibleNPCs, amount)
    local group = {}
    local remainingNpcs = amount
    local remainingPossibleNPCs = possibleNPCs
    while remainingNpcs > 0 do
        local currentNPC = RandomInt(remainingPossibleNPCs[1], remainingPossibleNPCs[#remainingPossibleNPCs])
        local currentAmmountToGenerate = ((#remainingPossibleNPCs == 1) and remainingNpcs) or RandomInt(1, remainingNpcs)
        __TS__ArrayPush(group, {name = currentNPC, ammount = currentAmmountToGenerate})
        remainingPossibleNPCs = __TS__ArrayFilter(
            remainingPossibleNPCs,
            function(____, npc) return npc ~= currentNPC end
        )
        remainingNpcs = remainingNpcs - currentAmmountToGenerate
    end
    return group
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
    LinkLuaModifier("modifier_visible", "modifiers/generic/modifier_visible", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_casting", "modifiers/generic/modifier_casting", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_damage_fx", "modifiers/generic/modifier_damage_fx", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_shield", "modifiers/generic/modifier_shield", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hide_bar", "modifiers/generic/modifier_hide_bar", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hidden", "modifiers/generic/modifier_hidden", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_banish", "modifiers/generic/modifier_banish", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hero_movement", "modifiers/generic/modifier_hero_movement", LUA_MODIFIER_MOTION_NONE)
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
function GameMode.prototype.RegisterPlayer(self, hero)
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
    elseif state == CustomGameState.PRE_WAVE then
        self.pre_wave = nil
        self:IncrementWave()
        local waveGroup = self.waveGroups[self.currentWave + 1]
        if waveGroup then
            self.wave = __TS__New(Wave, self.alliances, -1, {waveGroup})
        else
            self:EndGame(0)
        end
    elseif state == CustomGameState.WAVE_IN_PROGRESS then
        self.wave = nil
        self.pre_wave = __TS__New(PreWave, self.alliances, settings.PreWaveDuration)
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
        SendOverheadHealMessage(target, event.heal)
        Timers:CreateTimer(
            0.05,
            function()
                CustomEntitiesLegacy:SendDataToClient(target)
            end
        )
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
            if self.wave then
                __TS__ArrayForEach(
                    self.wave.ais,
                    function(____, ai)
                        if ai.unit:IsAlive() then
                            ai.unit:ForceKill(false)
                        end
                    end
                )
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
    self:RegisterUnit(npc)
    if npc:IsRealHero() then
        if self:IsPVP() then
            return self:OnHeroInGamePVP(npc)
        elseif self:IsPVE() then
            return self:OnHeroInGamePVE(npc)
        end
    end
    return true
end
function GameMode.prototype.IsPlayerHero(self, hero)
    local playerID = hero:GetPlayerOwnerID()
    return playerID ~= -1
end
function GameMode.prototype.IncrementWave(self)
    self.currentWave = self.currentWave + 1
end
function GameMode.prototype.IsPVP(self)
    return GetMapName() == Custom_MapNames.PVP
end
function GameMode.prototype.IsPVE(self)
    return GetMapName() == Custom_MapNames.PVE
end
function GameMode.prototype.OnHeroInGamePVE(self, hero)
    if hero:GetTeamNumber() ~= DOTA_TEAM_CUSTOM_1 then
        return self:RegisterPlayer(hero)
    end
    return true
end
function GameMode.prototype.OnHeroInGamePVP(self, hero)
    return self:RegisterPlayer(hero)
end
function GameMode.prototype.RegisterUnit(self, unit)
    if unit:IsRealHero() then
        if self:IsPlayerHero(unit) then
            __TS__ArrayPush(
                self.units,
                __TS__New(CustomPlayerHeroNPC, unit)
            )
        else
            __TS__ArrayPush(
                self.units,
                __TS__New(CustomNonPlayerHeroNPC, unit)
            )
        end
    else
        __TS__ArrayPush(
            self.units,
            __TS__New(CustomNPC, unit)
        )
    end
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
    if self.wave then
        self.wave:OnUnitDies(killed)
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
        if self.wave then
            self.wave:OnUnitHurt(victim)
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
