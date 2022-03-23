--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 10,["8"] = 10,["9"] = 10,["10"] = 10,["11"] = 10,["12"] = 15,["13"] = 10,["14"] = 20,["15"] = 21,["16"] = 22,["17"] = 24,["18"] = 25,["19"] = 26,["20"] = 27,["21"] = 28,["22"] = 29,["23"] = 30,["24"] = 31,["25"] = 15,["26"] = 34,["27"] = 35,["28"] = 37,["29"] = 37,["30"] = 37,["31"] = 38,["32"] = 38,["33"] = 38,["34"] = 38,["35"] = 38,["36"] = 38,["37"] = 38,["38"] = 39,["39"] = 40,["41"] = 34,["42"] = 44,["43"] = 45,["44"] = 47,["47"] = 51,["48"] = 52,["49"] = 53,["50"] = 54,["51"] = 55,["52"] = 44,["53"] = 59,["54"] = 59,["55"] = 64,["56"] = 64,["57"] = 68,["58"] = 68,["59"] = 72,["60"] = 73,["61"] = 74,["62"] = 76,["63"] = 77,["64"] = 77,["65"] = 77,["66"] = 77,["67"] = 77,["68"] = 77,["69"] = 77,["70"] = 77,["71"] = 77,["72"] = 77,["73"] = 82,["74"] = 87,["75"] = 72,["76"] = 90,["77"] = 90,["78"] = 10,["79"] = 10});
local ____exports = {}
local ____unit_entity = require("clases.unit_entity")
local UnitEntity = ____unit_entity.default
____exports.default = (function()
    ____exports.default = __TS__Class()
    local BreakableBounty = ____exports.default
    BreakableBounty.name = "BreakableBounty"
    __TS__ClassExtends(BreakableBounty, UnitEntity)
    function BreakableBounty.prototype.____constructor(self, origin, options)
        UnitEntity.prototype.____constructor(self, {properties = {origin = origin, name = "breakable_bounty"}})
        self.particle = (options.particle and options.particle) or nil
        self.model = options.model
        self.scale = (options.scale and options.scale) or 1
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
        local currentAngle = (GameRules:GetGameTime() % (math.pi * 2)) * 2
        if (not CustomEntitiesLegacy:IsBanished(
            self:GetUnit()
        )) and self:Alive() then
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
    return BreakableBounty
end)()
return ____exports
