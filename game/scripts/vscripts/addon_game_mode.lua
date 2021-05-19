--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 19,["30"] = 19,["31"] = 20,["32"] = 20,["33"] = 20,["34"] = 21,["35"] = 21,["36"] = 22,["37"] = 22,["38"] = 22,["39"] = 23,["40"] = 23,["41"] = 24,["42"] = 24,["43"] = 25,["44"] = 25,["45"] = 26,["46"] = 26,["47"] = 48,["48"] = 53,["49"] = 53,["50"] = 53,["51"] = 53,["52"] = 53,["53"] = 58,["54"] = 58,["55"] = 58,["56"] = 58,["57"] = 58,["58"] = 63,["59"] = 64,["60"] = 65,["61"] = 66,["62"] = 68,["63"] = 70,["64"] = 71,["65"] = 70,["67"] = 72,["68"] = 73,["69"] = 74,["70"] = 75,["71"] = 76,["72"] = 78,["73"] = 81,["74"] = 85,["75"] = 86,["76"] = 89,["77"] = 89,["78"] = 89,["79"] = 89,["80"] = 89,["81"] = 89,["82"] = 89,["83"] = 91,["84"] = 92,["85"] = 93,["86"] = 94,["87"] = 95,["88"] = 97,["89"] = 98,["90"] = 99,["91"] = 100,["92"] = 88,["93"] = 104,["94"] = 105,["95"] = 106,["96"] = 107,["97"] = 108,["98"] = 109,["99"] = 110,["100"] = 111,["101"] = 112,["102"] = 113,["103"] = 114,["104"] = 116,["105"] = 117,["106"] = 118,["107"] = 119,["108"] = 120,["109"] = 121,["110"] = 123,["111"] = 124,["112"] = 125,["113"] = 127,["114"] = 128,["115"] = 129,["116"] = 130,["118"] = 104,["119"] = 134,["120"] = 135,["121"] = 134,["122"] = 138,["123"] = 139,["124"] = 139,["125"] = 139,["126"] = 139,["127"] = 140,["128"] = 140,["129"] = 140,["130"] = 140,["131"] = 141,["132"] = 141,["133"] = 141,["134"] = 141,["135"] = 142,["136"] = 142,["137"] = 142,["138"] = 142,["139"] = 144,["140"] = 145,["141"] = 146,["142"] = 147,["144"] = 150,["145"] = 150,["146"] = 150,["147"] = 151,["148"] = 152,["149"] = 152,["150"] = 152,["151"] = 153,["152"] = 152,["153"] = 152,["154"] = 150,["155"] = 150,["156"] = 138,["157"] = 158,["158"] = 159,["159"] = 160,["160"] = 161,["161"] = 163,["162"] = 164,["163"] = 165,["164"] = 167,["165"] = 167,["166"] = 167,["167"] = 168,["168"] = 169,["170"] = 171,["171"] = 172,["173"] = 175,["174"] = 176,["176"] = 167,["177"] = 167,["178"] = 158,["179"] = 181,["180"] = 182,["181"] = 183,["182"] = 221,["183"] = 223,["184"] = 223,["185"] = 223,["186"] = 224,["187"] = 225,["189"] = 227,["190"] = 228,["192"] = 223,["193"] = 223,["194"] = 181,["195"] = 233,["196"] = 234,["197"] = 235,["199"] = 237,["200"] = 239,["201"] = 240,["202"] = 240,["203"] = 240,["204"] = 241,["205"] = 242,["206"] = 243,["208"] = 240,["209"] = 240,["211"] = 248,["212"] = 233,["213"] = 251,["214"] = 252,["215"] = 253,["216"] = 254,["217"] = 255,["218"] = 256,["219"] = 257,["220"] = 258,["221"] = 259,["222"] = 260,["223"] = 261,["224"] = 262,["225"] = 264,["226"] = 265,["227"] = 266,["228"] = 267,["230"] = 269,["231"] = 251,["232"] = 272,["233"] = 273,["234"] = 274,["235"] = 275,["236"] = 276,["237"] = 277,["238"] = 272,["239"] = 280,["240"] = 281,["241"] = 282,["242"] = 283,["243"] = 284,["244"] = 280,["245"] = 287,["246"] = 288,["247"] = 288,["248"] = 288,["249"] = 288,["250"] = 288,["251"] = 289,["252"] = 289,["253"] = 289,["254"] = 289,["255"] = 289,["256"] = 290,["257"] = 290,["258"] = 290,["259"] = 290,["260"] = 290,["261"] = 291,["262"] = 291,["263"] = 291,["264"] = 291,["265"] = 291,["266"] = 292,["267"] = 292,["268"] = 292,["269"] = 292,["270"] = 292,["271"] = 293,["272"] = 293,["273"] = 293,["274"] = 293,["275"] = 293,["276"] = 295,["277"] = 287,["278"] = 298,["279"] = 299,["280"] = 299,["281"] = 299,["282"] = 300,["283"] = 301,["284"] = 302,["285"] = 303,["286"] = 304,["288"] = 299,["289"] = 299,["290"] = 308,["291"] = 308,["292"] = 308,["293"] = 308,["294"] = 308,["295"] = 312,["296"] = 312,["297"] = 312,["298"] = 313,["299"] = 314,["300"] = 316,["301"] = 317,["302"] = 319,["303"] = 320,["304"] = 322,["305"] = 323,["306"] = 324,["307"] = 325,["308"] = 327,["309"] = 328,["311"] = 331,["312"] = 332,["313"] = 333,["316"] = 312,["317"] = 312,["318"] = 338,["319"] = 338,["320"] = 338,["321"] = 339,["322"] = 340,["323"] = 342,["324"] = 343,["325"] = 345,["327"] = 346,["328"] = 346,["329"] = 347,["330"] = 348,["331"] = 349,["332"] = 350,["335"] = 346,["338"] = 355,["339"] = 356,["342"] = 360,["343"] = 361,["344"] = 361,["345"] = 361,["347"] = 338,["348"] = 338,["349"] = 365,["350"] = 365,["351"] = 365,["352"] = 366,["353"] = 367,["354"] = 369,["355"] = 370,["356"] = 371,["357"] = 372,["358"] = 373,["359"] = 374,["362"] = 365,["363"] = 365,["364"] = 298,["365"] = 380,["366"] = 381,["367"] = 382,["368"] = 383,["369"] = 384,["370"] = 385,["371"] = 386,["372"] = 387,["373"] = 380,["374"] = 390,["375"] = 391,["376"] = 392,["377"] = 393,["378"] = 394,["379"] = 395,["380"] = 396,["381"] = 397,["382"] = 398,["383"] = 399,["384"] = 400,["385"] = 401,["386"] = 403,["387"] = 404,["388"] = 405,["389"] = 406,["390"] = 407,["391"] = 408,["392"] = 409,["393"] = 410,["394"] = 411,["395"] = 412,["396"] = 413,["397"] = 414,["398"] = 415,["399"] = 416,["400"] = 417,["401"] = 419,["402"] = 420,["403"] = 421,["404"] = 422,["405"] = 423,["406"] = 424,["407"] = 425,["408"] = 426,["409"] = 427,["410"] = 429,["411"] = 431,["412"] = 390,["413"] = 434,["414"] = 435,["415"] = 434,["416"] = 438,["417"] = 439,["418"] = 439,["419"] = 439,["420"] = 439,["421"] = 439,["422"] = 445,["423"] = 438,["424"] = 448,["425"] = 449,["426"] = 451,["427"] = 451,["428"] = 451,["429"] = 452,["430"] = 452,["431"] = 452,["432"] = 453,["433"] = 454,["435"] = 452,["436"] = 452,["437"] = 451,["438"] = 451,["439"] = 459,["440"] = 448,["441"] = 462,["442"] = 463,["443"] = 464,["444"] = 465,["445"] = 467,["446"] = 468,["447"] = 469,["448"] = 469,["449"] = 469,["450"] = 469,["451"] = 469,["452"] = 470,["454"] = 472,["455"] = 473,["456"] = 474,["457"] = 475,["458"] = 476,["459"] = 478,["460"] = 479,["461"] = 480,["463"] = 483,["464"] = 484,["465"] = 485,["466"] = 487,["468"] = 490,["470"] = 462,["471"] = 494,["472"] = 495,["473"] = 496,["474"] = 497,["475"] = 498,["476"] = 499,["477"] = 494,["478"] = 502,["479"] = 503,["480"] = 504,["481"] = 505,["482"] = 507,["483"] = 508,["484"] = 509,["485"] = 511,["486"] = 512,["487"] = 513,["488"] = 515,["489"] = 516,["490"] = 517,["491"] = 519,["492"] = 520,["493"] = 521,["495"] = 523,["497"] = 526,["498"] = 527,["499"] = 528,["501"] = 502,["502"] = 532,["503"] = 533,["504"] = 534,["505"] = 536,["506"] = 536,["507"] = 536,["508"] = 537,["509"] = 537,["510"] = 537,["511"] = 537,["512"] = 537,["513"] = 537,["514"] = 536,["515"] = 536,["516"] = 540,["517"] = 532,["518"] = 543,["519"] = 544,["520"] = 545,["521"] = 553,["522"] = 554,["523"] = 555,["524"] = 555,["525"] = 555,["526"] = 555,["527"] = 555,["528"] = 555,["529"] = 555,["530"] = 555,["531"] = 556,["532"] = 543,["533"] = 559,["534"] = 560,["535"] = 561,["536"] = 562,["538"] = 559,["539"] = 566,["540"] = 567,["541"] = 566,["542"] = 570,["543"] = 571,["544"] = 573,["545"] = 578,["546"] = 579,["547"] = 580,["548"] = 581,["549"] = 583,["550"] = 584,["551"] = 585,["553"] = 588,["554"] = 589,["555"] = 594,["556"] = 594,["557"] = 594,["558"] = 595,["559"] = 595,["560"] = 595,["561"] = 596,["562"] = 596,["563"] = 596,["564"] = 596,["565"] = 598,["566"] = 599,["568"] = 602,["569"] = 603,["570"] = 603,["571"] = 603,["572"] = 604,["573"] = 605,["575"] = 608,["578"] = 612,["579"] = 613,["580"] = 614,["581"] = 615,["582"] = 616,["583"] = 617,["587"] = 621,["588"] = 622,["590"] = 624,["591"] = 625,["593"] = 628,["594"] = 570,["595"] = 631,["596"] = 632,["597"] = 631,["598"] = 635,["599"] = 636,["600"] = 639,["601"] = 640,["602"] = 641,["603"] = 642,["604"] = 643,["606"] = 645,["608"] = 648,["609"] = 649,["610"] = 649,["611"] = 649,["612"] = 650,["613"] = 649,["614"] = 649,["615"] = 653,["616"] = 654,["617"] = 656,["618"] = 657,["619"] = 657,["620"] = 657,["621"] = 658,["622"] = 657,["623"] = 657,["626"] = 688,["627"] = 635,["628"] = 691,["629"] = 692,["630"] = 693,["631"] = 695,["632"] = 699,["633"] = 700,["635"] = 703,["636"] = 704,["637"] = 704,["638"] = 704,["639"] = 704,["640"] = 705,["641"] = 706,["643"] = 709,["644"] = 710,["645"] = 710,["646"] = 710,["647"] = 711,["648"] = 710,["649"] = 710,["650"] = 714,["651"] = 715,["652"] = 717,["653"] = 718,["654"] = 718,["655"] = 718,["656"] = 719,["657"] = 718,["658"] = 718,["661"] = 724,["662"] = 691,["663"] = 727,["664"] = 728,["665"] = 730,["666"] = 731,["668"] = 727,["669"] = 735,["670"] = 736,["671"] = 737,["672"] = 738,["673"] = 740,["674"] = 741,["675"] = 742,["676"] = 743,["680"] = 748,["683"] = 752,["684"] = 753,["686"] = 756,["687"] = 757,["688"] = 758,["690"] = 761,["691"] = 762,["693"] = 765,["694"] = 766,["695"] = 767,["696"] = 768,["697"] = 768,["698"] = 768,["699"] = 769,["700"] = 770,["702"] = 768,["703"] = 768,["707"] = 735,["708"] = 778,["709"] = 779,["710"] = 780,["711"] = 782,["712"] = 783,["713"] = 785,["714"] = 786,["715"] = 787,["716"] = 787,["717"] = 787,["718"] = 788,["719"] = 789,["720"] = 790,["721"] = 791,["724"] = 787,["725"] = 787,["726"] = 796,["727"] = 797,["728"] = 798,["729"] = 799,["733"] = 804,["736"] = 778,["737"] = 809,["738"] = 810,["739"] = 809,["740"] = 813,["741"] = 814,["742"] = 815,["743"] = 816,["745"] = 819,["746"] = 820,["748"] = 823,["749"] = 824,["751"] = 827,["752"] = 828,["753"] = 829,["754"] = 830,["755"] = 831,["756"] = 832,["759"] = 836,["760"] = 813,["761"] = 839,["762"] = 840,["763"] = 840,["764"] = 840,["765"] = 840,["766"] = 839,["767"] = 843,["768"] = 844,["769"] = 843,["770"] = 847,["771"] = 848,["772"] = 847,["773"] = 851,["774"] = 852,["775"] = 851,["776"] = 855,["777"] = 856,["778"] = 857,["780"] = 859,["781"] = 855,["782"] = 862,["783"] = 863,["784"] = 862,["785"] = 866,["786"] = 867,["787"] = 868,["788"] = 868,["789"] = 868,["790"] = 868,["792"] = 870,["793"] = 870,["794"] = 870,["795"] = 870,["797"] = 866,["798"] = 874,["799"] = 875,["800"] = 875,["801"] = 875,["802"] = 875,["803"] = 874,["804"] = 878,["805"] = 879,["806"] = 880,["807"] = 882,["808"] = 883,["809"] = 884,["811"] = 887,["812"] = 888,["814"] = 891,["815"] = 892,["816"] = 893,["818"] = 895,["819"] = 896,["820"] = 896,["821"] = 896,["822"] = 896,["823"] = 896,["824"] = 897,["827"] = 900,["829"] = 878,["830"] = 904,["831"] = 905,["832"] = 906,["833"] = 907,["834"] = 908,["836"] = 904,["837"] = 912,["838"] = 913,["839"] = 914,["840"] = 916,["841"] = 917,["843"] = 920,["844"] = 921,["847"] = 912,["848"] = 926,["849"] = 927,["850"] = 927,["851"] = 927,["852"] = 928,["853"] = 929,["854"] = 929,["855"] = 929,["856"] = 929,["857"] = 930,["859"] = 927,["860"] = 927,["861"] = 926,["862"] = 935,["863"] = 936,["864"] = 936,["865"] = 936,["866"] = 937,["867"] = 938,["868"] = 939,["869"] = 941,["870"] = 942,["871"] = 942,["872"] = 942,["873"] = 942,["874"] = 943,["876"] = 945,["877"] = 946,["878"] = 947,["879"] = 947,["880"] = 947,["881"] = 947,["882"] = 948,["886"] = 936,["887"] = 936,["888"] = 935,["889"] = 955,["890"] = 956,["891"] = 956,["892"] = 956,["893"] = 956,["894"] = 957,["895"] = 958,["897"] = 960,["898"] = 955,["899"] = 963,["900"] = 964,["901"] = 964,["902"] = 964,["903"] = 964,["904"] = 965,["905"] = 966,["907"] = 968,["908"] = 963,["909"] = 971,["910"] = 972,["911"] = 972,["912"] = 972,["913"] = 972,["914"] = 971,["915"] = 975,["916"] = 976,["917"] = 975,["918"] = 979,["919"] = 980,["920"] = 982,["921"] = 983,["923"] = 986,["924"] = 979,["925"] = 989,["926"] = 990,["927"] = 991,["928"] = 992,["929"] = 993,["930"] = 993,["931"] = 993,["932"] = 993,["933"] = 993,["934"] = 993,["935"] = 995,["936"] = 1002,["937"] = 1003,["938"] = 989,["939"] = 1006,["940"] = 1007,["941"] = 1006,["942"] = 1011,["943"] = 1011,["944"] = 70,["945"] = 1015,["946"] = 1015,["947"] = 1015,["948"] = 1015,["949"] = 1020,["950"] = 1021});
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
    self.waveGroups = {{{name = NPCNames.FLYING_SKULL, ammount = 5}, {name = NPCNames.DIRE_ZOMBIE, ammount = 8}, {name = NPCNames.DIRE_ZOMBIE_RAGER, ammount = 3}, {name = NPCNames.DIRE_ZOMBIE_MEELE, ammount = 3}}, {{name = NPCNames.QUEEN, ammount = 1}, {name = NPCNames.FLYING_SKULL, ammount = 5}}, {{name = NPCNames.DIRE_ZOMBIE, ammount = 8}, {name = NPCNames.DIRE_ZOMBIE_RAGER, ammount = 6}, {name = NPCNames.DIRE_ZOMBIE_MEELE, ammount = 8}}, {{name = NPCNames.CENTAUR, ammount = 1}}}
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
    LinkLuaModifier("modifier_generic_meele_npc", "abilities/generic/modifier_generic_meele_npc", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_phased", "abilities/generic/modifier_generic_phased", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_flying", "abilities/generic/modifier_generic_flying", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_generic_ignore_ms_limit", "abilities/generic/modifier_generic_ignore_ms_limit", LUA_MODIFIER_MOTION_NONE)
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
