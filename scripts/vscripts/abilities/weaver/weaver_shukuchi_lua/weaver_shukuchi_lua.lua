weaver_shukuchi_lua = class ({})
LinkLuaModifier( "modifier_weaver_shukuchi_lua", "abilities/weaver/weaver_shukuchi_lua/modifier_weaver_shukuchi_lua", LUA_MODIFIER_MOTION_NONE )

function weaver_shukuchi_lua:OnSpellStart()
	-- unit identifier
    local caster = self:GetCaster()

    -- load data
	local duration = self:GetSpecialValueFor("duration")

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_weaver_shukuchi_lua", -- modifier name
		{ duration = duration } -- kv
	)

end

--------------------------------------------------------------------------------
function weaver_shukuchi_lua:PlayEffects()
	-- Get Resources
	local sound_cast = "sounds/weapons/hero/weaver/shukuchi.vsnd"

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end