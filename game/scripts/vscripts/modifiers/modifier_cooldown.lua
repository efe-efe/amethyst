local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 2,["9"] = 2,["10"] = 3,["11"] = 3,["12"] = 5,["13"] = 6,["14"] = 5,["15"] = 6,["16"] = 7,["17"] = 8,["18"] = 7,["19"] = 11,["20"] = 12,["21"] = 13,["23"] = 11,["24"] = 17,["25"] = 18,["26"] = 17,["27"] = 21,["28"] = 22,["29"] = 23,["30"] = 24,["31"] = 25,["32"] = 26,["33"] = 28,["36"] = 21,["37"] = 33,["38"] = 34,["39"] = 35,["40"] = 36,["41"] = 37,["43"] = 39,["46"] = 33,["47"] = 44,["48"] = 45,["49"] = 46,["50"] = 48,["51"] = 49,["52"] = 50,["53"] = 52,["55"] = 44,["56"] = 56,["57"] = 56,["58"] = 58,["59"] = 58,["60"] = 60,["61"] = 61,["62"] = 60,["63"] = 64,["64"] = 65,["65"] = 64,["66"] = 6,["67"] = 5,["68"] = 6,["70"] = 6});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_combat_events = require("modifiers.modifier_combat_events")
local ModifierCombatEvents = ____modifier_combat_events.ModifierCombatEvents
____exports.ModifierCooldown = __TS__Class()
local ModifierCooldown = ____exports.ModifierCooldown
ModifierCooldown.name = "ModifierCooldown"
__TS__ClassExtends(ModifierCooldown, ModifierCombatEvents)
function ModifierCooldown.prototype.DestroyOnExpire(self)
    return false
end
function ModifierCooldown.prototype.OnCreated(self)
    if IsServer() then
        self:StartCooldown()
    end
end
function ModifierCooldown.prototype.OnIntervalThink(self)
    self:Replenish()
end
function ModifierCooldown.prototype.Replenish(self)
    if IsServer() then
        if not self:IsCooldownReady() then
            self:SetDuration(-1, true)
            self:StartIntervalThink(-1)
            self:SetStackCount(1)
            self:OnReplenish()
        end
    end
end
function ModifierCooldown.prototype.ReduceCooldown(self, amount)
    if IsServer() then
        local difference = self:GetRemainingTime() - amount
        if difference < 0 then
            self:Replenish()
        else
            self:StartCooldown(difference)
        end
    end
end
function ModifierCooldown.prototype.StartCooldown(self, cooldown)
    if IsServer() then
        local time = cooldown or self:GetReplenishTime()
        self:SetDuration(time, true)
        self:StartIntervalThink(time)
        self:SetStackCount(0)
        self:OnCooldownStart()
    end
end
function ModifierCooldown.prototype.OnReplenish(self)
end
function ModifierCooldown.prototype.OnCooldownStart(self)
end
function ModifierCooldown.prototype.GetReplenishTime(self)
    return 0
end
function ModifierCooldown.prototype.IsCooldownReady(self)
    return self:GetStackCount() > 0
end
ModifierCooldown = __TS__Decorate(
    {registerModifier(nil)},
    ModifierCooldown
)
____exports.ModifierCooldown = ModifierCooldown
return ____exports
