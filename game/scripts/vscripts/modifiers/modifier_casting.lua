local ____lualib = require("lualib_bundle")
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 15,["10"] = 15,["11"] = 16,["12"] = 16,["13"] = 17,["14"] = 17,["15"] = 1,["16"] = 2,["17"] = 2,["18"] = 3,["19"] = 3,["20"] = 4,["21"] = 4,["22"] = 5,["23"] = 5,["24"] = 6,["25"] = 6,["26"] = 7,["27"] = 7,["28"] = 8,["29"] = 8,["30"] = 9,["31"] = 9,["32"] = 10,["33"] = 10,["34"] = 13,["35"] = 19,["36"] = 20,["37"] = 19,["38"] = 20,["39"] = 23,["40"] = 24,["41"] = 23,["42"] = 27,["43"] = 28,["44"] = 29,["45"] = 32,["46"] = 33,["48"] = 45,["50"] = 27,["51"] = 49,["52"] = 50,["53"] = 60,["56"] = 49,["57"] = 68,["58"] = 69,["59"] = 70,["61"] = 73,["62"] = 75,["63"] = 76,["64"] = 78,["65"] = 78,["66"] = 78,["67"] = 78,["68"] = 78,["69"] = 78,["70"] = 78,["71"] = 78,["72"] = 78,["74"] = 68,["75"] = 82,["76"] = 83,["77"] = 82,["78"] = 86,["79"] = 87,["80"] = 88,["81"] = 89,["82"] = 90,["85"] = 94,["86"] = 86,["87"] = 97,["88"] = 98,["89"] = 99,["91"] = 101,["92"] = 97,["93"] = 104,["94"] = 105,["95"] = 106,["97"] = 109,["98"] = 104,["99"] = 20,["100"] = 19,["101"] = 20,["103"] = 20});
local ____exports = {}
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____util = require("util")
local fullyFaceTowards = ____util.fullyFaceTowards
____exports.Translate = Translate or ({})
____exports.Translate.odachi = 1
____exports.Translate[____exports.Translate.odachi] = "odachi"
____exports.Translate.sharp_blade = 2
____exports.Translate[____exports.Translate.sharp_blade] = "sharp_blade"
____exports.Translate.aggressive = 3
____exports.Translate[____exports.Translate.aggressive] = "aggressive"
____exports.Translate.attack_close_range = 4
____exports.Translate[____exports.Translate.attack_close_range] = "attack_close_range"
____exports.Translate.ti10_taunt = 5
____exports.Translate[____exports.Translate.ti10_taunt] = "ti10_taunt"
____exports.Translate.overload = 6
____exports.Translate[____exports.Translate.overload] = "overload"
____exports.Translate.ti8 = 7
____exports.Translate[____exports.Translate.ti8] = "ti8"
____exports.Translate.overkilled = 8
____exports.Translate[____exports.Translate.overkilled] = "overkilled"
____exports.Translate.loadout = 9
____exports.Translate[____exports.Translate.loadout] = "loadout"
local translateKeys = __TS__ObjectKeys(____exports.Translate)
____exports.ModifierCasting = __TS__Class()
local ModifierCasting = ____exports.ModifierCasting
ModifierCasting.name = "ModifierCasting"
__TS__ClassExtends(ModifierCasting, CustomModifier)
function ModifierCasting.prototype.IsHidden(self)
    return true
end
function ModifierCasting.prototype.OnCreated(self, params)
    if IsServer() then
        self.movementSpeed = params.movementSpeed
        if params.translate then
            self:SetStackCount(params.translate)
        end
        self:StartIntervalThink(0.03)
    end
end
function ModifierCasting.prototype.OnDestroy(self)
    if IsServer() then
        if self:GetRemainingTime() > 0.05 then
        end
    end
end
function ModifierCasting.prototype.OnIntervalThink(self)
    if not self.parent:IsAlive() then
        self:Destroy()
    end
    if self.parent:GetPlayerOwnerID() ~= -1 then
        local mouse = CustomAbilitiesLegacy:GetCursorPosition(self.ability)
        local direction = mouse:__sub(self.parent:GetAbsOrigin()):Normalized()
        fullyFaceTowards(
            nil,
            self.parent,
            Vector(
                direction.x,
                direction.y,
                self.parent:GetForwardVector().z
            )
        )
    end
end
function ModifierCasting.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS, MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE}
end
function ModifierCasting.prototype.GetActivityTranslationModifiers(self)
    for ____, key in ipairs(translateKeys) do
        local value = ____exports.Translate[key]
        if self:GetStackCount() == value then
            return key
        end
    end
    return ""
end
function ModifierCasting.prototype.GetModifierMoveSpeedBonus_Percentage(self)
    if self.movementSpeed and self.movementSpeed ~= 0 then
        return -(100 - self.movementSpeed)
    end
    return 0
end
function ModifierCasting.prototype.CheckState(self)
    if self.movementSpeed == 0 then
        return {[MODIFIER_STATE_ROOTED] = true}
    end
    return {}
end
ModifierCasting = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_casting"})},
    ModifierCasting
)
____exports.ModifierCasting = ModifierCasting
return ____exports
