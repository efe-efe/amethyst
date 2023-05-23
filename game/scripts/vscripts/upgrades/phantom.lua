local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 1,["8"] = 1,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 4,["14"] = 4,["15"] = 4,["16"] = 4,["17"] = 4,["18"] = 3,["19"] = 13,["20"] = 13,["21"] = 13,["22"] = 13,["23"] = 13,["24"] = 13,["25"] = 13,["26"] = 3,["27"] = 22,["28"] = 22,["29"] = 22,["30"] = 22,["31"] = 22,["32"] = 22,["33"] = 22,["34"] = 3,["35"] = 31,["36"] = 31,["37"] = 31,["38"] = 31,["39"] = 31,["40"] = 31,["41"] = 31,["42"] = 3,["43"] = 3,["44"] = 40,["45"] = 40,["46"] = 41,["47"] = 41,["48"] = 41,["49"] = 41,["50"] = 41,["51"] = 41,["52"] = 41,["53"] = 41,["54"] = 40,["55"] = 50,["56"] = 50,["57"] = 50,["58"] = 50,["59"] = 50,["60"] = 50,["61"] = 50,["62"] = 50,["63"] = 40,["64"] = 59,["65"] = 59,["66"] = 59,["67"] = 59,["68"] = 59,["69"] = 59,["70"] = 59,["71"] = 59,["72"] = 40,["73"] = 68,["74"] = 68,["75"] = 68,["76"] = 68,["77"] = 68,["78"] = 68,["79"] = 68,["80"] = 68,["81"] = 40,["82"] = 77,["83"] = 77,["84"] = 77,["85"] = 77,["86"] = 77,["87"] = 77,["88"] = 77,["89"] = 77,["90"] = 40,["91"] = 86,["92"] = 86,["93"] = 86,["94"] = 86,["95"] = 86,["96"] = 86,["97"] = 86,["98"] = 86,["99"] = 40,["100"] = 96,["101"] = 96,["102"] = 96,["103"] = 96,["104"] = 96,["105"] = 96,["106"] = 96,["107"] = 96,["108"] = 40,["109"] = 105,["110"] = 105,["111"] = 105,["112"] = 105,["113"] = 105,["114"] = 105,["115"] = 105,["116"] = 105,["117"] = 40,["118"] = 40,["119"] = 114,["120"] = 114,["121"] = 114,["122"] = 114,["123"] = 114,["124"] = 114,["125"] = 114,["126"] = 40,["127"] = 40,["128"] = 123,["129"] = 128});
local ____exports = {}
local ____common = require("upgrades.common")
local UpgradeTypes = ____common.UpgradeTypes
local Shards = __TS__ArrayMap(
    {{
        id = "phantom_dash_damage",
        name = "Swift knives",
        description = "Your Swift leaves a fan of knives on its original position.",
        ability = "phantom_mobility",
        maxStacks = 5,
        modifier = {},
        tier = 1
    }, {
        id = "phantom_dash_shield",
        name = "Swift shield",
        description = "Your Swift gives you shield for a short period of time after passing through enemies and increases its range.",
        ability = "phantom_mobility",
        maxStacks = 5,
        modifier = {},
        tier = 1
    }, {
        id = "phantom_strike_knives",
        name = "Strike knives",
        description = "Your Phantom Strike leaves a fan of knives on the arival location.",
        ability = "phantom_counter",
        maxStacks = 5,
        modifier = {},
        tier = 1
    }},
    function(____, shard) return __TS__ObjectAssign(
        {},
        shard,
        {
            type = UpgradeTypes.SHARD,
            modifier = __TS__ObjectAssign({}, shard.modifier, {name = "modifier_upgrade_" .. shard.id})
        }
    ) end
)
local Favors = __TS__ArrayMap(
    {
        {
            id = "phantom_extra_daggers",
            name = "Extra daggers",
            description = "Your Stiffling Daggers throws 3 daggers.",
            ability = "phantom_special_attack",
            maxStacks = 1,
            modifier = {},
            tier = 1
        },
        {
            id = "phantom_fast_daggers",
            name = "Fast daggers",
            description = "Your Stiffling Daggers cooldown is two times to your attack speed, but no longer apply slow.",
            ability = "phantom_special_attack",
            maxStacks = 1,
            modifier = {},
            tier = 1
        },
        {
            id = "phantom_coup_cast_fast",
            name = "Coup de Grace cast fast",
            description = "Reduces the cast time of Coup de Grace considerably.",
            ability = "phantom_ultimate",
            maxStacks = 1,
            modifier = {},
            tier = 1
        },
        {
            id = "phantom_countering_stacks",
            name = "Phantom Strike stacks",
            description = "Your Phantom Strike consumes all your Phantom Stacks to multiply your damage while the attack speed buff is on.",
            ability = "phantom_counter",
            maxStacks = 1,
            modifier = {},
            tier = 1
        },
        {
            id = "phantom_act_while_countering",
            name = "Phantom Strike while acting",
            description = "You can act while in counter state but the counter state duration its reduced.",
            ability = "phantom_counter",
            maxStacks = 1,
            modifier = {},
            tier = 1
        },
        {
            id = "phantom_strike_instant",
            name = "Phantom Strike instant effect",
            description = "Your Phantom Strike is activated instantly without the need to be activated by an attack, but no longer heals and the banish duration is reduced.",
            ability = "phantom_counter",
            maxStacks = 1,
            modifier = {},
            tier = 1
        },
        {
            id = "phantom_quick_recast",
            name = "Phantom Quick Strike recast",
            description = "Your Quick Strike can be used again for free after hitting at least one enemy.",
            ability = "phantom_extra",
            maxStacks = 1,
            modifier = {},
            tier = 1
        },
        {
            id = "phantom_critical_recast",
            name = "Phantom Critical Strike recast",
            description = "Your Critical Strike can be used again after hitting at least one enemy.",
            ability = "phantom_second_attack",
            maxStacks = 1,
            modifier = {},
            tier = 1
        }
    },
    function(____, favor) return __TS__ObjectAssign(
        {},
        favor,
        {
            type = UpgradeTypes.FAVOR,
            modifier = __TS__ObjectAssign({}, favor.modifier, {name = "modifier_upgrade_" .. favor.id})
        }
    ) end
)
local PhantomRewards = {Shards = Shards, Favors = Favors}
____exports.default = PhantomRewards
return ____exports
