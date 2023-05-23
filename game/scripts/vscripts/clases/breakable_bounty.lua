local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 1,["8"] = 1,["9"] = 10,["10"] = 10,["11"] = 10,["12"] = 10,["13"] = 15,["14"] = 10,["15"] = 23,["16"] = 24,["17"] = 25,["18"] = 27,["19"] = 28,["20"] = 29,["21"] = 30,["22"] = 31,["23"] = 32,["24"] = 33,["25"] = 34,["26"] = 15,["27"] = 37,["28"] = 38,["29"] = 40,["30"] = 41,["31"] = 41,["32"] = 41,["33"] = 41,["34"] = 41,["35"] = 41,["36"] = 41,["37"] = 42,["38"] = 43,["40"] = 37,["41"] = 47,["42"] = 48,["43"] = 50,["46"] = 54,["47"] = 55,["48"] = 56,["49"] = 57,["50"] = 58,["51"] = 47,["52"] = 62,["53"] = 62,["54"] = 67,["55"] = 67,["56"] = 71,["57"] = 71,["58"] = 75,["59"] = 76,["60"] = 77,["61"] = 79,["62"] = 80,["63"] = 80,["64"] = 80,["65"] = 80,["66"] = 80,["67"] = 80,["68"] = 80,["69"] = 80,["70"] = 80,["71"] = 80,["72"] = 85,["73"] = 90,["74"] = 75,["75"] = 93,["76"] = 93});
local ____exports = {}
local ____unit_entity = require("clases.unit_entity")
local UnitEntity = ____unit_entity.default
____exports.default = __TS__Class()
local BreakableBounty = ____exports.default
BreakableBounty.name = "BreakableBounty"
__TS__ClassExtends(BreakableBounty, UnitEntity)
function BreakableBounty.prototype.____constructor(self, origin, options)
    UnitEntity.prototype.____constructor(self, {properties = {origin = origin, name = "breakable_bounty", team = DOTA_TEAM_CUSTOM_8}})
    self.particle = options.particle and options.particle or nil
    self.model = options.model
    self.scale = options.scale and options.scale or 1
    local unit = self:GetUnit()
    unit:SetModel(self.model)
    unit:SetModelScale(self.scale)
    unit:SetMaxHealth(options.health)
    unit:SetBaseMaxHealth(options.health)
    unit:SetHealth(options.health)
    CustomEntitiesLegacy:SendDataToClient(unit)
    self:PlayEffectsOnSpawn()
end
function BreakableBounty.prototype.Update(self)
    local currentAngle = GameRules:GetGameTime() % (math.pi * 2) * 2
    if not CustomEntitiesLegacy:IsBanished(self:GetUnit()) and self:Alive() then
        CustomEntitiesLegacy:FullyFaceTowards(
            self:GetUnit(),
            Vector(
                math.cos(currentAngle),
                math.sin(currentAngle)
            )
        )
        self:GetUnit():SetModel(self.model)
        self:GetUnit():SetModelScale(self.scale)
    end
end
function BreakableBounty.prototype.OnDeath(self, event)
    local killer = EntIndexToHScript(event.entindex_attacker)
    if killer == self.unit then
        return
    end
    self:Effect(killer)
    self:PlayEffectsOnDeath()
    self:BeforeRemoving(killer)
    self:GetUnit():AddNoDraw()
    self:Destroy(false)
end
function BreakableBounty.prototype.BeforeRemoving(self, killer)
end
function BreakableBounty.prototype.Effect(self, killer)
end
function BreakableBounty.prototype.PlayEffectsOnSpawn(self)
end
function BreakableBounty.prototype.PlayEffectsOnDeath(self)
    local parent = self:GetUnit()
    local origin = parent:GetAbsOrigin()
    EmitSoundOn("Hero_Magnataur.ReversePolarity.Cast", parent)
    EFX(
        "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf",
        PATTACH_WORLDORIGIN,
        nil,
        {
            cp0 = origin,
            cp2 = Vector(255, 80, 230),
            release = true
        }
    )
    EFX("particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf", PATTACH_WORLDORIGIN, nil, {cp0 = origin, cp5 = origin, release = true})
    self:PlaySpecificEffectsOnDeath()
end
function BreakableBounty.prototype.PlaySpecificEffectsOnDeath(self)
end
return ____exports
