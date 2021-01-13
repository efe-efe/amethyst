item_soul_custom = class({})
LinkLuaModifier("modifier_item_soul_custom", "items/item_soul_custom/modifier_item_soul_custom", LUA_MODIFIER_MOTION_HORIZONTAL)

function item_soul_custom:OnSpellStart()
    local caster = self:GetCaster()
    local current_health = self:GetCaster():GetHealth()
    local damage = self:GetSpecialValueFor("self_damage")
    local duration = self:GetSpecialValueFor("duration")
    local current_mana = self:GetCaster():GetMana()
    local max_mana = self:GetCaster():GetMaxMana()

    local damage_table = {
        victim = caster,
        attacker = caster,
        damage_type = DAMAGE_TYPE_PURE,
    }

    if current_health - damage <= 0 then
        damage_table.damage = current_health - 1
    else
        damage_table.damage = damage
    end
    ApplyDamage(damage_table)

    Timers:CreateTimer(0.03, function()
        CustomEntities:GiveManaAndEnergy(caster, self:GetSpecialValueFor("mana"), true)
        caster:AddNewModifier(caster, self, "modifier_item_soul_custom", { duration = duration, current_mana = current_mana, max_mana = max_mana})
    end)
    self:PlayEffects()
end

function item_soul_custom:PlayEffects()
    EmitSoundOn("DOTA_Item.SoulRing.Activate", self:GetCaster() )

    local particle_cast = "particles/items2_fx/soul_ring.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(5,0,0))
    ParticleManager:ReleaseParticleIndex(effect_cast)
end