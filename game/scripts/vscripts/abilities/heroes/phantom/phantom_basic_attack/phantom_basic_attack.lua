phantom_basic_attack = class({})
LinkLuaModifier( "modifier_phantom_strike_stack", "abilities/heroes/phantom/phantom_shared_modifiers/modifier_phantom_strike_stack", LUA_MODIFIER_MOTION_NONE )

function phantom_basic_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local attack_damage = caster:GetAttackDamage()

	local cooldown_reduction = self:GetSpecialValueFor("cooldown_reduction")

	local projectile_speed = 2000
	local projectile_direction = ( Vector( point.x - origin.x, point.y - origin.y, 0)):Normalized()
	local offset = 50

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
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit)
			local counter = 0
			for k, v in pairs(_self.rehit) do counter = counter + 1 end
			if counter > 1 then return end
			-- perform the actual attack
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

			if _self.Source == caster then 
				if caster:HasModifier("modifier_phantom_counter") then
					local ability = caster:FindAbilityByName("phantom_counter")
					local heal = ability:GetSpecialValueFor("lifesteal")
					caster:Heal(heal, caster)

					SafeDestroyModifier("modifier_phantom_counter", caster, caster)
				end

				-- Add modifier
				caster:AddNewModifier(
					caster, -- player source
					self, -- ability source
					"modifier_phantom_strike_stack", -- modifier name
					{} -- kv
				)
			end

			-- Reduce the cd of the second attack by 1
			local second_attack = caster:FindAbilityByName("phantom_second_attack")
			local second_attack_cd = second_attack:GetCooldownTimeRemaining()
			local new_cd = second_attack_cd - cooldown_reduction

			if (new_cd) < 0 then 
				second_attack:EndCooldown()
			else
				second_attack:EndCooldown()
				second_attack:StartCooldown(new_cd)
			end


			self:PlayEffectsOnImpact(unit)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Misc
-- Add mana on attack modifier. Only first time upgraded
function phantom_basic_attack:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Projectile Finish
function phantom_basic_attack:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()
	local offset = 40
	local origin = caster:GetOrigin()
	local direction = (pos - origin):Normalized()
	local final_position = origin + Vector(direction.x * offset, direction.y * offset, 0)

	-- Create Particles
	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_attack_blinkb.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, final_position )
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)	
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function phantom_basic_attack:PlayEffectsOnImpact( hTarget )
	EmitSoundOn( "Hero_PhantomAssassin.Attack", hTarget )
end

-- On Projectile miss
function phantom_basic_attack:PlayEffectsOnCast()
	EmitSoundOn( "Hero_PhantomAssassin.PreAttack", self:GetCaster() )
end

if IsClient() then require("abilities") end
Abilities.BasicAttack( phantom_basic_attack )
Abilities.Initialize( 
	phantom_basic_attack,
	{ activity = ACT_DOTA_TELEPORT_END, rate = 1.3 },
	{ movement_speed = 80 }
)