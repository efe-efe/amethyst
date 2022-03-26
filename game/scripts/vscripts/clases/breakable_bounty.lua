--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 10,["8"] = 10,["9"] = 10,["10"] = 10,["11"] = 10,["12"] = 15,["13"] = 10,["14"] = 21,["15"] = 22,["16"] = 23,["17"] = 25,["18"] = 26,["19"] = 27,["20"] = 28,["21"] = 29,["22"] = 30,["23"] = 31,["24"] = 32,["25"] = 15,["26"] = 35,["27"] = 36,["28"] = 38,["29"] = 38,["30"] = 38,["31"] = 39,["32"] = 39,["33"] = 39,["34"] = 39,["35"] = 39,["36"] = 39,["37"] = 39,["38"] = 40,["39"] = 41,["41"] = 35,["42"] = 45,["43"] = 46,["44"] = 48,["47"] = 52,["48"] = 53,["49"] = 54,["50"] = 55,["51"] = 56,["52"] = 45,["53"] = 60,["54"] = 60,["55"] = 65,["56"] = 65,["57"] = 69,["58"] = 69,["59"] = 73,["60"] = 74,["61"] = 75,["62"] = 77,["63"] = 78,["64"] = 78,["65"] = 78,["66"] = 78,["67"] = 78,["68"] = 78,["69"] = 78,["70"] = 78,["71"] = 78,["72"] = 78,["73"] = 83,["74"] = 88,["75"] = 73,["76"] = 91,["77"] = 91,["78"] = 10,["79"] = 10});
local ____exports = {}
local ____unit_entity = require("clases.unit_entity")
local UnitEntity = ____unit_entity.default
____exports.default = (function()
    ____exports.default = __TS__Class()
    local BreakableBounty = ____exports.default
    BreakableBounty.name = "BreakableBounty"
    __TS__ClassExtends(BreakableBounty, UnitEntity)
    function BreakableBounty.prototype.____constructor(self, origin, options)
        UnitEntity.prototype.____constructor(self, {properties = {origin = origin, name = "breakable_bounty", team = DOTA_TEAM_CUSTOM_8}})
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
