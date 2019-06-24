wisp_mobility = class({})
wisp_mobility_back = class({})
LinkLuaModifier( "modifier_wisp_mobility_thinker", "abilities/heroes/wisp/wisp_mobility/modifier_wisp_mobility_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_wisp_mobility", "abilities/heroes/wisp/wisp_mobility/modifier_wisp_mobility", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Shared data
wisp_mobility.origins = {}

--------------------------------------------------------------------------------
-- Ability Start
function wisp_mobility:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	-- load data
	local max_range = self:GetSpecialValueFor("range")
	local back_duration = self:GetSpecialValueFor("back_duration")

	-- determine target position
	local direction = (point - origin)
	if direction:Length2D() > max_range then
		direction = direction:Normalized() * max_range
	end

	--create visual thinker
	local thinker = CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_wisp_mobility_thinker", --modifierName
        { duration = back_duration }, --paramTable
        origin, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
	)
	modifier = thinker:FindModifierByName( "modifier_wisp_mobility_thinker" )

	-- Add the modifier that swap back the abilities on destroy
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_wisp_mobility", -- modifier name
		{ duration = back_duration }
    )

	-- teleport
	FindClearSpaceForUnit( caster, origin + direction, true )

	-- Play effects
    self:PlayEffects( origin, direction )
	
	-- Put the back ability on the mobility slot
	caster:SwapAbilities( 
		self:GetAbilityName(),
		"wisp_mobility_back",
		false,
		true
	)
	
	-- register position
	self.origins[caster] = {
		modifier = modifier,
		position = origin,
	}

	--share data
	local wisp_mobility_back = caster:FindAbilityByName( "wisp_mobility_back" )
	wisp_mobility_back.origins = self.origins
end

function wisp_mobility:RemoveOrigin( origin )

	if self.origins[origin].modifier~=nil then
		if not self.origins[origin].modifier:IsNull() then
				self.origins[origin].modifier:Destroy()
		end
	end
	if self.origins[origin] ~= nil then
		self.origins[origin] = nil
	end
end

--------------------------------------------------------------------------------
function wisp_mobility:PlayEffects( origin, direction )
	-- Get Resources
	local particle_cast_a = "particles/mod_units/heroes/hero_wisp/wisp_relocate_teleport.vpcf"
	local sound_cast = "Hero_Wisp.TeleportIn"

	-- Create Sound
	local particle_cast_b = "particles/econ/items/wisp/wisp_relocate_teleport_ti7.vpcf"

	-- At original position
	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast_a, 0, origin )
	ParticleManager:SetParticleControlForward( effect_cast_a, 0, direction:Normalized() )
	ParticleManager:ReleaseParticleIndex( effect_cast_a )
    EmitSoundOn( sound_cast, self:GetCaster()  )

	-- At arrival position
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast_b, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControlForward( effect_cast_b, 0, direction:Normalized() )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
end

--------------------------------------------------------------------------------
-- Sub-ability
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Ability Start
function wisp_mobility_back:OnSpellStart()
	-- load data
	local caster = self:GetCaster()

	-- Put the back ability on the mobility slot
	SafeDestroyModifier("modifier_wisp_mobility", caster, caster)
	
	-- get origin from the caster
	local origin = self.origins[caster]
	
	if not origin then return end

	-- teletransport
	FindClearSpaceForUnit( caster, origin.position, true )

	-- destroy the origin
	if not self.origins[caster].modifier:IsNull() then
		self.origins[caster].modifier:Destroy()
	end
	self.origins[caster] = nil

	self:PlayEffects()
end

--------------------------------------------------------------------------------
function wisp_mobility_back:PlayEffects( origin )
	-- Get Resources
	local sound_cast = "Hero_Wisp.TeleportOut"

    EmitSoundOn( sound_cast, self:GetCaster()  )
end