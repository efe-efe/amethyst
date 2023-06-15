local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 2,["9"] = 2,["10"] = 3,["11"] = 3,["12"] = 16,["13"] = 17,["14"] = 16,["15"] = 17,["17"] = 17,["18"] = 18,["19"] = 24,["20"] = 25,["21"] = 16,["22"] = 27,["23"] = 28,["24"] = 30,["25"] = 31,["26"] = 32,["27"] = 33,["28"] = 34,["29"] = 36,["30"] = 38,["31"] = 39,["32"] = 40,["34"] = 43,["35"] = 44,["37"] = 27,["38"] = 48,["39"] = 49,["40"] = 50,["42"] = 48,["43"] = 54,["44"] = 55,["45"] = 56,["46"] = 58,["47"] = 59,["48"] = 60,["50"] = 63,["51"] = 64,["52"] = 64,["53"] = 64,["54"] = 64,["55"] = 64,["56"] = 65,["57"] = 65,["58"] = 65,["59"] = 65,["60"] = 65,["63"] = 73,["64"] = 75,["65"] = 76,["66"] = 77,["67"] = 78,["70"] = 81,["71"] = 82,["72"] = 83,["74"] = 86,["75"] = 87,["76"] = 89,["77"] = 90,["78"] = 91,["79"] = 91,["80"] = 91,["81"] = 91,["82"] = 91,["83"] = 92,["84"] = 92,["85"] = 92,["86"] = 92,["87"] = 92,["91"] = 96,["93"] = 54,["94"] = 100,["95"] = 100,["96"] = 102,["97"] = 103,["98"] = 105,["99"] = 106,["100"] = 107,["101"] = 108,["102"] = 114,["103"] = 114,["104"] = 114,["105"] = 114,["106"] = 114,["107"] = 115,["108"] = 115,["109"] = 115,["110"] = 115,["111"] = 115,["112"] = 116,["113"] = 116,["114"] = 116,["115"] = 116,["116"] = 116,["117"] = 117,["118"] = 117,["119"] = 117,["120"] = 117,["121"] = 117,["122"] = 118,["123"] = 119,["124"] = 120,["125"] = 120,["126"] = 120,["127"] = 120,["128"] = 120,["130"] = 122,["131"] = 122,["132"] = 122,["133"] = 122,["134"] = 122,["136"] = 124,["137"] = 124,["141"] = 129,["142"] = 130,["143"] = 131,["144"] = 137,["145"] = 137,["146"] = 137,["147"] = 137,["148"] = 137,["149"] = 138,["150"] = 138,["151"] = 138,["152"] = 138,["153"] = 138,["154"] = 139,["155"] = 139,["156"] = 139,["157"] = 139,["158"] = 139,["159"] = 140,["160"] = 140,["162"] = 102,["163"] = 144,["164"] = 145,["165"] = 146,["166"] = 147,["168"] = 150,["169"] = 144,["170"] = 17,["171"] = 16,["172"] = 17,["174"] = 17});
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
        self.initialized = self.delayTime <= 0
        self:StartIntervalThink(0.03)
    end
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
