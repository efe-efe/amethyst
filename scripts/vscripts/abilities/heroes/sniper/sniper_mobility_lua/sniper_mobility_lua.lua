sniper_mobility_lua = class({})
LinkLuaModifier( "modifier_sniper_mobility_thinker_lua", "abilities/heroes/sniper/sniper_mobility_lua/modifier_sniper_mobility_thinker_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_shrapnel_thinker_lua", "abilities/heroes/sniper/sniper_shared_modifiers/modifier_sniper_shrapnel_thinker_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Set the aoe indicator
function sniper_mobility_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function sniper_mobility_lua:OnSpellStart()
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor( "duration" )

    -- Effect thinker
    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_sniper_mobility_thinker_lua", --modifierName
        { }, --paramTable
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )

    
    -- Effect thinker
    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_sniper_shrapnel_thinker_lua", --modifierName
        { duration = duration }, --paramTable
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )
    
    self:PlayEffects()    
    -- Put CD on the alternate version of the ability
	local ex_version = caster:FindAbilityByName("sniper_ex_mobility_lua")
	ex_version:StartCooldown(self:GetCooldown(0))
end

function sniper_mobility_lua:PlayEffects()
    local sound_cast = "Hero_Techies.LandMine.Detonate"
    EmitSoundOn( sound_cast, self:GetCaster() )	
end