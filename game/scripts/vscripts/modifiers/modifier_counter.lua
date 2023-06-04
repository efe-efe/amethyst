local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 4,["13"] = 5,["14"] = 4,["15"] = 5,["17"] = 5,["18"] = 6,["19"] = 4,["20"] = 8,["21"] = 9,["22"] = 10,["24"] = 8,["25"] = 17,["26"] = 18,["27"] = 19,["28"] = 20,["29"] = 21,["32"] = 17,["33"] = 29,["34"] = 30,["35"] = 29,["36"] = 39,["37"] = 40,["38"] = 39,["39"] = 43,["40"] = 44,["41"] = 43,["42"] = 47,["43"] = 53,["44"] = 55,["45"] = 60,["48"] = 47,["49"] = 65,["50"] = 66,["51"] = 67,["53"] = 69,["54"] = 65,["55"] = 72,["56"] = 73,["57"] = 72,["58"] = 78,["59"] = 79,["60"] = 78,["61"] = 5,["62"] = 4,["63"] = 5,["65"] = 5});
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
