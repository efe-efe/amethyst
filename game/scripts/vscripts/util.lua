local ____lualib = require("lualib_bundle")
local __TS__InstanceOf = ____lualib.__TS__InstanceOf
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["6"] = 1,["7"] = 2,["8"] = 3,["9"] = 4,["10"] = 6,["11"] = 6,["12"] = 7,["13"] = 7,["14"] = 71,["15"] = 72,["16"] = 74,["17"] = 74,["18"] = 74,["19"] = 74,["20"] = 74,["21"] = 74,["22"] = 74,["23"] = 74,["24"] = 74,["25"] = 74,["26"] = 74,["27"] = 74,["28"] = 71,["29"] = 83,["30"] = 84,["31"] = 85,["32"] = 87,["33"] = 87,["34"] = 87,["35"] = 87,["36"] = 87,["37"] = 87,["38"] = 87,["39"] = 87,["40"] = 83,["41"] = 102,["42"] = 106,["44"] = 102,["45"] = 111,["46"] = 113,["47"] = 111,["48"] = 145,["49"] = 150,["50"] = 150,["51"] = 150,["52"] = 150,["53"] = 150,["54"] = 150,["55"] = 152,["56"] = 153,["58"] = 145,["59"] = 9,["60"] = 10,["61"] = 11,["62"] = 13,["63"] = 14,["65"] = 18,["66"] = 18,["67"] = 18,["68"] = 18,["69"] = 18,["70"] = 18,["71"] = 18,["72"] = 18,["73"] = 18,["74"] = 18,["75"] = 18,["76"] = 41,["77"] = 41,["78"] = 41,["79"] = 41,["80"] = 41,["82"] = 43,["85"] = 47,["86"] = 47,["87"] = 47,["88"] = 47,["89"] = 47,["90"] = 47,["91"] = 47,["92"] = 57,["93"] = 57,["94"] = 57,["95"] = 57,["96"] = 57,["98"] = 9,["99"] = 61,["100"] = 62,["101"] = 63,["103"] = 65,["104"] = 66,["106"] = 68,["107"] = 61,["108"] = 90,["109"] = 91,["110"] = 92,["111"] = 94,["112"] = 94,["113"] = 94,["114"] = 94,["115"] = 94,["116"] = 94,["117"] = 94,["118"] = 94,["119"] = 90,["120"] = 97,["121"] = 99,["122"] = 97,["123"] = 116,["124"] = 121,["125"] = 122,["127"] = 125,["128"] = 127,["129"] = 128,["131"] = 130,["132"] = 131,["134"] = 116,["135"] = 135,["136"] = 136,["137"] = 137,["138"] = 137,["139"] = 137,["140"] = 137,["141"] = 137,["142"] = 137,["143"] = 137,["144"] = 135,["145"] = 140,["146"] = 141,["147"] = 142,["148"] = 142,["149"] = 142,["150"] = 142,["151"] = 142,["152"] = 142,["153"] = 142,["154"] = 140,["155"] = 157,["156"] = 157,["157"] = 157,["159"] = 158,["160"] = 158,["161"] = 158,["162"] = 158,["163"] = 158,["164"] = 158,["165"] = 158,["166"] = 159,["167"] = 159,["168"] = 159,["169"] = 159,["170"] = 159,["171"] = 159,["172"] = 159,["173"] = 161,["175"] = 157,["176"] = 166,["177"] = 167,["178"] = 167,["179"] = 167,["180"] = 167,["181"] = 167,["182"] = 167,["183"] = 167,["184"] = 168,["185"] = 168,["186"] = 168,["187"] = 168,["188"] = 168,["189"] = 168,["190"] = 168,["191"] = 170,["193"] = 166,["194"] = 175,["195"] = 176,["196"] = 178,["197"] = 183,["198"] = 183,["199"] = 183,["200"] = 183,["201"] = 183,["202"] = 183,["203"] = 183,["204"] = 183,["205"] = 183,["206"] = 184,["207"] = 175,["208"] = 187,["209"] = 188,["210"] = 189,["211"] = 190,["212"] = 192,["213"] = 193,["215"] = 196,["216"] = 197,["218"] = 200,["219"] = 187,["220"] = 203,["221"] = 204,["222"] = 203,["223"] = 207,["224"] = 208,["225"] = 211,["226"] = 211,["227"] = 211,["228"] = 211,["229"] = 211,["230"] = 211,["231"] = 211,["232"] = 211,["233"] = 211,["234"] = 211,["235"] = 217,["236"] = 218,["237"] = 219,["238"] = 219,["239"] = 219,["240"] = 219,["241"] = 219,["243"] = 222,["244"] = 224,["245"] = 228,["246"] = 229,["247"] = 229,["248"] = 229,["249"] = 229,["250"] = 229,["251"] = 229,["252"] = 229,["254"] = 207,["255"] = 233,["256"] = 234,["257"] = 233,["258"] = 237,["259"] = 238,["260"] = 237,["261"] = 241,["262"] = 248,["263"] = 249,["264"] = 250,["265"] = 264,["266"] = 264,["267"] = 264,["268"] = 264,["269"] = 264,["270"] = 264,["271"] = 264,["272"] = 241,["273"] = 273,["276"] = 277,["279"] = 275,["285"] = 273,["286"] = 281,["287"] = 282,["288"] = 284,["289"] = 288,["292"] = 292,["293"] = 281,["294"] = 295,["295"] = 296,["296"] = 297,["297"] = 298,["299"] = 295});
local ____exports = {}
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifierMotionBoth = ____custom_modifier.CustomModifierMotionBoth
local CustomModifierMotionHorizontal = ____custom_modifier.CustomModifierMotionHorizontal
local CustomModifierMotionVertical = ____custom_modifier.CustomModifierMotionVertical
local ____modifier_gem = require("modifiers.modifier_gem")
local ModifierGem = ____modifier_gem.ModifierGem
local ____modifier_obstacle = require("modifiers.modifier_obstacle")
local ModifierObstacle = ____modifier_obstacle.ModifierObstacle
function ____exports.overheadMessageEFX(self, unit, value, wordLength, color, shield)
    local duration = math.max(1, value / 10)
    EFX(
        "particles/msg_damage.vpcf",
        PATTACH_WORLDORIGIN,
        nil,
        {
            cp0 = unit:GetAbsOrigin(),
            cp1 = Vector(0, value, shield),
            cp2 = Vector(duration, wordLength, 0),
            cp3 = color,
            release = true
        }
    )
