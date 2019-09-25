sniper_mobility = class({})
LinkLuaModifier( "modifier_sniper_mobility_thinker", "abilities/heroes/sniper/sniper_mobility/modifier_sniper_mobility_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_shrapnel_thinker_lua", "abilities/heroes/sniper/sniper_shared_modifiers/modifier_sniper_shrapnel_thinker_lua", LUA_MODIFIER_MOTION_NONE )

function sniper_mobility:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("sniper_ex_mobility")
end

--------------------------------------------------------------------------------
-- Ability Start
function sniper_mobility:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	self.radius = self:GetSpecialValueFor("radius")
	
	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.2, activity=ACT_DOTA_CAST_ABILITY_1, rate=2.0})
	caster:AddNewModifier(caster, self , "modifier_cast_point", { 
		duration = cast_point,
		movement_speed = 10,
	})
end

--------------------------------------------------------------------------------
-- Ability Start
function sniper_mobility:OnCastPointEnd( point )
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor( "duration" )
    local shrapnel = caster:FindAbilityByName("sniper_special_attack")

    local direction = (caster:GetOrigin() - point):Normalized()
    local thinker_origin = caster:GetOrigin() + direction * 150


    -- Effect thinker
    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_sniper_mobility_thinker", --modifierName
        { }, --paramTable
        thinker_origin, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )

	CreateModifierThinker(
		caster, --hCaster
		shrapnel, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_sniper_shrapnel_thinker_lua",
			show_all = 1,
			radius = self.radius,
			delay_time = shrapnel:GetSpecialValueFor( "delay_time" ),
			thinker_duration = shrapnel:GetSpecialValueFor( "duration" ),
		}, --paramTable
		thinker_origin, --vOrigin
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