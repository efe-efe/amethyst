--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 1,["8"] = 3,["9"] = 3,["10"] = 3,["11"] = 3,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 5,["16"] = 8,["17"] = 9,["18"] = 8,["19"] = 11,["20"] = 12,["21"] = 11,["22"] = 14,["23"] = 15,["24"] = 14,["25"] = 17,["26"] = 18,["27"] = 17,["28"] = 23,["29"] = 24,["30"] = 24,["31"] = 24,["32"] = 23,["33"] = 26,["34"] = 27,["35"] = 28,["38"] = 32,["39"] = 33,["40"] = 33,["41"] = 33,["42"] = 33,["45"] = 26,["46"] = 4,["48"] = 3,["50"] = 4,["52"] = 4,["53"] = 3});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local BaseModifier = ____dota_ts_adapter.BaseModifier
____exports.default = (function()
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
        CustomEntitiesLegacy:SendDataToClient(
            self:GetParent()
        )
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
        {
            registerModifier(nil)
        },
        modifier_generic_use_energy
    )
    return modifier_generic_use_energy
end)()
return ____exports
