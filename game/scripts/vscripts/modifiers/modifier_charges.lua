local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 4,["13"] = 5,["14"] = 4,["15"] = 5,["16"] = 6,["17"] = 7,["18"] = 6,["19"] = 10,["20"] = 11,["21"] = 10,["22"] = 14,["23"] = 15,["24"] = 14,["25"] = 18,["26"] = 19,["27"] = 18,["28"] = 22,["29"] = 23,["30"] = 24,["31"] = 25,["32"] = 26,["35"] = 22,["36"] = 31,["37"] = 32,["38"] = 33,["40"] = 31,["41"] = 37,["42"] = 38,["43"] = 39,["44"] = 37,["45"] = 42,["46"] = 43,["47"] = 44,["48"] = 42,["49"] = 47,["50"] = 48,["51"] = 49,["52"] = 50,["53"] = 52,["54"] = 53,["55"] = 54,["57"] = 57,["58"] = 59,["59"] = 60,["60"] = 61,["62"] = 64,["63"] = 65,["67"] = 70,["68"] = 71,["69"] = 73,["70"] = 74,["72"] = 76,["73"] = 78,["74"] = 79,["76"] = 82,["77"] = 83,["81"] = 47,["82"] = 89,["83"] = 90,["84"] = 91,["85"] = 91,["86"] = 91,["87"] = 91,["88"] = 89,["89"] = 94,["90"] = 95,["91"] = 96,["92"] = 97,["93"] = 98,["95"] = 100,["96"] = 101,["97"] = 102,["99"] = 94,["100"] = 106,["101"] = 107,["102"] = 106,["103"] = 110,["104"] = 111,["105"] = 112,["108"] = 115,["110"] = 110,["111"] = 119,["112"] = 120,["113"] = 121,["116"] = 124,["117"] = 125,["118"] = 126,["119"] = 127,["123"] = 119,["124"] = 133,["125"] = 134,["126"] = 135,["127"] = 136,["128"] = 133,["129"] = 139,["130"] = 140,["131"] = 139,["132"] = 143,["133"] = 144,["134"] = 143,["135"] = 147,["136"] = 148,["137"] = 147,["138"] = 5,["139"] = 4,["140"] = 5,["142"] = 5});
local ____exports = {}
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.ModifierCharges = __TS__Class()
local ModifierCharges = ____exports.ModifierCharges
ModifierCharges.name = "ModifierCharges"
__TS__ClassExtends(ModifierCharges, CustomModifier)
function ModifierCharges.prototype.IsHidden(self)
    return false
end
function ModifierCharges.prototype.IsDebuff(self)
    return false
end
function ModifierCharges.prototype.IsPurgable(self)
    return false
end
function ModifierCharges.prototype.DestroyOnExpire(self)
    return false
end
function ModifierCharges.prototype.OnCreated(self)
    if IsServer() then
        self:SetStackCount(self:GetMaxCharges())
        if self:GetReplenishType() == "async" then
            self:CalculateCharge()
        end
    end
end
function ModifierCharges.prototype.OnRefresh(self)
    if IsServer() then
        self:CalculateCharge()
    end
end
function ModifierCharges.prototype.AddCharge(self)
    self:IncrementStackCount()
    self:CalculateCharge()
end
function ModifierCharges.prototype.RemoveCharge(self)
    self:DecrementStackCount()
    self:CalculateCharge()
end
function ModifierCharges.prototype.CalculateCharge(self)
    if self:GetReplenishType() == "async" then
        self.ability:EndCooldown()
        if self:GetStackCount() >= self:GetMaxCharges() then
            self:SetStackCount(self:GetMaxCharges())
            self:SetDuration(-1, true)
            self:StartIntervalThink(-1)
        else
            if self:GetRemainingTime() <= 0.05 then
                local chargeTime = self.ability:GetCooldown(-1)
                self:StartIntervalThink(chargeTime)
                self:SetDuration(chargeTime, true)
            end
            if self:GetStackCount() == 0 then
                self.ability:StartCooldown(self:GetRemainingTime())
            end
        end
    end
    if self:GetReplenishType() == "sync" then
        if self:GetStackCount() == self:GetMaxCharges() then
            self:SetDuration(-1, false)
            self:StartIntervalThink(-1)
        end
        if self:GetStackCount() < self:GetMaxCharges() then
            if self:GetRemainingTime() <= 0.05 then
                self:ResetCooldown()
            end
            if self:GetStackCount() == 0 then
                self.ability:StartCooldown(self:GetRemainingTime())
            end
        end
    end
end
function ModifierCharges.prototype.ResetCooldown(self)
    self:StartIntervalThink(self:GetReplenishTime())
    self:SetDuration(
        self:GetReplenishTime(),
        true
    )
end
function ModifierCharges.prototype.OnIntervalThink(self)
    if self:GetReplenishType() == "async" then
        self:IncrementStackCount()
        self:StartIntervalThink(-1)
        self:CalculateCharge()
    end
    if self:GetReplenishType() == "sync" then
        self:SetStackCount(self:GetMaxCharges())
        self:StartIntervalThink(-1)
    end
end
function ModifierCharges.prototype.DeclareFunctions(self)
    return {MODIFIER_EVENT_ON_ABILITY_FULLY_CAST, MODIFIER_EVENT_ON_DEATH}
end
function ModifierCharges.prototype.OnDeath(self, event)
    if IsServer() then
        if event.unit ~= self.parent then
            return
        end
        self:SetStackCount(self:GetMaxCharges())
    end
end
function ModifierCharges.prototype.OnAbilityFullyCast(self, event)
    if IsServer() then
        if event.unit ~= self.parent then
            return
        end
        if event.ability == self.ability then
            if not GameRules.Addon:IsInWTFMode() then
                self:DecrementStackCount()
                self:CalculateCharge()
            end
        end
    end
end
function ModifierCharges.prototype.RefreshCharges(self)
    self:SetStackCount(self:GetMaxCharges())
    self:CalculateCharge()
    self.ability:EndCooldown()
end
function ModifierCharges.prototype.GetReplenishTime(self)
    return 0
end
function ModifierCharges.prototype.GetReplenishType(self)
    return "sync"
end
function ModifierCharges.prototype.GetMaxCharges(self)
    return 1
end
ModifierCharges = __TS__Decorate(
    {registerModifier(nil)},
    ModifierCharges
)
____exports.ModifierCharges = ModifierCharges
return ____exports
