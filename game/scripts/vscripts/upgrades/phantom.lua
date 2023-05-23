local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 1,["8"] = 1,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 4,["14"] = 4,["15"] = 4,["16"] = 4,["17"] = 4,["18"] = 3,["19"] = 13,["20"] = 13,["21"] = 13,["22"] = 13,["23"] = 13,["24"] = 13,["25"] = 13,["26"] = 3,["27"] = 23,["28"] = 23,["29"] = 23,["30"] = 23,["31"] = 23,["32"] = 23,["33"] = 23,["34"] = 3,["35"] = 33,["36"] = 33,["37"] = 33,["38"] = 33,["39"] = 33,["40"] = 33,["41"] = 33,["42"] = 3,["43"] = 3,["44"] = 42,["45"] = 42,["46"] = 43,["47"] = 43,["48"] = 43,["49"] = 43,["50"] = 43,["51"] = 43,["52"] = 43,["53"] = 43,["54"] = 42,["55"] = 52,["56"] = 52,["57"] = 52,["58"] = 52,["59"] = 52,["60"] = 52,["61"] = 52,["62"] = 52,["63"] = 42,["64"] = 62,["65"] = 62,["66"] = 62,["67"] = 62,["68"] = 62,["69"] = 62,["70"] = 62,["71"] = 62,["72"] = 42,["73"] = 71,["74"] = 71,["75"] = 71,["76"] = 71,["77"] = 71,["78"] = 71,["79"] = 71,["80"] = 71,["81"] = 42,["82"] = 81,["83"] = 81,["84"] = 81,["85"] = 81,["86"] = 81,["87"] = 81,["88"] = 81,["89"] = 81,["90"] = 42,["91"] = 91,["92"] = 91,["93"] = 91,["94"] = 91,["95"] = 91,["96"] = 91,["97"] = 91,["98"] = 91,["99"] = 42,["100"] = 101,["101"] = 101,["102"] = 101,["103"] = 101,["104"] = 101,["105"] = 101,["106"] = 101,["107"] = 101,["108"] = 42,["109"] = 111,["110"] = 111,["111"] = 111,["112"] = 111,["113"] = 111,["114"] = 111,["115"] = 111,["116"] = 111,["117"] = 42,["118"] = 42,["119"] = 121,["120"] = 121,["121"] = 121,["122"] = 121,["123"] = 121,["124"] = 121,["125"] = 121,["126"] = 42,["127"] = 42,["128"] = 130,["129"] = 135});
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
