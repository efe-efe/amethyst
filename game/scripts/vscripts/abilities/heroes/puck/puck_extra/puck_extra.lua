puck_extra = class({})
LinkLuaModifier("modifier_puck_extra_debuff", "abilities/heroes/puck/puck_extra/modifier_puck_extra_debuff", LUA_MODIFIER_MOTION_NONE)

function puck_extra:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_2 end 
function puck_extra:GetPlaybackRateOverride() 		return 1.0 end
function puck_extra:GetCastPointSpeed() 			return 0 end
function puck_extra:GetFadeGestureOnCast()			return false end

function puck_extra:OnSpellStart()
	local caster = self:GetCaster()
    local point = Clamp(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
    local pre_silence_duration = self:GetSpecialValueFor("pre_silence_duration")
	self.radius = self:GetSpecialValueFor("radius")
    
    FindClearSpaceForUnit(caster, point, true)

    local enemies = caster:FindUnitsInRadius(
        caster:GetOrigin(), 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
   )

    for _,enemy in pairs(enemies) do
        enemy:AddNewModifier(caster, self, "modifier_puck_extra_debuff", { duration = pre_silence_duration })
    end

    self:PlayEffectsOnCast()
    CreateRadiusMarker(caster, point, self.radius, RADIUS_SCOPE_PUBLIC)
end

function puck_extra:PlayEffectsOnCast()
    EmitSoundOn("Hero_Puck.Waning_Rift", self:GetCaster())
	
	local random_number = RandomInt(1, 3)
	EmitSoundOn("puck_puck_ability_rift_0" .. random_number, self:GetCaster())
    	
	local particle_cast = "particles/econ/items/puck/puck_fairy_wing/puck_waning_rift_fairy_wing.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, self.radius, self.radius))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(puck_extra)