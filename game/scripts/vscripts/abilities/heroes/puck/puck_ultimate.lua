local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 36,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 4,["17"] = 4,["18"] = 5,["19"] = 5,["20"] = 6,["21"] = 6,["22"] = 6,["23"] = 7,["24"] = 7,["25"] = 9,["26"] = 9,["27"] = 10,["28"] = 11,["29"] = 12,["30"] = 11,["31"] = 14,["32"] = 15,["33"] = 14,["34"] = 17,["35"] = 18,["36"] = 17,["37"] = 21,["38"] = 22,["39"] = 23,["40"] = 24,["41"] = 24,["42"] = 24,["43"] = 24,["44"] = 24,["45"] = 24,["46"] = 24,["47"] = 24,["48"] = 24,["49"] = 26,["50"] = 26,["51"] = 26,["52"] = 26,["53"] = 26,["54"] = 26,["55"] = 26,["56"] = 26,["57"] = 26,["58"] = 31,["59"] = 21,["60"] = 10,["61"] = 9,["62"] = 10,["64"] = 35,["65"] = 35,["66"] = 36,["67"] = 39,["68"] = 40,["69"] = 39,["70"] = 43,["71"] = 44,["72"] = 43,["73"] = 47,["74"] = 48,["75"] = 47,["76"] = 51,["77"] = 52,["78"] = 51,["79"] = 55,["80"] = 56,["81"] = 55,["82"] = 59,["83"] = 60,["84"] = 59,["85"] = 63,["86"] = 36,["87"] = 65,["88"] = 66,["89"] = 66,["90"] = 66,["91"] = 66,["92"] = 66,["93"] = 66,["94"] = 66,["95"] = 66,["96"] = 66,["97"] = 76,["98"] = 77,["99"] = 77,["100"] = 77,["101"] = 77,["102"] = 77,["103"] = 77,["104"] = 77,["105"] = 77,["106"] = 77,["107"] = 77,["108"] = 77,["109"] = 83,["110"] = 83,["111"] = 83,["112"] = 83,["113"] = 83,["114"] = 83,["116"] = 88,["118"] = 63,["119"] = 96,["120"] = 36,["121"] = 98,["122"] = 99,["123"] = 100,["125"] = 96,["126"] = 104,["127"] = 105,["128"] = 104,["129"] = 108,["130"] = 109,["131"] = 110,["134"] = 113,["135"] = 114,["136"] = 115,["137"] = 116,["138"] = 117,["139"] = 117,["140"] = 117,["141"] = 117,["142"] = 117,["146"] = 108,["147"] = 36,["148"] = 35,["149"] = 36,["151"] = 123,["152"] = 123,["153"] = 124,["154"] = 127,["155"] = 128,["156"] = 129,["157"] = 130,["159"] = 127,["160"] = 134,["161"] = 135,["162"] = 140,["163"] = 141,["164"] = 141,["165"] = 141,["166"] = 141,["167"] = 141,["168"] = 141,["169"] = 141,["170"] = 141,["171"] = 141,["172"] = 151,["173"] = 151,["174"] = 151,["175"] = 151,["176"] = 151,["177"] = 151,["178"] = 151,["179"] = 151,["180"] = 134,["181"] = 124,["182"] = 123,["183"] = 124,["185"] = 155,["186"] = 155,["187"] = 156,["188"] = 157,["189"] = 158,["190"] = 157,["191"] = 161,["192"] = 162,["193"] = 161,["194"] = 165,["195"] = 166,["196"] = 167,["197"] = 168,["198"] = 168,["199"] = 168,["200"] = 168,["201"] = 168,["202"] = 168,["203"] = 174,["204"] = 175,["205"] = 175,["206"] = 175,["207"] = 175,["208"] = 175,["209"] = 175,["210"] = 178,["213"] = 165,["214"] = 156,["215"] = 155,["216"] = 156});
local ____exports = {}
local ModifierPuckUltimateThinker, ModifierPuckUltimate, ModifierPuckUltimateCheck
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_thinker = require("modifiers.modifier_thinker")
local ModifierThinker = ____modifier_thinker.ModifierThinker
local ____util = require("util")
local clampPosition = ____util.clampPosition
local ____custom_ability = require("abilities.framework.custom_ability")
local CustomAbility = ____custom_ability.CustomAbility
local ____custom_modifier = require("abilities.framework.custom_modifier")
local CustomModifier = ____custom_modifier.CustomModifier
local ____puck_basic_attack = require("abilities.heroes.puck.puck_basic_attack")
local PuckBasicAttack = ____puck_basic_attack.PuckBasicAttack
local PuckBasicAttackRelated = ____puck_basic_attack.PuckBasicAttackRelated
local ____puck_counter = require("abilities.heroes.puck.puck_counter")
local PuckCounter = ____puck_counter.PuckCounter
local PuckUltimate = __TS__Class()
PuckUltimate.name = "PuckUltimate"
__TS__ClassExtends(PuckUltimate, CustomAbility)
function PuckUltimate.prototype.GetAnimation(self)
    return ACT_DOTA_CAST_ABILITY_5