end
function ____exports.sendOverheadEnergyMessage(self, unit, value)
    local wordLength = string.len(tostring(math.floor(value))) + 1
    local color = Vector(255, 243, 140)
    ____exports.overheadMessageEFX(
        nil,
        unit,
        value,
        wordLength,
        color,
        0
    )
end
function ____exports.setEnergy(self, unit, amount, informClient)
    if informClient then
    end
end
function ____exports.getEnergy(self, unit)
    return 0
end
function ____exports.giveEnergy(self, unit, amount, informClient, showOverhead)
    ____exports.setEnergy(
        nil,
        unit,
        ____exports.getEnergy(nil, unit) + amount,
        informClient
    )
    if showOverhead then
        ____exports.sendOverheadEnergyMessage(nil, unit, amount)
    end
end
function ____exports.sendDataToClient(self, unit)
    if unit:IsRealHero() and not unit:IsIllusion() then
        local allianceName = "NOT_ALLIANCE"
        if CustomEntitiesLegacy:GetAlliance(unit) then
            allianceName = CustomEntitiesLegacy:GetAlliance(unit):GetName()
        end
        local data = {
            entityIndex = unit:GetEntityIndex(),
            teamId = unit:GetTeam(),
            playerId = unit:GetPlayerOwnerID(),
            allianceName = allianceName,
            name = unit:GetName(),
            health = unit:GetHealth(),
            maxHealth = unit:GetMaxHealth(),
            mana = unit:GetMana(),
            maxMana = unit:GetMaxMana()
        }
        CustomNetTables:SetTableValue(
            "units",
            tostring(unit:GetPlayerID()),
            data
        )
    else
        if unit:IsIllusion() then
            return
        end
        local data = {
            playerId = nil,
            entityIndex = unit:GetEntityIndex(),
            teamId = unit:GetTeam(),
            health = unit:GetHealth(),
            maxHealth = unit:GetMaxHealth()
        }
        CustomNetTables:SetTableValue(
            "units",
            tostring("_" .. tostring(unit:GetEntityIndex())),
            data
        )
    end
end
function ____exports.clamp(self, value, max, min)
    if max and value > max then
        return max
    end
    if min and value < min then
        return min
    end
    return value
end
function ____exports.sendOverheadManaMessage(self, unit, value)
    local wordLength = string.len(tostring(math.floor(value))) + 1
    local color = Vector(27, 113, 230)
    ____exports.overheadMessageEFX(
        nil,
        unit,
        value,
        wordLength,
        color,
        0
    )
end
function ____exports.getMaxEnergy(self, unit)
    return 0
end
function ____exports.giveMana(self, unit, amount, informClient, showOverhead)
    if unit:HasModifier("modifier_sapphire") then
        amount = amount * 2
    end
    unit:GiveMana(amount)
    if informClient then
        ____exports.sendDataToClient(nil, unit)
    end
    if showOverhead then
        ____exports.sendOverheadManaMessage(nil, unit, amount)
    end
