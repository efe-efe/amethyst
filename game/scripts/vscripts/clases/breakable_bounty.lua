local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 1,["8"] = 1,["9"] = 10,["10"] = 10,["11"] = 10,["12"] = 10,["13"] = 15,["14"] = 10,["15"] = 23,["16"] = 24,["17"] = 25,["18"] = 27,["19"] = 28,["20"] = 29,["21"] = 30,["22"] = 31,["23"] = 32,["24"] = 33,["25"] = 34,["26"] = 15,["27"] = 37,["28"] = 38,["29"] = 40,["30"] = 41,["31"] = 41,["32"] = 43,["33"] = 43,["34"] = 43,["35"] = 41,["36"] = 41,["37"] = 45,["38"] = 46,["40"] = 37,["41"] = 50,["42"] = 51,["43"] = 53,["46"] = 57,["47"] = 58,["48"] = 59,["49"] = 60,["50"] = 61,["51"] = 50,["52"] = 65,["53"] = 65,["54"] = 70,["55"] = 70,["56"] = 74,["57"] = 74,["58"] = 78,["59"] = 79,["60"] = 80,["61"] = 82,["62"] = 83,["63"] = 83,["64"] = 83,["65"] = 83,["66"] = 87,["67"] = 87,["68"] = 87,["69"] = 87,["70"] = 83,["71"] = 83,["72"] = 93,["73"] = 103,["74"] = 78,["75"] = 106,["76"] = 106});
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
