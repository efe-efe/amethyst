local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 2,["9"] = 2,["10"] = 3,["11"] = 3,["12"] = 5,["13"] = 6,["14"] = 5,["15"] = 6,["17"] = 6,["18"] = 7,["19"] = 5,["20"] = 9,["21"] = 10,["22"] = 11,["24"] = 9,["25"] = 18,["26"] = 19,["27"] = 20,["28"] = 21,["29"] = 22,["32"] = 18,["33"] = 30,["34"] = 31,["35"] = 30,["36"] = 40,["37"] = 41,["38"] = 40,["39"] = 44,["40"] = 45,["41"] = 44,["42"] = 48,["43"] = 54,["44"] = 56,["45"] = 61,["48"] = 48,["49"] = 66,["50"] = 67,["51"] = 68,["53"] = 70,["54"] = 66,["55"] = 73,["56"] = 74,["57"] = 73,["58"] = 79,["59"] = 80,["60"] = 79,["61"] = 6,["62"] = 5,["63"] = 6,["65"] = 6});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_combat_events = require("modifiers.modifier_combat_events")
local ModifierCombatEvents = ____modifier_combat_events.ModifierCombatEvents
____exports.ModifierCounter = __TS__Class()
local ModifierCounter = ____exports.ModifierCounter
ModifierCounter.name = "ModifierCounter"
__TS__ClassExtends(ModifierCounter, ModifierCombatEvents)
function ModifierCounter.prototype.____constructor(self, ...)
    ModifierCombatEvents.prototype.____constructor(self, ...)
    self.particleIds = {}
end
function ModifierCounter.prototype.OnCreated(self)
    if IsServer() then
        self.particleIds = self:Visuals()
    end
end
function ModifierCounter.prototype.OnDestroy(self)
    if IsServer() then
        for ____, particleId in ipairs(self.particleIds) do
            ParticleManager:DestroyParticle(particleId, false)
            ParticleManager:ReleaseParticleIndex(particleId)
        end
    end
end
function ModifierCounter.prototype.Visuals(self)
    return {ParticleManager:CreateParticle("particles/items_fx/black_king_bar_avatar.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)}
end
function ModifierCounter.prototype.GetMovementSpeedPercentage(self)
    return 0
end
function ModifierCounter.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE, MODIFIER_EVENT_ON_ORDER}
end
function ModifierCounter.prototype.OnOrder(self, event)
    if event.unit == self.parent then
        if event.order_type == DOTA_UNIT_ORDER_STOP or event.order_type == DOTA_UNIT_ORDER_HOLD_POSITION or event.order_type == DOTA_UNIT_ORDER_CAST_POSITION or event.order_type == DOTA_UNIT_ORDER_CAST_NO_TARGET then
            self:Destroy()
        end
    end
end
function ModifierCounter.prototype.GetModifierMoveSpeedBonus_Percentage(self)
    if self:GetMovementSpeedPercentage() ~= 0 then
        return -(100 - self:GetMovementSpeedPercentage())
    end
    return 0
end
function ModifierCounter.prototype.CheckState(self)
    return {[MODIFIER_STATE_ROOTED] = self:GetMovementSpeedPercentage() == 0}
end
function ModifierCounter.prototype.GetStatusEffectName(self)
    return "particles/status_fx/status_effect_avatar.vpcf"
end
ModifierCounter = __TS__Decorate(
    {registerModifier(nil)},
    ModifierCounter
)
____exports.ModifierCounter = ModifierCounter
return ____exports