end
function ____exports.giveManaPercent(self, unit, percentage, informClient, showOverhead)
    local mana = unit:GetMaxMana() * percentage / 100
    ____exports.giveMana(
        nil,
        unit,
        mana,
        informClient,
        showOverhead
    )
end
function ____exports.giveEnergyPercent(self, unit, percentage, informClient, showOverhead)
    local energy = ____exports.getMaxEnergy(nil, unit) * percentage / 100
    ____exports.giveEnergy(
        nil,
        unit,
        energy,
        informClient,
        showOverhead
    )
end
function ____exports.giveManaAndEnergyPercent(self, unit, percentage, informClient, showOverhead)
    if showOverhead == nil then
        showOverhead = true
    end
    ____exports.giveManaPercent(
        nil,
        unit,
        percentage,
        false,
        showOverhead
    )
    ____exports.giveEnergyPercent(
        nil,
        unit,
        percentage,
        false,
        showOverhead
    )
    if informClient then
    end
end
function ____exports.giveManaAndEnergy(self, unit, amount, informClient, showOverhead)
    ____exports.giveEnergy(
        nil,
        unit,
        amount,
        false,
        showOverhead
    )
    ____exports.giveMana(
        nil,
        unit,
        amount,
        false,
        showOverhead
    )
    if informClient then
    end
end
function ____exports.replenishEFX(self, target)
    local origin = target:GetAbsOrigin()
    local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_death.vpcf", PATTACH_CUSTOMORIGIN, target)
    ParticleManager:SetParticleControlEnt(
        particleId,
        0,
        target,
        PATTACH_POINT_FOLLOW,
        "attach_attack1",
        origin,
        true
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
function ____exports.clampPosition(self, origin, target, options)
    local direction = target:__sub(origin):Normalized()
    local distance = target:__sub(origin):Length2D()
    local result = target
    if options and options.maxRange and distance > (options and options.maxRange) then
        result = direction:__mul(options and options.maxRange):__add(origin)
    end
    if options and options.minRange and distance < options.minRange then
        result = direction:__mul(options and options.minRange):__add(origin)
    end
    return result
end
function ____exports.direction2D(self, origin, target)
    return Vector(target.x - origin.x, target.y - origin.y, 0):Normalized()
end
function ____exports.meeleEFX(self, caster, direction, radius, color)
    local origin = caster:GetAbsOrigin()
    local efx = EFX(
        "particles/juggernaut/juggernaut_basic_attack_parent.vpcf",
        PATTACH_WORLDORIGIN,
        nil,
        {
            cp0 = origin,
            cp0f = direction,
            cp3 = Vector(radius, 0, 0)
        }
    )
    if color then
        ParticleManager:SetParticleControl(efx, 60, color)
        ParticleManager:SetParticleControl(
            efx,
            61,
            Vector(1, 0, 0)
        )
    end
    ParticleManager:ReleaseParticleIndex(efx)
    EFX("particles/juggernaut/juggernaut_basic_attack_dust.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster, {release = true})
    if radius > 300 then
        ____exports.meeleEFX(
            nil,
            caster,
            direction,
            200,
            color
        )
    end
end
function ____exports.isObstacle(self, unit)
    return ModifierObstacle:findOne(unit)
end
function ____exports.isGem(self, unit)
    return ModifierGem:findOne(unit)
end
function ____exports.attackWithBaseDamage(self, options)
    local preAttackDamage = 0
    local multiplier = options.multiplier or 1
    local damageType = options.damageType or DAMAGE_TYPE_PHYSICAL
    ApplyDamage({
        victim = options.target,
        attacker = options.source,
        damage = math.floor((options.source:GetAverageTrueAttackDamage(options.target) + preAttackDamage) * multiplier),
        damage_type = damageType,
        ability = options.ability
    })
end
function ____exports.callEntityFuncSafe(self, entity, key)
    do
        local function ____catch(____error)
            print(____error)
        end
        local ____try, ____hasReturned = pcall(function()
            entity[key](entity)
        end)
        if not ____try then
            ____catch(____hasReturned)
        end
    end
end
local function isDisplacing(self, unit)
    for ____, modifier in ipairs(unit:FindAllModifiers()) do
        if __TS__InstanceOf(modifier, CustomModifierMotionHorizontal) or __TS__InstanceOf(modifier, CustomModifierMotionVertical) or __TS__InstanceOf(modifier, CustomModifierMotionBoth) then
            return true
        end
    end
    return false
end
function ____exports.fullyFaceTowards(self, unit, direction)
    if not isDisplacing(nil, unit) then
        unit:SetForwardVector(direction)
        unit:FaceTowards(unit:GetAbsOrigin():__add(direction))
    end
end
return ____exports
