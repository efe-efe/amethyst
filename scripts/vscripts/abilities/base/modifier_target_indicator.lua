modifier_target_indicator = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_target_indicator:IsHidden()
	return false
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_target_indicator:OnCreated( params )
	self.parent = self:GetParent()
	self.radius = params.radius
    self.min_range = params.min_range
	self.max_range = params.max_range

	--print("CREATED TARGET INDICATOR")
	--print(self:GetDuration())

    if IsServer() then
        self:PlayEffects()
        self:StartIntervalThink( 0.01 )
    end
end

--------------------------------------------------------------------------------
-- Refresh
function modifier_target_indicator:OnRefresh()
	self.parent = self:GetParent()
	self.radius = params.radius
    self.min_range = params.min_range
    self.max_range = params.max_range

	--print("REFRESHED TARGET INDICATOR")

    if IsServer() then
        self:StopEffects()
        self:PlayEffects()
        self:StartIntervalThink( 0.01 )
    end
end


--------------------------------------------------------------------------------
-- Refresh
function modifier_target_indicator:OnDestroy()
	if IsServer() then
		--print("DESTROYED TARGET INDICATOR")

        self:StopEffects()
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_target_indicator:OnIntervalThink()
    local mouse = GameMode.mouse_positions[self.parent:GetPlayerID()]
    local origin = self.parent:GetOrigin()
    
	local direction = (mouse - origin):Normalized()
	local distance = (mouse - origin):Length2D()
    local point = CalcRange(origin, mouse, self.max_range, self.min_range)

    self:UpdateEffects(origin, point)
end

--------------------------------------------------------------------------------
-- Graphics
function modifier_target_indicator:PlayEffects()
	local particle_cast = "particles/mod_units/range_finder_tower_aoe.vpcf"
	local particle_cast_aoe = "particles/ui_mouseactions/range_finder_aoe.vpcf"
	local player_owner = self.parent:GetPlayerOwner()
    local mouse = GameMode.mouse_positions[self.parent:GetPlayerID()]

	if self.show_all == 1 then
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
			--print("CREATING EFFECTS TARGET INDICATOR")
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
		--print("DESTROYING EFFECTS TARGET INDICATOR")
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