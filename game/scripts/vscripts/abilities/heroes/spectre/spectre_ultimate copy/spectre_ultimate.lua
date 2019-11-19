spectre_ultimate = class({})
LinkLuaModifier( "modifier_spectre_ultimate_illusion", "abilities/heroes/spectre/spectre_ultimate/modifier_spectre_ultimate_illusion", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function spectre_ultimate:OnCastPointEnd( )
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local name = caster:GetUnitName()
	local damage = self:GetAbilityDamage()
	
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	local illusion_duration = self:GetSpecialValueFor("illusion_duration")

	-- logic
	local projectile = {
		vSpawnOrigin = {unit=caster, attach="attach_attack1", offset=Vector(0,0,0)},
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit)
			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}
			ApplyDamage( damage_table )
			
			-- Callback
			local modifyIllusion = function ( illusion )
				-- set facing
				illusion:SetForwardVector( unit:GetForwardVector() )

				-- clean item slots
				for slot=0,5 do
					-- remove anything in current slot
					local iItem = illusion:GetItemInSlot(slot)
					if iItem then illusion:RemoveItem( illusion:GetItemInSlot(slot) ) end
				end

				-- make illusion
				illusion:MakeIllusion()
				illusion:SetOwner( _self.Source )
				illusion:SetPlayerID( _self.Source:GetPlayerID() )

				--Add illusion modifier
				illusion:AddNewModifier(
					_self.Source,
					self,
					"modifier_spectre_ultimate_illusion",
					{ duration = illusion_duration }
				)

				if _self.Source == caster then
					local swap = caster:FindAbilityByName("spectre_ultimate_recast")
					swap.illusion_index = illusion:GetEntityIndex()
					
					caster:SwapAbilities( 
						"spectre_ultimate",
						"spectre_ultimate_recast",
						false,
						true
					)
				end
			end
			
			--ilusion position
			local illusion_origin = Vector(
				unit:GetOrigin().x - 100,
				unit:GetOrigin().y,
				unit:GetOrigin().z
			)

			--Create unit (illusion)
			local illusion = CreateUnitByNameAsync(
				name, -- szUnitName
				illusion_origin, -- vLocation,
				false, -- bFindClearSpace,
				_self.Source, -- hNPCOwner,
				nil, -- hUnitOwner,
				_self.Source:GetTeamNumber(), -- iTeamNumber
				modifyIllusion
			)
			
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	--THIS IS ONLY FOR VISUALS
	local info = { 
		Source = caster, 
		Ability = self, 
		vSpawnOrigin = origin, 
		bDeleteOnHit = false, 
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY, 
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE, 
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		EffectName = "particles/mod_units/heroes/hero_spectre/spectre_transversant_spectral_dagger.vpcf", 
		fDistance = projectile.fDistance, 
		fStartRadius = projectile.fUniqueRadius, 
		fEndRadius =projectile.fUniqueRadius, 
		vVelocity = projectile.vVelocity, 
		bHasFrontalCone = false, 
		bReplaceExisting = false, 
		fExpireTime = GameRules:GetGameTime() + 8.0, 
		bProvidesVision = false, 
	} 
	 
	self:PlayEffectsOnLaunch()
	Projectiles:CreateProjectile(projectile)
	ProjectileManager:CreateLinearProjectile(info) 
end
--------------------------------------------------------------------------------
-- Graphics & sounds

--cast
function spectre_ultimate:PlayEffectsOnLaunch()
	-- Get Resources
	local sound_cast = "Hero_Spectre.DaggerCast.ti7"
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_death_mist.vpcf"

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, self:GetCaster() )
	EmitGlobalSound("spectre_spec_ability_haunt_01")
end

--Impact
function spectre_ultimate:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()
	-- Cast Sound
    local sound_cast = "Hero_Nevermore.RequiemOfSouls.Damage"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Cast Particles 
	local particle_cast = "particles/econ/items/death_prophet/death_prophet_ti9/death_prophet_silence_ti9_ground_smoke.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end


if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	spectre_ultimate,
	{ activity = ACT_DOTA_ATTACK, rate = 0.4 },
	{ movement_speed = 0, fixed_range = 1 }
)