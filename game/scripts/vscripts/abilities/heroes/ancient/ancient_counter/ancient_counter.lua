ancient_counter = class({})
LinkLuaModifier( "modifier_ancient_counter_recast", "abilities/heroes/ancient/ancient_counter/modifier_ancient_counter_recast", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function ancient_counter:OnCastPointEnd()
    local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
        "modifier_counter", 
		{ 
            activity = ACT_DOTA_CAST_ABILITY_3,
            rate = 0.4,
            movement_speed = 0,
            duration = duration, 
            destroy_on_trigger = 1,
        }
    )
end

function ancient_counter:OnTrigger()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local recast_duration = self:GetSpecialValueFor("recast_duration")
    
    local enemies = caster:FindUnitsInRadius(
        caster:GetOrigin(), 
        radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )
    
    for _,enemy in pairs(enemies) do
        local direction = (enemy:GetOrigin() - caster:GetOrigin()):Normalized()
        local distance = radius - (enemy:GetOrigin() - caster:GetOrigin()):Length2D()

        enemy:AddNewModifier(
            caster, -- player source
            self, -- ability source
            "modifier_generic_displacement", -- modifier name
            {
                x = direction.x,
                y = direction.y,
                r = distance,
                speed = 1000,
                peak = 50,
                restricted = 1,
            } -- kv
        )
    end

    caster:AddNewModifier(caster, self, "modifier_ancient_counter_recast", { duration = recast_duration })

    self:PlayEffectsOnTrigger( radius )
end

function ancient_counter:PlayEffectsOnTrigger( radius )
	local particle_cast = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_mystic_flare_ambient.vpcf"
    --EmitSoundOn("Hero_SkywrathMage.ConcussiveShot.Target", self:GetCaster())
    
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 0.4 , 0 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
    ancient_counter,
    nil, 
	{ movement_speed = 100 }
)