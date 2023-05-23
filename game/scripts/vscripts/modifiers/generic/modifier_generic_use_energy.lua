local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 1,["11"] = 3,["12"] = 3,["13"] = 3,["14"] = 4,["15"] = 5,["16"] = 6,["17"] = 5,["18"] = 8,["19"] = 9,["20"] = 8,["21"] = 11,["22"] = 12,["23"] = 11,["24"] = 14,["25"] = 15,["26"] = 14,["27"] = 17,["28"] = 18,["29"] = 17,["30"] = 23,["31"] = 24,["32"] = 23,["33"] = 26,["34"] = 27,["35"] = 28,["38"] = 32,["39"] = 33,["40"] = 33,["41"] = 33,["42"] = 33,["45"] = 26,["46"] = 4,["47"] = 3,["48"] = 4,["50"] = 3});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local BaseModifier = ____dota_ts_adapter.BaseModifier
____exports.default = __TS__Class()
local modifier_generic_use_energy = ____exports.default
modifier_generic_use_energy.name = "modifier_generic_use_energy"
__TS__ClassExtends(modifier_generic_use_energy, BaseModifier)
function modifier_generic_use_energy.prototype.IsHidden(self)
    return true
end
function modifier_generic_use_energy.prototype.IsDebuff(self)
    return false
end
function modifier_generic_use_energy.prototype.IsPurgable(self)
    return false
end
function modifier_generic_use_energy.prototype.RemoveOnDeath(self)
    return false
end
function modifier_generic_use_energy.prototype.DeclareFunctions(self)
    return {MODIFIER_EVENT_ON_SPENT_MANA, MODIFIER_EVENT_ON_ABILITY_FULLY_CAST}
end
function modifier_generic_use_energy.prototype.OnSpentMana(self, event)
    CustomEntitiesLegacy:SendDataToClient(self:GetParent())
end
function modifier_generic_use_energy.prototype.OnAbilityFullyCast(self, event)
    if IsServer() then
        if event.unit ~= self:GetParent() then
            return
        end
        if not GameRules.Addon:IsInWTFMode() then
            CustomEntitiesLegacy:GiveEnergy(
                event.unit,
                -event.ability:GetEnergyCost()
            )
        end
    end
end
modifier_generic_use_energy = __TS__Decorate(
    {registerModifier(nil)},
    modifier_generic_use_energy
)
____exports.default = modifier_generic_use_energy
return ____exports
