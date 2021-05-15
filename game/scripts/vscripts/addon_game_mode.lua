--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 19,["30"] = 19,["31"] = 20,["32"] = 20,["33"] = 20,["34"] = 21,["35"] = 21,["36"] = 22,["37"] = 22,["38"] = 22,["39"] = 23,["40"] = 23,["41"] = 24,["42"] = 24,["43"] = 25,["44"] = 25,["45"] = 26,["46"] = 26,["47"] = 48,["48"] = 53,["49"] = 53,["50"] = 53,["51"] = 53,["52"] = 53,["53"] = 58,["54"] = 58,["55"] = 58,["56"] = 58,["57"] = 58,["58"] = 63,["59"] = 64,["60"] = 65,["61"] = 66,["62"] = 68,["63"] = 70,["64"] = 71,["65"] = 70,["67"] = 72,["68"] = 73,["69"] = 74,["70"] = 75,["71"] = 76,["72"] = 78,["73"] = 81,["74"] = 85,["75"] = 86,["76"] = 89,["77"] = 89,["78"] = 89,["79"] = 89,["80"] = 89,["81"] = 89,["82"] = 89,["83"] = 91,["84"] = 92,["85"] = 93,["86"] = 94,["87"] = 95,["88"] = 97,["89"] = 98,["90"] = 99,["91"] = 100,["92"] = 88,["93"] = 104,["94"] = 105,["95"] = 106,["96"] = 107,["97"] = 108,["98"] = 109,["99"] = 110,["100"] = 111,["101"] = 112,["102"] = 113,["103"] = 114,["104"] = 116,["105"] = 117,["106"] = 118,["107"] = 119,["108"] = 120,["109"] = 121,["110"] = 123,["111"] = 124,["112"] = 125,["113"] = 127,["114"] = 128,["115"] = 129,["116"] = 130,["118"] = 104,["119"] = 134,["120"] = 135,["121"] = 134,["122"] = 138,["123"] = 139,["124"] = 139,["125"] = 139,["126"] = 139,["127"] = 140,["128"] = 140,["129"] = 140,["130"] = 140,["131"] = 141,["132"] = 141,["133"] = 141,["134"] = 141,["135"] = 142,["136"] = 142,["137"] = 142,["138"] = 142,["139"] = 144,["140"] = 145,["141"] = 146,["142"] = 147,["144"] = 150,["145"] = 150,["146"] = 150,["147"] = 151,["148"] = 152,["149"] = 152,["150"] = 152,["151"] = 153,["152"] = 152,["153"] = 152,["154"] = 150,["155"] = 150,["156"] = 138,["157"] = 158,["158"] = 159,["159"] = 160,["160"] = 161,["161"] = 163,["162"] = 164,["163"] = 165,["164"] = 167,["165"] = 167,["166"] = 167,["167"] = 168,["168"] = 169,["170"] = 171,["171"] = 172,["173"] = 175,["174"] = 176,["176"] = 167,["177"] = 167,["178"] = 158,["179"] = 181,["180"] = 182,["181"] = 183,["182"] = 215,["183"] = 217,["184"] = 217,["185"] = 217,["186"] = 218,["187"] = 219,["189"] = 221,["190"] = 222,["192"] = 217,["193"] = 217,["194"] = 181,["195"] = 227,["196"] = 228,["197"] = 229,["199"] = 231,["200"] = 233,["201"] = 234,["202"] = 234,["203"] = 234,["204"] = 235,["205"] = 236,["206"] = 237,["208"] = 234,["209"] = 234,["211"] = 242,["212"] = 227,["213"] = 245,["214"] = 246,["215"] = 247,["216"] = 248,["217"] = 249,["218"] = 250,["219"] = 251,["220"] = 252,["221"] = 253,["222"] = 254,["223"] = 255,["224"] = 256,["225"] = 258,["226"] = 259,["227"] = 260,["228"] = 261,["230"] = 263,["231"] = 245,["232"] = 266,["233"] = 267,["234"] = 268,["235"] = 269,["236"] = 270,["237"] = 271,["238"] = 266,["239"] = 274,["240"] = 275,["241"] = 276,["242"] = 277,["243"] = 278,["244"] = 274,["245"] = 281,["246"] = 282,["247"] = 282,["248"] = 282,["249"] = 282,["250"] = 282,["251"] = 283,["252"] = 283,["253"] = 283,["254"] = 283,["255"] = 283,["256"] = 284,["257"] = 284,["258"] = 284,["259"] = 284,["260"] = 284,["261"] = 285,["262"] = 285,["263"] = 285,["264"] = 285,["265"] = 285,["266"] = 286,["267"] = 286,["268"] = 286,["269"] = 286,["270"] = 286,["271"] = 287,["272"] = 287,["273"] = 287,["274"] = 287,["275"] = 287,["276"] = 289,["277"] = 281,["278"] = 292,["279"] = 293,["280"] = 293,["281"] = 293,["282"] = 294,["283"] = 295,["284"] = 296,["285"] = 297,["286"] = 298,["288"] = 293,["289"] = 293,["290"] = 302,["291"] = 302,["292"] = 302,["293"] = 302,["294"] = 302,["295"] = 306,["296"] = 306,["297"] = 306,["298"] = 307,["299"] = 308,["300"] = 310,["301"] = 311,["302"] = 313,["303"] = 314,["304"] = 316,["305"] = 317,["306"] = 318,["307"] = 319,["308"] = 321,["309"] = 322,["311"] = 325,["312"] = 326,["313"] = 327,["316"] = 306,["317"] = 306,["318"] = 332,["319"] = 332,["320"] = 332,["321"] = 333,["322"] = 334,["323"] = 336,["324"] = 337,["325"] = 339,["327"] = 340,["328"] = 340,["329"] = 341,["330"] = 342,["331"] = 343,["332"] = 344,["335"] = 340,["338"] = 349,["339"] = 350,["342"] = 354,["343"] = 355,["344"] = 355,["345"] = 355,["347"] = 332,["348"] = 332,["349"] = 359,["350"] = 359,["351"] = 359,["352"] = 360,["353"] = 361,["354"] = 363,["355"] = 364,["356"] = 365,["357"] = 366,["358"] = 367,["359"] = 368,["362"] = 359,["363"] = 359,["364"] = 292,["365"] = 374,["366"] = 375,["367"] = 376,["368"] = 377,["369"] = 378,["370"] = 379,["371"] = 380,["372"] = 381,["373"] = 374,["374"] = 384,["375"] = 385,["376"] = 386,["377"] = 387,["378"] = 388,["379"] = 389,["380"] = 390,["381"] = 391,["382"] = 392,["383"] = 393,["384"] = 394,["385"] = 395,["386"] = 397,["387"] = 398,["388"] = 399,["389"] = 400,["390"] = 401,["391"] = 402,["392"] = 403,["393"] = 404,["394"] = 405,["395"] = 406,["396"] = 407,["397"] = 409,["398"] = 410,["399"] = 411,["400"] = 412,["401"] = 413,["402"] = 414,["403"] = 415,["404"] = 416,["405"] = 417,["406"] = 419,["407"] = 421,["408"] = 384,["409"] = 424,["410"] = 425,["411"] = 424,["412"] = 428,["413"] = 429,["414"] = 429,["415"] = 429,["416"] = 429,["417"] = 429,["418"] = 435,["419"] = 428,["420"] = 438,["421"] = 439,["422"] = 441,["423"] = 441,["424"] = 441,["425"] = 442,["426"] = 442,["427"] = 442,["428"] = 443,["429"] = 444,["431"] = 442,["432"] = 442,["433"] = 441,["434"] = 441,["435"] = 449,["436"] = 438,["437"] = 452,["438"] = 453,["439"] = 454,["440"] = 455,["441"] = 457,["442"] = 458,["443"] = 459,["444"] = 459,["445"] = 459,["446"] = 459,["447"] = 459,["448"] = 460,["450"] = 462,["451"] = 463,["452"] = 464,["453"] = 465,["454"] = 466,["455"] = 468,["456"] = 469,["457"] = 470,["459"] = 473,["460"] = 474,["461"] = 475,["462"] = 477,["464"] = 480,["466"] = 452,["467"] = 484,["468"] = 485,["469"] = 486,["470"] = 487,["471"] = 488,["472"] = 489,["473"] = 484,["474"] = 492,["475"] = 493,["476"] = 494,["477"] = 495,["478"] = 497,["479"] = 498,["480"] = 499,["481"] = 501,["482"] = 502,["483"] = 503,["484"] = 505,["485"] = 506,["486"] = 507,["487"] = 509,["488"] = 510,["489"] = 511,["491"] = 513,["493"] = 516,["494"] = 517,["495"] = 518,["497"] = 492,["498"] = 522,["499"] = 523,["500"] = 524,["501"] = 526,["502"] = 526,["503"] = 526,["504"] = 527,["505"] = 527,["506"] = 527,["507"] = 527,["508"] = 527,["509"] = 527,["510"] = 526,["511"] = 526,["512"] = 530,["513"] = 522,["514"] = 533,["515"] = 534,["516"] = 535,["517"] = 543,["518"] = 544,["519"] = 545,["520"] = 545,["521"] = 545,["522"] = 545,["523"] = 545,["524"] = 545,["525"] = 545,["526"] = 545,["527"] = 546,["528"] = 533,["529"] = 549,["530"] = 550,["531"] = 551,["532"] = 552,["534"] = 549,["535"] = 556,["536"] = 557,["537"] = 556,["538"] = 560,["539"] = 561,["540"] = 563,["541"] = 568,["542"] = 569,["543"] = 570,["544"] = 571,["545"] = 573,["546"] = 574,["547"] = 575,["549"] = 578,["550"] = 579,["551"] = 584,["552"] = 584,["553"] = 584,["554"] = 585,["555"] = 585,["556"] = 585,["557"] = 586,["558"] = 586,["559"] = 586,["560"] = 586,["561"] = 588,["562"] = 589,["564"] = 592,["565"] = 593,["566"] = 593,["567"] = 593,["568"] = 594,["569"] = 595,["571"] = 598,["574"] = 602,["575"] = 603,["576"] = 604,["577"] = 605,["578"] = 606,["579"] = 607,["583"] = 611,["584"] = 612,["586"] = 614,["587"] = 615,["589"] = 618,["590"] = 560,["591"] = 621,["592"] = 622,["593"] = 621,["594"] = 625,["595"] = 626,["596"] = 629,["597"] = 630,["598"] = 631,["599"] = 632,["600"] = 633,["602"] = 635,["604"] = 638,["605"] = 639,["606"] = 639,["607"] = 639,["608"] = 640,["609"] = 639,["610"] = 639,["611"] = 643,["612"] = 644,["613"] = 646,["614"] = 647,["615"] = 647,["616"] = 647,["617"] = 648,["618"] = 647,["619"] = 647,["622"] = 678,["623"] = 625,["624"] = 681,["625"] = 682,["626"] = 683,["627"] = 685,["628"] = 689,["629"] = 690,["631"] = 693,["632"] = 694,["633"] = 694,["634"] = 694,["635"] = 694,["636"] = 695,["637"] = 696,["639"] = 699,["640"] = 700,["641"] = 700,["642"] = 700,["643"] = 701,["644"] = 700,["645"] = 700,["646"] = 704,["647"] = 705,["648"] = 707,["649"] = 708,["650"] = 708,["651"] = 708,["652"] = 709,["653"] = 708,["654"] = 708,["657"] = 714,["658"] = 681,["659"] = 717,["660"] = 718,["661"] = 720,["662"] = 721,["664"] = 717,["665"] = 725,["666"] = 726,["667"] = 727,["668"] = 728,["669"] = 730,["670"] = 731,["671"] = 732,["672"] = 733,["676"] = 738,["679"] = 742,["680"] = 743,["682"] = 746,["683"] = 747,["684"] = 748,["686"] = 751,["687"] = 752,["689"] = 755,["690"] = 756,["691"] = 757,["692"] = 758,["693"] = 758,["694"] = 758,["695"] = 759,["696"] = 760,["698"] = 758,["699"] = 758,["703"] = 725,["704"] = 768,["705"] = 769,["706"] = 770,["707"] = 772,["708"] = 773,["709"] = 775,["710"] = 776,["711"] = 777,["712"] = 777,["713"] = 777,["714"] = 778,["715"] = 779,["716"] = 780,["717"] = 781,["720"] = 777,["721"] = 777,["722"] = 786,["723"] = 787,["724"] = 788,["725"] = 789,["729"] = 794,["732"] = 768,["733"] = 799,["734"] = 800,["735"] = 799,["736"] = 803,["737"] = 804,["738"] = 805,["739"] = 806,["741"] = 809,["742"] = 810,["744"] = 813,["745"] = 814,["747"] = 817,["748"] = 818,["749"] = 819,["750"] = 820,["751"] = 821,["752"] = 822,["755"] = 826,["756"] = 803,["757"] = 829,["758"] = 830,["759"] = 830,["760"] = 830,["761"] = 830,["762"] = 829,["763"] = 833,["764"] = 834,["765"] = 833,["766"] = 837,["767"] = 838,["768"] = 837,["769"] = 841,["770"] = 842,["771"] = 841,["772"] = 845,["773"] = 846,["774"] = 847,["776"] = 849,["777"] = 845,["778"] = 852,["779"] = 853,["780"] = 852,["781"] = 856,["782"] = 857,["783"] = 858,["784"] = 858,["785"] = 858,["786"] = 858,["788"] = 860,["789"] = 860,["790"] = 860,["791"] = 860,["793"] = 856,["794"] = 864,["795"] = 865,["796"] = 865,["797"] = 865,["798"] = 865,["799"] = 864,["800"] = 868,["801"] = 869,["802"] = 870,["803"] = 872,["804"] = 873,["805"] = 874,["807"] = 877,["808"] = 878,["810"] = 881,["811"] = 882,["812"] = 883,["814"] = 885,["815"] = 886,["816"] = 886,["817"] = 886,["818"] = 886,["819"] = 886,["820"] = 887,["823"] = 890,["825"] = 868,["826"] = 894,["827"] = 895,["828"] = 896,["829"] = 897,["830"] = 898,["832"] = 894,["833"] = 902,["834"] = 903,["835"] = 904,["836"] = 905,["838"] = 902,["839"] = 909,["840"] = 910,["841"] = 910,["842"] = 910,["843"] = 911,["844"] = 912,["845"] = 912,["846"] = 912,["847"] = 912,["848"] = 913,["850"] = 910,["851"] = 910,["852"] = 909,["853"] = 918,["854"] = 919,["855"] = 919,["856"] = 919,["857"] = 920,["858"] = 921,["859"] = 922,["860"] = 924,["861"] = 925,["862"] = 925,["863"] = 925,["864"] = 925,["865"] = 926,["867"] = 928,["868"] = 929,["869"] = 930,["870"] = 930,["871"] = 930,["872"] = 930,["873"] = 931,["877"] = 919,["878"] = 919,["879"] = 918,["880"] = 938,["881"] = 939,["882"] = 939,["883"] = 939,["884"] = 939,["885"] = 940,["886"] = 941,["888"] = 943,["889"] = 938,["890"] = 946,["891"] = 947,["892"] = 947,["893"] = 947,["894"] = 947,["895"] = 948,["896"] = 949,["898"] = 951,["899"] = 946,["900"] = 954,["901"] = 955,["902"] = 955,["903"] = 955,["904"] = 955,["905"] = 954,["906"] = 958,["907"] = 959,["908"] = 958,["909"] = 962,["910"] = 963,["911"] = 965,["912"] = 966,["914"] = 969,["915"] = 962,["916"] = 972,["917"] = 973,["918"] = 974,["919"] = 975,["920"] = 976,["921"] = 976,["922"] = 976,["923"] = 976,["924"] = 976,["925"] = 976,["926"] = 978,["927"] = 985,["928"] = 986,["929"] = 972,["930"] = 989,["931"] = 990,["932"] = 989,["933"] = 994,["934"] = 994,["935"] = 70,["936"] = 998,["937"] = 998,["938"] = 998,["939"] = 998,["940"] = 1003,["941"] = 1004});
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
require("util.custom_abilities")
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
local PlayerNPC = ____custom_npc.PlayerNPC
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
    self.waveGroups = {{{name = NPCNames.DIRE_ZOMBIE, ammount = 10}, {name = NPCNames.DIRE_ZOMBIE_RAGER, ammount = 5}, {name = NPCNames.DIRE_ZOMBIE_MEELE, ammount = 5}}, {{name = NPCNames.QUEEN, ammount = 1}}, {{name = NPCNames.DIRE_ZOMBIE, ammount = 8}, {name = NPCNames.DIRE_ZOMBIE_RAGER, ammount = 6}, {name = NPCNames.DIRE_ZOMBIE_MEELE, ammount = 8}}, {{name = NPCNames.CENTAUR, ammount = 1}}}
    self.pre_wave = __TS__New(PreWave, self.alliances, settings.PreRoundDuration)
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
    LinkLuaModifier("modifier_ruby", "modifiers/modifier_ruby.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_ruby_attack", "modifiers/modifier_ruby.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_sapphire", "modifiers/modifier_sapphire.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_emerald", "modifiers/modifier_emerald.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_amethyst", "modifiers/modifier_amethyst.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_miss", "modifiers/modifier_miss.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_restricted", "modifiers/modifier_restricted.lua", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_silence", "abilities/generic/modifier_generic_silence", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_fading_slow", "abilities/generic/modifier_generic_fading_slow", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_fading_haste", "abilities/generic/modifier_generic_fading_haste", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_stunned", "abilities/generic/modifier_generic_stunned", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_provides_vision", "abilities/generic/modifier_generic_provides_vision", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_knockback", "abilities/generic/modifier_generic_knockback", LUA_MODIFIER_MOTION_BOTH)
    LinkLuaModifier("modifier_generic_root", "abilities/generic/modifier_generic_root", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_invencible", "abilities/generic/modifier_generic_invencible", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_confuse", "abilities/generic/modifier_generic_confuse", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_sleep", "abilities/generic/modifier_generic_sleep", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_fear", "abilities/generic/modifier_generic_fear", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_visible", "abilities/base/modifier_visible", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_casting", "abilities/base/modifier_casting", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_damage_fx", "abilities/base/modifier_damage_fx", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hero_base", "abilities/base/modifier_hero_base", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_shield", "abilities/base/modifier_shield", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hide_bar", "abilities/base/modifier_hide_bar", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hidden", "abilities/base/modifier_hidden", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_banish", "abilities/base/modifier_banish", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_hero_movement", "abilities/base/modifier_hero_movement", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_mount", "abilities/heroes/common/mount/modifier_mount.lua", LUA_MODIFIER_MOTION_NONE)
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
        self.pre_wave = __TS__New(PreWave, self.alliances, settings.PreRoundDuration)
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
        local energyCost = CustomAbilities:GetEnergyCost(ability)
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
            if not CustomAbilities:HasBehavior(ability, DOTA_ABILITY_BEHAVIOR_IMMEDIATE) then
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
    return __TS__ArrayFilter(
        self.players,
        function(____, player) return player.hero == hero end
    )[1] ~= nil
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
        __TS__ArrayPush(
            self.units,
            __TS__New(PlayerNPC, unit)
        )
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
    if (event.entindex_attacker ~= nil) and (event.entindex_killed ~= nil) then
        local victim = EntIndexToHScript(event.entindex_killed)
        SendOverheadDamageMessage(victim, event.damage)
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
