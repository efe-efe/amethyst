local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 2,["9"] = 2,["10"] = 3,["11"] = 3,["12"] = 5,["13"] = 6,["14"] = 5,["15"] = 6,["16"] = 11,["17"] = 12,["18"] = 11,["19"] = 15,["20"] = 16,["21"] = 17,["22"] = 19,["23"] = 21,["24"] = 22,["25"] = 23,["28"] = 27,["29"] = 29,["30"] = 30,["31"] = 31,["33"] = 34,["34"] = 36,["36"] = 15,["37"] = 40,["38"] = 41,["39"] = 42,["40"] = 43,["41"] = 43,["42"] = 43,["43"] = 43,["44"] = 43,["45"] = 43,["47"] = 46,["49"] = 40,["50"] = 50,["51"] = 51,["52"] = 52,["54"] = 50,["55"] = 56,["56"] = 57,["57"] = 58,["58"] = 59,["61"] = 63,["62"] = 64,["64"] = 66,["67"] = 56,["68"] = 71,["69"] = 72,["70"] = 71,["71"] = 75,["72"] = 76,["73"] = 77,["76"] = 81,["77"] = 82,["79"] = 85,["80"] = 86,["83"] = 75,["84"] = 6,["85"] = 5,["86"] = 6,["88"] = 6});
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
