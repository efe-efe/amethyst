local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 4,["13"] = 5,["14"] = 4,["15"] = 5,["16"] = 10,["17"] = 11,["18"] = 10,["19"] = 14,["20"] = 15,["21"] = 16,["22"] = 18,["23"] = 20,["24"] = 21,["25"] = 22,["28"] = 26,["29"] = 28,["30"] = 29,["31"] = 30,["33"] = 33,["34"] = 35,["36"] = 14,["37"] = 49,["38"] = 50,["39"] = 51,["40"] = 52,["41"] = 52,["42"] = 52,["43"] = 52,["44"] = 52,["45"] = 52,["47"] = 55,["49"] = 49,["50"] = 60,["51"] = 61,["52"] = 62,["54"] = 60,["55"] = 66,["56"] = 67,["57"] = 68,["58"] = 69,["61"] = 73,["62"] = 74,["64"] = 76,["67"] = 66,["68"] = 81,["69"] = 82,["70"] = 81,["71"] = 85,["72"] = 86,["73"] = 87,["76"] = 91,["77"] = 92,["79"] = 95,["80"] = 96,["83"] = 85,["84"] = 5,["85"] = 4,["86"] = 5,["88"] = 5});
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
