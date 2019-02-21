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

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = Vector(origin.x, origin.y, origin.z + 128),
		
		bDeleteOnHit = true,
		
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
		fExpireTime = GameRules:GetGameTime() + 10.0,
		
		bProvidesVision = true,
		iVisionRadius = projectile_vision,
        iVisionTeamNumber = caster:GetTeamNumber(),
        
        ExtraData = {
			
		}
	}
	
	ProjectileManager:CreateLinearProjectile(info)
	self:PlayEffects()
end

--------------------------------------------------------------------------------
-- Projectile
function spectre_ultimate_lua:OnProjectileHit( hTarget, vLocation )
	if hTarget ~= nil and ( not hTarget:IsInvulnerable() ) and ( not hTarget:TriggerSpellAbsorb( self ) ) then
		
		if IsServer() then
			local caster =  self:GetCaster()
			
			local damage = {
				victim = hTarget,
				attacker = caster,
				damage = self.damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage( damage )
			
			--callback
			local modifyIllusion = function ( illusion )

				-- set facing
				illusion:SetForwardVector( hTarget:GetForwardVector() )

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
				hTarget:GetOrigin().x - 100,
				hTarget:GetOrigin().y,
				hTarget:GetOrigin().z
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
			self:PlayEffects2(hTarget)
		end
	end

	return true
end

--Impact
function spectre_ultimate_lua:PlayEffects2(hTarget)
	-- Get Resources
    local sound_cast = "Hero_Nevermore.RequiemOfSouls.Damage"
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_ambient_endcap.vpcf"

	-- Create Sound
	EmitSoundOn( sound_cast, hTarget )

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

--cast
function spectre_ultimate_lua:PlayEffects()
	-- Get Resources
	local sound_cast = "Hero_Spectre.DaggerCast.ti7"
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_death_mist.vpcf"

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, self:GetCaster() )
end

