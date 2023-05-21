--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 10,["8"] = 10,["9"] = 10,["10"] = 10,["11"] = 10,["12"] = 15,["13"] = 10,["14"] = 23,["15"] = 24,["16"] = 25,["17"] = 27,["18"] = 28,["19"] = 29,["20"] = 30,["21"] = 31,["22"] = 32,["23"] = 33,["24"] = 34,["25"] = 15,["26"] = 37,["27"] = 38,["28"] = 40,["29"] = 40,["30"] = 40,["31"] = 41,["32"] = 41,["33"] = 43,["34"] = 43,["35"] = 43,["36"] = 41,["37"] = 41,["38"] = 45,["39"] = 46,["41"] = 37,["42"] = 50,["43"] = 51,["44"] = 53,["47"] = 57,["48"] = 58,["49"] = 59,["50"] = 60,["51"] = 61,["52"] = 50,["53"] = 65,["54"] = 65,["55"] = 70,["56"] = 70,["57"] = 74,["58"] = 74,["59"] = 78,["60"] = 79,["61"] = 80,["62"] = 82,["63"] = 83,["64"] = 83,["65"] = 83,["66"] = 83,["67"] = 87,["68"] = 87,["69"] = 87,["70"] = 87,["71"] = 83,["72"] = 83,["73"] = 93,["74"] = 103,["75"] = 78,["76"] = 106,["77"] = 106,["78"] = 10,["79"] = 10});
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
