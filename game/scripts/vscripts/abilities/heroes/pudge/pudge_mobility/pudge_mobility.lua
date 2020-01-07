pudge_mobility = class({})
--------------------------------------------------------------------------------
-- Ability Start
function pudge_mobility:OnCastPointEnd()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = CalcRange(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

	local direction = (point - origin):Normalized()
    local distance = (point - origin):Length2D()
	
	--[[

    self.vHookOffset = 0
    self.hook_speed = 2000
    self.hook_distance = distance
    self.hook_width = 150
    
   -- local vKillswitch = --Vector( ( ( self.hook_distance / self.hook_speed ) * 2 ), 0, 0 )
    
    local duration = 5

    if caster and caster:IsHero() then
		local hHook = caster:GetTogglableWearable( DOTA_LOADOUT_TYPE_WEAPON )
		if hHook ~= nil then
			hHook:AddEffects( EF_NODRAW )
		end
    end
    
	self.nChainParticleFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_pudge/pudge_meathook.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster() )
	ParticleManager:SetParticleAlwaysSimulate( self.nChainParticleFXIndex )
	ParticleManager:SetParticleControlEnt( self.nChainParticleFXIndex, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_weapon_chain_rt", self:GetCaster():GetOrigin() + self.vHookOffset, true )
	ParticleManager:SetParticleControl( self.nChainParticleFXIndex, 1, Vector(point.x, point.y, 0 ))
	ParticleManager:SetParticleControl( self.nChainParticleFXIndex, 2, Vector( self.hook_speed, self.hook_distance, self.hook_width ) )
	ParticleManager:SetParticleControl( self.nChainParticleFXIndex, 3, Vector( duration, 0,0 ) )
	ParticleManager:SetParticleControl( self.nChainParticleFXIndex, 4, Vector( 1, 0, 0 ) )
	ParticleManager:SetParticleControl( self.nChainParticleFXIndex, 5, Vector( 1, 0, 0 ) )
	ParticleManager:SetParticleControlEnt( self.nChainParticleFXIndex, 7, self:GetCaster(), PATTACH_CUSTOMORIGIN, nil, self:GetCaster():GetOrigin(), true )


    ]]

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_generic_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = (distance/0.65),
            peak = 90,
            colliding = 0,
			collide_with_ent = 1, 
            activity = ACT_DOTA_FLAIL,
            rate = 1.0,
        } -- kv
	)
	
	self:PlayEffectsOnCast()
end

function pudge_mobility:OnDisplacementEnd()
	self:PlayEffectsOnDisplacementEnd()
end

function pudge_mobility:PlayEffectsOnDisplacementEnd()
	local particle_cast = "particles/econ/events/ti8/blink_dagger_ti8_end.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetCaster() )

	
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function pudge_mobility:PlayEffectsOnCast()
	EmitSoundOn( "Hero.Pudge.Arcana.Streak", self:GetCaster() )

	local particle_cast = "particles/red_blink/blink_dagger_ti8_start.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetCaster() )

	self.effect_cast = ParticleManager:CreateParticle("particles/econ/items/pudge/pudge_tassles_of_black_death/pudge_black_death_rot.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(250,0,0) )

end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	pudge_mobility,
	{ activity = ACT_DOTA_GENERIC_CHANNEL_1, rate = 2.0 },
	{ movement_speed = 0}
)