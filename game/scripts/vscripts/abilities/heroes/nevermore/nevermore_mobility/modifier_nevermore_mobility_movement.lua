modifier_nevermore_mobility_movement = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_nevermore_mobility_movement:IsHidden()
	return true
end

function modifier_nevermore_mobility_movement:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_nevermore_mobility_movement:OnCreated( kv )
	if IsServer() then
        -- references
		self.distance = kv.r
		self.direction = Vector(kv.x,kv.y,0):Normalized()
		self.speed = kv.speed -- special value
		self.origin = self:GetParent():GetOrigin()
		self.scratched = false

		StartAnimation(self:GetParent(), {
			duration=1.0, 
			activity=ACT_DOTA_FLAIL,
			translate="forcestaff_friendly",
			rate=1.2
		})

		if self:ApplyHorizontalMotionController() == false then
			self:Destroy()
        end
	end
end

function modifier_nevermore_mobility_movement:OnRefresh( kv )
end

function modifier_nevermore_mobility_movement:OnDestroy( kv )
	if IsServer() then
		
		--Quits the animation
		local order = 
		{
			OrderType = DOTA_UNIT_ORDER_HOLD_POSITION,
			UnitIndex = self:GetParent():entindex()
		}
		ExecuteOrderFromTable(order)
		
		self:GetParent():InterruptMotionControllers( true )
	end
end


function modifier_nevermore_mobility_movement:UpdateHorizontalMotion( me, dt )
	local pos = self:GetParent():GetOrigin()
	local distance =  (pos-self.origin):Length2D()
	-- stop if already past distance
	if distance >= self.distance then
		self:Destroy()
		return
	end

	if distance > self.distance/3 and self.scratched == false then
		self:PlayEffects()
		self.scratched = true
	end

	-- set position
	local target = pos + self.direction * (self.speed*dt)

	-- change position
	self:GetParent():SetOrigin( target )
end

function modifier_nevermore_mobility_movement:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_nevermore_mobility_movement:DeclareFunctions()
	local funcs = {
	    MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}

	return funcs
end

-- Status Effects
function modifier_nevermore_mobility_movement:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end


function modifier_nevermore_mobility_movement:PlayEffects()
	local caster = self:GetParent()
    local particle_cast = "particles/econ/items/shadow_fiend/sf_desolation/sf_desolation_scratch.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControl(effect_cast, 0, caster:GetOrigin()) 
	ParticleManager:ReleaseParticleIndex( effect_cast )
end


-- Graphics & Animations
function modifier_nevermore_mobility_movement:GetEffectName()
	return "particles/econ/items/spectre/spectre_transversant_soul/spectre_ti7_crimson_spectral_dagger_path_owner.vpcf"
end

function modifier_nevermore_mobility_movement:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
