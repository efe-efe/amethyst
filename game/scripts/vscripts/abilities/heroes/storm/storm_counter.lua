local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["12"] = 17,["13"] = 1,["14"] = 1,["15"] = 1,["16"] = 3,["17"] = 3,["18"] = 4,["19"] = 4,["20"] = 5,["21"] = 5,["22"] = 5,["23"] = 5,["24"] = 5,["25"] = 6,["26"] = 6,["27"] = 8,["28"] = 8,["29"] = 9,["30"] = 10,["31"] = 11,["32"] = 12,["33"] = 10,["34"] = 9,["35"] = 8,["36"] = 9,["38"] = 16,["39"] = 16,["40"] = 17,["41"] = 18,["42"] = 17,["43"] = 21,["44"] = 22,["45"] = 23,["46"] = 23,["47"] = 23,["48"] = 23,["49"] = 23,["50"] = 28,["52"] = 18,["53"] = 32,["54"] = 33,["55"] = 34,["56"] = 35,["58"] = 38,["59"] = 38,["60"] = 38,["61"] = 38,["62"] = 38,["63"] = 38,["64"] = 39,["65"] = 39,["66"] = 39,["67"] = 39,["68"] = 39,["69"] = 39,["70"] = 39,["71"] = 39,["72"] = 39,["73"] = 48,["74"] = 49,["75"] = 49,["76"] = 49,["77"] = 49,["78"] = 49,["79"] = 49,["80"] = 55,["81"] = 55,["82"] = 55,["83"] = 55,["84"] = 55,["85"] = 56,["86"] = 56,["87"] = 56,["88"] = 56,["89"] = 56,["90"] = 56,["91"] = 56,["92"] = 56,["93"] = 56,["94"] = 56,["95"] = 56,["96"] = 56,["98"] = 64,["99"] = 65,["100"] = 66,["101"] = 66,["102"] = 66,["103"] = 66,["104"] = 66,["105"] = 66,["106"] = 66,["107"] = 66,["108"] = 67,["109"] = 67,["110"] = 67,["111"] = 67,["112"] = 67,["113"] = 67,["114"] = 67,["115"] = 67,["116"] = 67,["117"] = 70,["118"] = 71,["119"] = 72,["120"] = 73,["123"] = 77,["125"] = 80,["126"] = 32,["127"] = 83,["128"] = 84,["129"] = 85,["131"] = 83,["132"] = 89,["133"] = 90,["134"] = 89,["135"] = 93,["136"] = 17,["138"] = 94,["139"] = 93,["140"] = 97,["141"] = 98,["142"] = 97,["143"] = 101,["144"] = 102,["145"] = 101,["146"] = 105,["147"] = 106,["148"] = 107,["149"] = 107,["150"] = 107,["151"] = 107,["152"] = 107,["153"] = 107,["154"] = 107,["155"] = 107,["156"] = 107,["157"] = 111,["158"] = 111,["159"] = 111,["160"] = 111,["161"] = 111,["162"] = 111,["163"] = 119,["164"] = 119,["165"] = 119,["166"] = 119,["167"] = 119,["168"] = 119,["169"] = 119,["170"] = 119,["171"] = 119,["172"] = 128,["173"] = 105,["174"] = 17,["175"] = 16,["176"] = 17,["178"] = 132,["179"] = 132,["180"] = 133,["181"] = 134,["182"] = 135,["183"] = 134,["184"] = 137,["185"] = 138,["186"] = 137,["187"] = 140,["188"] = 141,["189"] = 140,["190"] = 144,["191"] = 145,["192"] = 145,["193"] = 133,["194"] = 145,["195"] = 145,["196"] = 144,["197"] = 133,["198"] = 132,["199"] = 133});
local ____exports = {}
local ModifierStormCounter, ModifierStormCounterDisplacement
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_counter = require("modifiers.modifier_counter")
local ModifierCounter = ____modifier_counter.ModifierCounter
local ____modifier_displacement = require("modifiers.modifier_displacement")
local ModifierDisplacement = ____modifier_displacement.ModifierDisplacement
local ____util = require("util")
local createRadiusMarker = ____util.createRadiusMarker
local direction2D = ____util.direction2D
local giveManaAndEnergy = ____util.giveManaAndEnergy
local strongPurge = ____util.strongPurge
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local StormCounter = __TS__Class()
StormCounter.name = "StormCounter"
__TS__ClassExtends(StormCounter, CustomAbility)
function StormCounter.prototype.OnSpellStart(self)
    local duration = self:GetSpecialValueFor("counter_duration")
    ModifierStormCounter:apply(self.caster, self.caster, self, {duration = duration})
