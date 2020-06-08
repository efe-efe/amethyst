demon_basic_attack = class({})
LinkLuaModifier("modifier_terrorblade_basic_attack", "abilities/heroes/terrorblade/terrorblade_basic_attack/modifier_terrorblade_basic_attack", LUA_MODIFIER_MOTION_NONE)

function demon_basic_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local attack_damage = caster:GetAttackDamage()

	-- Projectile data
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()

    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	-- Projectile
	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_terrorblade/terrorblade_metamorphosis_base_attack.vpcf",
		vSpawnOrigin = origin + Vector(0,0, 96),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			if _self.Source == caster then 
				caster:GiveManaPercent(mana_gain_pct, unit)

				local damage = {
					victim = unit,
					attacker = _self.Source,
					damage = attack_damage,
					damage_type = DAMAGE_TYPE_PHYSICAL,
					ability = self
				}
				ApplyDamage(damage)

				unit:AddNewModifier(caster, self, "modifier_terrorblade_basic_attack", {})
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function demon_basic_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_Terrorblade_Morphed.Attack", self:GetCaster())
end

function demon_basic_attack:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()

	-- Create Sound
	EmitSoundOnLocationWithCaster(pos, "Hero_Terrorblade_Morphed.projectileImpact", caster)

	-- Create Particle
	local particle_cast = "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.BasicAttack(demon_basic_attack)
Abilities.Initialize(
	demon_basic_attack,
	{ activity = ACT_DOTA_ATTACK, rate = 1.3 },
	{ movement_speed = 10, fixed_range = 1 }
)