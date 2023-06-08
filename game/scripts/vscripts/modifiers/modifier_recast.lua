local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 4,["13"] = 5,["14"] = 4,["15"] = 5,["16"] = 10,["17"] = 11,["18"] = 10,["19"] = 14,["20"] = 15,["21"] = 16,["22"] = 18,["23"] = 20,["24"] = 21,["25"] = 22,["28"] = 26,["29"] = 28,["30"] = 29,["31"] = 30,["33"] = 33,["34"] = 35,["36"] = 14,["37"] = 39,["38"] = 40,["39"] = 41,["40"] = 42,["41"] = 42,["42"] = 42,["43"] = 42,["44"] = 42,["45"] = 42,["47"] = 45,["49"] = 39,["50"] = 49,["51"] = 50,["52"] = 51,["54"] = 49,["55"] = 55,["56"] = 56,["57"] = 57,["58"] = 58,["61"] = 62,["62"] = 63,["64"] = 65,["67"] = 55,["68"] = 70,["69"] = 71,["70"] = 70,["71"] = 74,["72"] = 75,["73"] = 76,["76"] = 80,["77"] = 81,["79"] = 84,["80"] = 85,["83"] = 74,["84"] = 5,["85"] = 4,["86"] = 5,["88"] = 5});
local ____exports = {}
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.ModifierRecast = __TS__Class()
local ModifierRecast = ____exports.ModifierRecast
ModifierRecast.name = "ModifierRecast"
__TS__ClassExtends(ModifierRecast, CustomModifier)
function ModifierRecast.prototype.IsHidden(self)
    return true
end
function ModifierRecast.prototype.OnCreated(self, params)
    if IsServer() then
        local abilityLeft = self.parent:FindAbilityByName(params.abilityLeft)
        self.duration = params.duration
        if not abilityLeft then
            print(("[ERROR] AbilityLeft (" .. params.abilityLeft) .. ") not found on ModifierRecast")
            self:Destroy()
            return
        end
        self.abilityLeft = abilityLeft
        if params.abilityRight then
            self.abilityRight = self.parent:FindAbilityByName(params.abilityRight)
            self.parent:SwapAbilities(params.abilityLeft, params.abilityRight, false, true)
        end
        local charges = params.charges or 1
        self:SetStackCount(self.abilityRight and charges or charges + 1)
    end
end
function ModifierRecast.prototype.OnDestroy(self)
    if IsServer() then
        if self.abilityRight then
            self.parent:SwapAbilities(
                self.abilityLeft:GetName(),
                self.abilityRight:GetName(),
                true,
                false
            )
        end
        self.abilityLeft:StartCooldown(self.abilityLeft:GetCooldown(self.abilityLeft:GetLevel()))
    end
end
function ModifierRecast.prototype.OnRefresh(self)
    if IsServer() then
        self:IncrementStackCount()
    end
end
function ModifierRecast.prototype.OnStackCountChanged(self)
    if IsServer() then
        if self:GetStackCount() <= 0 then
            self:Destroy()
            return
        end
        if not self.abilityRight then
            self.abilityLeft:EndCooldown()
        else
            self.abilityRight:EndCooldown()
        end
    end
end
function ModifierRecast.prototype.DeclareFunctions(self)
    return {MODIFIER_EVENT_ON_ABILITY_FULLY_CAST}
end
function ModifierRecast.prototype.OnAbilityFullyCast(self, event)
    if IsServer() then
        if event.unit ~= self.parent then
            return
        end
        if not self.abilityRight and event.ability == self.abilityLeft then
            self:DecrementStackCount()
        end
        if event.ability == self.abilityRight then
            self:DecrementStackCount()
        end
    end
end
ModifierRecast = __TS__Decorate(
    {registerModifier(nil)},
    ModifierRecast
)
____exports.ModifierRecast = ModifierRecast
return ____exports
