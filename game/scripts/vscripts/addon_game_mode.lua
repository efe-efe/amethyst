--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 2,["7"] = 2,["8"] = 3,["9"] = 3,["10"] = 4,["11"] = 4,["12"] = 5,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 19,["30"] = 19,["31"] = 20,["32"] = 20,["33"] = 20,["34"] = 20,["35"] = 21,["36"] = 21,["37"] = 22,["38"] = 22,["39"] = 22,["40"] = 23,["41"] = 23,["42"] = 24,["43"] = 24,["44"] = 25,["45"] = 25,["46"] = 27,["47"] = 27,["48"] = 50,["49"] = 55,["50"] = 55,["51"] = 55,["52"] = 55,["53"] = 55,["54"] = 60,["55"] = 60,["56"] = 60,["57"] = 60,["58"] = 60,["59"] = 65,["60"] = 66,["61"] = 67,["62"] = 68,["63"] = 69,["64"] = 71,["65"] = 73,["66"] = 74,["67"] = 73,["69"] = 75,["70"] = 76,["71"] = 77,["72"] = 78,["73"] = 79,["74"] = 81,["75"] = 87,["76"] = 88,["77"] = 91,["78"] = 91,["79"] = 91,["80"] = 91,["81"] = 91,["82"] = 91,["83"] = 91,["84"] = 93,["85"] = 94,["86"] = 95,["87"] = 96,["88"] = 97,["89"] = 99,["90"] = 100,["91"] = 101,["92"] = 102,["93"] = 90,["94"] = 106,["95"] = 107,["96"] = 108,["97"] = 109,["98"] = 110,["99"] = 111,["100"] = 112,["101"] = 113,["102"] = 114,["103"] = 115,["104"] = 116,["105"] = 118,["106"] = 119,["107"] = 120,["108"] = 121,["109"] = 122,["110"] = 123,["111"] = 125,["112"] = 126,["113"] = 127,["114"] = 129,["115"] = 130,["116"] = 131,["117"] = 132,["119"] = 106,["120"] = 136,["121"] = 137,["122"] = 136,["123"] = 140,["124"] = 141,["125"] = 141,["126"] = 141,["127"] = 141,["128"] = 142,["129"] = 142,["130"] = 142,["131"] = 142,["132"] = 143,["133"] = 143,["134"] = 143,["135"] = 143,["136"] = 144,["137"] = 144,["138"] = 144,["139"] = 144,["140"] = 145,["141"] = 145,["142"] = 145,["143"] = 145,["144"] = 147,["145"] = 148,["146"] = 149,["147"] = 150,["149"] = 153,["150"] = 153,["151"] = 153,["152"] = 154,["153"] = 155,["154"] = 155,["155"] = 155,["156"] = 156,["157"] = 155,["158"] = 155,["159"] = 153,["160"] = 153,["161"] = 140,["162"] = 161,["163"] = 162,["164"] = 163,["165"] = 164,["166"] = 166,["167"] = 167,["168"] = 168,["169"] = 170,["170"] = 170,["171"] = 170,["172"] = 171,["173"] = 172,["175"] = 174,["176"] = 175,["178"] = 177,["179"] = 178,["181"] = 170,["182"] = 170,["183"] = 161,["184"] = 183,["185"] = 184,["186"] = 185,["187"] = 187,["188"] = 187,["189"] = 187,["190"] = 188,["191"] = 189,["193"] = 191,["194"] = 192,["196"] = 187,["197"] = 187,["198"] = 183,["199"] = 197,["200"] = 198,["201"] = 199,["203"] = 201,["204"] = 203,["205"] = 204,["206"] = 204,["207"] = 204,["208"] = 205,["209"] = 206,["210"] = 207,["212"] = 204,["213"] = 204,["215"] = 212,["216"] = 197,["217"] = 215,["218"] = 216,["219"] = 217,["220"] = 218,["221"] = 219,["222"] = 220,["223"] = 221,["224"] = 222,["225"] = 223,["226"] = 224,["227"] = 225,["228"] = 226,["229"] = 228,["230"] = 229,["231"] = 230,["232"] = 231,["234"] = 233,["235"] = 215,["236"] = 236,["237"] = 237,["238"] = 238,["239"] = 239,["240"] = 240,["241"] = 241,["242"] = 236,["243"] = 244,["244"] = 245,["245"] = 246,["246"] = 247,["247"] = 248,["248"] = 244,["249"] = 251,["250"] = 252,["251"] = 252,["252"] = 252,["253"] = 252,["254"] = 252,["255"] = 253,["256"] = 253,["257"] = 253,["258"] = 253,["259"] = 253,["260"] = 254,["261"] = 254,["262"] = 254,["263"] = 254,["264"] = 254,["265"] = 255,["266"] = 255,["267"] = 255,["268"] = 255,["269"] = 255,["270"] = 256,["271"] = 256,["272"] = 256,["273"] = 256,["274"] = 256,["275"] = 257,["276"] = 257,["277"] = 257,["278"] = 257,["279"] = 257,["280"] = 258,["281"] = 251,["282"] = 261,["283"] = 262,["284"] = 262,["285"] = 262,["286"] = 263,["287"] = 264,["288"] = 265,["289"] = 266,["290"] = 267,["292"] = 262,["293"] = 262,["294"] = 271,["295"] = 271,["296"] = 271,["297"] = 271,["298"] = 271,["299"] = 275,["300"] = 275,["301"] = 275,["302"] = 276,["303"] = 277,["304"] = 279,["305"] = 280,["306"] = 282,["307"] = 283,["308"] = 285,["309"] = 286,["310"] = 287,["311"] = 288,["312"] = 290,["313"] = 291,["315"] = 294,["316"] = 295,["317"] = 296,["320"] = 275,["321"] = 275,["322"] = 301,["323"] = 301,["324"] = 301,["325"] = 302,["326"] = 303,["327"] = 305,["328"] = 306,["329"] = 308,["331"] = 309,["332"] = 309,["333"] = 310,["334"] = 311,["335"] = 312,["336"] = 313,["339"] = 309,["342"] = 318,["343"] = 319,["346"] = 323,["347"] = 324,["348"] = 324,["349"] = 324,["351"] = 301,["352"] = 301,["353"] = 328,["354"] = 328,["355"] = 328,["356"] = 329,["357"] = 330,["358"] = 332,["359"] = 333,["360"] = 334,["361"] = 335,["362"] = 336,["363"] = 337,["366"] = 328,["367"] = 328,["368"] = 261,["369"] = 343,["370"] = 344,["371"] = 345,["372"] = 346,["373"] = 347,["374"] = 348,["375"] = 349,["376"] = 350,["377"] = 343,["378"] = 353,["379"] = 354,["380"] = 355,["381"] = 356,["382"] = 357,["383"] = 358,["384"] = 359,["385"] = 361,["386"] = 362,["387"] = 363,["388"] = 364,["389"] = 365,["390"] = 367,["391"] = 368,["392"] = 369,["393"] = 370,["394"] = 371,["395"] = 372,["396"] = 373,["397"] = 374,["398"] = 375,["399"] = 376,["400"] = 377,["401"] = 378,["402"] = 379,["403"] = 380,["404"] = 381,["405"] = 382,["406"] = 383,["407"] = 384,["408"] = 385,["409"] = 386,["410"] = 387,["411"] = 388,["412"] = 389,["413"] = 390,["414"] = 392,["415"] = 393,["416"] = 394,["417"] = 395,["418"] = 396,["419"] = 397,["420"] = 398,["421"] = 399,["422"] = 400,["423"] = 401,["424"] = 402,["425"] = 403,["426"] = 404,["427"] = 405,["428"] = 406,["429"] = 407,["431"] = 410,["432"] = 353,["433"] = 413,["434"] = 414,["435"] = 413,["436"] = 417,["437"] = 418,["438"] = 418,["439"] = 418,["440"] = 418,["441"] = 418,["442"] = 424,["443"] = 417,["444"] = 427,["445"] = 428,["446"] = 430,["447"] = 430,["448"] = 430,["449"] = 431,["450"] = 431,["451"] = 431,["452"] = 432,["453"] = 433,["455"] = 431,["456"] = 431,["457"] = 430,["458"] = 430,["459"] = 438,["460"] = 427,["461"] = 441,["462"] = 442,["463"] = 443,["464"] = 444,["465"] = 446,["466"] = 447,["467"] = 448,["468"] = 448,["469"] = 448,["470"] = 448,["471"] = 448,["472"] = 449,["474"] = 451,["475"] = 452,["476"] = 453,["477"] = 454,["478"] = 455,["479"] = 457,["480"] = 458,["481"] = 459,["483"] = 462,["484"] = 463,["485"] = 464,["486"] = 465,["487"] = 467,["489"] = 470,["491"] = 441,["492"] = 474,["493"] = 475,["494"] = 476,["495"] = 477,["496"] = 478,["497"] = 479,["498"] = 474,["499"] = 482,["500"] = 483,["501"] = 484,["502"] = 485,["503"] = 487,["504"] = 488,["505"] = 489,["506"] = 491,["507"] = 492,["508"] = 493,["509"] = 495,["510"] = 496,["511"] = 497,["512"] = 518,["513"] = 519,["514"] = 520,["516"] = 482,["517"] = 524,["518"] = 525,["519"] = 526,["520"] = 528,["521"] = 528,["522"] = 528,["523"] = 529,["524"] = 529,["525"] = 529,["526"] = 529,["527"] = 529,["528"] = 529,["529"] = 528,["530"] = 528,["531"] = 532,["532"] = 524,["533"] = 535,["534"] = 536,["535"] = 537,["536"] = 545,["537"] = 546,["538"] = 547,["539"] = 547,["540"] = 547,["541"] = 547,["542"] = 547,["543"] = 547,["544"] = 547,["545"] = 547,["546"] = 548,["547"] = 535,["548"] = 551,["549"] = 552,["550"] = 553,["551"] = 554,["553"] = 551,["554"] = 558,["555"] = 559,["556"] = 558,["557"] = 562,["558"] = 563,["559"] = 565,["560"] = 570,["561"] = 571,["562"] = 572,["563"] = 573,["564"] = 575,["565"] = 576,["566"] = 577,["568"] = 580,["569"] = 581,["570"] = 586,["571"] = 586,["572"] = 586,["573"] = 587,["574"] = 587,["575"] = 587,["576"] = 588,["577"] = 588,["578"] = 588,["579"] = 588,["580"] = 590,["581"] = 591,["583"] = 594,["584"] = 595,["585"] = 595,["586"] = 595,["587"] = 596,["588"] = 597,["590"] = 600,["593"] = 604,["594"] = 605,["595"] = 606,["596"] = 607,["597"] = 608,["598"] = 609,["602"] = 613,["603"] = 614,["605"] = 616,["606"] = 617,["608"] = 620,["609"] = 562,["610"] = 623,["611"] = 624,["612"] = 623,["613"] = 627,["614"] = 628,["615"] = 631,["616"] = 632,["617"] = 633,["618"] = 634,["619"] = 635,["621"] = 637,["623"] = 640,["624"] = 641,["625"] = 643,["626"] = 644,["627"] = 644,["628"] = 644,["629"] = 645,["630"] = 644,["631"] = 644,["634"] = 650,["635"] = 651,["636"] = 651,["637"] = 651,["638"] = 652,["639"] = 651,["640"] = 651,["641"] = 680,["642"] = 627,["643"] = 683,["644"] = 684,["645"] = 685,["646"] = 687,["647"] = 691,["648"] = 692,["650"] = 695,["651"] = 696,["652"] = 696,["653"] = 696,["654"] = 696,["655"] = 697,["656"] = 698,["658"] = 701,["659"] = 702,["660"] = 702,["661"] = 702,["662"] = 703,["663"] = 702,["664"] = 702,["665"] = 706,["666"] = 707,["667"] = 709,["668"] = 710,["669"] = 710,["670"] = 710,["671"] = 711,["672"] = 710,["673"] = 710,["676"] = 716,["677"] = 683,["678"] = 719,["679"] = 720,["680"] = 722,["681"] = 723,["683"] = 719,["684"] = 727,["685"] = 728,["686"] = 729,["687"] = 730,["688"] = 732,["689"] = 733,["690"] = 734,["691"] = 735,["695"] = 740,["698"] = 744,["699"] = 745,["701"] = 748,["702"] = 749,["703"] = 750,["705"] = 753,["706"] = 754,["708"] = 787,["709"] = 788,["710"] = 789,["711"] = 790,["712"] = 792,["713"] = 793,["714"] = 794,["715"] = 795,["720"] = 727,["721"] = 802,["722"] = 803,["723"] = 804,["724"] = 806,["725"] = 807,["726"] = 809,["727"] = 810,["728"] = 811,["729"] = 811,["730"] = 811,["731"] = 812,["732"] = 813,["733"] = 814,["734"] = 815,["737"] = 811,["738"] = 811,["739"] = 820,["740"] = 821,["741"] = 822,["742"] = 823,["746"] = 828,["749"] = 802,["750"] = 833,["751"] = 834,["752"] = 833,["753"] = 837,["754"] = 838,["755"] = 839,["756"] = 840,["758"] = 843,["759"] = 844,["761"] = 847,["762"] = 848,["764"] = 851,["765"] = 852,["766"] = 853,["767"] = 854,["768"] = 855,["769"] = 856,["770"] = 857,["774"] = 862,["775"] = 837,["776"] = 865,["777"] = 866,["778"] = 867,["779"] = 865,["780"] = 870,["781"] = 871,["782"] = 870,["783"] = 874,["784"] = 875,["785"] = 874,["786"] = 878,["787"] = 879,["788"] = 878,["789"] = 882,["790"] = 883,["791"] = 885,["792"] = 886,["793"] = 887,["795"] = 889,["798"] = 892,["800"] = 894,["801"] = 895,["802"] = 882,["803"] = 898,["804"] = 899,["805"] = 899,["806"] = 899,["807"] = 899,["808"] = 898,["809"] = 902,["810"] = 903,["811"] = 904,["812"] = 906,["813"] = 907,["814"] = 908,["816"] = 911,["817"] = 912,["819"] = 915,["820"] = 916,["821"] = 917,["823"] = 919,["824"] = 920,["825"] = 920,["826"] = 920,["827"] = 920,["828"] = 920,["829"] = 921,["832"] = 924,["834"] = 902,["835"] = 928,["836"] = 929,["837"] = 930,["838"] = 931,["839"] = 932,["841"] = 928,["842"] = 936,["843"] = 937,["844"] = 938,["845"] = 940,["846"] = 941,["848"] = 944,["849"] = 945,["852"] = 936,["853"] = 950,["854"] = 951,["855"] = 951,["856"] = 951,["857"] = 952,["858"] = 953,["859"] = 953,["860"] = 953,["861"] = 953,["862"] = 954,["864"] = 951,["865"] = 951,["866"] = 950,["867"] = 959,["868"] = 960,["869"] = 960,["870"] = 960,["871"] = 961,["872"] = 962,["873"] = 963,["874"] = 965,["875"] = 966,["876"] = 966,["877"] = 966,["878"] = 966,["879"] = 967,["881"] = 969,["882"] = 970,["883"] = 971,["884"] = 971,["885"] = 971,["886"] = 971,["887"] = 972,["891"] = 960,["892"] = 960,["893"] = 959,["894"] = 979,["895"] = 980,["896"] = 980,["897"] = 980,["898"] = 980,["899"] = 981,["900"] = 982,["902"] = 984,["903"] = 979,["904"] = 987,["905"] = 988,["906"] = 988,["907"] = 988,["908"] = 988,["909"] = 989,["910"] = 990,["912"] = 992,["913"] = 987,["914"] = 995,["915"] = 996,["916"] = 996,["917"] = 996,["918"] = 996,["919"] = 995,["920"] = 999,["921"] = 1000,["922"] = 999,["923"] = 1003,["924"] = 1004,["925"] = 1006,["926"] = 1007,["928"] = 1010,["929"] = 1003,["930"] = 1013,["931"] = 1014,["932"] = 1015,["933"] = 1016,["934"] = 1017,["935"] = 1017,["936"] = 1017,["937"] = 1017,["938"] = 1017,["939"] = 1017,["940"] = 1019,["941"] = 1026,["942"] = 1027,["943"] = 1013,["944"] = 1030,["945"] = 1031,["946"] = 1030,["947"] = 1035,["948"] = 1035,["949"] = 73,["950"] = 1039,["951"] = 1039,["952"] = 1039,["953"] = 1039,["954"] = 1044,["955"] = 1045});
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
