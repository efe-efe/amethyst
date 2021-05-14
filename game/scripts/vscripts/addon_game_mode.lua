--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 19,["30"] = 19,["31"] = 20,["32"] = 20,["33"] = 20,["34"] = 21,["35"] = 21,["36"] = 22,["37"] = 22,["38"] = 22,["39"] = 23,["40"] = 23,["41"] = 23,["42"] = 24,["43"] = 24,["44"] = 25,["45"] = 25,["46"] = 47,["47"] = 52,["48"] = 52,["49"] = 52,["50"] = 52,["51"] = 52,["52"] = 57,["53"] = 57,["54"] = 57,["55"] = 57,["56"] = 57,["57"] = 62,["58"] = 63,["59"] = 64,["60"] = 65,["61"] = 67,["62"] = 69,["63"] = 70,["64"] = 69,["66"] = 71,["67"] = 72,["68"] = 73,["69"] = 74,["70"] = 75,["71"] = 77,["72"] = 80,["73"] = 84,["74"] = 85,["75"] = 88,["76"] = 88,["77"] = 88,["78"] = 88,["79"] = 88,["80"] = 88,["81"] = 88,["82"] = 90,["83"] = 91,["84"] = 92,["85"] = 93,["86"] = 94,["87"] = 96,["88"] = 97,["89"] = 98,["90"] = 99,["91"] = 87,["92"] = 103,["93"] = 104,["94"] = 105,["95"] = 106,["96"] = 107,["97"] = 108,["98"] = 109,["99"] = 110,["100"] = 111,["101"] = 112,["102"] = 113,["103"] = 115,["104"] = 116,["105"] = 117,["106"] = 118,["107"] = 119,["108"] = 120,["109"] = 122,["110"] = 123,["111"] = 124,["112"] = 126,["113"] = 127,["114"] = 128,["115"] = 129,["117"] = 103,["118"] = 133,["119"] = 134,["120"] = 133,["121"] = 137,["122"] = 138,["123"] = 138,["124"] = 138,["125"] = 138,["126"] = 139,["127"] = 139,["128"] = 139,["129"] = 139,["130"] = 140,["131"] = 140,["132"] = 140,["133"] = 140,["134"] = 141,["135"] = 141,["136"] = 141,["137"] = 141,["138"] = 143,["139"] = 144,["140"] = 145,["141"] = 146,["143"] = 149,["144"] = 149,["145"] = 149,["146"] = 150,["147"] = 151,["148"] = 151,["149"] = 151,["150"] = 152,["151"] = 151,["152"] = 151,["153"] = 149,["154"] = 149,["155"] = 137,["156"] = 157,["157"] = 158,["158"] = 159,["159"] = 160,["160"] = 162,["161"] = 163,["162"] = 164,["163"] = 166,["164"] = 166,["165"] = 166,["166"] = 167,["167"] = 168,["169"] = 170,["170"] = 171,["172"] = 174,["173"] = 175,["175"] = 166,["176"] = 166,["177"] = 157,["178"] = 180,["179"] = 181,["180"] = 182,["181"] = 201,["182"] = 203,["183"] = 203,["184"] = 203,["185"] = 204,["186"] = 205,["188"] = 207,["189"] = 208,["191"] = 203,["192"] = 203,["193"] = 180,["194"] = 213,["195"] = 214,["196"] = 215,["198"] = 217,["199"] = 219,["200"] = 220,["201"] = 220,["202"] = 220,["203"] = 221,["204"] = 222,["205"] = 223,["207"] = 220,["208"] = 220,["210"] = 228,["211"] = 213,["212"] = 231,["213"] = 232,["214"] = 233,["215"] = 234,["216"] = 235,["217"] = 236,["218"] = 237,["219"] = 238,["220"] = 239,["221"] = 240,["222"] = 241,["223"] = 242,["224"] = 244,["225"] = 245,["226"] = 246,["227"] = 247,["229"] = 249,["230"] = 231,["231"] = 252,["232"] = 253,["233"] = 254,["234"] = 255,["235"] = 256,["236"] = 257,["237"] = 252,["238"] = 260,["239"] = 261,["240"] = 262,["241"] = 263,["242"] = 264,["243"] = 260,["244"] = 267,["245"] = 268,["246"] = 268,["247"] = 268,["248"] = 268,["249"] = 268,["250"] = 269,["251"] = 269,["252"] = 269,["253"] = 269,["254"] = 269,["255"] = 270,["256"] = 270,["257"] = 270,["258"] = 270,["259"] = 270,["260"] = 271,["261"] = 271,["262"] = 271,["263"] = 271,["264"] = 271,["265"] = 272,["266"] = 272,["267"] = 272,["268"] = 272,["269"] = 272,["270"] = 273,["271"] = 273,["272"] = 273,["273"] = 273,["274"] = 273,["275"] = 275,["276"] = 267,["277"] = 278,["278"] = 279,["279"] = 279,["280"] = 279,["281"] = 280,["282"] = 281,["283"] = 282,["284"] = 283,["285"] = 284,["287"] = 279,["288"] = 279,["289"] = 288,["290"] = 288,["291"] = 288,["292"] = 288,["293"] = 288,["294"] = 292,["295"] = 292,["296"] = 292,["297"] = 293,["298"] = 294,["299"] = 296,["300"] = 297,["301"] = 299,["302"] = 300,["303"] = 302,["304"] = 303,["305"] = 304,["306"] = 305,["307"] = 307,["308"] = 308,["310"] = 311,["311"] = 312,["312"] = 313,["315"] = 292,["316"] = 292,["317"] = 318,["318"] = 318,["319"] = 318,["320"] = 319,["321"] = 320,["322"] = 322,["323"] = 323,["324"] = 325,["326"] = 326,["327"] = 326,["328"] = 327,["329"] = 328,["330"] = 329,["331"] = 330,["334"] = 326,["337"] = 335,["338"] = 336,["341"] = 340,["342"] = 341,["343"] = 341,["344"] = 341,["346"] = 318,["347"] = 318,["348"] = 345,["349"] = 345,["350"] = 345,["351"] = 346,["352"] = 347,["353"] = 349,["354"] = 350,["355"] = 351,["356"] = 352,["357"] = 353,["358"] = 354,["361"] = 345,["362"] = 345,["363"] = 278,["364"] = 360,["365"] = 361,["366"] = 362,["367"] = 363,["368"] = 364,["369"] = 365,["370"] = 366,["371"] = 367,["372"] = 360,["373"] = 370,["374"] = 371,["375"] = 372,["376"] = 373,["377"] = 374,["378"] = 375,["379"] = 376,["380"] = 377,["381"] = 378,["382"] = 379,["383"] = 380,["384"] = 381,["385"] = 383,["386"] = 384,["387"] = 385,["388"] = 386,["389"] = 387,["390"] = 388,["391"] = 389,["392"] = 390,["393"] = 391,["394"] = 392,["395"] = 393,["396"] = 395,["397"] = 396,["398"] = 397,["399"] = 398,["400"] = 399,["401"] = 400,["402"] = 401,["403"] = 402,["404"] = 403,["405"] = 405,["406"] = 407,["407"] = 370,["408"] = 410,["409"] = 411,["410"] = 410,["411"] = 414,["412"] = 415,["413"] = 415,["414"] = 415,["415"] = 415,["416"] = 415,["417"] = 421,["418"] = 414,["419"] = 424,["420"] = 425,["421"] = 427,["422"] = 427,["423"] = 427,["424"] = 428,["425"] = 428,["426"] = 428,["427"] = 429,["428"] = 430,["430"] = 428,["431"] = 428,["432"] = 427,["433"] = 427,["434"] = 435,["435"] = 424,["436"] = 438,["437"] = 439,["438"] = 440,["439"] = 441,["440"] = 443,["441"] = 444,["442"] = 445,["443"] = 445,["444"] = 445,["445"] = 445,["446"] = 445,["447"] = 446,["449"] = 448,["450"] = 449,["451"] = 450,["452"] = 451,["453"] = 452,["454"] = 454,["455"] = 455,["456"] = 456,["458"] = 459,["459"] = 460,["460"] = 461,["461"] = 463,["463"] = 466,["465"] = 438,["466"] = 470,["467"] = 471,["468"] = 472,["469"] = 473,["470"] = 474,["471"] = 475,["472"] = 470,["473"] = 478,["474"] = 479,["475"] = 480,["476"] = 481,["477"] = 483,["478"] = 484,["479"] = 485,["480"] = 487,["481"] = 488,["482"] = 489,["483"] = 491,["484"] = 492,["485"] = 493,["486"] = 495,["487"] = 496,["488"] = 497,["490"] = 499,["492"] = 502,["493"] = 503,["494"] = 504,["496"] = 478,["497"] = 508,["498"] = 509,["499"] = 510,["500"] = 512,["501"] = 512,["502"] = 512,["503"] = 513,["504"] = 513,["505"] = 513,["506"] = 513,["507"] = 513,["508"] = 513,["509"] = 512,["510"] = 512,["511"] = 516,["512"] = 508,["513"] = 519,["514"] = 520,["515"] = 521,["516"] = 529,["517"] = 530,["518"] = 531,["519"] = 531,["520"] = 531,["521"] = 531,["522"] = 531,["523"] = 531,["524"] = 531,["525"] = 531,["526"] = 532,["527"] = 519,["528"] = 535,["529"] = 536,["530"] = 537,["531"] = 538,["533"] = 535,["534"] = 542,["535"] = 543,["536"] = 542,["537"] = 546,["538"] = 547,["539"] = 549,["540"] = 554,["541"] = 555,["542"] = 556,["543"] = 557,["544"] = 559,["545"] = 560,["546"] = 561,["548"] = 564,["549"] = 565,["550"] = 570,["551"] = 570,["552"] = 570,["553"] = 571,["554"] = 571,["555"] = 571,["556"] = 572,["557"] = 572,["558"] = 572,["559"] = 572,["560"] = 574,["561"] = 575,["563"] = 578,["564"] = 579,["565"] = 579,["566"] = 579,["567"] = 580,["568"] = 581,["570"] = 584,["573"] = 588,["574"] = 589,["575"] = 590,["576"] = 591,["577"] = 592,["578"] = 593,["582"] = 597,["583"] = 598,["585"] = 600,["586"] = 601,["588"] = 604,["589"] = 546,["590"] = 607,["591"] = 608,["592"] = 607,["593"] = 611,["594"] = 612,["595"] = 615,["596"] = 616,["597"] = 617,["598"] = 618,["599"] = 619,["601"] = 621,["603"] = 624,["604"] = 625,["605"] = 625,["606"] = 625,["607"] = 626,["608"] = 625,["609"] = 625,["610"] = 629,["611"] = 630,["612"] = 632,["613"] = 633,["614"] = 633,["615"] = 633,["616"] = 634,["617"] = 633,["618"] = 633,["621"] = 664,["622"] = 611,["623"] = 667,["624"] = 668,["625"] = 669,["626"] = 671,["627"] = 675,["628"] = 676,["630"] = 679,["631"] = 680,["632"] = 680,["633"] = 680,["634"] = 680,["635"] = 681,["636"] = 682,["638"] = 685,["639"] = 686,["640"] = 686,["641"] = 686,["642"] = 687,["643"] = 686,["644"] = 686,["645"] = 690,["646"] = 691,["647"] = 693,["648"] = 694,["649"] = 694,["650"] = 694,["651"] = 695,["652"] = 694,["653"] = 694,["656"] = 700,["657"] = 667,["658"] = 703,["659"] = 704,["660"] = 706,["661"] = 707,["663"] = 703,["664"] = 711,["665"] = 712,["666"] = 713,["667"] = 714,["668"] = 716,["669"] = 717,["670"] = 718,["671"] = 719,["675"] = 724,["678"] = 728,["679"] = 729,["681"] = 732,["682"] = 733,["683"] = 734,["685"] = 737,["686"] = 738,["688"] = 741,["689"] = 742,["690"] = 743,["691"] = 744,["692"] = 744,["693"] = 744,["694"] = 745,["695"] = 746,["697"] = 744,["698"] = 744,["702"] = 711,["703"] = 754,["704"] = 755,["705"] = 756,["706"] = 758,["707"] = 759,["708"] = 761,["709"] = 762,["710"] = 763,["711"] = 763,["712"] = 763,["713"] = 764,["714"] = 765,["715"] = 766,["716"] = 767,["719"] = 763,["720"] = 763,["721"] = 772,["722"] = 773,["723"] = 774,["724"] = 775,["728"] = 780,["731"] = 754,["732"] = 785,["733"] = 786,["734"] = 785,["735"] = 789,["736"] = 790,["737"] = 791,["738"] = 792,["740"] = 795,["741"] = 796,["743"] = 799,["744"] = 800,["746"] = 803,["747"] = 804,["748"] = 805,["749"] = 806,["750"] = 807,["751"] = 808,["754"] = 812,["755"] = 789,["756"] = 815,["757"] = 816,["758"] = 816,["759"] = 816,["760"] = 816,["761"] = 815,["762"] = 819,["763"] = 820,["764"] = 819,["765"] = 823,["766"] = 824,["767"] = 823,["768"] = 827,["769"] = 828,["770"] = 827,["771"] = 831,["772"] = 832,["773"] = 833,["775"] = 835,["776"] = 831,["777"] = 838,["778"] = 839,["779"] = 838,["780"] = 842,["781"] = 843,["782"] = 843,["783"] = 843,["784"] = 843,["785"] = 843,["786"] = 844,["787"] = 845,["788"] = 845,["789"] = 845,["790"] = 845,["792"] = 847,["793"] = 847,["794"] = 847,["795"] = 847,["797"] = 842,["798"] = 851,["799"] = 852,["800"] = 852,["801"] = 852,["802"] = 852,["803"] = 852,["804"] = 853,["805"] = 853,["806"] = 853,["807"] = 853,["808"] = 851,["809"] = 856,["810"] = 857,["811"] = 858,["812"] = 860,["813"] = 861,["814"] = 862,["816"] = 865,["817"] = 866,["819"] = 869,["820"] = 870,["821"] = 871,["823"] = 873,["824"] = 874,["825"] = 874,["826"] = 874,["827"] = 874,["828"] = 874,["829"] = 875,["832"] = 878,["834"] = 856,["835"] = 882,["836"] = 883,["837"] = 884,["838"] = 885,["839"] = 886,["841"] = 882,["842"] = 890,["843"] = 891,["844"] = 892,["845"] = 893,["847"] = 890,["848"] = 897,["849"] = 898,["850"] = 898,["851"] = 898,["852"] = 899,["853"] = 900,["854"] = 900,["855"] = 900,["856"] = 900,["857"] = 901,["859"] = 898,["860"] = 898,["861"] = 897,["862"] = 906,["863"] = 907,["864"] = 907,["865"] = 907,["866"] = 908,["867"] = 909,["868"] = 910,["869"] = 912,["870"] = 913,["871"] = 913,["872"] = 913,["873"] = 913,["874"] = 914,["876"] = 916,["877"] = 917,["878"] = 918,["879"] = 918,["880"] = 918,["881"] = 918,["882"] = 919,["886"] = 907,["887"] = 907,["888"] = 906,["889"] = 926,["890"] = 927,["891"] = 927,["892"] = 927,["893"] = 927,["894"] = 928,["895"] = 929,["897"] = 931,["898"] = 926,["899"] = 934,["900"] = 935,["901"] = 935,["902"] = 935,["903"] = 935,["904"] = 936,["905"] = 937,["907"] = 939,["908"] = 934,["909"] = 942,["910"] = 943,["911"] = 943,["912"] = 943,["913"] = 943,["914"] = 942,["915"] = 946,["916"] = 947,["917"] = 946,["918"] = 950,["919"] = 951,["920"] = 953,["921"] = 954,["923"] = 957,["924"] = 950,["925"] = 960,["926"] = 961,["927"] = 962,["928"] = 963,["929"] = 964,["930"] = 964,["931"] = 964,["932"] = 964,["933"] = 964,["934"] = 964,["935"] = 966,["936"] = 973,["937"] = 974,["938"] = 960,["939"] = 977,["940"] = 978,["941"] = 977,["942"] = 982,["943"] = 982,["944"] = 69,["945"] = 986,["946"] = 986,["947"] = 986,["948"] = 986,["949"] = 991,["950"] = 992});
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
local NPCNames = ____wave.NPCNames
local ____settings = require("settings")
local settings = ____settings.default
local ____pre_wave = require("clases.pre_wave")
local PreWave = ____pre_wave.default
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
    self.currentWave = 0
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
    self:SetState(CustomGameState.WAVE_IN_PROGRESS)
    self.waveGroups = {{{name = NPCNames.DIRE_ZOMBIE, ammount = 15}}, {{name = NPCNames.QUEEN, ammount = 1}}, {{name = NPCNames.DIRE_ZOMBIE, ammount = 20}}, {{name = NPCNames.CENTAUR, ammount = 1}}}
    self.wave = __TS__New(Wave, self.alliances, -1, {self.waveGroups[self.currentWave + 1]})
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
                    self.wave.npcs,
                    function(____, npc)
                        if npc.unit:IsAlive() then
                            npc.unit:ForceKill(false)
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
    print(
        "Registering: ",
        unit:GetName(),
        unit:GetUnitName()
    )
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
    print(
        "Removing: ",
        unit:GetName(),
        unit:GetUnitName()
    )
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
