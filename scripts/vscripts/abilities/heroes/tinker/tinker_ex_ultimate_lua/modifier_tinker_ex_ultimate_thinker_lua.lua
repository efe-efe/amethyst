modifier_tinker_ex_ultimate_thinker_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_tinker_ex_ultimate_thinker_lua:IsHidden()
	return true
end

function modifier_tinker_ex_ultimate_thinker_lua:IsDebuff()
	return false
end

function modifier_tinker_ex_ultimate_thinker_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_tinker_ex_ultimate_thinker_lua:OnCreated( kv )
	if IsServer() then
		-- references
		local duration = self:GetAbility():GetSpecialValueFor( "duration" ) -- special value
		self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
		
		local speed = self:GetAbility():GetSpecialValueFor( "speed" ) -- special value
		local distance = self:GetAbility():GetSpecialValueFor( "distance" ) -- special value
		local machines_per_sec = self:GetAbility():GetSpecialValueFor( "machines_per_sec" ) -- special value
		local collision_radius = self:GetAbility():GetSpecialValueFor( "collision_radius" ) -- special value
		local splash_radius = self:GetAbility():GetSpecialValueFor( "splash_radius" ) -- special value
		local splash_damage = self:GetAbility():GetAbilityDamage()

		-- generate Data
		local projectile_name = "particles/econ/items/tinker/tinker_motm_rollermaw/tinker_rollermaw.vpcf"
		local interval = 1/5
		local center = self:GetParent():GetOrigin()

		local direction = (center-self:GetCaster():GetOrigin())
		direction = Vector( direction.x, direction.y, 0 ):Normalized()
		self:GetParent():SetForwardVector( direction )
		
		self.spawn_vector = self:GetParent():GetRightVector()

		self.center_start = center - direction*self.radius

		-- Precache projectile info
		self.projectile_info = {
			Source = self:GetCaster(),
			Ability = self:GetAbility(),
			-- vSpawnOrigin = spawn,
			
		    bDeleteOnHit = true,
		    
		    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		    
		    EffectName = projectile_name,
		    fDistance = distance,
		    fStartRadius = collision_radius,
		    fEndRadius = collision_radius,
			vVelocity = direction * speed,

			ExtraData = {
				radius = splash_radius,
				damage = splash_damage,
			}
		}














		self.projectile = {
			EffectName = projectile_name,
			fDistance = distance,
			fStartRadius = collision_radius,
			fEndRadius = collision_radius,
			Source = self:GetCaster(),
			fExpireTime = 8.0,
			vVelocity = direction * 1,
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
			iVisionTeamNumber = self:GetCaster():GetTeam(),
			bFlyingVision = false,
			fVisionTickTime = .1,
			fVisionLingerDuration = 1,
			draw = true,
			fRehitDelay = 1.0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
			OnUnitHit = function(_self, unit) 
				local damage = {
					victim = unit,
					attacker = self:GetCaster(),
					damage = damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
				}
	
				ApplyDamage( damage )
				_self.Destroy()
			end,
			OnFinish = function(_self, pos)
			end,
		}
	












		self.counter = 0
		-- add duration
		self:SetDuration( duration, false )

		-- Start interval
		self:StartIntervalThink( interval )
		self:OnIntervalThink()

		-- effects
		local sound_cast = "Hero_Tinker.March_of_the_Machines"
		EmitSoundOn( sound_cast, self:GetParent() )
	end
end

function modifier_tinker_ex_ultimate_thinker_lua:OnRefresh( kv )
	
end

function modifier_tinker_ex_ultimate_thinker_lua:OnDestroy( kv )
	if IsServer() then
		-- effects
		local sound_cast = "Hero_Tinker.March_of_the_Machines"
		StopSoundOn( sound_cast, self:GetParent() )

		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_tinker_ex_ultimate_thinker_lua:OnIntervalThink()
	-- generate spawn point
	local spawn = self.center_start + self.spawn_vector*RandomInt( -self.radius, self.radius )

	-- spawn machines
	self.projectile_info.vSpawnOrigin = spawn
	self.projectile.vSpawnOrigin = spawn
	Projectiles:CreateProjectile(self.projectile)
	--ProjectileManager:CreateLinearProjectile(self.projectile_info)

	self.counter = self.counter + 1
	print(self.counter)
end