spectre_ultimate_lua = class({})
LinkLuaModifier( "modifier_spectre_ultimate_illusion_lua", "abilities/heroes/spectre/spectre_ultimate_lua/modifier_spectre_ultimate_illusion_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function spectre_ultimate_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local name = caster:GetUnitName()
	
	-- load data
	local projectile_name = "particles/mod_units/heroes/hero_spectre/spectre_transversant_spectral_dagger.vpcf"
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_vision = 500
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	self.damage = self:GetSpecialValueFor("damage")
	self.illusion_duration = self:GetSpecialValueFor("illusion_duration")

	-- logic
	local projectile = {
		EffectName = "" --[[projectile_name]],
		vSpawnOrigin = {unit=caster, attach="attach_attack1", offset=Vector(0,0,0)},
		fDistance = projectile_distance,
		fStartRadius = projectile_start_radius,
		fEndRadius = projectile_end_radius,
		Source = caster,
		fExpireTime = 8.0,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		bMultipleHits = true,
		bIgnoreSource = true,
		TreeBehavior = PROJECTILES_NOTHING,
		bCutTrees = true,
		bTreeFullCollision = false,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		nChangeMax = 1,
		bRecreateOnChange = true,
		bZCheck = false,
		bGroundLock = true,
		bProvidesVision = true,
		iVisionRadius = 200,
		iVisionTeamNumber = caster:GetTeam(),
		bFlyingVision = false,
		fVisionTickTime = .1,
		fVisionLingerDuration = 1,
		draw = false,
		fRehitDelay = 1.0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit)
			local caster =  self:GetCaster()
			
			-- Damage
			local damage = {
				victim = unit,
				attacker = _self.Source,
				damage = self.damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}
			ApplyDamage( damage )
			
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
					"modifier_spectre_ultimate_illusion_lua",
					{ duration = self.illusion_duration }
				)
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

			-- Effects
			self:PlayEffects_b(_self:GetPosition())
			_self.Destroy()
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_b(pos)
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
		 
		EffectName = projectile_name, 
		fDistance = projectile_distance, 
		fStartRadius = projectile_start_radius, 
		fEndRadius =projectile_end_radius, 
		vVelocity = projectile_direction * projectile_speed, 
 
		bHasFrontalCone = false, 
		bReplaceExisting = false, 
		fExpireTime = GameRules:GetGameTime() + 8.0, 
		 
		bProvidesVision = false, 
	} 
	 
	self:PlayEffects_a()
	Projectiles:CreateProjectile(projectile)
	ProjectileManager:CreateLinearProjectile(info) 
end
--------------------------------------------------------------------------------
-- Graphics & sounds

--cast
function spectre_ultimate_lua:PlayEffects_a()
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
function spectre_ultimate_lua:PlayEffects_b(pos)
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
