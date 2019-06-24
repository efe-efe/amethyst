sniper_mobility = class({})
LinkLuaModifier( "modifier_sniper_mobility_thinker", "abilities/heroes/sniper/sniper_mobility/modifier_sniper_mobility_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_shrapnel_thinker_lua", "abilities/heroes/sniper/sniper_shared_modifiers/modifier_sniper_shrapnel_thinker_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Set the aoe indicator
function sniper_mobility:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function sniper_mobility:OnSpellStart()
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    local duration = self:GetSpecialValueFor( "duration" )
    local shrapnel = caster:FindAbilityByName("sniper_special_attack")

    -- Effect thinker
    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_sniper_mobility_thinker", --modifierName
        { }, --paramTable
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )

    
    -- Effect thinker
    CreateModifierThinker(
        caster, --hCaster
        shrapnel, --hAbility
        "modifier_sniper_shrapnel_thinker_lua", --modifierName
        { duration = shrapnel:GetSpecialValueFor("duration") }, --paramTable
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )
    
    self:PlayEffects()    
    -- Put CD on the alternate version of the ability
	local ex_version = caster:FindAbilityByName("sniper_ex_mobility")
	ex_version:StartCooldown(self:GetCooldown(0))
end

function sniper_mobility:PlayEffects()
    local sound_cast = "Hero_Techies.LandMine.Detonate"
    EmitSoundOn( sound_cast, self:GetCaster() )	
end