end
function PuckUltimate.prototype.GetPlaybackRateOverride(self)
    return 1
end
function PuckUltimate.prototype.GetCastingCrawl(self)
    return 0
end
function PuckUltimate.prototype.OnSpellStart(self)
    local origin = self.caster:GetAbsOrigin()
    local cursor = CustomAbilitiesLegacy:GetCursorPosition(self)
    local point = clampPosition(
        nil,
        origin,
        cursor,
        {maxRange = self:GetCastRange(
            Vector(0, 0, 0),
            nil
        )}
    )
    ModifierPuckUltimateThinker:createThinker(
        self.caster,
        self,
        point,
        {
            duration = self:GetSpecialValueFor("duration") + 0.2,
            delayTime = self:GetSpecialValueFor("duration")
        }
    )
    EmitSoundOn("Hero_Puck.Dream_Coil", self.caster)
end
PuckUltimate = __TS__Decorate(
    {registerAbility(nil, "puck_ultimate")},
    PuckUltimate
)
ModifierPuckUltimateThinker = __TS__Class()
ModifierPuckUltimateThinker.name = "ModifierPuckUltimateThinker"
__TS__ClassExtends(ModifierPuckUltimateThinker, ModifierThinker)
function ModifierPuckUltimateThinker.prototype.IsAura(self)
    return true
end
function ModifierPuckUltimateThinker.prototype.GetModifierAura(self)
    return ModifierPuckUltimateCheck.name
end
function ModifierPuckUltimateThinker.prototype.GetAuraRadius(self)
    return self.radius
end
function ModifierPuckUltimateThinker.prototype.GetAuraDuration(self)
    return 0
end
function ModifierPuckUltimateThinker.prototype.GetAuraSearchTeam(self)
    return DOTA_UNIT_TARGET_TEAM_BOTH
