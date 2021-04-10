sniper_basic_attack = class({})
LinkLuaModifier("modifier_sniper_basic_attack_charges", "abilities/heroes/sniper/sniper_basic_attack/modifier_sniper_basic_attack_charges", LUA_MODIFIER_MOTION_NONE)

function sniper_basic_attack:GetIntrinsicModifierName()
	return "modifier_sniper_basic_attack_charges"
end

function sniper_basic_attack:GetCastPoint()
	if IsServer() then
		return self.BaseClass.GetCastPoint(self) + self:GetCaster():GetAttackAnimationPoint()
	end
end

function sniper_basic_attack:GetCastAnimationCustom()	return ACT_DOTA_ATTACK end
function sniper_basic_attack:GetPlaybackRateOverride() 	return 1.5 end
function sniper_basic_attack:GetCastPointSpeed()
	return 10
end

function sniper_basic_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = CustomAbilities:GetCursorPosition(self)
	local origin = caster:GetOrigin()
    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = Direction2D(origin, point)

	caster:FindModifierByName('modifier_sniper_basic_attack_charges'):ResetCooldown()

	CustomEntities:ProjectileAttack(caster, {
		bIsBasicAttack = true,
		tProjectile = {
			EffectName = "particles/sniper/sniper_basic_attack.vpcf",
			vSpawnOrigin = origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96),
			fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
			fStartRadius = self:GetSpecialValueFor("hitbox"),
			Source = caster,
			vVelocity = projectile_direction * projectile_speed,
			UnitBehavior = PROJECTILES_DESTROY,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_DESTROY,
			GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntities:Allies(_self.Source, unit) end,
			OnUnitHit = function(_self, unit)
				CustomEntities:AttackWithBaseDamage(caster, {
					hTarget = unit,
					hAbility = self,
				})
				
				if _self.Source == caster then 
					if CustomEntities:ProvidesMana(unit) then
						CustomEntities:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
					end
				end
			end,
			OnFinish = function(_self, pos)
				self:PlayEffectsOnFinish(pos)
			end,
		}
	})

	self:PlayEffectsOnCast()
end

function sniper_basic_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_Sniper.MKG_attack", self:GetCaster())
end

function sniper_basic_attack:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()
	EmitSoundOnLocationWithCaster(pos, "Hero_Sniper.ProjectileImpact", caster)

	local particle_cast = "particles/sniper/sniper_basic_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(sniper_basic_attack)