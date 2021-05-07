modifier_centaur_passive = class({})

function modifier_centaur_passive:OnTrigger(params)
	if IsServer() then
		self:PlayEffectsOnTrigger()
	end
end

function modifier_centaur_passive:OnHit(params)
	if IsServer() then
		if not params.bTriggerCounters then
			return true
		end

		self:OnTrigger({})

		if params.iType == PROJECTILE_HIT then
			local projectile = params.hProjectile
			self:LaunchProjectile(projectile.Source:GetAbsOrigin())
		end
		
		return true
	end
end

function modifier_centaur_passive:LaunchProjectile(vPoint)
    if IsServer() then
        local caster = self:GetCaster()
        local parent = self:GetParent()
        local origin = parent:GetOrigin()
        local point = vPoint
        local projectile_speed = 500
        local projectile_direction = Direction2D(origin, point)
        local damage = 7
    
        CustomEntitiesLegacy:ProjectileAttack(caster, {
            tProjectile = {
                EffectName = "particles/invoker/invoker_spirit_projectile.vpcf", -- "particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_echoslam_proj_v2.vpcf",
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

function modifier_centaur_passive:GetMovementSpeedPercentage() return 100 end

function modifier_centaur_passive:PlayEffectsOnTrigger()
    local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger_sphere.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.OnHit(modifier_centaur_passive)