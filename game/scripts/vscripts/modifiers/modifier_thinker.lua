local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 2,["9"] = 2,["10"] = 3,["11"] = 3,["12"] = 15,["13"] = 16,["14"] = 15,["15"] = 16,["17"] = 16,["18"] = 17,["19"] = 23,["20"] = 24,["21"] = 15,["22"] = 26,["23"] = 27,["24"] = 29,["25"] = 30,["26"] = 31,["27"] = 32,["28"] = 33,["29"] = 35,["30"] = 37,["31"] = 38,["32"] = 39,["35"] = 43,["36"] = 44,["37"] = 26,["38"] = 47,["39"] = 48,["40"] = 49,["42"] = 47,["43"] = 53,["44"] = 54,["45"] = 55,["46"] = 57,["47"] = 58,["48"] = 59,["50"] = 62,["51"] = 63,["52"] = 63,["53"] = 63,["54"] = 63,["55"] = 63,["56"] = 64,["57"] = 64,["58"] = 64,["59"] = 64,["60"] = 64,["63"] = 72,["64"] = 74,["65"] = 75,["66"] = 76,["67"] = 77,["70"] = 80,["71"] = 81,["72"] = 82,["74"] = 85,["75"] = 86,["76"] = 88,["77"] = 89,["78"] = 90,["79"] = 90,["80"] = 90,["81"] = 90,["82"] = 90,["83"] = 91,["84"] = 91,["85"] = 91,["86"] = 91,["87"] = 91,["91"] = 95,["93"] = 53,["94"] = 99,["95"] = 99,["96"] = 101,["97"] = 102,["98"] = 104,["99"] = 105,["100"] = 106,["101"] = 107,["102"] = 113,["103"] = 113,["104"] = 113,["105"] = 113,["106"] = 113,["107"] = 114,["108"] = 114,["109"] = 114,["110"] = 114,["111"] = 114,["112"] = 115,["113"] = 115,["114"] = 115,["115"] = 115,["116"] = 115,["117"] = 116,["118"] = 116,["119"] = 116,["120"] = 116,["121"] = 116,["122"] = 117,["123"] = 118,["124"] = 119,["125"] = 119,["126"] = 119,["127"] = 119,["128"] = 119,["130"] = 121,["131"] = 121,["132"] = 121,["133"] = 121,["134"] = 121,["136"] = 123,["137"] = 123,["141"] = 128,["142"] = 129,["143"] = 130,["144"] = 136,["145"] = 136,["146"] = 136,["147"] = 136,["148"] = 136,["149"] = 137,["150"] = 137,["151"] = 137,["152"] = 137,["153"] = 137,["154"] = 138,["155"] = 138,["156"] = 138,["157"] = 138,["158"] = 138,["159"] = 139,["160"] = 139,["162"] = 101,["163"] = 143,["164"] = 144,["165"] = 145,["166"] = 146,["168"] = 149,["169"] = 143,["170"] = 16,["171"] = 15,["172"] = 16,["174"] = 16});
local ____exports = {}
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.ModifierThinker = __TS__Class()
local ModifierThinker = ____exports.ModifierThinker
ModifierThinker.name = "ModifierThinker"
__TS__ClassExtends(ModifierThinker, CustomModifier)
function ModifierThinker.prototype.____constructor(self, ...)
    CustomModifier.prototype.____constructor(self, ...)
    self.initialized = false
    self.particleIds = {}
    self.counter = 0
end
function ModifierThinker.prototype.OnCreated(self, params)
    self.initialized = true
    self.delayTime = params.delayTime or 0
    self.radius = params.radius or 0
    self.scope = params.scope or "public"
    self.behavior = params.behavior or "static"
    self.content = params.content or "static"
    local visibility = params.visibility or "visible"
    if IsServer() then
        if self.radius > 0 and visibility == "visible" then
            self:DrawVisuals(self.delayTime > 0 and 0 or 1)
        end
    end
    self.initialized = self.delayTime <= 0
    self:StartIntervalThink(0.03)
end
function ModifierThinker.prototype.OnDestroy(self)
    if IsServer() then
        self:RemoveVisuals()
    end
