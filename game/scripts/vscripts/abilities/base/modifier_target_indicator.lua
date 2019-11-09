modifier_target_indicator = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_target_indicator:IsHidden()
	return true
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_target_indicator:OnCreated( params )
	self.parent = self:GetParent()

    if IsServer() then
		self.radius = params.radius
		self.public = params.public and true or false
		self.fixed_range = params.fixed_range

        self:PlayEffects()
        self:StartIntervalThink( 0.01 )
    end
end

--------------------------------------------------------------------------------
-- Refresh
function modifier_target_indicator:OnRefresh( params )
	self.parent = self:GetParent()

    if IsServer() then
		self.radius = params.radius
		self.public = params.public and true or false
		self.fixed_range = params.fixed_range
	
        self:StopEffects()
        self:PlayEffects()
        self:StartIntervalThink( 0.01 )
    end
end


--------------------------------------------------------------------------------
-- Refresh
function modifier_target_indicator:OnDestroy()
	if IsServer() then
        self:StopEffects()
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_target_indicator:OnIntervalThink()
    local mouse = GameMode.mouse_positions[self.parent:GetPlayerID()]
	local origin = self.parent:GetOrigin()
	local ranges = self:GetRanges(self.fixed_range)

    local point = CalcRange(origin, mouse, ranges.max_range, ranges.min_range)

    self:UpdateEffects(origin, point)
end

--------------------------------------------------------------------------------
-- Graphics
function modifier_target_indicator:PlayEffects()
	local particle_cast = "particles/mod_units/range_finder_tower_aoe.vpcf"
	local particle_cast_aoe = "particles/ui_mouseactions/range_finder_aoe.vpcf"
	local player_owner = self.parent:GetPlayerOwner()
    local mouse = GameMode.mouse_positions[self.parent:GetPlayerID()]

	if self.public then
		if self.no_target ~= 1 then
			self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent)
		end
		if self.radius ~= nil then
            self.effect_cast_aoe = ParticleManager:CreateParticle( particle_cast_aoe, PATTACH_WORLDORIGIN, self.parent)
			ParticleManager:SetParticleControl( self.effect_cast_aoe, 0, mouse)
			ParticleManager:SetParticleControl( self.effect_cast_aoe, 3, Vector(self.radius, 0, 0))
		end
	else
		if self.no_target ~= 1 then
			self.effect_cast = ParticleManager:CreateParticleForPlayer( particle_cast, PATTACH_WORLDORIGIN, self.parent, player_owner )
		end
		if self.radius ~= nil then
			self.effect_cast_aoe = ParticleManager:CreateParticleForPlayer( particle_cast_aoe, PATTACH_WORLDORIGIN, self.parent, player_owner )
			ParticleManager:SetParticleControl( self.effect_cast_aoe, 0, mouse)
			ParticleManager:SetParticleControl( self.effect_cast_aoe, 2, mouse)
			ParticleManager:SetParticleControl( self.effect_cast_aoe, 3, Vector(self.radius, 0, 0))
		end
	end
end

function modifier_target_indicator:StopEffects()
	if self.effect_cast ~= nil then
		ParticleManager:DestroyParticle( self.effect_cast, false ) 
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end

	if self.effect_cast_aoe ~= nil then
		ParticleManager:DestroyParticle( self.effect_cast_aoe, false ) 
		ParticleManager:ReleaseParticleIndex( self.effect_cast_aoe )
	end
end


function modifier_target_indicator:UpdateEffects(origin, point)
	if self.no_target ~= 1 then
		ParticleManager:SetParticleControl( self.effect_cast, 7, Vector(point.x, point.y, 128)) -- aoe
		ParticleManager:SetParticleControl( self.effect_cast, 0, origin)	-- line origin
		ParticleManager:SetParticleControl( self.effect_cast, 2, origin)	-- line end
	end
	if self.radius ~= nil then
		if self.no_target == 1 then
			ParticleManager:SetParticleControl( self.effect_cast_aoe, 0, self.parent:GetOrigin())	-- line origin
			ParticleManager:SetParticleControl( self.effect_cast_aoe, 2, self.parent:GetOrigin())	-- line origin
		else
			ParticleManager:SetParticleControl( self.effect_cast_aoe, 0, point)
			ParticleManager:SetParticleControl( self.effect_cast_aoe, 2, point)	
		end
	end
end

function modifier_target_indicator:GetRanges( fixed )
	local ranges = {
		min_range = 0,
		max_range = 0,
	}

	if self:GetAbility():HasBehavior(DOTA_ABILITY_BEHAVIOR_NO_TARGET) then
		ranges.max_range = 0
	else 
		ranges.max_range = self:GetAbility():GetCastRange(Vector(0,0,0), nil)
	end

	if fixed == 1 then
		ranges.min_range = ranges.max_range
	else
		ranges.min_range = self:GetAbility():GetSpecialValueFor("min_range")
	end

	return ranges
end
