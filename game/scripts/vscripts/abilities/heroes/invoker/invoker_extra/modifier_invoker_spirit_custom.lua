modifier_invoker_spirit_custom = class({})

function modifier_invoker_spirit_custom:OnCreated(table)
    if IsServer() then
        self.efx = EFX("particles/econ/items/invoker/ti8_invoker_prism_crystal_spellcaster/ti8_invoker_prism_forge_spirit_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), {})
        self.radius_marker_modifier = CreateTimedRadiusMarker(self:GetCaster(), self:GetParent():GetAbsOrigin(), 150, self:GetDuration(), 0.0, RADIUS_SCOPE_PUBLIC):FindModifierByName('radius_marker_thinker')
    end
end

function modifier_invoker_spirit_custom:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ORDER,
        MODIFIER_EVENT_ON_ABILITY_EXECUTED,
    }
end

function modifier_invoker_spirit_custom:OnOrder(params)
    if params.unit ~= self:GetCaster() then
        return
    end
    
    local invoker_basic_attack = self:GetCaster():FindAbilityByName("invoker_basic_attack")
    if  params.ability == invoker_basic_attack then
        local parent = self:GetParent()
        local origin = parent:GetAbsOrigin()
        local point = CustomAbilities:GetCursorPosition(self:GetAbility())
        local direction = Direction2D(origin, point)

        CustomEntitiesLegacy:FullyFaceTowards(self:GetParent(), direction)
        self:GetParent():StartGesture(ACT_DOTA_ATTACK)
    end
end

function modifier_invoker_spirit_custom:OnAbilityExecuted(params)
    if IsServer() then
        if params.unit ~= self:GetCaster() then
            return
        end

        local invoker_basic_attack = self:GetCaster():FindAbilityByName("invoker_basic_attack")
        if  params.ability == invoker_basic_attack then
            self:LaunchProjectile(CustomAbilities:GetCursorPosition(self:GetAbility()))
        end
    end
end

function modifier_invoker_spirit_custom:OnDestroy()
    if IsServer() then
        DEFX(self.efx, true)

        if self.radius_marker_modifier ~= nil then
            if not self.radius_marker_modifier:IsNull() then
                self.radius_marker_modifier:Destroy()
            end
        end

        self:GetParent():Kill(nil, self:GetParent())
    end
end

function modifier_invoker_spirit_custom:LaunchProjectile(vPoint)
    if IsServer() then
        local caster = self:GetCaster()
        local parent = self:GetParent()
        local origin = parent:GetOrigin()
        local point = vPoint
        local mana_gain_pct = 3
        local projectile_speed = 2000
        local projectile_direction = Direction2D(origin, point)
        local damage = parent:GetAverageTrueAttackDamage(parent)
    
        CustomEntitiesLegacy:ProjectileAttack(caster, {
            tProjectile = {
                EffectName = "particles/invoker/invoker_spirit_projectile.vpcf",
                vSpawnOrigin = origin + Vector(0, 0, 96),
                fDistance = 1200,
                fStartRadius = 70,
                Source = parent,
                vVelocity = projectile_direction * projectile_speed,
                UnitBehavior = PROJECTILES_DESTROY,
                TreeBehavior = PROJECTILES_NOTHING,
                WallBehavior = PROJECTILES_DESTROY,
                GroundBehavior = PROJECTILES_NOTHING,
                fGroundOffset = 0,
                UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) end,
                OnUnitHit = function(_self, unit) 
                    local damage_table = {
                        victim = unit,
                        attacker = _self.Source,
                        damage = damage,
                        damage_type = DAMAGE_TYPE_PHYSICAL,
                        ability = self
                    }
                    ApplyDamage(damage_table)
        
                    if _self.Source == parent then
                        if CustomEntitiesLegacy:ProvidesMana(unit) then
                            CustomEntitiesLegacy:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
                        end
                    end
                end,
                OnFinish = function(_self, pos)
                    EFX("particles/units/heroes/hero_invoker_kid/invoker_kid_forged_spirit_projectile_end.vpcf", PATTACH_WORLDORIGIN, nil, {
                        cp0 = pos,
                        cp3 = pos,
                    })
                end,
            }
        })
    end
end