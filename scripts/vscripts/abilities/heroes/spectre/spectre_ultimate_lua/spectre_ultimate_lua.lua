spectre_ultimate_lua = class({})
LinkLuaModifier( "modifier_spectre_ultimate_illusion_lua", "abilities/heroes/spectre/spectre_ultimate_lua/modifier_spectre_ultimate_illusion_lua", LUA_MODIFIER_MOTION_NONE )

-- This function is used to change between abilities and ex abilities
--------------------------------------------------------------------------------
function spectre_ultimate_lua:GetRelatedName()
    return "spectre_ex_ultimate_lua"
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_ultimate_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	
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
		EffectName = projectile_name,
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
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= caster:GetTeamNumber() end,
		OnUnitHit = function(_self, unit)
			-- Hit
			--------------------
			
			local caster =  self:GetCaster()
			
			local damage = {
				victim = unit,
				attacker = caster,
				damage = self.damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage( damage )
			
			--callback
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
				illusion:SetOwner( caster )
				illusion:SetPlayerID( caster:GetPlayerID() )

				--Add illusion modifier
				illusion:AddNewModifier(
					caster,
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
				caster:GetUnitName(), -- szUnitName
				illusion_origin, -- vLocation,
				false, -- bFindClearSpace,
				caster, -- hNPCOwner,
				nil, -- hUnitOwner,
				caster:GetTeamNumber(), -- iTeamNumber
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

	self:PlayEffects_a()

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
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
end

--Impact
function spectre_ultimate_lua:PlayEffects_b(pos)
	local caster = self:GetCaster()
	-- Cast Sound
    local sound_cast = "Hero_Nevermore.RequiemOfSouls.Damage"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Cast Particles 
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_ambient_endcap.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end
