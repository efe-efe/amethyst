spectre_basic_attack = class({})
LinkLuaModifier( "modifier_spectre_desolate_lua", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_desolate_lua/modifier_spectre_desolate_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_basic_attack", "abilities/heroes/spectre/spectre_basic_attack/modifier_spectre_basic_attack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
--Passive Modifier
function spectre_basic_attack:GetIntrinsicModifierName()
	return "modifier_spectre_basic_attack"
end

function spectre_basic_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local attack_damage = caster:GetAttackDamage()

	local heal = self:GetSpecialValueFor("heal")
	local desolate_duration = self:GetSpecialValueFor("desolate_duration")
	local silence_duration = self:GetSpecialValueFor("silence_duration")

	local heal_charged = self:GetSpecialValueFor("heal_charged")
	local damage_bonus_charged = self:GetSpecialValueFor("damage_bonus_charged")

	local projectile_speed = 3000
	local projectile_direction = ( Vector( point.x - origin.x, point.y - origin.y, 0)):Normalized()
	local offset = 10

	local modifier = caster:FindModifierByName("modifier_spectre_basic_attack")
	local charged = modifier:GetStackCount() > 0 and true or false 

	local projectile = {
		vSpawnOrigin = origin + Vector(projectile_direction.x * offset, projectile_direction.y * offset, 0),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" end,
		OnUnitHit = function(_self, unit)
			local counter = 0
			for k, v in pairs(_self.rehit) do counter = counter + 1 end
			if counter > 1 and not charged then return end

			-- perform the actual attack
			_self.Source:PerformAttack(
				unit, -- handle hTarget 
				true, -- bool bUseCastAttackOrb, 
				true, -- bool bProcessProcs,
				true, -- bool bSkipCooldown
				false, -- bool bIgnoreInvis
				false, -- bool bUseProjectile
				false, -- bool bFakeAttack
				true -- bool bNeverMiss
			)
			
			--Apply charged weapon effects
			if charged then
				--Silence enemy
				unit:AddNewModifier(_self.Source, self , "modifier_generic_silenced_lua", { duration = silence_duration })
				unit:AddNewModifier(_self.Source, self , "modifier_spectre_desolate_lua", { duration = desolate_duration })
				_self.Source:Heal( heal_charged, _self.Source )

				local damage = {
					victim = unit,
					attacker = _self.Source,
					damage = damage_bonus_charged,
					damage_type = DAMAGE_TYPE_PHYSICAL,
				}
		
				ApplyDamage( damage )
			end 
			self:PlayEffectsOnImpact(unit, _self.currentPosition, charged)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos, charged)
		end,
	}

	modifier:DecrementStackCount()
	modifier:CalculateCharge()
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Misc
-- Add mana on attack modifier. Only first time upgraded
function spectre_basic_attack:OnUpgrade()
	if self:GetLevel()==1 then
		self:GetCaster():AddNewModifier(self:GetCaster(), self , "modifier_mana_on_attack", {})
	end
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Projectile Finish
function spectre_basic_attack:PlayEffectsOnFinish( pos, charged )
	local caster = self:GetCaster()
	local offset = 50
	local new_position = caster:GetOrigin() + (pos - caster:GetOrigin()):Normalized() * offset

	local particle_cast_b = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta_swipe.vpcf"
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast_b, 0, new_position)
	ParticleManager:SetParticleControlForward( effect_cast_b, 0, (pos - caster:GetOrigin()):Normalized())
	ParticleManager:ReleaseParticleIndex( effect_cast_b )

	if charged then
		-- Create Particles
		local particle_cast = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_crimson_blade_fury_abyssal_start.vpcf"
		local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
		ParticleManager:SetParticleControl( effect_cast, 2, caster:GetOrigin())
		ParticleManager:ReleaseParticleIndex( effect_cast )
	end
end

function spectre_basic_attack:PlayEffectsOnCast( )
	local sound_cast = "Hero_Spectre.PreAttack"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

-- On Projectile Hit enemy
function spectre_basic_attack:PlayEffectsOnImpact( hTarget, pos, charged )
	if charged then
		-- Create Sound
		local sound_cast = "Hero_BountyHunter.Jinada"
		EmitSoundOn( sound_cast, hTarget )
		
		-- Create Particles
		local particle_cast = "particles/econ/items/slark/slark_ti6_blade/slark_ti6_blade_essence_shift.vpcf"
		local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, hTarget )
		ParticleManager:ReleaseParticleIndex( effect_cast )
	else
		-- Create Sound
		EmitSoundOn( "Hero_Spectre.Attack", hTarget )

		local caster = self:GetCaster()
		local offset = 50
		local new_position = caster:GetOrigin() + (pos - caster:GetOrigin()):Normalized() * offset
	
		-- Create Particles
		local particle_cast = "particles/units/heroes/hero_spectre/spectre_desolate.vpcf"
		local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
		ParticleManager:SetParticleControl( effect_cast, 0, pos)
		ParticleManager:SetParticleControlForward( effect_cast, 0, (pos - caster:GetOrigin() ):Normalized())
		ParticleManager:ReleaseParticleIndex( effect_cast )
	
		local particle_cast_b = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta_swipe.vpcf"
		local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( effect_cast_b, 0, new_position)
		ParticleManager:SetParticleControlForward( effect_cast_b, 0, (pos - caster:GetOrigin()):Normalized())
		ParticleManager:ReleaseParticleIndex( effect_cast_b )
	end
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	spectre_basic_attack,
	{ activity = ACT_DOTA_ATTACK, rate = 1.1 },
	{ movement_speed = 80, hide_indicator = 1 }
)
Abilities.BasicAttack( spectre_basic_attack )