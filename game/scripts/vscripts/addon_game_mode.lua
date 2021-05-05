--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 19,["30"] = 19,["31"] = 21,["32"] = 21,["33"] = 22,["34"] = 22,["35"] = 22,["36"] = 23,["37"] = 23,["38"] = 23,["39"] = 24,["40"] = 24,["41"] = 25,["42"] = 25,["43"] = 47,["44"] = 52,["45"] = 52,["46"] = 52,["47"] = 52,["48"] = 52,["49"] = 57,["50"] = 57,["51"] = 57,["52"] = 57,["53"] = 57,["54"] = 62,["55"] = 63,["56"] = 64,["57"] = 65,["58"] = 67,["60"] = 70,["63"] = 71,["64"] = 72,["65"] = 73,["66"] = 74,["67"] = 75,["68"] = 77,["69"] = 80,["70"] = 84,["71"] = 85,["72"] = 88,["73"] = 88,["74"] = 88,["75"] = 88,["76"] = 88,["77"] = 88,["78"] = 88,["79"] = 90,["80"] = 91,["81"] = 92,["82"] = 93,["83"] = 94,["84"] = 96,["85"] = 97,["86"] = 98,["87"] = 99,["88"] = 87,["89"] = 103,["90"] = 104,["91"] = 105,["92"] = 106,["93"] = 107,["94"] = 108,["95"] = 109,["96"] = 110,["97"] = 111,["98"] = 112,["99"] = 113,["100"] = 115,["101"] = 116,["102"] = 117,["103"] = 118,["104"] = 119,["105"] = 120,["106"] = 122,["107"] = 123,["108"] = 124,["109"] = 126,["110"] = 127,["111"] = 128,["112"] = 129,["114"] = 103,["115"] = 133,["116"] = 134,["117"] = 133,["120"] = 138,["121"] = 138,["124"] = 139,["125"] = 139,["128"] = 140,["129"] = 140,["132"] = 141,["133"] = 141,["135"] = 143,["136"] = 144,["137"] = 145,["138"] = 146,["140"] = 149,["141"] = 149,["142"] = 149,["143"] = 150,["144"] = 149,["145"] = 149,["147"] = 154,["148"] = 155,["149"] = 156,["150"] = 157,["151"] = 159,["152"] = 160,["153"] = 161,["154"] = 163,["155"] = 163,["156"] = 163,["157"] = 164,["158"] = 165,["160"] = 167,["161"] = 168,["163"] = 171,["164"] = 172,["166"] = 163,["167"] = 163,["168"] = 154,["169"] = 177,["170"] = 178,["171"] = 179,["172"] = 198,["173"] = 200,["174"] = 200,["175"] = 200,["176"] = 201,["177"] = 202,["179"] = 204,["180"] = 205,["182"] = 200,["183"] = 200,["184"] = 177,["186"] = 211,["187"] = 212,["189"] = 214,["190"] = 216,["191"] = 217,["192"] = 217,["193"] = 217,["194"] = 218,["195"] = 219,["196"] = 220,["198"] = 217,["199"] = 217,["201"] = 225,["203"] = 228,["204"] = 229,["205"] = 230,["206"] = 231,["207"] = 232,["208"] = 233,["209"] = 234,["210"] = 235,["211"] = 236,["212"] = 237,["213"] = 238,["214"] = 239,["215"] = 241,["216"] = 242,["217"] = 243,["218"] = 244,["220"] = 246,["221"] = 228,["223"] = 250,["224"] = 251,["225"] = 252,["226"] = 253,["227"] = 254,["230"] = 258,["231"] = 259,["232"] = 260,["233"] = 261,["235"] = 264,["236"] = 265,["237"] = 265,["238"] = 265,["239"] = 265,["240"] = 265,["241"] = 266,["242"] = 266,["243"] = 266,["244"] = 266,["245"] = 266,["246"] = 267,["247"] = 267,["248"] = 267,["249"] = 267,["250"] = 267,["251"] = 268,["252"] = 268,["253"] = 268,["254"] = 268,["255"] = 268,["256"] = 269,["257"] = 269,["258"] = 269,["259"] = 269,["260"] = 269,["261"] = 270,["262"] = 270,["263"] = 270,["264"] = 270,["265"] = 270,["266"] = 272,["267"] = 264,["268"] = 275,["269"] = 276,["270"] = 276,["271"] = 276,["272"] = 277,["273"] = 278,["274"] = 279,["275"] = 280,["276"] = 281,["278"] = 276,["279"] = 276,["280"] = 285,["281"] = 285,["282"] = 285,["283"] = 285,["284"] = 285,["285"] = 289,["286"] = 289,["287"] = 289,["288"] = 290,["289"] = 291,["290"] = 293,["291"] = 294,["292"] = 296,["293"] = 297,["294"] = 299,["295"] = 300,["296"] = 301,["297"] = 302,["298"] = 304,["299"] = 305,["301"] = 308,["302"] = 309,["303"] = 310,["306"] = 289,["307"] = 289,["308"] = 315,["309"] = 315,["310"] = 315,["311"] = 316,["312"] = 317,["313"] = 319,["314"] = 320,["315"] = 322,["317"] = 323,["318"] = 323,["319"] = 324,["320"] = 325,["321"] = 326,["322"] = 327,["325"] = 323,["328"] = 332,["329"] = 333,["332"] = 337,["333"] = 338,["334"] = 338,["335"] = 338,["337"] = 315,["338"] = 315,["339"] = 342,["340"] = 342,["341"] = 342,["342"] = 343,["343"] = 344,["344"] = 346,["345"] = 347,["346"] = 348,["347"] = 349,["348"] = 350,["349"] = 351,["352"] = 342,["353"] = 342,["354"] = 275,["355"] = 357,["356"] = 358,["357"] = 359,["358"] = 360,["359"] = 361,["360"] = 362,["361"] = 363,["362"] = 364,["363"] = 357,["365"] = 368,["366"] = 369,["367"] = 370,["368"] = 371,["369"] = 372,["370"] = 373,["371"] = 374,["372"] = 375,["373"] = 376,["374"] = 377,["375"] = 378,["376"] = 380,["377"] = 381,["378"] = 382,["379"] = 383,["380"] = 384,["381"] = 385,["382"] = 386,["383"] = 387,["384"] = 388,["385"] = 389,["386"] = 390,["387"] = 392,["388"] = 393,["389"] = 394,["390"] = 395,["391"] = 396,["392"] = 397,["393"] = 398,["394"] = 399,["395"] = 401,["396"] = 403,["398"] = 406,["399"] = 407,["400"] = 406,["401"] = 410,["402"] = 411,["403"] = 411,["404"] = 411,["405"] = 411,["406"] = 411,["407"] = 417,["408"] = 410,["409"] = 420,["410"] = 421,["411"] = 423,["412"] = 423,["413"] = 423,["414"] = 424,["415"] = 424,["416"] = 424,["417"] = 425,["418"] = 426,["420"] = 424,["421"] = 424,["422"] = 423,["423"] = 423,["424"] = 431,["425"] = 420,["426"] = 434,["427"] = 435,["428"] = 436,["429"] = 437,["430"] = 439,["431"] = 440,["432"] = 441,["433"] = 441,["434"] = 441,["435"] = 441,["436"] = 441,["437"] = 442,["439"] = 444,["440"] = 445,["441"] = 446,["442"] = 447,["443"] = 448,["444"] = 450,["445"] = 451,["446"] = 452,["448"] = 455,["449"] = 456,["450"] = 457,["451"] = 459,["453"] = 462,["455"] = 434,["456"] = 466,["457"] = 467,["458"] = 466,["459"] = 470,["460"] = 471,["461"] = 472,["462"] = 473,["463"] = 474,["464"] = 475,["465"] = 470,["466"] = 478,["467"] = 479,["468"] = 480,["469"] = 481,["470"] = 483,["471"] = 484,["472"] = 485,["473"] = 487,["474"] = 488,["475"] = 489,["476"] = 491,["477"] = 492,["478"] = 493,["479"] = 495,["480"] = 496,["481"] = 497,["483"] = 499,["485"] = 502,["486"] = 503,["487"] = 504,["489"] = 478,["490"] = 508,["491"] = 509,["492"] = 510,["493"] = 512,["494"] = 512,["495"] = 512,["496"] = 513,["497"] = 513,["498"] = 513,["499"] = 513,["500"] = 513,["501"] = 513,["502"] = 512,["503"] = 512,["504"] = 516,["505"] = 508,["506"] = 519,["507"] = 520,["508"] = 521,["509"] = 529,["510"] = 530,["511"] = 531,["512"] = 531,["513"] = 531,["514"] = 531,["515"] = 531,["516"] = 531,["517"] = 531,["518"] = 531,["519"] = 532,["521"] = 535,["522"] = 536,["523"] = 537,["524"] = 538,["526"] = 535,["527"] = 542,["528"] = 543,["529"] = 542,["530"] = 546,["531"] = 547,["532"] = 549,["533"] = 554,["534"] = 555,["535"] = 556,["536"] = 557,["537"] = 559,["538"] = 560,["539"] = 561,["541"] = 564,["542"] = 565,["543"] = 570,["544"] = 570,["545"] = 570,["546"] = 571,["547"] = 571,["548"] = 571,["549"] = 572,["550"] = 572,["551"] = 572,["552"] = 572,["553"] = 574,["554"] = 575,["556"] = 578,["557"] = 579,["558"] = 579,["559"] = 579,["560"] = 580,["561"] = 581,["563"] = 584,["566"] = 588,["567"] = 589,["568"] = 590,["569"] = 591,["570"] = 592,["571"] = 593,["575"] = 597,["576"] = 598,["578"] = 600,["579"] = 601,["581"] = 604,["583"] = 607,["584"] = 608,["585"] = 607,["586"] = 611,["587"] = 612,["588"] = 615,["589"] = 616,["590"] = 617,["591"] = 618,["592"] = 619,["594"] = 621,["596"] = 624,["597"] = 625,["598"] = 625,["599"] = 625,["600"] = 626,["601"] = 625,["602"] = 625,["603"] = 629,["604"] = 630,["605"] = 632,["606"] = 633,["607"] = 633,["608"] = 633,["609"] = 634,["610"] = 633,["611"] = 633,["614"] = 664,["615"] = 611,["616"] = 667,["617"] = 668,["618"] = 669,["619"] = 671,["620"] = 675,["621"] = 676,["623"] = 679,["624"] = 680,["625"] = 680,["626"] = 680,["627"] = 680,["628"] = 681,["629"] = 682,["631"] = 685,["632"] = 686,["633"] = 686,["634"] = 686,["635"] = 687,["636"] = 686,["637"] = 686,["638"] = 690,["639"] = 691,["640"] = 693,["641"] = 694,["642"] = 694,["643"] = 694,["644"] = 695,["645"] = 694,["646"] = 694,["649"] = 700,["650"] = 667,["652"] = 705,["653"] = 707,["654"] = 708,["657"] = 712,["658"] = 713,["659"] = 714,["660"] = 715,["661"] = 717,["662"] = 718,["663"] = 719,["664"] = 720,["668"] = 725,["671"] = 729,["672"] = 730,["674"] = 733,["675"] = 734,["676"] = 735,["678"] = 738,["679"] = 739,["681"] = 742,["682"] = 743,["683"] = 744,["684"] = 745,["685"] = 745,["686"] = 745,["687"] = 746,["688"] = 747,["690"] = 745,["691"] = 745,["695"] = 712,["696"] = 755,["697"] = 756,["698"] = 757,["699"] = 759,["700"] = 760,["701"] = 762,["702"] = 763,["703"] = 764,["704"] = 764,["705"] = 764,["706"] = 765,["707"] = 766,["708"] = 767,["709"] = 768,["712"] = 764,["713"] = 764,["714"] = 773,["715"] = 774,["716"] = 775,["717"] = 776,["721"] = 781,["724"] = 755,["725"] = 786,["726"] = 787,["727"] = 786,["728"] = 790,["729"] = 791,["730"] = 792,["731"] = 793,["733"] = 796,["734"] = 797,["735"] = 798,["736"] = 799,["737"] = 800,["738"] = 801,["739"] = 802,["740"] = 803,["743"] = 806,["744"] = 807,["745"] = 808,["746"] = 809,["747"] = 810,["748"] = 811,["753"] = 817,["754"] = 790,["755"] = 820,["756"] = 821,["757"] = 820,["758"] = 824,["759"] = 825,["760"] = 824,["761"] = 828,["762"] = 829,["763"] = 828,["764"] = 832,["765"] = 833,["766"] = 834,["767"] = 835,["770"] = 838,["772"] = 841,["773"] = 842,["774"] = 843,["776"] = 845,["777"] = 841,["778"] = 848,["779"] = 849,["780"] = 851,["782"] = 855,["783"] = 856,["784"] = 857,["785"] = 858,["786"] = 859,["787"] = 860,["790"] = 863,["791"] = 864,["792"] = 865,["796"] = 848,["797"] = 871,["798"] = 871,["799"] = 888,["800"] = 889,["801"] = 890,["802"] = 891,["803"] = 892,["805"] = 888,["806"] = 896,["807"] = 897,["808"] = 898,["809"] = 899,["811"] = 896,["812"] = 903,["813"] = 904,["814"] = 904,["815"] = 904,["816"] = 905,["817"] = 906,["818"] = 906,["819"] = 906,["820"] = 906,["821"] = 907,["823"] = 904,["824"] = 904,["825"] = 903,["826"] = 912,["827"] = 913,["828"] = 913,["829"] = 913,["830"] = 914,["831"] = 915,["832"] = 916,["833"] = 918,["834"] = 919,["835"] = 919,["836"] = 919,["837"] = 919,["838"] = 920,["840"] = 922,["841"] = 923,["842"] = 924,["843"] = 924,["844"] = 924,["845"] = 924,["846"] = 925,["850"] = 913,["851"] = 913,["852"] = 912,["853"] = 932,["854"] = 933,["855"] = 933,["856"] = 933,["857"] = 933,["858"] = 934,["859"] = 935,["861"] = 937,["862"] = 932,["863"] = 940,["864"] = 941,["865"] = 941,["866"] = 941,["867"] = 941,["868"] = 942,["869"] = 943,["871"] = 945,["872"] = 940,["873"] = 948,["874"] = 949,["875"] = 949,["876"] = 949,["877"] = 949,["878"] = 948,["879"] = 952,["880"] = 953,["881"] = 952,["882"] = 956,["883"] = 957,["884"] = 959,["885"] = 960,["887"] = 963,["888"] = 956,["889"] = 966,["890"] = 967,["891"] = 968,["892"] = 969,["893"] = 970,["894"] = 970,["895"] = 970,["896"] = 970,["897"] = 970,["898"] = 970,["899"] = 972,["900"] = 979,["901"] = 980,["902"] = 966,["903"] = 983,["904"] = 984,["905"] = 983,["906"] = 988,["907"] = 988,["908"] = 69,["909"] = 992,["910"] = 992,["911"] = 992,["912"] = 992,["913"] = 997,["914"] = 998});
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
require("util.custom_entities")
require("util.math")
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
local Custom_ActionTypes = {}
Custom_ActionTypes.MOVEMENT = 0
Custom_ActionTypes[Custom_ActionTypes.MOVEMENT] = "MOVEMENT"
Custom_ActionTypes.ABILITY = 1
Custom_ActionTypes[Custom_ActionTypes.ABILITY] = "ABILITY"
local Custom_ActionModes = {}
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
    self.state = CustomGameState.NONE
    self.thinkers = {}
    self.wtf = false
    self.units = {}
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
        function(self)
            CustomGameEventManager:Send_ServerToAllClients("get_mouse_position", {})
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
    self.waveGroups = {{name = NPCNames.DIRE_ZOMBIE, ammount = 20}, {name = NPCNames.QUEEN, ammount = 1}, {name = NPCNames.DIRE_ZOMBIE, ammount = 40}, {name = NPCNames.CENTAUR, ammount = 1}}
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
                    local currentDirection = CustomEntities:GetRawDirection(hero)
                    local incomingDirection = event.payload.direction
                    local vector = Vector(incomingDirection["0"], incomingDirection["1"], 0)
                    if mode == Custom_ActionModes.STOP then
                        vector = vector:__mul(-1)
                    end
                    local newDirection = currentDirection:__add(vector)
                    newDirection.z = hero:GetForwardVector().z
                    CustomEntities:SetDirection(hero, newDirection.x, newDirection.y)
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
                    CustomEntities:SendDataToClient(hero)
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
function GameMode.prototype.RegisterUnit(self, unit)
    __TS__ArrayPush(self.units, unit)
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
        local energy = CustomEntities:GetEnergy(caster)
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
                CustomEntities:FullyFaceTowards(caster, direction)
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
        local new_treshold = CustomEntities:GetTreshold(target) + event.heal
        if new_treshold > self.max_treshold then
            event.heal = self.max_treshold - CustomEntities:GetTreshold(target)
            CustomEntities:SetTreshold(target, self.max_treshold)
        else
            CustomEntities:SetTreshold(target, new_treshold)
        end
        SendOverheadHealMessage(target, event.heal)
        Timers:CreateTimer(
            0.05,
            function()
                CustomEntities:SendDataToClient(target)
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
        CustomEntities:SetTreshold(
            victim,
            CustomEntities:GetTreshold(victim) - damage_after_reductions
        )
        if CustomEntities:GetTreshold(victim) < 0 then
            CustomEntities:SetTreshold(victim, 0)
        end
        victim:AddNewModifier(victim, nil, "modifier_damage_fx", {duration = 0.1})
        Timers:CreateTimer(
            0.05,
            function()
                CustomEntities:SendDataToClient(victim)
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
                CustomEntities:SetDirection(hero, 0, 0)
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
                        if npc:GetUnit():IsAlive() then
                            npc:GetUnit():ForceKill(false)
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
            CustomEntities:SendDataToClient(hero)
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
    if not CustomEntities:IsInitialized(npc) then
        if not (npc:GetName() == "npc_dota_thinker") then
            if npc:IsRealHero() then
                CustomEntities:Initialize(npc)
                if self:IsPVP() then
                    return self:OnHeroInGamePVP(npc)
                elseif self:IsPVE() then
                    return self:OnHeroInGamePVE(npc)
                end
            else
                if self:IsPVP() then
                    CustomEntities:Initialize(npc)
                    return true
                elseif self:IsPVE() then
                    CustomEntities:Initialize(npc, true)
                    return true
                end
            end
        end
    end
    return true
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
        if not self:RegisterPlayer(hero) then
            return false
        end
    end
    return true
end
function GameMode.prototype.OnHeroInGamePVP(self, hero)
    if not self:RegisterPlayer(hero) then
        return false
    end
    return true
end
function GameMode.prototype.OnEntityKilled(self, event)
    local killed = EntIndexToHScript(event.entindex_killed)
    if GetMapName() == Custom_MapNames.PVE then
    end
    local parent = CustomEntities:GetParent(killed)
    if parent then
        local killer = EntIndexToHScript(event.entindex_attacker)
        parent:OnDeath({killer = killer})
        if self:IsPVE() and self.wave then
            self.wave.aliveNpcs = self.wave.aliveNpcs - 1
        end
    else
        if killed:IsRealHero() then
            if self:IsPVP() then
                self:OnEntityKilledPVP(killed)
            end
        end
    end
end
function GameMode.prototype.OnEntityKilledPVE(self, killed)
end
function GameMode.prototype.OnEntityKilledPVP(self, killed)
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
                CustomEntities:GiveEnergy(
                    player.hero,
                    CustomEntities:GetMaxEnergy(player.hero)
                )
                CustomEntities:SendDataToClient(player.hero)
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
____exports.GameMode = __TS__Decorate({reloadable}, ____exports.GameMode)
__TS__ObjectAssign(
    getfenv(),
    {Activate = ____exports.GameMode.Activate, Precache = ____exports.GameMode.Precache}
)
if GameRules.Addon then
    GameRules.Addon:Reload()
end
return ____exports
