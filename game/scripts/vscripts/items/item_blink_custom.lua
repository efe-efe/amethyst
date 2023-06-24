local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 5,["15"] = 5,["16"] = 6,["17"] = 7,["18"] = 8,["19"] = 9,["20"] = 10,["21"] = 10,["22"] = 10,["23"] = 10,["24"] = 10,["25"] = 11,["26"] = 11,["27"] = 11,["28"] = 10,["29"] = 10,["30"] = 10,["31"] = 10,["32"] = 15,["33"] = 16,["34"] = 17,["35"] = 7,["36"] = 20,["37"] = 21,["38"] = 23,["39"] = 28,["40"] = 28,["41"] = 28,["42"] = 28,["43"] = 28,["44"] = 29,["45"] = 20,["46"] = 32,["47"] = 33,["48"] = 38,["49"] = 32,["50"] = 6,["51"] = 5,["52"] = 6});
local ____exports = {}
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____util = require("util")
local clampPosition = ____util.clampPosition
local ItemBlink = __TS__Class()
ItemBlink.name = "ItemBlink"
__TS__ClassExtends(ItemBlink, CustomAbility)
function ItemBlink.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local point = clampPosition(
        nil,
        origin,
        cursor,
        {
            maxRange = self:GetCastRange(
                Vector(0, 0, 0),
                nil
            ),
            minRange = self:GetSpecialValueFor("min_range")
        }
    )
    self:PlayEffectsStart()
    FindClearSpaceForUnit(self.caster, point, true)
    self:PlayEffectsEnd()
end
function ItemBlink.prototype.PlayEffectsStart(self)
    EmitSoundOn("DOTA_Item.BlinkDagger.Activate", self.caster)
    local particleId = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(
        particleId,
        0,
        self.caster:GetOrigin()
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
function ItemBlink.prototype.PlayEffectsEnd(self)
    local particleId = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_end.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
    ParticleManager:ReleaseParticleIndex(particleId)
end
ItemBlink = __TS__Decorate(
    {registerAbility(nil, "item_blink_custom")},
    ItemBlink
)
return ____exports
