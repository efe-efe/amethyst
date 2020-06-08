wisp_mobility = class({})
wisp_mobility_back = class({})
LinkLuaModifier("modifier_wisp_mobility_thinker", "abilities/heroes/wisp/wisp_mobility/modifier_wisp_mobility_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_mobility", "abilities/heroes/wisp/wisp_mobility/modifier_wisp_mobility", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Shared data
wisp_mobility.origins = {}

--------------------------------------------------------------------------------
-- Ability Start
function wisp_mobility:OnSpellStart()
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	caster:AddNewModifier(
		caster,
		self,
		"modifier_cast_point_old",
		{ 
			duration = cast_point, 
			can_walk = 0,
		}
	)
end

--------------------------------------------------------------------------------
-- Ability Start
function wisp_mobility:OnCastPointEnd(point)
	-- unit identifier
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()

	-- load data
	local max_range = self:GetSpecialValueFor("range")
	local back_duration = self:GetSpecialValueFor("back_duration")

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
	modifier = thinker:FindModifierByName("modifier_wisp_mobility_thinker")

	-- Add the modifier that swap back the abilities on destroy
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_wisp_mobility", -- modifier name
		{ duration = back_duration }
   )

	-- teleport
	FindClearSpaceForUnit(caster, point, true)

	-- Play effects
    self:PlayEffectsOrigin()
    self:PlayEffectsArrival(point)
	
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
	local wisp_mobility_back = caster:FindAbilityByName("wisp_mobility_back")
	wisp_mobility_back.origins = self.origins
end

function wisp_mobility:RemoveOrigin(origin)

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
-- Graphics & Sounds
function wisp_mobility:PlayEffectsOrigin()
	-- Create Sound
	EmitSoundOn("Hero_Wisp.TeleportIn", self:GetCaster() )
	
	local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_relocate_teleport.vpcf"

	-- At original position
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self:GetCaster())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function wisp_mobility:PlayEffectsArrival(point)
	local particle_cast = "particles/econ/items/wisp/wisp_relocate_teleport_ti7.vpcf"

	-- At arrival position
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 0, point)
	ParticleManager:ReleaseParticleIndex(effect_cast)
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
	FindClearSpaceForUnit(caster, origin.position, true)

	-- destroy the origin
	if not self.origins[caster].modifier:IsNull() then
		self.origins[caster].modifier:Destroy()
	end
	self.origins[caster] = nil

    EmitSoundOn("Hero_Wisp.TeleportOut", self:GetCaster() )
end