end
StormCounter = __TS__Decorate(
    {registerAbility(nil, "storm_counter")},
    StormCounter
)
ModifierStormCounter = __TS__Class()
ModifierStormCounter.name = "ModifierStormCounter"
__TS__ClassExtends(ModifierStormCounter, ModifierCounter)
function ModifierStormCounter.prototype.OnDestroy(self)
    ModifierCounter.prototype.OnDestroy(self)
    if IsServer() then
        EmitSoundOn("Hero_Juggernaut.Attack", self.parent)
        local particleId = ParticleManager:CreateParticle(
            "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bonus.vpcf",
            PATTACH_ABSORIGIN_FOLLOW,
            self:GetCaster()
        )
        ParticleManager:ReleaseParticleIndex(particleId)
    end
end
function ModifierStormCounter.prototype.OnHit(self, event)
    if IsServer() then
        if not event.triggerCounters then
            return true
        end
        giveManaAndEnergy(
            nil,
            self.parent,
            self:Value("mana_gain"),
            true
        )
        local enemies = CustomEntitiesLegacy:FindUnitsInRadius(
            self.parent,
            self.parent:GetAbsOrigin(),
            self:Value("radius"),
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER
        )
        for ____, enemy in ipairs(enemies) do
            ApplyDamage({
                victim = enemy,
                attacker = self.parent,
                damage = self:Value("ability_damage"),
                damage_type = DAMAGE_TYPE_PURE
            })
            local direction = direction2D(
                nil,
                self.parent:GetAbsOrigin(),
                enemy:GetAbsOrigin()
            )
            ModifierStormCounterDisplacement:apply(
                enemy,
                self.parent,
                self.ability,
                {
                    x = direction.x,
                    y = direction.y,
                    distance = self:Value("knockback_distance"),
                    speed = self:Value("knockback_distance") / 0.25,
                    peak = 50
                }
            )
        end
        strongPurge(nil, self.parent)
        self:PlayEffectsOnTrigger()
        createRadiusMarker(
            nil,
            self.parent,
            self.parent:GetAbsOrigin(),
            self:Value("radius"),
            "public",
            0.1
        )
        ScreenShake(
            self.parent:GetAbsOrigin(),
            100,
            300,
            0.45,
            1000,
            0,
            true
        )
        if event.attackCategory == "projectile" then
            local projectile = event.projectile
            if projectile:getIsDestructible() then
                projectile:scheduleDestroy()
            end
        end
        return false
    end
    return true
end
function ModifierStormCounter.prototype.AfterHit(self)
    if IsServer() then
        self:Destroy()
    end
end
function ModifierStormCounter.prototype.GetMovementSpeedPercentage(self)
    return 0
end
function ModifierStormCounter.prototype.DeclareFunctions(self)
    local ____array_0 = __TS__SparseArrayNew(unpack(ModifierCounter.prototype.DeclareFunctions(self)))
    __TS__SparseArrayPush(____array_0, MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE)
    return {__TS__SparseArraySpread(____array_0)}
end
function ModifierStormCounter.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_CAST_ABILITY_1
end
function ModifierStormCounter.prototype.GetOverrideAnimationRate(self)
    return 0.5
end
function ModifierStormCounter.prototype.PlayEffectsOnTrigger(self)
    EmitSoundOn("stormspirit_ss_laugh_04", self.parent)
    EFX(
        "particles/units/heroes/hero_void_spirit/voidspirit_overload_discharge.vpcf",
        PATTACH_WORLDORIGIN,
        self.parent,
        {
            cp0 = self.parent:GetAbsOrigin(),
            release = true
        }
    )
    local particleId = EFX(
        "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_chakra_magic.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        self.parent,
        {cp1 = self.parent:GetAbsOrigin()}
    )
    ParticleManager:SetParticleControlEnt(
        particleId,
        1,
        self.parent,
        PATTACH_POINT_FOLLOW,
        "attach_hitloc",
        self.parent:GetAbsOrigin(),
        true
    )
    ParticleManager:ReleaseParticleIndex(particleId)
end
ModifierStormCounter = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_storm_counter_countering"})},
    ModifierStormCounter
)
ModifierStormCounterDisplacement = __TS__Class()
ModifierStormCounterDisplacement.name = "ModifierStormCounterDisplacement"
__TS__ClassExtends(ModifierStormCounterDisplacement, ModifierDisplacement)
function ModifierStormCounterDisplacement.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE}
end
function ModifierStormCounterDisplacement.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_FLAIL
end
function ModifierStormCounterDisplacement.prototype.GetOverrideAnimationRate(self)
    return 1
end
function ModifierStormCounterDisplacement.prototype.CheckState(self)
    return __TS__ObjectAssign(
        {},
        ModifierDisplacement.prototype.CheckState(self),
        {[MODIFIER_STATE_NO_HEALTH_BAR] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true}
    )
end
ModifierStormCounterDisplacement = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_storm_counter_displacement"})},
    ModifierStormCounterDisplacement
)
return ____exports
