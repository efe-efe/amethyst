local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 1,["9"] = 1,["10"] = 2,["11"] = 2,["12"] = 4,["13"] = 5,["14"] = 4,["15"] = 5,["16"] = 9,["17"] = 10,["18"] = 9,["19"] = 13,["20"] = 14,["21"] = 15,["22"] = 16,["24"] = 13,["25"] = 24,["26"] = 25,["27"] = 26,["28"] = 27,["30"] = 24,["31"] = 31,["32"] = 32,["33"] = 33,["34"] = 33,["35"] = 33,["36"] = 33,["37"] = 33,["38"] = 33,["39"] = 33,["40"] = 33,["41"] = 33,["42"] = 31,["43"] = 39,["44"] = 40,["45"] = 39,["46"] = 5,["47"] = 4,["48"] = 5,["50"] = 5,["51"] = 49,["52"] = 50,["53"] = 49,["54"] = 50,["55"] = 53,["56"] = 54,["57"] = 55,["59"] = 53,["60"] = 59,["61"] = 60,["62"] = 61,["64"] = 59,["65"] = 65,["66"] = 66,["67"] = 67,["68"] = 74,["69"] = 75,["70"] = 75,["71"] = 75,["72"] = 75,["73"] = 75,["74"] = 75,["75"] = 75,["76"] = 75,["77"] = 75,["78"] = 75,["80"] = 65,["81"] = 50,["82"] = 49,["83"] = 50,["85"] = 50});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_combat_events = require("modifiers.modifier_combat_events")
local ModifierCombatEvents = ____modifier_combat_events.ModifierCombatEvents
____exports.ModifierRuby = __TS__Class()
local ModifierRuby = ____exports.ModifierRuby
ModifierRuby.name = "ModifierRuby"
__TS__ClassExtends(ModifierRuby, ModifierCombatEvents)
function ModifierRuby.prototype.IsHidden(self)
    return false
end
function ModifierRuby.prototype.OnCreated(self, params)
    if IsServer() then
        self.damage = params.damage
        self.particleId = ParticleManager:CreateParticle("particles/generic_gameplay/rune_haste_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    end
end
function ModifierRuby.prototype.OnDestroy(self)
    if IsServer() then
        ParticleManager:DestroyParticle(self.particleId, false)
        ParticleManager:ReleaseParticleIndex(self.particleId)
    end
end
function ModifierRuby.prototype.OnBasicAttackStarted(self)
    ____exports.ModifierRubyAttack:apply(self.parent, self.parent, nil, {damage = self.damage})
    EFX(
        "particles/gems/ruby_rings.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        self.parent,
        {
            cp1 = self.parent:GetAbsOrigin(),
            release = true
        }
    )
end
function ModifierRuby.prototype.GetTexture(self)
    return "modifier_ruby"
end
ModifierRuby = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_ruby"})},
    ModifierRuby
)
____exports.ModifierRuby = ModifierRuby
____exports.ModifierRubyAttack = __TS__Class()
local ModifierRubyAttack = ____exports.ModifierRubyAttack
ModifierRubyAttack.name = "ModifierRubyAttack"
__TS__ClassExtends(ModifierRubyAttack, ModifierCombatEvents)
function ModifierRubyAttack.prototype.OnCreated(self, params)
    if IsServer() then
        self.damage = params.damage
    end
end
function ModifierRubyAttack.prototype.OnBasicAttackEnded(self)
    if IsServer() then
        self:Destroy()
    end
end
function ModifierRubyAttack.prototype.OnBasicAttackLanded(self, event)
    if IsServer() then
        ApplyDamage({victim = event.target, attacker = self.parent, damage = self.damage, damage_type = DAMAGE_TYPE_PURE})
        EmitSoundOn("Hero_DoomBringer.LvlDeath", event.target)
        EFX(
            "particles/gems/ruby.vpcf",
            PATTACH_WORLDORIGIN,
            nil,
            {
                cp0 = event.target:GetAbsOrigin(),
                cp1 = event.target:GetAbsOrigin(),
                release = true
            }
        )
    end
end
ModifierRubyAttack = __TS__Decorate(
    {registerModifier(nil, {customNameForI18n = "modifier_ruby_attack"})},
    ModifierRubyAttack
)
____exports.ModifierRubyAttack = ModifierRubyAttack
return ____exports
