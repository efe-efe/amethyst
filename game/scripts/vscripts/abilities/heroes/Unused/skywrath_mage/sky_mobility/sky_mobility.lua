sky_mobility = class({})

--------------------------------------------------------------------------------
-- Ability Start
function sky_mobility:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
    self.radius =  self:GetSpecialValueFor( "radius" )

	-- Animation and pseudo cast point
	StartAnimation(caster, { 
        duration = cast_point + 0.1, 
        activity = ACT_DOTA_CAST_ABILITY_2, 
        rate = 1.0 
    })
	caster:AddNewModifier(
        caster, 
        self,
        "modifier_cast_point_old", 
        {
            duration = cast_point,
            radius = self.radius,
            movement_speed = 10,
        }
    )
end

--------------------------------------------------------------------------------
function sky_mobility:OnCastPointEnd( point )
    --Initialize variables
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local max_range = self:GetSpecialValueFor("range")


    -- determine target position
    local difference = point - origin

    if difference:Length2D() > max_range then
        point = origin + (point - origin):Normalized() * max_range
    end

    -- teleport
    FindClearSpaceForUnit( caster, point , true )

    --Effects
    self:PlayEffects()
end

function sky_mobility:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_ground.vpcf"
    local sound_cast = "Hero_Enchantress.EnchantCast"
    
    -- Sound
    EmitSoundOn(sound_cast, self:GetCaster())

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end