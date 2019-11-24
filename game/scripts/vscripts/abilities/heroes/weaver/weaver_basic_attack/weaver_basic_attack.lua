weaver_basic_attack = class({})
LinkLuaModifier( "modifier_weaver_basic_attack_charges", "abilities/heroes/weaver/weaver_basic_attack/modifier_weaver_basic_attack_charges", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function weaver_basic_attack:GetIntrinsicModifierName()
	return "modifier_weaver_basic_attack_charges"
end

function weaver_basic_attack:HasCharges()
	return true
end

function weaver_basic_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local attack_damage = caster:GetAttackDamage()

	-- Projectile data
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	local extra_damage = self:GetSpecialValueFor("extra_damage")
	local modifier = caster:FindModifierByName("modifier_weaver_basic_attack_stack")
	local charged = modifier and (modifier:GetStackCount() == 3 and true or false) or false
    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	-- Projectile
	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_weaver/weaver_base_attack.vpcf",
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
			end
			
			local damage = {
				victim = unit,
				attacker = _self.Source,
				damage = attack_damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
			}
			ApplyDamage( damage )
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos, charged)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function weaver_basic_attack:PlayEffectsOnCast()
	EmitSoundOn( "Hero_Weaver.Attack", self:GetCaster() )
end

function weaver_basic_attack:PlayEffectsOnFinish( pos, charged )
	local caster = self:GetCaster()

	-- Create Sound
	EmitSoundOnLocationWithCaster( pos, "Hero_Weaver.ProjectileImpact", caster )

	-- Create Particle
	local particle_cast = charged and "particles/items4_fx/meteor_hammer_spell_impact_ember.vpcf" or "particles/units/heroes/hero_vengeful/vengeful_base_attack_end_flash.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("wrappers/abilities") end
Abilities.BasicAttack( weaver_basic_attack )
Abilities.Initialize( 
	weaver_basic_attack,
	{ activity = ACT_DOTA_ATTACK, rate = 1.8 },
	{ movement_speed = 10, hide_indicator = 1, fixed_range = 1 }
)