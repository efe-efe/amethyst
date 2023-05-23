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
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["16"] = 1,["17"] = 2,["18"] = 2,["19"] = 3,["20"] = 3,["21"] = 4,["22"] = 4,["23"] = 5,["24"] = 5,["25"] = 6,["26"] = 7,["27"] = 8,["28"] = 9,["29"] = 10,["30"] = 11,["31"] = 12,["32"] = 13,["33"] = 14,["34"] = 15,["35"] = 16,["36"] = 17,["37"] = 17,["38"] = 18,["39"] = 18,["40"] = 19,["41"] = 19,["42"] = 20,["43"] = 20,["44"] = 21,["45"] = 22,["46"] = 24,["47"] = 24,["48"] = 25,["49"] = 25,["50"] = 25,["51"] = 26,["52"] = 26,["53"] = 27,["54"] = 27,["55"] = 28,["56"] = 28,["57"] = 29,["58"] = 29,["59"] = 30,["60"] = 30,["61"] = 31,["62"] = 31,["63"] = 32,["64"] = 32,["65"] = 54,["66"] = 59,["67"] = 59,["68"] = 59,["69"] = 59,["70"] = 59,["71"] = 64,["72"] = 64,["73"] = 64,["74"] = 64,["75"] = 64,["76"] = 69,["77"] = 70,["78"] = 71,["79"] = 72,["80"] = 73,["81"] = 75,["82"] = 77,["83"] = 78,["84"] = 77,["86"] = 79,["87"] = 80,["88"] = 82,["89"] = 83,["90"] = 84,["91"] = 86,["92"] = 92,["93"] = 93,["94"] = 96,["95"] = 96,["96"] = 98,["97"] = 99,["98"] = 96,["99"] = 96,["100"] = 96,["101"] = 104,["102"] = 105,["103"] = 106,["104"] = 107,["105"] = 108,["106"] = 110,["107"] = 111,["108"] = 112,["109"] = 113,["110"] = 95,["111"] = 117,["112"] = 118,["113"] = 123,["114"] = 128,["115"] = 133,["116"] = 138,["117"] = 143,["118"] = 148,["119"] = 153,["120"] = 158,["121"] = 163,["122"] = 169,["123"] = 174,["124"] = 179,["125"] = 184,["126"] = 189,["127"] = 194,["128"] = 200,["129"] = 205,["130"] = 210,["131"] = 216,["132"] = 217,["133"] = 218,["134"] = 219,["136"] = 117,["137"] = 223,["138"] = 224,["139"] = 223,["140"] = 227,["141"] = 228,["142"] = 228,["143"] = 229,["144"] = 229,["145"] = 232,["146"] = 232,["147"] = 239,["148"] = 239,["149"] = 242,["150"] = 242,["151"] = 246,["152"] = 247,["153"] = 248,["154"] = 249,["156"] = 252,["157"] = 252,["158"] = 252,["159"] = 253,["160"] = 257,["161"] = 257,["162"] = 257,["163"] = 258,["164"] = 257,["165"] = 257,["166"] = 252,["167"] = 252,["168"] = 227,["169"] = 263,["170"] = 264,["171"] = 265,["172"] = 266,["173"] = 268,["174"] = 269,["175"] = 270,["176"] = 272,["177"] = 272,["178"] = 272,["179"] = 273,["180"] = 274,["182"] = 276,["183"] = 277,["185"] = 279,["186"] = 280,["188"] = 272,["189"] = 272,["190"] = 263,["191"] = 285,["192"] = 286,["193"] = 287,["194"] = 289,["195"] = 289,["196"] = 289,["197"] = 290,["198"] = 291,["200"] = 293,["201"] = 294,["203"] = 289,["204"] = 289,["205"] = 285,["206"] = 299,["207"] = 300,["208"] = 301,["210"] = 303,["211"] = 305,["212"] = 306,["213"] = 306,["214"] = 306,["215"] = 307,["216"] = 308,["217"] = 309,["219"] = 306,["220"] = 306,["222"] = 314,["223"] = 299,["224"] = 317,["225"] = 318,["226"] = 319,["227"] = 320,["228"] = 321,["229"] = 322,["230"] = 323,["231"] = 324,["232"] = 325,["233"] = 326,["234"] = 327,["235"] = 328,["236"] = 330,["237"] = 331,["238"] = 332,["239"] = 333,["241"] = 335,["242"] = 317,["243"] = 338,["244"] = 339,["245"] = 340,["246"] = 341,["247"] = 342,["248"] = 343,["249"] = 338,["250"] = 346,["251"] = 347,["252"] = 348,["253"] = 349,["254"] = 350,["255"] = 346,["256"] = 353,["257"] = 354,["258"] = 354,["259"] = 354,["260"] = 354,["261"] = 354,["262"] = 359,["263"] = 359,["264"] = 359,["265"] = 359,["266"] = 359,["267"] = 364,["268"] = 364,["269"] = 364,["270"] = 364,["271"] = 364,["272"] = 369,["273"] = 369,["274"] = 369,["275"] = 369,["276"] = 369,["277"] = 374,["278"] = 374,["279"] = 374,["280"] = 374,["281"] = 374,["282"] = 379,["283"] = 379,["284"] = 379,["285"] = 379,["286"] = 379,["287"] = 384,["288"] = 353,["289"] = 387,["290"] = 388,["291"] = 388,["292"] = 390,["293"] = 391,["294"] = 392,["295"] = 393,["296"] = 394,["297"] = 395,["299"] = 388,["300"] = 388,["301"] = 400,["302"] = 400,["303"] = 402,["304"] = 403,["305"] = 404,["306"] = 406,["307"] = 407,["308"] = 408,["309"] = 410,["310"] = 411,["311"] = 413,["312"] = 414,["313"] = 415,["314"] = 416,["315"] = 422,["316"] = 423,["318"] = 426,["319"] = 427,["320"] = 428,["322"] = 435,["323"] = 436,["324"] = 437,["325"] = 440,["326"] = 441,["331"] = 400,["332"] = 400,["333"] = 449,["334"] = 449,["335"] = 451,["336"] = 452,["337"] = 453,["338"] = 455,["339"] = 456,["340"] = 458,["342"] = 459,["343"] = 459,["344"] = 460,["345"] = 461,["346"] = 462,["347"] = 463,["350"] = 459,["353"] = 468,["354"] = 469,["357"] = 473,["358"] = 474,["360"] = 449,["361"] = 449,["362"] = 479,["363"] = 479,["364"] = 481,["365"] = 482,["366"] = 483,["367"] = 485,["368"] = 486,["369"] = 487,["370"] = 488,["371"] = 489,["372"] = 490,["375"] = 479,["376"] = 479,["377"] = 387,["378"] = 497,["379"] = 498,["380"] = 499,["381"] = 500,["382"] = 501,["383"] = 502,["384"] = 503,["385"] = 504,["386"] = 497,["387"] = 507,["388"] = 508,["389"] = 513,["390"] = 518,["391"] = 523,["392"] = 528,["393"] = 533,["394"] = 539,["395"] = 544,["396"] = 549,["397"] = 554,["398"] = 559,["399"] = 565,["400"] = 570,["401"] = 575,["402"] = 580,["403"] = 585,["404"] = 590,["405"] = 595,["406"] = 600,["407"] = 605,["408"] = 610,["409"] = 615,["410"] = 620,["411"] = 625,["412"] = 630,["413"] = 635,["414"] = 640,["415"] = 645,["416"] = 650,["417"] = 655,["418"] = 661,["419"] = 666,["420"] = 671,["421"] = 676,["422"] = 681,["423"] = 687,["424"] = 688,["425"] = 693,["426"] = 698,["427"] = 704,["428"] = 705,["429"] = 706,["430"] = 708,["431"] = 708,["432"] = 708,["433"] = 709,["434"] = 710,["435"] = 711,["437"] = 717,["438"] = 718,["440"] = 724,["441"] = 725,["444"] = 708,["445"] = 708,["446"] = 733,["447"] = 738,["448"] = 743,["449"] = 748,["450"] = 753,["452"] = 760,["453"] = 507,["454"] = 763,["455"] = 764,["456"] = 763,["457"] = 767,["458"] = 768,["459"] = 768,["460"] = 768,["461"] = 768,["462"] = 768,["463"] = 774,["464"] = 774,["465"] = 767,["466"] = 777,["467"] = 778,["468"] = 780,["469"] = 780,["470"] = 780,["471"] = 781,["472"] = 781,["473"] = 781,["474"] = 782,["475"] = 783,["477"] = 781,["478"] = 781,["479"] = 780,["480"] = 780,["481"] = 788,["482"] = 777,["483"] = 791,["484"] = 795,["485"] = 796,["486"] = 797,["487"] = 799,["488"] = 800,["489"] = 801,["490"] = 809,["492"] = 811,["493"] = 812,["494"] = 813,["495"] = 814,["496"] = 814,["497"] = 815,["498"] = 817,["499"] = 818,["500"] = 819,["502"] = 822,["503"] = 823,["504"] = 824,["505"] = 825,["506"] = 827,["508"] = 830,["510"] = 791,["511"] = 834,["512"] = 835,["513"] = 836,["514"] = 837,["515"] = 838,["516"] = 839,["517"] = 834,["518"] = 842,["519"] = 843,["520"] = 844,["521"] = 845,["522"] = 846,["523"] = 847,["524"] = 848,["525"] = 849,["526"] = 850,["527"] = 851,["528"] = 852,["529"] = 853,["530"] = 854,["531"] = 856,["532"] = 856,["533"] = 856,["534"] = 856,["535"] = 856,["536"] = 856,["537"] = 854,["538"] = 874,["539"] = 875,["540"] = 876,["542"] = 842,["543"] = 880,["544"] = 881,["545"] = 882,["546"] = 884,["547"] = 884,["548"] = 884,["549"] = 885,["550"] = 884,["551"] = 884,["552"] = 888,["553"] = 880,["554"] = 891,["555"] = 892,["556"] = 896,["557"] = 896,["558"] = 896,["559"] = 896,["560"] = 896,["561"] = 896,["562"] = 896,["563"] = 896,["564"] = 904,["565"] = 905,["566"] = 906,["567"] = 906,["568"] = 906,["569"] = 906,["570"] = 906,["571"] = 906,["572"] = 909,["573"] = 891,["574"] = 912,["575"] = 913,["576"] = 914,["577"] = 915,["579"] = 912,["580"] = 919,["581"] = 920,["582"] = 919,["583"] = 923,["584"] = 924,["585"] = 927,["586"] = 932,["587"] = 935,["588"] = 936,["589"] = 937,["590"] = 939,["591"] = 940,["592"] = 944,["594"] = 947,["595"] = 948,["596"] = 953,["597"] = 954,["598"] = 955,["599"] = 955,["600"] = 955,["601"] = 955,["602"] = 958,["603"] = 960,["605"] = 963,["606"] = 964,["607"] = 967,["608"] = 968,["610"] = 971,["613"] = 975,["614"] = 976,["615"] = 977,["616"] = 978,["617"] = 979,["618"] = 980,["622"] = 984,["623"] = 985,["625"] = 988,["626"] = 991,["628"] = 994,["629"] = 923,["630"] = 997,["631"] = 998,["632"] = 997,["633"] = 1001,["634"] = 1002,["635"] = 1007,["636"] = 1008,["637"] = 1010,["638"] = 1011,["639"] = 1013,["641"] = 1015,["643"] = 1018,["644"] = 1019,["645"] = 1021,["646"] = 1022,["647"] = 1022,["648"] = 1022,["649"] = 1023,["650"] = 1022,["651"] = 1022,["654"] = 1028,["655"] = 1029,["656"] = 1029,["657"] = 1029,["658"] = 1030,["659"] = 1029,["660"] = 1029,["661"] = 1058,["662"] = 1001,["663"] = 1061,["664"] = 1062,["665"] = 1063,["666"] = 1065,["667"] = 1069,["668"] = 1070,["670"] = 1073,["671"] = 1074,["672"] = 1077,["673"] = 1077,["674"] = 1077,["675"] = 1078,["676"] = 1077,["677"] = 1077,["678"] = 1081,["679"] = 1082,["680"] = 1082,["681"] = 1082,["682"] = 1082,["683"] = 1086,["684"] = 1087,["686"] = 1090,["687"] = 1091,["688"] = 1093,["689"] = 1094,["690"] = 1094,["691"] = 1094,["692"] = 1095,["693"] = 1094,["694"] = 1094,["698"] = 1101,["699"] = 1061,["700"] = 1104,["701"] = 1105,["702"] = 1107,["703"] = 1108,["705"] = 1104,["706"] = 1112,["707"] = 1113,["708"] = 1114,["709"] = 1116,["710"] = 1117,["711"] = 1118,["712"] = 1119,["713"] = 1120,["717"] = 1125,["720"] = 1129,["721"] = 1130,["723"] = 1133,["724"] = 1134,["725"] = 1135,["727"] = 1138,["728"] = 1139,["730"] = 1142,["731"] = 1143,["734"] = 1147,["735"] = 1149,["738"] = 1153,["739"] = 1154,["741"] = 1157,["742"] = 1158,["744"] = 1161,["745"] = 1162,["747"] = 1165,["748"] = 1166,["750"] = 1169,["751"] = 1170,["752"] = 1173,["754"] = 1176,["755"] = 1177,["758"] = 1181,["759"] = 1182,["760"] = 1183,["761"] = 1184,["765"] = 1189,["766"] = 1190,["769"] = 1193,["770"] = 1194,["771"] = 1194,["772"] = 1194,["773"] = 1194,["774"] = 1195,["777"] = 1198,["778"] = 1200,["779"] = 1201,["782"] = 1204,["786"] = 1112,["787"] = 1210,["788"] = 1211,["789"] = 1212,["790"] = 1214,["791"] = 1215,["792"] = 1217,["793"] = 1218,["794"] = 1219,["795"] = 1219,["796"] = 1219,["797"] = 1220,["798"] = 1221,["799"] = 1222,["800"] = 1223,["803"] = 1219,["804"] = 1219,["805"] = 1228,["806"] = 1229,["807"] = 1230,["808"] = 1231,["812"] = 1236,["815"] = 1210,["816"] = 1241,["817"] = 1242,["818"] = 1241,["819"] = 1245,["820"] = 1246,["821"] = 1247,["822"] = 1248,["824"] = 1252,["825"] = 1255,["827"] = 1258,["828"] = 1259,["830"] = 1262,["831"] = 1263,["832"] = 1264,["833"] = 1265,["834"] = 1266,["835"] = 1267,["836"] = 1268,["840"] = 1273,["841"] = 1245,["842"] = 1276,["843"] = 1277,["844"] = 1278,["845"] = 1276,["846"] = 1281,["847"] = 1282,["848"] = 1281,["849"] = 1285,["850"] = 1286,["851"] = 1285,["852"] = 1289,["853"] = 1290,["854"] = 1289,["855"] = 1293,["856"] = 1296,["857"] = 1298,["858"] = 1299,["859"] = 1300,["861"] = 1302,["864"] = 1305,["866"] = 1307,["867"] = 1307,["868"] = 1308,["869"] = 1293,["870"] = 1311,["871"] = 1312,["872"] = 1312,["873"] = 1312,["874"] = 1312,["875"] = 1311,["876"] = 1317,["877"] = 1318,["878"] = 1320,["879"] = 1321,["880"] = 1322,["882"] = 1324,["883"] = 1325,["884"] = 1325,["885"] = 1325,["886"] = 1325,["887"] = 1325,["888"] = 1330,["891"] = 1333,["893"] = 1317,["894"] = 1337,["895"] = 1338,["896"] = 1339,["897"] = 1340,["898"] = 1341,["900"] = 1337,["901"] = 1345,["902"] = 1346,["903"] = 1347,["904"] = 1348,["905"] = 1349,["907"] = 1351,["909"] = 1345,["910"] = 1355,["911"] = 1356,["912"] = 1356,["913"] = 1356,["914"] = 1357,["915"] = 1358,["916"] = 1358,["917"] = 1358,["918"] = 1358,["919"] = 1362,["921"] = 1356,["922"] = 1356,["923"] = 1355,["924"] = 1367,["925"] = 1368,["926"] = 1368,["927"] = 1368,["928"] = 1369,["929"] = 1370,["930"] = 1371,["931"] = 1373,["932"] = 1374,["933"] = 1374,["934"] = 1374,["935"] = 1374,["936"] = 1375,["938"] = 1382,["939"] = 1383,["940"] = 1384,["941"] = 1384,["942"] = 1384,["943"] = 1384,["944"] = 1385,["948"] = 1368,["949"] = 1368,["950"] = 1367,["951"] = 1397,["952"] = 1398,["953"] = 1398,["954"] = 1398,["955"] = 1398,["956"] = 1398,["957"] = 1398,["958"] = 1398,["959"] = 1398,["960"] = 1397,["961"] = 1401,["962"] = 1402,["963"] = 1402,["964"] = 1402,["965"] = 1402,["966"] = 1405,["967"] = 1406,["969"] = 1408,["970"] = 1401,["971"] = 1411,["972"] = 1412,["973"] = 1412,["974"] = 1412,["975"] = 1412,["976"] = 1411,["977"] = 1415,["978"] = 1420,["979"] = 1415,["980"] = 1423,["981"] = 1424,["982"] = 1426,["983"] = 1427,["985"] = 1430,["986"] = 1423,["987"] = 1433,["988"] = 1434,["989"] = 1435,["990"] = 1436,["991"] = 1437,["992"] = 1437,["993"] = 1437,["994"] = 1437,["995"] = 1437,["996"] = 1437,["997"] = 1443,["998"] = 1443,["999"] = 1450,["1000"] = 1451,["1001"] = 1433,["1002"] = 1454,["1003"] = 1455,["1004"] = 1454,["1005"] = 1459,["1006"] = 1459,["1007"] = 77,["1008"] = 78,["1009"] = 1462,["1010"] = 1462,["1011"] = 1462,["1012"] = 1462,["1013"] = 1467,["1014"] = 1468});
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
        mana_given / 100 + 0.25
    )
    local ____self_round_pickupWrappers_12 = self.round.pickupWrappers
    ____self_round_pickupWrappers_12[#____self_round_pickupWrappers_12 + 1] = {origin = origin, type = PickupTypes.DEATH, timer = -1, entity = entity}
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
if GameRules.Addon then
    GameRules.Addon:Reload()
end
return ____exports
