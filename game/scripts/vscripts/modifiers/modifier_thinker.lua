local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 2,["9"] = 2,["10"] = 3,["11"] = 3,["12"] = 16,["13"] = 17,["14"] = 16,["15"] = 17,["17"] = 17,["18"] = 18,["19"] = 26,["20"] = 27,["21"] = 16,["22"] = 29,["23"] = 30,["24"] = 31,["25"] = 32,["26"] = 33,["27"] = 34,["28"] = 35,["29"] = 36,["30"] = 37,["31"] = 39,["32"] = 40,["34"] = 43,["35"] = 44,["37"] = 29,["38"] = 48,["39"] = 49,["40"] = 50,["42"] = 48,["43"] = 54,["44"] = 55,["45"] = 56,["47"] = 59,["48"] = 60,["49"] = 61,["50"] = 67,["51"] = 69,["52"] = 70,["53"] = 71,["56"] = 74,["57"] = 75,["58"] = 76,["59"] = 77,["60"] = 78,["63"] = 82,["64"] = 83,["65"] = 84,["67"] = 86,["69"] = 54,["70"] = 90,["71"] = 90,["72"] = 92,["73"] = 93,["74"] = 94,["75"] = 94,["76"] = 94,["77"] = 94,["78"] = 94,["79"] = 95,["80"] = 95,["81"] = 95,["82"] = 95,["83"] = 95,["85"] = 92,["86"] = 99,["87"] = 100,["88"] = 102,["89"] = 103,["90"] = 104,["91"] = 105,["92"] = 111,["93"] = 111,["94"] = 111,["95"] = 111,["96"] = 111,["97"] = 112,["98"] = 112,["99"] = 112,["100"] = 112,["101"] = 112,["102"] = 113,["103"] = 113,["104"] = 113,["105"] = 113,["106"] = 113,["107"] = 114,["108"] = 114,["109"] = 114,["110"] = 114,["111"] = 114,["112"] = 115,["113"] = 116,["114"] = 117,["115"] = 117,["116"] = 117,["117"] = 117,["118"] = 117,["120"] = 119,["121"] = 119,["122"] = 119,["123"] = 119,["124"] = 119,["126"] = 121,["127"] = 121,["131"] = 126,["132"] = 127,["133"] = 128,["134"] = 134,["135"] = 134,["136"] = 134,["137"] = 134,["138"] = 134,["139"] = 135,["140"] = 135,["141"] = 135,["142"] = 135,["143"] = 135,["144"] = 136,["145"] = 136,["146"] = 136,["147"] = 136,["148"] = 136,["149"] = 137,["150"] = 137,["152"] = 99,["153"] = 141,["154"] = 142,["155"] = 143,["156"] = 144,["158"] = 147,["159"] = 141,["160"] = 17,["161"] = 16,["162"] = 17,["164"] = 17});
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
    if IsServer() then
        self.initialized = true
        self.delayTime = params.delayTime or 0
        self.radius = params.radius or 0
        self.scope = params.scope or "public"
        self.behavior = params.behavior or "static"
        self.content = params.content or "static"
        self.visibility = params.visibility or "visible"
        if self.radius > 0 and self.visibility == "visible" then
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
    if self.behavior == "follow" then
        self.parent:SetAbsOrigin(self.caster:GetAbsOrigin())
    end
    if not self.initialized then
        local percentage = self.counter / (self.delayTime * 30)
        self:UpdateVisuals(percentage)
        self.counter = self.counter + 1
        if percentage >= 1 then
            self.initialized = true
            self.counter = 0
        end
    else
        if self.counter == 0 then
            self:OnReady()
            self:RemoveVisuals()
            if self.visibility == "visible" then
                self:DrawVisuals(self:GetDuration() - self.delayTime)
            end
        end
        if self.content == "clearout" then
            local percentage = self.counter / ((self:GetDuration() - self.delayTime) * 30)
            self:UpdateVisuals(percentage)
        end
        self.counter = self.counter + 1
    end
end
function ModifierThinker.prototype.OnReady(self)
end
function ModifierThinker.prototype.UpdateVisuals(self, percentage)
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
