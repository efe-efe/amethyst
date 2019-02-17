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
	local old_origin = caster:GetOrigin()

	-- load data
	local max_range = self:GetSpecialValueFor("range")
	local back_duration = self:GetSpecialValueFor("back_duration")

	-- determine target position
	local direction = (point - old_origin)
	if direction:Length2D() > max_range then
		direction = direction:Normalized() * max_range
	end

	--create visual thinker
	local thinker = CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_wisp_mobility_thinker_lua", --modifierName
        { duration = back_duration }, --paramTable
        old_origin, --vOrigin
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
	FindClearSpaceForUnit( caster, old_origin + direction, true )

	-- Play effects
    self:PlayEffects( old_origin, direction )
	
	-- Put the back ability on the mobility slot
	caster:SwapAbilities( 
		self:GetAbilityName(),
		"wisp_mobility_back_lua",
		false,
		true
	)
	
	-- register position
	local extraData = {}
	extraData.time = GameRules:GetGameTime()
	extraData.modifier = modifier
	extraData.caster = caster
	self.origins[old_origin] = extraData

	Timers:CreateTimer(back_duration - 0.1, function()
		if self.origins[old_origin] ~=nil then
			self:RemoveOrigin(old_origin)
		end
	end)
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
-- Ability Events
function wisp_mobility_lua:OnUpgrade()
	if not self.wisp_mobility_back then
		-- init data share
		self.wisp_mobility_back = self:GetCaster():FindAbilityByName( "wisp_mobility_back_lua" )
		self.wisp_mobility_back.origins = self.origins
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

	-- Put the back ability on the mobility slot
	local modifier = self:GetCaster():FindModifierByNameAndCaster( "modifier_wisp_mobility_lua", self:GetCaster() )
	if modifier~=nil then
		modifier:Destroy()
	end
	
	-- get origin from the caster
	local origin = false
	for k,v in pairs(self.origins) do
		if self.origins[k].caster == self:GetCaster() then
			origin = k
			break
		end
	end
	
	if not origin then return end

	-- teletransport
	FindClearSpaceForUnit( self:GetCaster(), origin, true )

	-- destroy the oldest
	self.origins[origin].modifier:Destroy()
	self.origins[origin] = nil

	self:PlayEffects()
end

--------------------------------------------------------------------------------
function wisp_mobility_back_lua:PlayEffects( origin )
	-- Get Resources
	local sound_cast = "Hero_Wisp.TeleportOut"

    EmitSoundOn( sound_cast, self:GetCaster()  )
end