centaur_range_attack = class({})

function centaur_range_attack:GetCastAnimationCustom() return ACT_DOTA_ATTACK end
function centaur_range_attack:GetPlaybackRateOverride() return 0.8 end
function centaur_range_attack:GetCastPointSpeed() return 0 end


function centaur_range_attack:OnAbilityPhaseStart()
	EFX('particles/units/heroes/hero_dawnbreaker/dawnbreaker_converge.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetCaster(), { relese = true })
	return true
end


function centaur_range_attack:OnSpellStart()
    local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local straight_direction = Direction2D(origin, point)

    
    local directions = {}
    table.insert(directions, straight_direction)
    table.insert(directions, RotatePoint(Vector(0,0,0), Vector(0,0,0) + straight_direction, -30):Normalized())
    table.insert(directions, RotatePoint(Vector(0,0,0), Vector(0,0,0) + straight_direction, 30):Normalized())

    for _,direction in ipairs(directions) do
        self:LaunchProjectile(direction)
    end
	self:PlayEffectsOnCast()
end

function centaur_range_attack:LaunchProjectile(vDirection)
    local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local damage = self:GetSpecialValueFor("ability_damage")
	local damage_table = {
        damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
	}

	CustomEntitiesLegacy:ProjectileAttack(caster, {
		tProjectile = {
			EffectName = "particles/units/heroes/hero_invoker/invoker_deafening_blast.vpcf",
			vSpawnOrigin = origin + Vector(vDirection.x * 45, vDirection.y * 45, 96),
			fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
			fStartRadius = self:GetSpecialValueFor("hitbox"),
			Source = caster,
			vVelocity = vDirection * projectile_speed,
			UnitBehavior = PROJECTILES_NOTHING,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_DESTROY,
			GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) end,
			OnUnitHit = function(_self, unit)
				damage_table.victim = unit
				damage_table.attacker = _self.Source
				
				ApplyDamage(damage_table)
				self:PlayEffectsOnHit(unit)
			end,
			OnFinish = function(_self, pos)
				self:PlayEffectsOnFinish(pos, 'particles/units/heroes/hero_sniper/sniper_assassinate_impact_sparks.vpcf')
			end,
		}
	})
end

function centaur_range_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_Centaur.DoubleEdge.TI9", self:GetCaster())
end

function centaur_range_attack:PlayEffectsOnFinish(pos, particle_cast)
	local caster = self:GetCaster()
	EmitSoundOnLocationWithCaster(pos, "Hero_Centaur.DoubleEdge", caster)
	EmitSoundOnLocationWithCaster(pos, "Hero_Centaur.DoubleEdge.TI9_layer", caster)
	EmitSoundOnLocationWithCaster(pos, "Hero_Centaur.Gore", caster)

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 1, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function centaur_range_attack:PlayEffectsOnHit(hTarget)
	local caster = self:GetCaster()
	EmitSoundOn("Hero_Sniper.AssassinateDamage", caster)

	local particle_cast = "particles/units/heroes/hero_sniper/sniper_assassinate_impact_blood.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)

	ParticleManager:SetParticleControl(effect_cast, 0, hTarget:GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, hTarget:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(centaur_range_attack)