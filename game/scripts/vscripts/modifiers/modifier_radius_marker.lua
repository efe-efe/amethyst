local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 6,["13"] = 7,["14"] = 6,["15"] = 7,["17"] = 7,["18"] = 8,["19"] = 9,["20"] = 10,["21"] = 6,["22"] = 16,["23"] = 17,["24"] = 18,["25"] = 19,["26"] = 20,["27"] = 21,["28"] = 23,["29"] = 25,["30"] = 26,["32"] = 28,["33"] = 29,["36"] = 16,["37"] = 34,["38"] = 35,["39"] = 36,["40"] = 37,["42"] = 34,["43"] = 41,["44"] = 42,["45"] = 43,["46"] = 45,["47"] = 46,["48"] = 47,["49"] = 47,["50"] = 47,["51"] = 47,["52"] = 47,["53"] = 48,["54"] = 48,["55"] = 48,["56"] = 48,["57"] = 48,["60"] = 52,["61"] = 53,["63"] = 56,["65"] = 58,["66"] = 59,["68"] = 41,["69"] = 63,["70"] = 64,["71"] = 65,["72"] = 67,["73"] = 68,["74"] = 69,["75"] = 70,["76"] = 77,["77"] = 77,["78"] = 77,["79"] = 77,["80"] = 77,["81"] = 78,["82"] = 78,["83"] = 78,["84"] = 78,["85"] = 78,["86"] = 79,["87"] = 79,["88"] = 79,["89"] = 79,["90"] = 79,["91"] = 80,["92"] = 80,["93"] = 80,["94"] = 80,["95"] = 80,["96"] = 81,["97"] = 82,["98"] = 83,["99"] = 83,["100"] = 83,["101"] = 83,["102"] = 83,["104"] = 85,["105"] = 85,["106"] = 85,["107"] = 85,["108"] = 85,["110"] = 87,["111"] = 87,["115"] = 91,["116"] = 92,["117"] = 93,["118"] = 100,["119"] = 100,["120"] = 100,["121"] = 100,["122"] = 100,["123"] = 101,["124"] = 101,["125"] = 101,["126"] = 101,["127"] = 101,["128"] = 102,["129"] = 102,["130"] = 102,["131"] = 102,["132"] = 102,["133"] = 103,["134"] = 103,["136"] = 63,["137"] = 107,["138"] = 108,["139"] = 109,["140"] = 110,["142"] = 107,["143"] = 7,["144"] = 6,["145"] = 7,["147"] = 7});
local ____exports = {}
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.ModifierRadiusMarker = __TS__Class()
local ModifierRadiusMarker = ____exports.ModifierRadiusMarker
ModifierRadiusMarker.name = "ModifierRadiusMarker"
__TS__ClassExtends(ModifierRadiusMarker, CustomModifier)
function ModifierRadiusMarker.prototype.____constructor(self, ...)
    CustomModifier.prototype.____constructor(self, ...)
    self.particleIds = {}
    self.counter = 0
    self.initialized = false
end
function ModifierRadiusMarker.prototype.OnCreated(self, params)
    if IsServer() then
        self.radius = params.radius
        self.delay = params.delay
        self.afterDelay = params.afterDelay
        self.scope = params.scope
        self:DrawVisuals()
        if self.delay > 0 then
            self:StartIntervalThink(0.03)
        else
            self.initialized = true
            self:OnIntervalThink()
        end
    end
end
function ModifierRadiusMarker.prototype.OnDestroy(self)
    if IsServer() then
        self:RemoveVisuals()
        UTIL_Remove(self:GetParent())
    end
end
function ModifierRadiusMarker.prototype.OnIntervalThink(self)
    if not self.initialized then
        local percentage = self.counter / (self.delay * 30)
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
        if percentage >= 1 then
            self.initialized = true
        end
        self.counter = self.counter + 1
    else
        self:SetDuration(self.afterDelay, true)
        self:StartIntervalThink(-1)
    end
end
function ModifierRadiusMarker.prototype.DrawVisuals(self)
    local percentage = self.delay > 0 and 0 or 1
    local caster_alliance = CustomEntitiesLegacy:GetAlliance(self.caster)
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
                if alliance == caster_alliance then
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
function ModifierRadiusMarker.prototype.RemoveVisuals(self)
    for ____, particleId in ipairs(self.particleIds) do
        ParticleManager:DestroyParticle(particleId, false)
        ParticleManager:ReleaseParticleIndex(particleId)
    end
end
ModifierRadiusMarker = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_radius_marker"})},
    ModifierRadiusMarker
)
____exports.ModifierRadiusMarker = ModifierRadiusMarker
return ____exports
