modifier_tinker_ex_ultimate_thinker_lua = class({})
LinkLuaModifier( "modifier_tinker_ex_ultimate_buff_lua", "abilities/heroes/tinker/tinker_ex_ultimate_lua/modifier_tinker_ex_ultimate_buff_lua", LUA_MODIFIER_MOTION_NONE )

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
		local point = self:GetParent():GetOrigin()
		local duration = self:GetAbility():GetSpecialValueFor( "duration" ) -- special value
		self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
		self.buff_duration = self:GetAbility():GetSpecialValueFor( "buff_duration" ) -- special value
		local machines_per_sec = self:GetAbility():GetSpecialValueFor( "machines_per_sec" ) -- special value
		local interval = 1/machines_per_sec

		self.origin = self:GetCaster():GetOrigin()
		self.projectile_direction = Vector(point.x - self.origin.x, point.y - self.origin.y, 0):Normalized()

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
	local damage = self:GetAbility():GetSpecialValueFor( "damage" ) -- special value
	-- generate Data
	local projectile_name = "particles/econ/items/tinker/tinker_motm_rollermaw/tinker_rollermaw.vpcf"
	local projectile_speed = self:GetAbility():GetSpecialValueFor( "projectile_speed" ) -- special value
	local projectile_distance = self:GetAbility():GetSpecialValueFor( "projectile_distance" ) -- special value
	local projectile_start_radius = self:GetAbility():GetSpecialValueFor( "hitbox" ) -- special value
	
	self:GetParent():SetForwardVector( self.projectile_direction )

	local spawn_vector = self:GetParent():GetRightVector()
	local spawn = self.origin + spawn_vector*RandomInt( -self.radius, self.radius )
	local projectile = {
		EffectName = projectile_name,
		fDistance = projectile_distance,
		fStartRadius = projectile_start_radius,
		fEndRadius = projectile_start_radius,
		Source = self:GetCaster(),
		fExpireTime = 8.0,
		vVelocity = self.projectile_direction * projectile_speed,
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
		iVisionRadius = 50,
		iVisionTeamNumber = self:GetCaster():GetTeam(),
		bFlyingVision = false,
		fVisionTickTime = .1,
		fVisionLingerDuration = 1,
		draw = false,
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
			self:PlayEffects(pos)
		end,
	}

	-- spawn machines
	projectile.vSpawnOrigin = spawn
	Projectiles:CreateProjectile(projectile)

	local allies = FindUnitsInLine(
		self:GetCaster():GetTeamNumber(),
		self.origin,
		self:GetParent():GetOrigin(),
		nil,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0
	)

	for _,ally in pairs(allies) do
        if ally == self:GetCaster() then
            ally:AddNewModifier(
                self:GetCaster(), 
                self:GetAbility(), 
                "modifier_tinker_ex_ultimate_buff_lua", 
                {duration =  self.buff_duration}
            )
        end
    end
end

function modifier_tinker_ex_ultimate_thinker_lua:PlayEffects(pos)
	local particle_cast = "particles/econ/items/tinker/tinker_motm_rollermaw/tinker_machine_destroy.vpcf"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end