end
function ModifierPuckUltimateThinker.prototype.GetAuraSearchType(self)
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function ModifierPuckUltimateThinker.prototype.OnCreated(self, params)
    ModifierThinker.prototype.OnCreated(self, params)
    if IsServer() then
        local enemies = CustomEntitiesLegacy:FindUnitsInRadius(
            self.caster,
            self.parent:GetAbsOrigin(),
            self.radius,
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER
        )
        for ____, enemy in ipairs(enemies) do
            ModifierPuckUltimate:apply(
                enemy,
                self.caster,
                self.ability,
                {
                    duration = self:Value("duration"),
                    x = self.parent:GetAbsOrigin().x,
                    y = self.parent:GetAbsOrigin().y,
                    z = self.parent:GetAbsOrigin().z
                }
            )
            enemy:AddNewModifier(
                self.caster,
                self.ability,
                "modifier_generic_stunned",
                {duration = self:Value("initial_stun_duration")}
            )
        end
        self.particleId = ParticleManager:CreateParticle("particles/econ/items/puck/puck_alliance_set/puck_dreamcoil_aproset.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    end
end
function ModifierPuckUltimateThinker.prototype.OnDestroy(self)
    ModifierThinker.prototype.OnDestroy(self)
    if IsServer() and self.particleId then
        ParticleManager:DestroyParticle(self.particleId, false)
        ParticleManager:ReleaseParticleIndex(self.particleId)
    end
end
function ModifierPuckUltimateThinker.prototype.DeclareFunctions(self)
    return {MODIFIER_EVENT_ON_ABILITY_EXECUTED}
end
function ModifierPuckUltimateThinker.prototype.OnAbilityExecuted(self, event)
    if IsServer() then
        if event.unit ~= self.caster then
            return
        end
        local basicAttack = PuckBasicAttack:findOne(self.caster)
        local counter = PuckCounter:findOne(self.caster)
        local basicAttackRelated = PuckBasicAttackRelated:findOne(self.caster)
        if event.ability == counter or event.ability == basicAttackRelated or event.ability == basicAttack then
            if basicAttack ~= nil then
                basicAttack:LaunchProjectile(
                    self.parent:GetAbsOrigin(),
                    CustomAbilitiesLegacy:GetCursorPosition(self.ability)
                )
            end
        end
    end
end
ModifierPuckUltimateThinker = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_ultimate_thinker"})},
    ModifierPuckUltimateThinker
)
ModifierPuckUltimate = __TS__Class()
ModifierPuckUltimate.name = "ModifierPuckUltimate"
__TS__ClassExtends(ModifierPuckUltimate, CustomModifier)
function ModifierPuckUltimate.prototype.OnCreated(self, params)
    if IsServer() then
        self.origin = Vector(params.x, params.y, params.z)
        self:PlayEffects()
    end
end
function ModifierPuckUltimate.prototype.PlayEffects(self)
    local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_puck/puck_dreamcoil_tether.vpcf", PATTACH_ABSORIGIN, self.parent)
    ParticleManager:SetParticleControl(particleId, 0, self.origin)
    ParticleManager:SetParticleControlEnt(
        particleId,
        1,
        self.parent,
        PATTACH_POINT_FOLLOW,
        "attach_hitloc",
        self.parent:GetAbsOrigin(),
        true
    )
    self:AddParticle(
        particleId,
        false,
        false,
        -1,
        false,
        false
    )
end
ModifierPuckUltimate = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_ultimate_debuff"})},
    ModifierPuckUltimate
)
ModifierPuckUltimateCheck = __TS__Class()
ModifierPuckUltimateCheck.name = "ModifierPuckUltimateCheck"
__TS__ClassExtends(ModifierPuckUltimateCheck, CustomModifier)
function ModifierPuckUltimateCheck.prototype.IsHidden(self)
    return true
end
function ModifierPuckUltimateCheck.prototype.IsPurgable(self)
    return false
end
function ModifierPuckUltimateCheck.prototype.OnDestroy(self)
    if IsServer() then
        if ModifierPuckUltimate:findOne(self.parent) then
            ApplyDamage({
                victim = self.parent,
                attacker = self.caster,
                damage = self:Value("ability_damage"),
                damage_type = DAMAGE_TYPE_PURE
            })
            self.parent:RemoveModifierByName(ModifierPuckUltimate.name)
            self.parent:AddNewModifier(
                self.caster,
                self.ability,
                "modifier_generic_stunned",
                {duration = self:Value("snap_stun_duration")}
            )
            EmitSoundOn("Hero_Puck.Dream_Coil_Snap", self.parent)
        end
    end
end
ModifierPuckUltimateCheck = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_puck_ultimate_area_check"})},
    ModifierPuckUltimateCheck
)
return ____exports
