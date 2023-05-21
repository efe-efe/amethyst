--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 2,["7"] = 2,["8"] = 3,["9"] = 3,["10"] = 4,["11"] = 4,["12"] = 5,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 18,["28"] = 18,["29"] = 19,["30"] = 19,["31"] = 20,["32"] = 20,["33"] = 21,["34"] = 22,["35"] = 24,["36"] = 24,["37"] = 25,["38"] = 25,["39"] = 25,["40"] = 26,["41"] = 26,["42"] = 27,["43"] = 27,["44"] = 28,["45"] = 28,["46"] = 29,["47"] = 29,["48"] = 30,["49"] = 30,["50"] = 31,["51"] = 31,["52"] = 32,["53"] = 32,["54"] = 54,["55"] = 59,["56"] = 59,["57"] = 59,["58"] = 59,["59"] = 59,["60"] = 64,["61"] = 64,["62"] = 64,["63"] = 64,["64"] = 64,["65"] = 69,["66"] = 70,["67"] = 71,["68"] = 72,["69"] = 73,["70"] = 75,["71"] = 77,["72"] = 78,["73"] = 77,["75"] = 79,["76"] = 80,["77"] = 82,["78"] = 83,["79"] = 84,["80"] = 86,["81"] = 92,["82"] = 93,["83"] = 96,["84"] = 96,["85"] = 98,["86"] = 99,["87"] = 96,["88"] = 96,["89"] = 96,["90"] = 104,["91"] = 105,["92"] = 106,["93"] = 107,["94"] = 108,["95"] = 110,["96"] = 111,["97"] = 112,["98"] = 113,["99"] = 95,["100"] = 117,["101"] = 118,["102"] = 123,["103"] = 128,["104"] = 133,["105"] = 138,["106"] = 143,["107"] = 148,["108"] = 153,["109"] = 158,["110"] = 163,["111"] = 169,["112"] = 174,["113"] = 179,["114"] = 184,["115"] = 189,["116"] = 194,["117"] = 200,["118"] = 205,["119"] = 210,["120"] = 216,["121"] = 217,["122"] = 218,["123"] = 219,["125"] = 117,["126"] = 223,["127"] = 224,["128"] = 223,["129"] = 227,["130"] = 228,["131"] = 228,["132"] = 228,["133"] = 228,["134"] = 229,["135"] = 229,["136"] = 229,["137"] = 229,["138"] = 232,["139"] = 232,["140"] = 232,["141"] = 232,["142"] = 239,["143"] = 239,["144"] = 239,["145"] = 239,["146"] = 242,["147"] = 242,["148"] = 242,["149"] = 242,["150"] = 246,["151"] = 247,["152"] = 248,["153"] = 249,["155"] = 252,["156"] = 252,["157"] = 252,["158"] = 253,["159"] = 257,["160"] = 257,["161"] = 257,["162"] = 258,["163"] = 257,["164"] = 257,["165"] = 252,["166"] = 252,["167"] = 227,["168"] = 263,["169"] = 264,["170"] = 265,["171"] = 266,["172"] = 268,["173"] = 269,["174"] = 270,["175"] = 272,["176"] = 272,["177"] = 272,["178"] = 273,["179"] = 274,["181"] = 276,["182"] = 277,["184"] = 279,["185"] = 280,["187"] = 272,["188"] = 272,["189"] = 263,["190"] = 285,["191"] = 286,["192"] = 287,["193"] = 289,["194"] = 289,["195"] = 289,["196"] = 290,["197"] = 291,["199"] = 293,["200"] = 294,["202"] = 289,["203"] = 289,["204"] = 285,["205"] = 299,["206"] = 300,["207"] = 301,["209"] = 303,["210"] = 305,["211"] = 306,["212"] = 306,["213"] = 306,["214"] = 307,["215"] = 308,["216"] = 309,["218"] = 306,["219"] = 306,["221"] = 314,["222"] = 299,["223"] = 317,["224"] = 318,["225"] = 319,["226"] = 320,["227"] = 321,["228"] = 322,["229"] = 323,["230"] = 324,["231"] = 325,["232"] = 326,["233"] = 327,["234"] = 328,["235"] = 330,["236"] = 331,["237"] = 332,["238"] = 333,["240"] = 335,["241"] = 317,["242"] = 338,["243"] = 339,["244"] = 340,["245"] = 341,["246"] = 342,["247"] = 343,["248"] = 338,["249"] = 346,["250"] = 347,["251"] = 348,["252"] = 349,["253"] = 350,["254"] = 346,["255"] = 353,["256"] = 354,["257"] = 354,["258"] = 354,["259"] = 354,["260"] = 354,["261"] = 359,["262"] = 359,["263"] = 359,["264"] = 359,["265"] = 359,["266"] = 364,["267"] = 364,["268"] = 364,["269"] = 364,["270"] = 364,["271"] = 369,["272"] = 369,["273"] = 369,["274"] = 369,["275"] = 369,["276"] = 374,["277"] = 374,["278"] = 374,["279"] = 374,["280"] = 374,["281"] = 379,["282"] = 379,["283"] = 379,["284"] = 379,["285"] = 379,["286"] = 384,["287"] = 353,["288"] = 387,["289"] = 388,["290"] = 388,["291"] = 390,["292"] = 391,["293"] = 392,["294"] = 393,["295"] = 394,["296"] = 395,["298"] = 388,["299"] = 388,["300"] = 400,["301"] = 400,["302"] = 402,["303"] = 403,["304"] = 404,["305"] = 406,["306"] = 407,["307"] = 408,["308"] = 410,["309"] = 411,["310"] = 413,["311"] = 414,["312"] = 415,["313"] = 416,["314"] = 422,["315"] = 423,["317"] = 426,["318"] = 427,["319"] = 428,["321"] = 435,["322"] = 436,["323"] = 437,["324"] = 440,["325"] = 441,["326"] = 441,["327"] = 441,["332"] = 400,["333"] = 400,["334"] = 449,["335"] = 449,["336"] = 451,["337"] = 452,["338"] = 453,["339"] = 455,["340"] = 456,["341"] = 458,["343"] = 459,["344"] = 459,["345"] = 460,["346"] = 461,["347"] = 462,["348"] = 463,["351"] = 459,["354"] = 468,["355"] = 469,["358"] = 473,["359"] = 474,["360"] = 474,["361"] = 474,["363"] = 449,["364"] = 449,["365"] = 479,["366"] = 479,["367"] = 481,["368"] = 482,["369"] = 483,["370"] = 485,["371"] = 486,["372"] = 487,["373"] = 488,["374"] = 489,["375"] = 490,["378"] = 479,["379"] = 479,["380"] = 387,["381"] = 497,["382"] = 498,["383"] = 499,["384"] = 500,["385"] = 501,["386"] = 502,["387"] = 503,["388"] = 504,["389"] = 497,["390"] = 507,["391"] = 508,["392"] = 513,["393"] = 518,["394"] = 523,["395"] = 528,["396"] = 533,["397"] = 539,["398"] = 544,["399"] = 549,["400"] = 554,["401"] = 559,["402"] = 565,["403"] = 570,["404"] = 575,["405"] = 580,["406"] = 585,["407"] = 590,["408"] = 595,["409"] = 600,["410"] = 605,["411"] = 610,["412"] = 615,["413"] = 620,["414"] = 625,["415"] = 630,["416"] = 635,["417"] = 640,["418"] = 645,["419"] = 650,["420"] = 655,["421"] = 661,["422"] = 666,["423"] = 671,["424"] = 676,["425"] = 681,["426"] = 687,["427"] = 688,["428"] = 693,["429"] = 698,["430"] = 704,["431"] = 705,["432"] = 706,["433"] = 708,["434"] = 708,["435"] = 708,["436"] = 709,["437"] = 710,["438"] = 711,["439"] = 711,["440"] = 711,["441"] = 711,["442"] = 711,["444"] = 717,["445"] = 718,["446"] = 718,["447"] = 718,["448"] = 718,["449"] = 718,["451"] = 724,["452"] = 725,["453"] = 725,["454"] = 725,["455"] = 725,["456"] = 725,["459"] = 708,["460"] = 708,["461"] = 733,["462"] = 738,["463"] = 738,["464"] = 738,["465"] = 738,["466"] = 738,["467"] = 743,["468"] = 743,["469"] = 743,["470"] = 743,["471"] = 743,["472"] = 748,["473"] = 748,["474"] = 748,["475"] = 748,["476"] = 748,["477"] = 753,["479"] = 760,["480"] = 507,["481"] = 763,["482"] = 764,["483"] = 763,["484"] = 767,["485"] = 768,["486"] = 768,["487"] = 768,["488"] = 768,["489"] = 768,["490"] = 774,["491"] = 767,["492"] = 777,["493"] = 778,["494"] = 780,["495"] = 780,["496"] = 780,["497"] = 781,["498"] = 781,["499"] = 781,["500"] = 782,["501"] = 783,["503"] = 781,["504"] = 781,["505"] = 780,["506"] = 780,["507"] = 788,["508"] = 777,["509"] = 791,["510"] = 795,["511"] = 796,["512"] = 797,["513"] = 799,["514"] = 800,["515"] = 801,["516"] = 802,["517"] = 805,["518"] = 801,["519"] = 801,["520"] = 809,["522"] = 811,["523"] = 812,["524"] = 813,["525"] = 814,["526"] = 815,["527"] = 817,["528"] = 818,["529"] = 819,["531"] = 822,["532"] = 823,["533"] = 824,["534"] = 825,["535"] = 827,["537"] = 830,["539"] = 791,["540"] = 834,["541"] = 835,["542"] = 836,["543"] = 837,["544"] = 838,["545"] = 839,["546"] = 834,["547"] = 842,["548"] = 843,["549"] = 844,["550"] = 845,["551"] = 846,["552"] = 847,["553"] = 848,["554"] = 849,["555"] = 850,["556"] = 851,["557"] = 852,["558"] = 853,["559"] = 854,["560"] = 874,["561"] = 875,["562"] = 876,["564"] = 842,["565"] = 880,["566"] = 881,["567"] = 882,["568"] = 884,["569"] = 884,["570"] = 884,["571"] = 885,["572"] = 885,["573"] = 885,["574"] = 885,["575"] = 885,["576"] = 885,["577"] = 884,["578"] = 884,["579"] = 888,["580"] = 880,["581"] = 891,["582"] = 892,["583"] = 896,["584"] = 904,["585"] = 905,["586"] = 906,["587"] = 906,["588"] = 906,["589"] = 906,["590"] = 906,["591"] = 906,["592"] = 906,["593"] = 906,["594"] = 909,["595"] = 891,["596"] = 912,["597"] = 913,["598"] = 914,["599"] = 915,["601"] = 912,["602"] = 919,["603"] = 920,["604"] = 919,["605"] = 923,["606"] = 924,["607"] = 927,["608"] = 932,["609"] = 935,["610"] = 936,["611"] = 937,["612"] = 939,["613"] = 940,["614"] = 944,["616"] = 947,["617"] = 948,["618"] = 953,["619"] = 953,["620"] = 953,["621"] = 954,["622"] = 954,["623"] = 954,["624"] = 955,["625"] = 955,["626"] = 955,["627"] = 955,["628"] = 958,["629"] = 960,["631"] = 963,["632"] = 964,["633"] = 964,["634"] = 964,["635"] = 967,["636"] = 968,["638"] = 971,["641"] = 975,["642"] = 976,["643"] = 977,["644"] = 978,["645"] = 979,["646"] = 980,["650"] = 984,["651"] = 985,["653"] = 988,["654"] = 991,["656"] = 994,["657"] = 923,["658"] = 997,["659"] = 998,["660"] = 997,["661"] = 1001,["662"] = 1002,["663"] = 1007,["664"] = 1008,["665"] = 1010,["666"] = 1011,["667"] = 1013,["669"] = 1015,["671"] = 1018,["672"] = 1019,["673"] = 1021,["674"] = 1022,["675"] = 1022,["676"] = 1022,["677"] = 1023,["678"] = 1022,["679"] = 1022,["682"] = 1028,["683"] = 1029,["684"] = 1029,["685"] = 1029,["686"] = 1030,["687"] = 1029,["688"] = 1029,["689"] = 1058,["690"] = 1001,["691"] = 1061,["692"] = 1062,["693"] = 1065,["694"] = 1069,["695"] = 1073,["696"] = 1074,["698"] = 1077,["699"] = 1078,["700"] = 1081,["701"] = 1081,["702"] = 1081,["703"] = 1082,["704"] = 1081,["705"] = 1081,["706"] = 1085,["707"] = 1086,["708"] = 1086,["709"] = 1086,["710"] = 1086,["711"] = 1090,["712"] = 1091,["714"] = 1094,["715"] = 1095,["716"] = 1097,["717"] = 1098,["718"] = 1098,["719"] = 1098,["720"] = 1099,["721"] = 1098,["722"] = 1098,["726"] = 1105,["727"] = 1061,["728"] = 1108,["729"] = 1109,["730"] = 1111,["731"] = 1112,["733"] = 1108,["734"] = 1116,["735"] = 1117,["736"] = 1118,["737"] = 1120,["738"] = 1121,["739"] = 1122,["740"] = 1123,["741"] = 1124,["745"] = 1129,["748"] = 1133,["749"] = 1134,["751"] = 1137,["752"] = 1138,["753"] = 1139,["755"] = 1142,["756"] = 1143,["758"] = 1146,["759"] = 1147,["762"] = 1151,["763"] = 1153,["766"] = 1157,["767"] = 1158,["769"] = 1161,["770"] = 1162,["772"] = 1165,["773"] = 1166,["775"] = 1169,["776"] = 1170,["778"] = 1173,["779"] = 1174,["780"] = 1177,["782"] = 1180,["783"] = 1181,["786"] = 1185,["787"] = 1186,["788"] = 1187,["789"] = 1188,["793"] = 1193,["794"] = 1194,["797"] = 1197,["798"] = 1198,["799"] = 1198,["800"] = 1198,["801"] = 1198,["802"] = 1199,["803"] = 1199,["804"] = 1199,["807"] = 1202,["808"] = 1204,["809"] = 1205,["812"] = 1208,["816"] = 1116,["817"] = 1214,["818"] = 1215,["819"] = 1216,["820"] = 1218,["821"] = 1219,["822"] = 1221,["823"] = 1222,["824"] = 1223,["825"] = 1223,["826"] = 1223,["827"] = 1224,["828"] = 1225,["829"] = 1226,["830"] = 1227,["833"] = 1223,["834"] = 1223,["835"] = 1232,["836"] = 1233,["837"] = 1234,["838"] = 1235,["842"] = 1240,["845"] = 1214,["846"] = 1245,["847"] = 1246,["848"] = 1245,["849"] = 1249,["850"] = 1250,["851"] = 1251,["852"] = 1252,["854"] = 1256,["855"] = 1259,["857"] = 1262,["858"] = 1263,["860"] = 1266,["861"] = 1267,["862"] = 1268,["863"] = 1269,["864"] = 1270,["865"] = 1271,["866"] = 1272,["870"] = 1277,["871"] = 1249,["872"] = 1280,["873"] = 1281,["874"] = 1282,["875"] = 1280,["876"] = 1285,["877"] = 1286,["878"] = 1285,["879"] = 1289,["880"] = 1290,["881"] = 1289,["882"] = 1293,["883"] = 1294,["884"] = 1293,["885"] = 1297,["886"] = 1300,["887"] = 1302,["888"] = 1303,["889"] = 1304,["891"] = 1306,["894"] = 1309,["896"] = 1311,["897"] = 1312,["898"] = 1297,["899"] = 1315,["900"] = 1316,["901"] = 1316,["902"] = 1316,["903"] = 1316,["904"] = 1315,["905"] = 1321,["906"] = 1322,["907"] = 1324,["908"] = 1325,["909"] = 1326,["911"] = 1328,["912"] = 1329,["913"] = 1329,["914"] = 1329,["915"] = 1329,["916"] = 1329,["917"] = 1334,["920"] = 1337,["922"] = 1321,["923"] = 1341,["924"] = 1342,["925"] = 1343,["926"] = 1344,["927"] = 1345,["929"] = 1341,["930"] = 1349,["931"] = 1350,["932"] = 1351,["933"] = 1352,["934"] = 1353,["936"] = 1355,["938"] = 1349,["939"] = 1359,["940"] = 1360,["941"] = 1360,["942"] = 1360,["943"] = 1361,["944"] = 1362,["945"] = 1362,["946"] = 1362,["947"] = 1362,["948"] = 1366,["950"] = 1360,["951"] = 1360,["952"] = 1359,["953"] = 1371,["954"] = 1372,["955"] = 1372,["956"] = 1372,["957"] = 1373,["958"] = 1374,["959"] = 1375,["960"] = 1377,["961"] = 1378,["962"] = 1378,["963"] = 1378,["964"] = 1378,["965"] = 1379,["967"] = 1386,["968"] = 1387,["969"] = 1388,["970"] = 1388,["971"] = 1388,["972"] = 1388,["973"] = 1389,["977"] = 1372,["978"] = 1372,["979"] = 1371,["980"] = 1401,["981"] = 1402,["982"] = 1402,["983"] = 1402,["984"] = 1402,["985"] = 1405,["986"] = 1406,["988"] = 1408,["989"] = 1401,["990"] = 1411,["991"] = 1412,["992"] = 1412,["993"] = 1412,["994"] = 1412,["995"] = 1415,["996"] = 1416,["998"] = 1418,["999"] = 1411,["1000"] = 1421,["1001"] = 1422,["1002"] = 1422,["1003"] = 1422,["1004"] = 1422,["1005"] = 1421,["1006"] = 1425,["1007"] = 1430,["1008"] = 1425,["1009"] = 1433,["1010"] = 1434,["1011"] = 1436,["1012"] = 1437,["1014"] = 1440,["1015"] = 1433,["1016"] = 1443,["1017"] = 1444,["1018"] = 1445,["1019"] = 1446,["1020"] = 1447,["1021"] = 1447,["1022"] = 1447,["1023"] = 1447,["1024"] = 1447,["1025"] = 1447,["1026"] = 1453,["1027"] = 1460,["1028"] = 1461,["1029"] = 1443,["1030"] = 1464,["1031"] = 1465,["1032"] = 1464,["1033"] = 1469,["1034"] = 1469,["1035"] = 77,["1036"] = 1472,["1037"] = 1472,["1038"] = 1472,["1039"] = 1472,["1040"] = 1477,["1041"] = 1478});
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
