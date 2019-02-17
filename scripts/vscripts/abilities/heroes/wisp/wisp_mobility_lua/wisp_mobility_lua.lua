wisp_mobility_lua = class({})
wisp_mobility_back_lua = class({})
LinkLuaModifier( "modifier_wisp_mobility_thinker_lua", "abilities/heroes/wisp/wisp_mobility_lua/modifier_wisp_mobility_thinker_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_wisp_mobility_lua", "abilities/heroes/wisp/wisp_mobility_lua/modifier_wisp_mobility_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Shared data
wisp_mobility_lua.origins = {}

--------------------------------------------------------------------------------
-- Ability Start
function wisp_mobility_lua:OnSpellStart()
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
        "modifier_wisp_mobility_thinker_lua", --modifierName
        { duration = back_duration }, --paramTable
        origin, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
	)
	modifier = thinker:FindModifierByName( "modifier_wisp_mobility_thinker_lua" )

	-- Add the modifier that swap back the abilities on destroy
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_wisp_mobility_lua", -- modifier name
		{ duration = back_duration }
    )

	-- teleport
	FindClearSpaceForUnit( caster, origin + direction, true )

	-- Play effects
    self:PlayEffects( origin, direction )
	
	-- Put the back ability on the mobility slot
	caster:SwapAbilities( 
		self:GetAbilityName(),
		"wisp_mobility_back_lua",
		false,
		true
	)
	
	-- register position
	self.origins[caster] = {
		modifier = modifier,
		position = origin,
	}

	--share data
	local wisp_mobility_back = caster:FindAbilityByName( "wisp_mobility_back_lua" )
	wisp_mobility_back.origins = self.origins

	--[[
	Timers:CreateTimer(back_duration - 0.1, function()
		if self.origins[origin] ~=nil then
			self:RemoveOrigin(origin)
		end
	end)
	]]--
end

function wisp_mobility_lua:RemoveOrigin( origin )

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
function wisp_mobility_lua:PlayEffects( origin, direction )
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
function wisp_mobility_back_lua:OnSpellStart()
	-- load data
	local caster = self:GetCaster()

	-- Put the back ability on the mobility slot
	local modifier = caster:FindModifierByNameAndCaster( "modifier_wisp_mobility_lua", self:GetCaster() )
	if modifier~=nil then
		if not modifier:IsNull() then
			modifier:Destroy()
		end
	end
	
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
function wisp_mobility_back_lua:PlayEffects( origin )
	-- Get Resources
	local sound_cast = "Hero_Wisp.TeleportOut"

    EmitSoundOn( sound_cast, self:GetCaster()  )
end