end
function ModifierThinker.prototype.OnIntervalThink(self)
    if not self.initialized then
        local percentage = self.counter / (self.delayTime * 30)
        if IsServer() then
            if self.behavior == "follow" then
                self.parent:SetAbsOrigin(self.caster:GetAbsOrigin())
            end
            for ____, particleId in ipairs(self.particleIds) do
                ParticleManager:SetParticleControl(
                    particleId,
                    0,
                    self.parent:GetAbsOrigin():__add(Vector(0, 0, 16))
                )
                ParticleManager:SetParticleControl(
                    particleId,
                    1,
                    Vector(self.radius, percentage, 0)
                )
            end
        end
        self.counter = self.counter + 1
        if percentage >= 1 then
            self.initialized = true
            self:OnReady()
            self.counter = 0
        end
    else
        if self.counter == 0 then
            self:RemoveVisuals()
            self:DrawVisuals(self:GetDuration() - self.delayTime)
        end
        if self.content == "clearout" then
            local percentage = self.counter / ((self:GetDuration() - self.delayTime) * 30)
            if IsServer() then
                for ____, particleId in ipairs(self.particleIds) do
                    ParticleManager:SetParticleControl(
                        particleId,
                        0,
                        self.parent:GetAbsOrigin():__add(Vector(0, 0, 16))
                    )
                    ParticleManager:SetParticleControl(
                        particleId,
                        1,
                        Vector(self.radius, percentage, 0)
                    )
                end
            end
        end
        self.counter = self.counter + 1
    end
end
function ModifierThinker.prototype.OnReady(self)
end
function ModifierThinker.prototype.DrawVisuals(self, percentage)
    local casterAlliance = CustomEntitiesLegacy:GetAlliance(self.caster)
    if self.scope == "public" then
        for ____, alliance in ipairs(GameRules.Addon.alliances) do
            for ____, team in ipairs(alliance.teams) do
                local particleId = ParticleManager:CreateParticleForTeam("particles/progress_circle/generic_progress_circle.vpcf", PATTACH_WORLDORIGIN, self.caster, team)
                ParticleManager:SetParticleControlForward(
                    particleId,
                    0,
                    Vector(0, -1, 0)
                )
                ParticleManager:SetParticleControl(
                    particleId,
                    0,
                    self.parent:GetAbsOrigin():__add(Vector(0, 0, 16))
                )
                ParticleManager:SetParticleControl(
                    particleId,
                    1,
                    Vector(self.radius, percentage, 1)
                )
                ParticleManager:SetParticleControl(
                    particleId,
                    16,
                    Vector(1, 0, 0)
                )
                local alliance = GameRules.Addon:FindAllianceByTeam(team)
                if alliance == casterAlliance then
                    ParticleManager:SetParticleControl(
                        particleId,
                        15,
                        Vector(70, 70, 250)
                    )
                else
                    ParticleManager:SetParticleControl(
                        particleId,
                        15,
                        Vector(250, 70, 70)
                    )
                end
                local ____self_particleIds_0 = self.particleIds
                ____self_particleIds_0[#____self_particleIds_0 + 1] = particleId
            end
        end
    end
    if self.scope == "local" then
        local parentOwner = self.caster:GetPlayerOwner()
        local particleId = ParticleManager:CreateParticleForPlayer("particles/progress_circle/generic_progress_circle.vpcf", PATTACH_WORLDORIGIN, self.caster, parentOwner)
        ParticleManager:SetParticleControl(
            particleId,
            0,
            self.parent:GetAbsOrigin():__add(Vector(0, 0, 16))
        )
        ParticleManager:SetParticleControl(
            particleId,
            1,
            Vector(self.radius, percentage, 1)
        )
        ParticleManager:SetParticleControl(
            particleId,
            15,
            Vector(70, 70, 250)
        )
        local ____self_particleIds_1 = self.particleIds
        ____self_particleIds_1[#____self_particleIds_1 + 1] = particleId
    end
end
function ModifierThinker.prototype.RemoveVisuals(self)
    for ____, particleId in ipairs(self.particleIds) do
        ParticleManager:DestroyParticle(particleId, false)
        ParticleManager:ReleaseParticleIndex(particleId)
    end
    self.particleIds = {}
end
ModifierThinker = __TS__Decorate(
    {registerModifier(nil)},
    ModifierThinker
)
____exports.ModifierThinker = ModifierThinker
return ____exports
