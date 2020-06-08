charge = class({})
LinkLuaModifier("modifier_charge_buff", "abilities/heroes/common/mount/modifier_charge_buff.lua", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Ability Start
function charge:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	caster:AddNewModifier(
        caster, 
        self,
        "modifier_cast_point", 
        {
            duration = cast_point,
            no_target = 1,
            movement_speed = 100,
            cancel_on_damage = 1,
        }
   )
end

--------------------------------------------------------------------------------
-- Ability Start
function charge:OnCastPointEnd()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

	-- Animation and pseudo cast point
	caster:AddNewModifier(
        caster, 
        self,
        "modifier_charge_buff", 
        {
            duration = duration,
        }
   )
    self:PlayEffectsOnCast()
end


function charge:PlayEffectsOnCast()
    local particle_cast = "particles/units/heroes/hero_dark_seer/dark_seer_surge_start.vpcf"
    local effect_cast =  ParticleManager:CreateParticle(
        particle_cast,
        PATTACH_ABSORIGIN_FOLLOW, 
        self:GetCaster()
   )
    ParticleManager:ReleaseParticleIndex(effect_cast)
end