local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 2,["9"] = 2,["10"] = 3,["11"] = 3,["12"] = 5,["13"] = 6,["14"] = 5,["15"] = 6,["17"] = 6,["18"] = 7,["19"] = 12,["20"] = 13,["21"] = 5,["22"] = 15,["23"] = 22,["24"] = 24,["25"] = 25,["26"] = 26,["27"] = 27,["28"] = 29,["29"] = 31,["30"] = 32,["31"] = 33,["34"] = 37,["35"] = 38,["36"] = 39,["38"] = 15,["39"] = 43,["40"] = 44,["41"] = 45,["43"] = 43,["44"] = 49,["45"] = 50,["46"] = 51,["47"] = 53,["48"] = 54,["49"] = 55,["51"] = 57,["52"] = 58,["53"] = 58,["54"] = 58,["55"] = 58,["56"] = 58,["57"] = 59,["58"] = 59,["59"] = 59,["60"] = 59,["61"] = 59,["64"] = 67,["65"] = 68,["66"] = 69,["68"] = 72,["70"] = 49,["71"] = 76,["72"] = 76,["73"] = 78,["74"] = 79,["75"] = 80,["76"] = 82,["77"] = 83,["78"] = 84,["79"] = 85,["80"] = 91,["81"] = 91,["82"] = 91,["83"] = 91,["84"] = 91,["85"] = 92,["86"] = 92,["87"] = 92,["88"] = 92,["89"] = 92,["90"] = 93,["91"] = 93,["92"] = 93,["93"] = 93,["94"] = 93,["95"] = 94,["96"] = 94,["97"] = 94,["98"] = 94,["99"] = 94,["100"] = 95,["101"] = 96,["102"] = 97,["103"] = 97,["104"] = 97,["105"] = 97,["106"] = 97,["108"] = 99,["109"] = 99,["110"] = 99,["111"] = 99,["112"] = 99,["114"] = 101,["115"] = 101,["119"] = 106,["120"] = 107,["121"] = 108,["122"] = 114,["123"] = 114,["124"] = 114,["125"] = 114,["126"] = 114,["127"] = 115,["128"] = 115,["129"] = 115,["130"] = 115,["131"] = 115,["132"] = 116,["133"] = 116,["134"] = 116,["135"] = 116,["136"] = 116,["137"] = 117,["138"] = 117,["140"] = 78,["141"] = 121,["142"] = 122,["143"] = 123,["144"] = 124,["146"] = 121,["147"] = 6,["148"] = 5,["149"] = 6,["151"] = 6});
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
    local visibility = params.visibility or "visible"
    if IsServer() then
        if self.radius > 0 and visibility == "visible" then
            self:DrawVisuals()
        end
    end
    if self.delayTime > 0 then
        self.initialized = false
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
        if percentage >= 1 then
            self.initialized = true
            self:OnReady()
        end
        self.counter = self.counter + 1
    end
end
function ModifierThinker.prototype.OnReady(self)
end
function ModifierThinker.prototype.DrawVisuals(self)
    local percentage = self.delayTime > 0 and 0 or 1
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
end
ModifierThinker = __TS__Decorate(
    {registerModifier(nil)},
    ModifierThinker
)
____exports.ModifierThinker = ModifierThinker
return ____exports
