local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 2,["9"] = 2,["10"] = 3,["11"] = 3,["12"] = 16,["13"] = 17,["14"] = 16,["15"] = 17,["17"] = 17,["18"] = 18,["19"] = 24,["20"] = 25,["21"] = 16,["22"] = 27,["23"] = 28,["24"] = 29,["25"] = 30,["26"] = 31,["27"] = 32,["28"] = 33,["29"] = 34,["30"] = 36,["31"] = 38,["32"] = 39,["34"] = 42,["35"] = 43,["37"] = 27,["38"] = 47,["39"] = 48,["40"] = 49,["42"] = 47,["43"] = 53,["44"] = 54,["45"] = 55,["47"] = 58,["48"] = 59,["49"] = 60,["50"] = 66,["51"] = 68,["52"] = 69,["53"] = 70,["56"] = 73,["57"] = 74,["58"] = 75,["59"] = 76,["61"] = 79,["62"] = 80,["63"] = 81,["65"] = 83,["67"] = 53,["68"] = 87,["69"] = 87,["70"] = 89,["71"] = 90,["72"] = 91,["73"] = 91,["74"] = 91,["75"] = 91,["76"] = 91,["77"] = 92,["78"] = 92,["79"] = 92,["80"] = 92,["81"] = 92,["83"] = 89,["84"] = 96,["85"] = 97,["86"] = 99,["87"] = 100,["88"] = 101,["89"] = 102,["90"] = 108,["91"] = 108,["92"] = 108,["93"] = 108,["94"] = 108,["95"] = 109,["96"] = 109,["97"] = 109,["98"] = 109,["99"] = 109,["100"] = 110,["101"] = 110,["102"] = 110,["103"] = 110,["104"] = 110,["105"] = 111,["106"] = 111,["107"] = 111,["108"] = 111,["109"] = 111,["110"] = 112,["111"] = 113,["112"] = 114,["113"] = 114,["114"] = 114,["115"] = 114,["116"] = 114,["118"] = 116,["119"] = 116,["120"] = 116,["121"] = 116,["122"] = 116,["124"] = 118,["125"] = 118,["129"] = 123,["130"] = 124,["131"] = 125,["132"] = 131,["133"] = 131,["134"] = 131,["135"] = 131,["136"] = 131,["137"] = 132,["138"] = 132,["139"] = 132,["140"] = 132,["141"] = 132,["142"] = 133,["143"] = 133,["144"] = 133,["145"] = 133,["146"] = 133,["147"] = 134,["148"] = 134,["150"] = 96,["151"] = 138,["152"] = 139,["153"] = 140,["154"] = 141,["156"] = 144,["157"] = 138,["158"] = 17,["159"] = 16,["160"] = 17,["162"] = 17});
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
        local visibility = params.visibility or "visible"
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
            self:DrawVisuals(self:GetDuration() - self.delayTime)
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
