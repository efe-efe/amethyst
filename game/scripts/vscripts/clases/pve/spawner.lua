local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["6"] = 1,["7"] = 1,["8"] = 10,["9"] = 10,["10"] = 10,["11"] = 19,["12"] = 20,["13"] = 21,["14"] = 22,["15"] = 23,["16"] = 24,["17"] = 19,["18"] = 27,["19"] = 28,["22"] = 31,["23"] = 32,["25"] = 34,["26"] = 35,["27"] = 43,["29"] = 27,["30"] = 47,["31"] = 48,["32"] = 49,["33"] = 49,["34"] = 49,["35"] = 49,["36"] = 49,["37"] = 49,["38"] = 48,["39"] = 59,["40"] = 47,["41"] = 69,["42"] = 70,["43"] = 71,["44"] = 72,["46"] = 75,["47"] = 76,["49"] = 69,["50"] = 80,["51"] = 81,["52"] = 82,["53"] = 83,["55"] = 80,["56"] = 87,["57"] = 88,["58"] = 87});
local ____exports = {}
local ____custom_ai = require("clases.pve.custom_ai")
local CustomAIMeta = ____custom_ai.CustomAIMeta
____exports.default = __TS__Class()
local Spawner = ____exports.default
Spawner.name = "Spawner"
function Spawner.prototype.____constructor(self, options)
    self.delayTime = options.delayTime
    self.remainingTime = options.remainingTime * 30
    self.origin = options.origin
    self.name = options.name
    self:CreateEFX()
end
function Spawner.prototype.Update(self)
    if self.remainingTime == -1 then
        return
    end
    if self.remainingTime > 0 then
        self.remainingTime = self.remainingTime - 1
    else
        self.ai = CustomAIMeta[self.name]:factory(self.origin)
        EFX("particles/ai_spawn.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.ai.unit, {release = true})
        self:Destroy()
    end
end
function Spawner.prototype.CreateEFX(self)
    self.marker = CreateTimedRadiusMarker(
        nil,
        self.origin,
        150,
        self.delayTime,
        0.2,
        RADIUS_SCOPE_PUBLIC
    ):FindModifierByName("radius_marker_thinker")
    self.efx = EFX("particles/econ/events/ti10/portal/portal_open_good.vpcf", PATTACH_WORLDORIGIN, nil, {cp0 = self.origin})
end
function Spawner.prototype.CleanEFX(self)
    if self.efx then
        ParticleManager:DestroyParticle(self.efx, false)
        ParticleManager:ReleaseParticleIndex(self.efx)
    end
    if self.marker then
        self.marker:Destroy()
    end
end
function Spawner.prototype.Destroy(self)
    if self.remainingTime ~= -1 then
        self:CleanEFX()
        self.remainingTime = -1
    end
end
function Spawner.prototype.GetAi(self)
    return self.ai
end
return ____exports
