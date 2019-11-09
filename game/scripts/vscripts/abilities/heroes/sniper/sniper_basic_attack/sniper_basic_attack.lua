sniper_basic_attack = class({})
LinkLuaModifier( "modifier_sniper_basic_attack_charges", "abilities/heroes/sniper/sniper_basic_attack/modifier_sniper_basic_attack_charges", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
--Passive Modifier
function sniper_basic_attack:GetIntrinsicModifierName()
	return "modifier_sniper_basic_attack_charges"
end

function sniper_basic_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	-- Projectile data
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local modifier = caster:FindModifierByName("modifier_sniper_basic_attack_charges")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	-- Projectile
	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_sniper/hero_gyrocopter_gyrotechnics/gyro_base_attack.vpcf",
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
			caster:PerformAttack(
				unit, -- handle hTarget 
				true, -- bool bUseCastAttackOrb, 
				true, -- bool bProcessProcs,
				true, -- bool bSkipCooldown
				false, -- bool bIgnoreInvis
				false, -- bool bUseProjectile
				false, -- bool bFakeAttack
				true -- bool bNeverMiss
			)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	modifier:DecrementStackCount()
	modifier:CalculateCharge()
	
	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Misc
-- Add mana on attack modifier. Only first time upgraded
function sniper_basic_attack:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On ability start
function sniper_basic_attack:PlayEffectsOnCast()
	EmitSoundOn( "Hero_Sniper.MKG_attack", self:GetCaster() )
end


-- On Projectile finish
function sniper_basic_attack:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()

	-- Create Sound
	EmitSoundOnLocationWithCaster( pos, "Hero_Sniper.ProjectileImpact", caster )

	-- Create Particle
	local particle_cast = "particles/mod_units/heroes/hero_sniper/hero_gyrocopter_gyrotechnics/gyro_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("abilities") end
Abilities.BasicAttack( sniper_basic_attack )
Abilities.Initialize( 
	sniper_basic_attack,
	{ activity = ACT_DOTA_RUN, translate = "aggressive", rate = 1.0 },
	{ movement_speed = 10, hide_indicator = 1, fixed_range = 1 }
)